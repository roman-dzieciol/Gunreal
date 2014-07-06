// ============================================================================
//  gTeleporterPod.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterPod extends gProjectile;


var() float                 ScreenOffset;

var   gTeleporterPod        OtherPod;
var   gTeleporterScreen     MyScreen;
var   Material              TransMaterials[2];
var   float                 TeleportTime;

var   gTeleporterNode       Node;
var   int                   TeleportID;

var   gTeleporterPod        PodList;

var   class<Emitter>        DeathEmitterClass;

var() Sound                 DeathSound;
var() float                 DeathSoundVolume;
var() float                 DeathSoundRadius;
var() ESoundSlot            DeathSoundSlot;

var   class<Emitter>        NotReadyEmitterClass;
var   Emitter               NotReadyEmitter;

var   class<Emitter>        ActivateEmitterClass;
var   Emitter               ActivateEmitter;

var() Sound                 ActivateSound;
var() float                 ActivateSoundVolume;
var() float                 ActivateSoundRadius;
var() ESoundSlot            ActivateSoundSlot;

var() Sound                 DeactivateSound;
var() float                 DeactivateSoundVolume;
var() float                 DeactivateSoundRadius;
var() ESoundSlot            DeactivateSoundSlot;

var   PlayerReplicationInfo     InstigatorPRI;

var() Sound ActiveAmbientSound;
var() byte ActiveSoundVolume;
var() float ActiveSoundRadius;


// ============================================================================
//  Replication
// ============================================================================
replication
{
    reliable if( bNetDirty && ROLE == ROLE_Authority )
        OtherPod;

    reliable if( bNetInitial && ROLE == ROLE_Authority )
        InstigatorPRI;
}

// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.TransMaterials[0]);
    S.PrecacheObject(default.TransMaterials[1]);
}

// ============================================================================
//  Lifespan
// ============================================================================
simulated event PostBeginPlay()
{
    //gLog( "PostBeginPlay" );

    Super.PostBeginPlay();

    // add to linked list
    default.PodList = Self;

    if( Role == ROLE_Authority )
    {
        if( InstigatorController != None )
            InstigatorPRI = InstigatorController.PlayerReplicationInfo;
    }

    if( Level.NetMode != NM_DedicatedServer )
    {
        MyScreen = Spawn(class'gTeleporterScreen', Self,,, rot(0,0,0));
    }

    SetAmbientSound(None);
}

simulated event Destroyed()
{
    local gTeleporterPod B;

    //gLog( "Destroyed" );

    // remove from linked list
    if( default.PodList == Self )
    {
        default.PodList = PodList;
    }
    else
    {
        for( B=default.PodList; B!=None; B=B.PodList )
        {
            if( B.PodList == Self )
            {
                B.PodList = PodList;
                break;
            }
        }
    }

    Super.Destroyed();

    if( MyScreen != None )
        MyScreen.Destroy();

    if( Node != None )
        Node.Destroy();

    if( NotReadyEmitter != None )
        NotReadyEmitter.Destroy();

    if( ActivateEmitter != None )
        ActivateEmitter.Destroy();
}


// ============================================================================
//  Physics
// ============================================================================

simulated singular event HitWall( vector HitNormal, Actor Other )
{
    // Let native physics handle bouncing
}

simulated event Landed(vector HitNormal)
{
    //gLog( "Landed" #HitNormal );

    Stick(Level, Location, HitNormal);
}

simulated function Stick(Actor Other, vector HitLocation, vector HitNormal)
{
    local int id;

    //gLog( "Stick" #Other #HitNormal #VSize(Velocity) );

    // stick to ground
    SetRotation(GetMineRotation(HitNormal));
    SetPhysics(PHYS_None);
    SetBase(Other);

    if( Role == ROLE_Authority )
    {
        Node = Spawn(class'gTeleporterNode', Self,, Location+vect(0,0,43), rot(0,0,0));
        if( Node != None && OtherPod != None && OtherPod.Node != None )
        {
            id = ++default.TeleportID;
            Node.LinkTeleporters("PodSrc" $ id, "PodDest" $ id, OtherPod.Node);

            SetAmbientSound(default.AmbientSound);
            OtherPod.SetAmbientSound(OtherPod.default.AmbientSound);

            if( NotReadyEmitter != None )
                NotReadyEmitter.Destroy();
        }
        else
        {
            if( NotReadyEmitterClass != None && NotReadyEmitter == None )
                NotReadyEmitter = Spawn( NotReadyEmitterClass, Self,, Location, Rotation );
        }
    }
}

simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    local vector Vel2D;

    //gLog( "TouchTarget" #GON(Other) #HitLocation #HitNormal );

    if( Role == ROLE_Authority )
    {
        if( Other == Instigator || !Other.bBlockActors )
            return;

        if( Physics != PHYS_None )
        {
            if( Pawn(Other) != None && Vehicle(Other) == None )
            {
                Vel2D = Velocity;
                Vel2D.Z = 0;

                if( VSize(Vel2D) < 200 )
                    return;
            }

            HitWall( -Normal(Velocity), Other );
        }
    }
}

simulated event PostRender2D(Canvas C, float ScreenLocX, float ScreenLocY)
{
    local gPlayer PC;

    PC = gPlayer(Level.GetLocalPlayerController());
    if( PC != None )
    {
        class'gTeleporterInfo'.static.StaticCreate(PC);
        bScriptPostRender = False;
    }
}

simulated event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    //gLog( "TakeDamage" #Damage #GON(InstigatedBy) );
    if( Role == ROLE_Authority )
    {
        if( InstigatedBy != None )
        {
            if( InstigatorController != None && InstigatorController == InstigatedBy.Controller )
                return;

            if( Level.Game.bTeamGame && InstigatedBy.GetTeam() == InstigatorTeam )
                return;
        }

        if( Damage > 0 )
        {
            Health -= Damage;

            if( Health < 0 )
            {
                Hit(Base, Location, vector(Rotation));
            }
        }
    }
}

simulated function Hit( Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "Hit" #GON(Other) #bDeleteMe #bHitting );
    if( Role == ROLE_Authority && !bDeleteMe && !bHitting )
    {
        bHitting = True;

        if( DeathEmitterClass != None )
            Spawn(DeathEmitterClass,,, Location, Rotation);

        if( DeathSound != None )
            PlaySound(DeathSound, DeathSoundSlot, DeathSoundVolume, False, DeathSoundRadius);

        Destroy();
    }
}

simulated function Activate()
{
    if( ActivateSound != None )
        PlaySound(ActivateSound, ActivateSoundSlot, ActivateSoundVolume, False, ActivateSoundRadius);

    if( ActivateEmitterClass != None && ActivateEmitter == None )
        ActivateEmitter = Spawn(ActivateEmitterClass, Self,, Location, Rotation);

    SetAmbientSound(ActiveAmbientSound);
}

simulated function Deactivate()
{
    if( DeactivateSound != None )
        PlaySound(DeactivateSound, DeactivateSoundSlot, DeactivateSoundVolume, False, DeactivateSoundRadius);

    if( ActivateEmitter != None )
        ActivateEmitter.Destroy();

    SetAmbientSound(default.AmbientSound);
}

simulated function SetAmbientSound(Sound S)
{
    AmbientSound = S;
    if( S == default.AmbientSound )
    {
        SoundVolume = default.SoundVolume;
        SoundRadius = default.SoundRadius;
    }
    else if( S == ActiveAmbientSound )
    {
        SoundVolume = ActiveSoundVolume;
        SoundRadius = ActiveSoundRadius;
    }
}


// ============================================================================
//  Rotation fixes
// ============================================================================

simulated final function rotator GetMineRotation( vector HitNormal )
{
    local vector X,Y,Z;

    Z = HitNormal;
    Y = Normal(vect(0,0,1) Cross Z);
    X = Normal(Y Cross Z);
    return OrthoRotation(X,Y,Z);
}

simulated final function vector GetMineNormal(rotator MineRot)
{
    local vector X,Y,Z;
    GetAxes(MineRot, X,Y,Z);
    return Z;
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ActiveAmbientSound              = Sound'G_Sounds.cg_telepod_disc_drone'
    ActiveSoundVolume               = 255
    ActiveSoundRadius               = 1024

    ExtraGravity                    = 1

    StuckThreshold                  = 1.0
    BounceThreshold                 = 50
    BounceFXThreshold               = 400

    ScreenOffset                    = 96
    TeleportTime                    = 1

    TransMaterials(0)               = Material'PlayerTransRed'
    TransMaterials(1)               = Material'PlayerTrans'

    DampenFactor                    = 0.1
    DampenFactorParallel            = 0.3

    BounceEmitterClass              = None//class'gGrenadeHitWall'
    DeathEmitterClass               = None//class'GEffects.gPlaceholderEmitter'
    NotReadyEmitterClass            = None//class'GEffects.gPlaceholderEmitter'
    ActivateEmitterClass            = None//class'GEffects.gPlaceholderEmitter'

    BounceSound                     = Sound'G_Sounds.cg_telepod_impact_bump'
    BounceSoundVolume               = 1.0
    BounceSoundVolumeCurve          = 4.0
    BounceSoundRadius               = 255
    BounceSoundSlot                 = SLOT_Nnne

    DeathSound                      = Sound'G_Sounds.cg_telepod_disc_death'
    DeathSoundVolume                = 1.0
    DeathSoundRadius                = 255
    DeathSoundSlot                  = SLOT_Misc

    ActivateSound                   = Sound'G_Sounds.cg_telepod_activate'
    ActivateSoundVolume             = 2.0
    ActivateSoundRadius             = 255
    ActivateSoundSlot               = SLOT_Misc

    DeactivateSound                 = Sound'G_Sounds.cg_telepod_deactivate'
    DeactivateSoundVolume           = 2.0
    DeactivateSoundRadius           = 255
    DeactivateSoundSlot             = SLOT_Misc

    // Projectile
    Speed                           = 500

    bScriptPostRender               = True

    // Actor
    CollisionRadius                 = 8
    CollisionHeight                 = 4
    bCanBeDamaged                   = True
    bProjTarget                     = True
    bUseCollisionStaticMesh         = True
    bIgnoreEncroachers              = True
    bBounce                         = False

    bUnlit                          = False
    StaticMesh                      = StaticMesh'G_Meshes.combo_tele1'
    DrawScale                       = 0.5
    PrePivot                        = (X=0,Y=0,Z=10)

    bOnlyDirtyReplication           = True
    bAlwaysRelevant                 = True

    AmbientSound                    = Sound'G_Sounds.cg_telepod_disc_ambient'
    SoundRadius                     = 12

    Health                          = 25

    LifeSpan                        = 0
}
