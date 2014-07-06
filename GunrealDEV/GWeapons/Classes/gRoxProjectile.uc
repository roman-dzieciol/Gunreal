// ============================================================================
//  gRoxProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRoxProjectile extends gRoxProjectileBase;


var   vector    Deviation;
var() float     PhysicsDelta;
var() float     DeviationRange;


replication
{
    reliable if( bNetInitial && Role == ROLE_Authority )
        Deviation;
}


simulated event PreBeginPlay()
{
    if( Role == ROLE_Authority )
    {
        // Randomize initial roll
        SetRotation(Rotation + rot(0,0,65535) * FRand());
        //gLog(""#Rotation);
    }
    else
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
        bCollideWorld = False;
    }

    // Scripted physics
    SetTimer(PhysicsDelta, True);

    Super.PreBeginPlay();
}

simulated event Timer()
{
    local vector Force;
    local vector X, Y, Z;

    GetAxes(Rotation, X, Y, Z);

    // Init deviation
    if( Deviation == vect(0,0,0) )
        Deviation = Z;

    // Keep the rocket around the original line of fire
    Force = Normal(Deviation) * (DeviationRange - VSize(Deviation)) * 2;
    if( FRand() > 0.1 )
        Force += Z * DeviationRange * 0.5;
    else
        Force -= Z * DeviationRange * 0.5;

    // Apply deviation
    Deviation += Force;
    Velocity += Force;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    PhysicsDelta                        = 0.1
    DeviationRange                      = 64


    // gProjectile
    AttachmentClass                     = class'GEffects.gRoxSmokeTrail'


    // Projectile
    Speed                               = 1536


    // Actor
    CollisionRadius                     = 4
    CollisionHeight                     = 4
    bFixedRotationDir                   = True
    Physics                             = PHYS_Projectile
    RotationRate                        = (Roll=50000)
    DesiredRotation                     = (Roll=30000)

    ForceType                           = FT_Constant
    ForceScale                          = 5.0
    ForceRadius                         = 100.0
    FluidSurfaceShootStrengthMod        = 10.0

    bDynamicLight                       = True
    LightType                           = LT_Steady
    LightEffect                         = LE_QuadraticNonIncidence
    LightPeriod                         = 0
    LightBrightness                     = 255
    LightHue                            = 28
    LightSaturation                     = 0
    LightRadius                         = 24

    AmbientSound                        = Sound'G_Sounds.rl_rocketfly1'
    SoundRadius                         = 640
    SoundVolume							= 204
}