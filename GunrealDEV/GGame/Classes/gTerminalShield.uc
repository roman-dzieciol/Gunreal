// ============================================================================
//  gTerminalShield.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTerminalShield extends gActor;


var() sound                 ActivateSound;
var() ESoundSlot            ActivateSoundSlot;
var() float                 ActivateSoundVolume;
var() float                 ActivateSoundRadius;
var() float                 ActivateSoundPitch;
var() class<Emitter>        ActivateEmitterClass;
var   Emitter               ActivatedEmitter;

var() Sound                 DeactivateSound;
var() ESoundSlot            DeactivateSoundSlot;
var() float                 DeactivateSoundVolume;
var() float                 DeactivateSoundRadius;
var() float                 DeactivateSoundPitch;
var() class<Emitter>        DeactivateEmitterClass;
var   Emitter               DeactivatedEmitter;

var() Sound                 DestroyedSound;
var() ESoundSlot            DestroyedSoundSlot;
var() float                 DestroyedSoundVolume;
var() float                 DestroyedSoundRadius;
var() float                 DestroyedSoundPitch;
var() class<Emitter>        DestroyedEmitterClass;
var   Emitter               DestroyedEmitter;

var() class<Emitter>        HitEmitterClass;
var() class<Emitter>        HitSphereEmitterClass;

var   bool                  bOpening;

var   float                 Alpha;
var() float                 FadeInSpeed;

var   gShieldFader          ScreenFader;
var   gShieldBlend          ScreenBlend;

var   bool                  bCollideActorsLast;


// ============================================================================
//  Terminal Shield
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.ActivateSound);
    S.PrecacheObject(default.ActivateEmitterClass);
    S.PrecacheObject(default.DeactivateSound);
    S.PrecacheObject(default.DeactivateEmitterClass);
    S.PrecacheObject(default.DestroyedSound);
    S.PrecacheObject(default.DestroyedEmitterClass);
    S.PrecacheObject(default.HitEmitterClass);
    S.PrecacheObject(default.HitSphereEmitterClass);
}

simulated event PostNetReceive()
{
    if( bCollideActors != bCollideActorsLast )
    {
        if( bCollideActors )
        {
            Activate();
        }
        else
        {
            Deactivate();
        }
    }

    bCollideActorsLast = bCollideActors;
}

simulated event PostBeginPlay()
{
    if( Level.NetMode != NM_DedicatedServer )
    {
        if( ScreenBlend == None )
        {
            ScreenFader = gShieldFader(Level.ObjectPool.AllocateObject(class'GEffects.gShieldFader'));
            ScreenFader.Material = Skins[0];
            ScreenFader.Color.A = 0;

            ScreenBlend = gShieldBlend(Level.ObjectPool.AllocateObject(class'GEffects.gShieldBlend'));
            ScreenBlend.Material = ScreenFader;

            Skins[0] = ScreenBlend;
        }
    }
}

simulated function Reset()
{
    GotoState('');
    SetCollision(False,False);
    bProjTarget = False;
    bHidden = True;
    //Health = MaxHealth;
    AmbientSound = None;
    bOpening = False;
    Alpha = 0;

    if( ScreenFader != None )
        ScreenFader.Color.A = Alpha * float(255);
}

simulated event Destroyed()
{
    //gLog( "Destroyed" );

    if( ScreenFader != None )
    {
        ScreenFader.Material = None;
        Level.ObjectPool.FreeObject(ScreenFader);
        ScreenFader = None;
    }

    if( ScreenBlend != None )
    {
        ScreenBlend.Material = None;
        Level.ObjectPool.FreeObject(ScreenBlend);
        ScreenBlend = None;
    }

    Skins[0] = None;

    Super.Destroyed();
}


simulated function Activate()
{
    //gLog( "Activate" );

    //Health = MaxHealth;
    bOpening = True;
    bHidden = False;
    Alpha = 0;

    PlaySound(ActivateSound, ActivateSoundSlot, ActivateSoundVolume, False, ActivateSoundRadius, ActivateSoundPitch, True);

    if( ScreenFader != None )
        ScreenFader.Color.A = Alpha * float(255);

    if( ActivateEmitterClass != None && ActivatedEmitter == None )
        ActivatedEmitter = spawn(ActivateEmitterClass, , , Location);
}

simulated event Tick(float DeltaTime)
{
    if( bOpening )
    {
        Alpha = FMin( 1, Alpha + (DeltaTime / FadeInSpeed) );
        if( ScreenFader != None )
            ScreenFader.Color.A = Alpha * float(255);

        if( Alpha >= 1.0 )
            Activated();
    }
}

simulated function Activated()
{
    //gLog( "Activated" );
    bOpening = False;
    SetCollision(True,True);
    bProjTarget = True;
    AmbientSound = default.AmbientSound;
}

simulated function Deactivate()
{
    //gLog( "Deactivate" );
    SetCollision(False,False);
    bProjTarget = False;

    if( DeactivateEmitterClass != None )
        DeactivatedEmitter = Spawn(DeactivateEmitterClass);

    if( gTerminal(Owner) != None && gTerminal(Owner).Health > 0 )
    	PlaySound(DeactivateSound, DeactivateSoundSlot, DeactivateSoundVolume, False, DeactivateSoundRadius, DeactivateSoundPitch, True);
    
	if( ActivatedEmitter != None )
    {
        ActivatedEmitter.Kill();
        ActivatedEmitter = None;
    }

    Reset();
}

event TakeDamage(int Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    //gLog( "TakeDamage" #Damage );
    if( gTerminal(Owner) != None )
    {
	    if( gTerminal(Owner).Health <= 0 )
	        return;

    	gTerminal(Owner).TakeDamage(Damage, Instigator, HitLocation, Momentum, DamageType);
	    
		if( gTerminal(Owner).Health <= 0 )
	    {
	        // Delay destruction to the end of this tick, so if hit destroys the shield, player is still safe from a blast
	        //gLog( "ShieldDestroying" );
	        GotoState('ShieldDestroying');
	    }
	    else
	    {
	        Spawn( HitEmitterClass,,, HitLocation, rotator(Location-HitLocation) );
	        Spawn( HitSphereEmitterClass );
	    }
    }
}

state ShieldDestroying
{
Begin:
    //gLog( "Begin" );
    PlaySound(DestroyedSound, DestroyedSoundSlot, DestroyedSoundVolume, False, DestroyedSoundRadius, DestroyedSoundPitch, True);

    if( DestroyedEmitterClass != None )
        DestroyedEmitter = Spawn( DestroyedEmitterClass );

    if( gTerminal(Owner) != None )
        gTerminal(Owner).ShieldDown();

    Reset();
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ActivateSound               = Sound'G_Sounds.shopping_bubble_a1'
    ActivateSoundSlot           = SLOT_None
    ActivateSoundVolume         = 2
    ActivateSoundRadius         = 150
    ActivateSoundPitch          = 1

    DeactivateSound             = Sound'G_Sounds.shopping_bubble_c1'
    DeactivateSoundSlot         = SLOT_None
    DeactivateSoundVolume       = 2
    DeactivateSoundRadius       = 150
    DeactivateSoundPitch        = 1

    DestroyedSound              = Sound'G_Sounds.shopping_bubble_d1'
    DestroyedSoundSlot          = SLOT_None
    DestroyedSoundVolume        = 5
    DestroyedSoundRadius        = 150
    DestroyedSoundPitch         = 1

    ActivateEmitterClass        = class'gShoppingBubbleEmitter'
    DeactivateEmitterClass      = class'gShoppingBubbleCloseEmitter'
    DestroyedEmitterClass       = class'gShoppingBubbleDestroyedEmitter'
    HitEmitterClass             = class'gShoppingBubbleHitEmitter'
    HitSphereEmitterClass       = class'GEffects.gTerminalHitEmitter'

    FadeInSpeed                 = 0.3


    // Actor
    DrawScale                   = 1.5
    DrawType                    = DT_StaticMesh
    StaticMesh                  = StaticMesh'G_Meshes.Pickups.terminal_shield_1b'
    PrePivot                    = (X=0,Y=0,Z=0.0)
    Skins(0)                    = Shader'G_FX.Shield.shield_c1'

    bUnlit                      = True
    bUseDynamicLights           = True

    CollisionRadius             = 128
    CollisionHeight             = 128
    bCollideActors              = False
    bCollideWorld               = False
    bBlockKarma                 = True
    bBlockZeroExtentTraces      = True
    bBlockNonZeroExtentTraces   = True
    bIgnoreEncroachers          = True
    bProjTarget                 = False
    bBlockActors                = False
    bAcceptsProjectors          = False
    bUseCylinderCollision       = True

    bCanBeDamaged               = True
    bNetNotify                  = True
    RemoteRole                  = ROLE_SimulatedProxy

    AmbientSound                = Sound'G_Sounds.shopping_bubble_b1'
    SoundVolume                 = 255
    SoundRadius                 = 250
    SoundPitch                  = 128
}
