// ============================================================================
//  gPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPickup extends gBasePickup
    abstract;


var() Sound                         SpawnSound;

var() class<gEmitter>               SpawnEmitterClass;
var() class<gEmitter>               PickupEmitterClass;

var() class<gEmitter>               GlowEmitterClass;
var   gEmitter                      GlowEmitter;

var() class<gPickupProjector>       GlowProjectorClass;
var   gPickupProjector              GlowProjector;

var() class<gOverlayTemplate>       OverlayClass;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    S.PrecacheObject(default.SpawnSound);

    S.PrecacheObject(default.SpawnEmitterClass);
    S.PrecacheObject(default.PickupEmitterClass);
    S.PrecacheObject(default.GlowEmitterClass);
    S.PrecacheObject(default.GlowProjectorClass);
    S.PrecacheObject(default.OverlayClass);
}


// ============================================================================
//  Lifespan
// ============================================================================

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( GlowProjectorClass != None && Level.NetMode != NM_DedicatedServer )
        GlowProjector = Spawn(GlowProjectorClass, Self);
}

simulated event Destroyed()
{
    Super.Destroyed();

    if( GlowEmitter != None )
        GlowEmitter.Destroy();

    if( GlowProjector != None )
        GlowProjector.Destroy();
}


// ============================================================================
//  Pickup
// ============================================================================

function RespawnEffect()
{
    PlaySound(SpawnSound, SLOT_None);
    if( SpawnEmitterClass != None )
        Spawn(SpawnEmitterClass, Self);
}

function AnnouncePickup(Pawn Receiver)
{
    Receiver.HandlePickup(Self);
    PlaySound(PickupSound, SLOT_None);

    if( gPlayer(Receiver.Controller) != None && OverlayClass != None )
        gPlayer(Receiver.Controller).ClientFlashOverlay(OverlayClass);

    if( PickupEmitterClass != None )
        Spawn(PickupEmitterClass, Self);
}

auto state Pickup
{
    event BeginState()
    {
        Super.BeginState();

        if( GlowEmitterClass != None )
            GlowEmitter = Spawn(GlowEmitterClass, Self);
    }

    event EndState()
    {
        Super.EndState();

        if( GlowEmitter != None )
            GlowEmitter.Kill();
    }
}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    SpawnEmitterClass           = class'GEffects.gPickupSpawnEmitter'
    PickupEmitterClass          = class'GEffects.gPickupPickupEmitter'

    GlowEmitterClass            = None
    GlowProjectorClass          = None

    RespawnTime                 = 30.0
    MaxDesireability            = 0.1

    MessageClass                = class'GGame.gPickupMessage'
    PickupMessage               = "Snagged an item."
    PickupForce                 = "Pickup"

    PickupSound                 = None
    SpawnSound                  = Sound'G_Sounds.g_item_resp_a'
    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 256.0

    DrawType                    = DT_StaticMesh
    StaticMesh                  = StaticMesh'G_Meshes.Pickups.pickup_1'
    DrawScale                   = 0.4
    Style                       = STY_AlphaZ
    ScaleGlow                   = 0.6
    bUnlit                      = True
    bAmbientGlow                = True
    AmbientGlow                 = 128
    CullDistance                = 6500.0

    Physics                     = PHYS_Rotating
    RotationRate                = (Yaw=24000)
    Mass                        = 10.0
    CollisionRadius             = 32.0
    CollisionHeight             = 23.0

    RemoteRole                  = ROLE_SimulatedProxy
    bNetInitialRotation         = True
}