// ============================================================================
//  gEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gEmitter extends gEmitterBase
    abstract;


var() bool              bTriggerEmitters;
var() bool              bTriggerKills;
var() array<int>        DisableOnTrigger;

var() bool              bFlash;
var() float             FlashBrightness;
var() float             FlashRadius;
var() float             FlashTimeIn;
var() float             FlashTimeOut;
var() float             FlashCurveIn;
var() float             FlashCurveOut;
var   float             FlashTime;

var() rangevector       TeamColorMultiplier;

var() bool              bServerAutoDestroy;
var() float             ServerAutoDestroyTime;

var() Sound             SpawnSound;
var() ESoundSlot        SpawnSoundSlot;
var() float             SpawnSoundVolume;
var() bool              SpawnSoundNoOverride;
var() float             SpawnSoundRadius;
var() float             SpawnSoundPitch;
var() bool              SpawnSoundAttenuate;

var() class<Actor>      ClientSpawnClass;
var() vector            ClientSpawnAxes;

var() class<Actor>      TriggerSpawnClass;
var() globalconfig bool bUseActorForces;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.SpawnSound);
    S.PrecacheObject(default.ClientSpawnClass);
    S.PrecacheObject(default.TriggerSpawnClass);
}


// ============================================================================
//  Emitter
// ============================================================================

simulated event PreBeginPlay()
{
    local int i;
    local rangevector NoRange;

    Super.PreBeginPlay();
    if( bDeleteMe )
        return;

    // Team coloring
    if( TeamColorMultiplier != NoRange )
    {
        for( i=0; i!=Emitters.Length; ++i )
            if( Emitters[i] != None )
                Emitters[i].ColorMultiplierRange = TeamColorMultiplier;
    }

    // Actor forces are enabled on highest detail only
    if( !class'gEmitter'.default.bUseActorForces )
    {
        for( i=0; i!=Emitters.Length; ++i )
            if( Emitters[i] != None )
                Emitters[i].UseActorForces = False;
    }
}

simulated event PostBeginPlay()
{
    //Log( "PostBeginPlay" @bDisableOnStart );

    if( bFlash && Level.NetMode != NM_DedicatedServer )
    {
        FlashTime = FlashTimeIn + FlashTimeOut;
        // FIXME: make this accurate
        if( !bTriggerKills && !AutoDestroy )
            LifeSpan = FMax(LifeSpan, (FlashTime)*2);
    }

    // Destroy on server if net temporary
    if( bServerAutoDestroy && bNetTemporary && Level.NetMode == NM_DedicatedServer )
        LifeSpan = ServerAutoDestroyTime;
}

simulated event PostNetBeginPlay()
{
    Super.PostNetBeginPlay();

    // Play spawn sound
    if( SpawnSound != None && Level.NetMode != NM_DedicatedServer )
        PlaySound(SpawnSound, SpawnSoundSlot, SpawnSoundVolume, SpawnSoundNoOverride, SpawnSoundRadius, SpawnSoundPitch, SpawnSoundAttenuate);

    if( ClientSpawnClass != None && Level.NetMode != NM_DedicatedServer )
        Spawn(ClientSpawnClass, self,, Location, rotator(vector(Rotation)*ClientSpawnAxes));
}

simulated event Tick(float DeltaTime)
{
    local float Alpha;

    // Flash fade in
    if( FlashTimeIn > 0 )
    {
        FlashTimeIn = FMax(FlashTimeIn - DeltaTime, 0);
        Alpha = 1 - ((FlashTimeIn / default.FlashTimeIn)**FlashCurveIn);
        LightBrightness = default.LightBrightness + (FlashBrightness - default.LightBrightness) * Alpha;
        LightRadius = default.LightRadius + (FlashRadius - default.LightRadius) * Alpha;
        //Log("FlashTimeIn" @Alpha @FlashTimeIn @FlashTimeOut @LightBrightness @LightRadius );
    }

    // Flash fade out
    else if( FlashTimeOut > 0 )
    {
        FlashTimeOut = FMax(FlashTimeOut - DeltaTime, 0);
        Alpha = ((FlashTimeOut / default.FlashTimeOut)**FlashCurveOut);
        LightBrightness = FlashBrightness * Alpha;
        LightRadius = FlashRadius * Alpha;
        //Log("FlashTimeOut" @Alpha @FlashTimeIn @FlashTimeOut @LightBrightness @LightRadius );
    }

    // Disable flash
    else
    {
        LightType = LT_None;
        bFlash = False;
        Disable('Tick');
    }
}

simulated event Trigger(Actor Other, Pawn EventInstigator)
{
    local int i;

    //gLog( "Trigger" @Other @EventInstigator @bTriggerKills );

    if( bTriggerEmitters )
        Super.Trigger(Other, EventInstigator);

    if( TriggerSpawnClass != None )
        Spawn(TriggerSpawnClass, self);

    if( bTriggerKills )
    {
        for( i=0; i!=DisableOnTrigger.Length; ++i )
        {
            Emitters[DisableOnTrigger[i]].Disabled = True;
        }

        LightType = LT_None;
        AmbientSound = None;
        Kill();
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ClientSpawnAxes             = (X=1,Y=1,Z=1)

    SpawnSound                  = None
    SpawnSoundSlot              = SLOT_None
    SpawnSoundVolume            = 1.0
    SpawnSoundNoOverride        = False
    SpawnSoundRadius            = 256
    SpawnSoundPitch             = 1.0
    SpawnSoundAttenuate         = False

    AutoDestroy                 = True
    bNoDelete                   = False
    bServerAutoDestroy          = True
    ServerAutoDestroyTime       = 0.25
}
