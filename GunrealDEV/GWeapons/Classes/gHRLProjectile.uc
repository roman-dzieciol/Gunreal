// ============================================================================
//  gHRLProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLProjectile extends gProjectile;


var() float         TurnSpeedCruise;
var() float         TurnSpeedFull;

var() float         ThrustTime;
var() float         TurnAngle;
var() float         BrakeAngle;
var() float         AccelSpeed;
var() float         BrakeSpeed;
var() float         LockAngle;

var   Actor         Target;
var   vector        TargetLocation;
var   vector        TargetDir;

var   bool          bTarget;
var   bool          bNotifyFreefall;
var   bool          bEffectsDestroyed;
var   bool          bNotifyLock;

var   vector        Deviation;
var   float         DeviationCounter;

var() float         MissileDamage;

var() Sound         AmbientSoundAlt;
var() Sound         AmbientSoundAltLock;
var() class<Actor>  AttachmentClassAlt;
var   Actor         AttachmentAlt;

var() class<Actor>  TransformEffectClass;

var() StaticMesh    LockMesh;
var() Sound         LockSound;
var() float         LockSoundVolume;
var() float         LockSoundRadius;
var() ESoundSlot    LockSoundSlot;


replication
{
    reliable if( bNetDirty && Role == ROLE_Authority )
        Target;

    reliable if( bNetDirty && Role == ROLE_Authority )
        bNotifyFreefall, bNotifyLock;
}


static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.LockMesh);

    S.PrecacheObject(default.AmbientSoundAlt);
    S.PrecacheObject(default.AmbientSoundAltLock);
    S.PrecacheObject(default.LockSound);

    S.PrecacheObject(default.AttachmentClassAlt);
    S.PrecacheObject(default.TransformEffectClass);
}


simulated event PreBeginPlay()
{
    if( Role == ROLE_Authority )
    {
        // Scripted physics
        SetTimer(ThrustTime, False);
    }
    else
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
        bCollideWorld = False;
    }

    Super.PreBeginPlay();
}

function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    if( Role == ROLE_Authority )
    {
        // Explode on touch
        Hit(Other, HitLocation, HitNormal);
    }
}

simulated event Tick(float DeltaTime)
{
    local vector TargetLoc,Dir;
    local float Angle,FAngle,Alpha,TSpeed,LSpeed;
    local quat Q;
    local float DevDist;
    local vector Force;
    local float DevRange;
    local vector X,Y,Z;

    Alpha = 100*(VSize(Velocity)/MaxSpeed);

    //VarWatch( "HRL", string(int(Alpha)), True );

    if( Target != None )
    {
        if( AttachmentAlt == None && AttachmentClassAlt != None && Level.NetMode != NM_DedicatedServer )
        {
            AttachmentAlt = Spawn(AttachmentClassAlt, Self,, Location, Rotation);
            AttachmentAlt.SetBase(Self);
        }

        LSpeed = VSize(Velocity);

        TargetLoc = Target.Location;
        Dir = Normal(TargetLoc - Location);
        Angle = Dir dot vector(Rotation);

        FAngle = acos(Angle)/pi;

        if( FAngle < LockAngle && Role == ROLE_Authority )
        {
            bNotifyLock = True;
        }

        if( !bNotifyLock || FAngle < TurnAngle )
        {
            TSpeed = Lerp( (LSpeed-Speed) / (MaxSpeed-Speed), TurnSpeedCruise, TurnSpeedFull, False);
            Alpha = (TSpeed * DeltaTime) / FAngle;
            Alpha = FClamp(Alpha,0,1);

            //gLog( "S" #Angle #F );

            Q = QuatSlerp(QuatFromRotator(Rotation),QuatFromRotator(rotator(Dir)), Alpha);
            SetRotation(QuatToRotator(Q));
            Velocity = LSpeed * vector(Rotation);
        }

        if( FAngle > BrakeAngle )
        {
            // Brake
            if( LSpeed > Speed )
                LSpeed = Max(Speed, LSpeed-DeltaTime*BrakeSpeed);
            Velocity = LSpeed * vector(Rotation);
            Acceleration = vect(0,0,0);
        }
        else
        {
            // Accel
            Acceleration = Normal(Velocity)*AccelSpeed;
        }
    }
    else
    {
        if( bNotifyFreefall )
        {
            Acceleration = vect(0,0,0);
            if( !bEffectsDestroyed )
            {
                DestroyEffects();
                bEffectsDestroyed = True;
            }
        }
        else
        {
            DeviationCounter += DeltaTime;
            if( DeviationCounter > 0.3 )
                DeviationCounter = 0;
            else
                return;

            DevRange = 256;

            GetAxes(Rotation, X, Y, Z);

            if( Deviation == vect(0, 0, 0) )
                Deviation = Z;

            DevDist = VSize(Deviation);
            Dir = Normal(Deviation);
            Force = Dir * (DevRange - DevDist) * 1;

            if( FRand() > 0.05 )
                Force += Z * 48;
            else
                Force -= Z * 48;

            Deviation += Force;
            Velocity += Force;
        }
    }
}

event Timer()
{
    if( Role == ROLE_Authority )
        bNotifyFreefall = True;
}

simulated function DestroyEffects()
{
    Super.DestroyEffects();

    if( AttachmentAlt != None && !AttachmentAlt.bDeleteMe )
    {
        if( bNoFx )
        {
            AttachmentAlt.Destroy();
        }
        else
        {
            AttachmentAlt.Trigger(Self, Instigator);
            AttachmentAlt.SetBase(None);
            AttachmentAlt = None;
        }
    }
}

final function Engage(Actor NewTarget)
{
    if( Role == ROLE_Authority )
    {
        if( Target != NewTarget )
        {
            Target = NewTarget;
            SetTimer(0, False);
            bNotifyFreefall = False;
            AmbientSound = AmbientSoundAltLock;
            Acceleration = vect(0, 0, 0);
            SetPhysics(PHYS_Projectile);
            Damage = MissileDamage;

            if( TransformEffectClass != None )
                Spawn(TransformEffectClass,,, Location, Rotation);

            PlaySound(LockSound, LockSoundSlot, LockSoundVolume,, LockSoundRadius);
        }
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    bRegisterProjectile             = True
    bHitProjTarget                  = False

    TurnSpeedCruise             = 0.5
    TurnSpeedFull               = 0.5
    TurnAngle                   = 0.5 // 180 degrees
    LockAngle                   = 0.014 // 5 Degrees
    BrakeAngle                  = 0.042 // 15 degrees
    BrakeSpeed                  = 1000
    AccelSpeed                  = 2000
    ThrustTime                  = 4

    MissileDamage               = 150

    AttachmentClassAlt          = class'GEffects.gRoxSmokeTrail'

    AmbientSoundAlt             = Sound'G_Sounds.hrl_rocketfly_alt'
    AmbientSoundAltLock         = Sound'G_Sounds.hrl_rocketfly_homing'

    LockSound                   = Sound'G_Sounds.hrl_altfire'
    LockSoundVolume             = 2.0
    LockSoundRadius             = 255
    LockSoundSlot               = SLOT_Interact


    // gProjectile
    ExtraGravity                = 0.5

    AttachmentClass             = class'GEffects.gHRLSmokeTrail'
    HitEffectClass              = class'GEffects.gHRLHitWall'
    TransformEffectClass        = class'GEffects.gHRLTransform'

    ImpactSound                 = Sound'G_Proc.hrl_p_boom'
    ImpactSoundVolume           = 6.0
    ImpactSoundRadius           = 500


    // Projectile
    Speed                       = 2000
    MaxSpeed                    = 2500

    Damage                      = 380
    DamageRadius                = 370
    MomentumTransfer            = 50000
    MyDamageType                = class'gDamTypeHRLRocket'


    // Actor
    CollisionRadius             = 4
    CollisionHeight             = 4
    bUseCylinderCollision       = False
    bUpdateSimulatedPosition    = True

    StaticMesh                  = StaticMesh'G_Meshes.Projectiles.hrl_proj_a'
    DrawScale                   = 0.2

    bDynamicLight               = True
    LightType                   = LT_Steady
    LightEffect                 = LE_QuadraticNonIncidence
    LightPeriod                 = 0
    LightBrightness             = 255
    LightHue                    = 28
    LightSaturation             = 0
    LightRadius                 = 28

    AmbientSound                = Sound'G_Sounds.hrl_rocketfly'
    SoundRadius                 = 1024
}