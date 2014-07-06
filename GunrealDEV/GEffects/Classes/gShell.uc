// ============================================================================
//  gShell.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShell extends gActor;


var() RangeVector       InitialVelocity;
var() float             DampenFactor;
var() float             DampenFactorParallel;

var() Sound             ImpactSound;
var() float             SoundTime;

var() float             ExtraGravity;
var() float             InitialSpin;


// ============================================================================
//  gShell
// ============================================================================

simulated event PostBeginPlay()
{
    Velocity.X = RandRange(InitialVelocity.X.Min,InitialVelocity.X.Max);
    Velocity.Y = RandRange(InitialVelocity.Y.Min,InitialVelocity.Y.Max);
    Velocity.Z = RandRange(InitialVelocity.Z.Min,InitialVelocity.Z.Max);
    Velocity = Velocity >> Rotation;
    if( Owner != None )
        Velocity += Owner.Velocity;

    Acceleration = PhysicsVolume.default.Gravity * ExtraGravity;
    RandSpin(InitialSpin);
}

final simulated function RandSpin(float spinRate)
{
    DesiredRotation = RotRand();
    RotationRate.Yaw = spinRate * 2 *FRand() - spinRate;
    RotationRate.Pitch = spinRate * 2 *FRand() - spinRate;
    RotationRate.Roll = spinRate * 2 *FRand() - spinRate;
}

simulated event HitWall( vector HitNormal, Actor HitActor )
{
    local vector VN;
    local float speed;


    // Reflect off Wall w/damping
    VN = (Velocity dot HitNormal) * HitNormal;
    Velocity = -VN * DampenFactor*FRand() + (Velocity - VN) * DampenFactorParallel*FRand();

    RandSpin(100000);
    DesiredRotation.Roll = 0;
    RotationRate.Roll = 0;
    Speed = VSize(Velocity);

    if( Speed < 50 )
    {
        bBounce = False;
        SetPhysics(PHYS_None);
        SetCollision(False,False);
        DesiredRotation = Rotation;
        DesiredRotation.Roll = 0;
        DesiredRotation.Pitch = 0;
        SetRotation(DesiredRotation);
        if( HitActor != None )
        {
            SetBase(HitActor);
        }
    }
    else
    {
        if( Level.NetMode != NM_DedicatedServer && Speed > 60 && SoundTime < Level.TimeSeconds )
        {
            PlaySound( ImpactSound, SLOT_Misc );
            SoundTime = Level.TimeSeconds + 0.25;
        }
        else
        {
            bFixedRotationDir = False;
            bRotateToDesired = True;
            DesiredRotation.Pitch = 0;
            RotationRate.Pitch = 50000;
        }
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    InitialSpin                     = 32768
    ExtraGravity                    = 0.5

    DampenFactor                    = 0.7
    DampenFactorParallel            = 1.0
    InitialVelocity                 = (X=(Min=240.000000,Max=320.000000),Y=(Min=-350.000000,Max=-80.000000))

    LifeSpan                        = 20
    ImpactSound                     = ProceduralSound'WeaponSounds.PShell1.P1Shell1'

    Physics                         = PHYS_Falling
    DrawType                        = DT_StaticMesh

    MaxLights                       = 1
    bAcceptsProjectors              = False
    bShadowCast                     = False
    RemoteRole                      = ROLE_None

    bHidden                         = False
    bBounce                         = True // No Landed() please
    bHardAttach                     = True

    bCollideActors                  = True
    bCollideWorld                   = True
    bBlockNonZeroExtentTraces       = False
    bBlockZeroExtentTraces          = False
    bUseCylinderCollision           = True
    bIgnoreEncroachers              = True

    bFixedRotationDir               = True
    DesiredRotation                 = (Pitch=12000,Yaw=5666,Roll=2334)

    CollisionHeight                 = 1
    CollisionRadius                 = 1

}
