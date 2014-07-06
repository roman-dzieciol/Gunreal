// ============================================================================
//  gNadeProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gNadeProjectile extends gProjectile;


var() float     ExplosionTimer;


simulated event PreBeginPlay()
{
    if( Role == ROLE_Authority )
    {
        // Spin randomly
        RandSpin(100000);

        // Time fuse
        SetTimer(ExplosionTimer, False);
    }
    else
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
    }

    Super.PreBeginPlay();
}

event Timer()
{
    // Time fuse
    Hit(Base, Location, vector(Rotation));
}

simulated singular event HitWall( vector HitNormal, Actor Other )
{
    if( Role == ROLE_Authority )
    {
        // Explode on vehicles
        if( Vehicle(Other) != None )
            Hit(Other, Location, HitNormal);

        // Bounce or stick on everything else
        else if( !Bounce(Other, HitNormal) )
            Stick(Other, Location, HitNormal);
    }
    else
    {
        // Bounce on everything else
        if( Vehicle(Other) == None )
            Bounce(Other, HitNormal);
    }
}

function Stick(Actor Other, vector HitLocation, vector HitNormal)
{
    local rotator NewRotation;

    //gLog( "Stick" #GON(Other) #HitLocation #HitNormal );

    if( Role == ROLE_Authority )
    {
        // Adjust location and rotation
        AlignTo(Other, HitLocation, HitNormal, NewRotation);
        SetLocation(HitLocation);
        SetRotation(NewRotation);

        // Replicate offset for base or location
        if( Other != None )
            BaseOffset = (HitLocation - Other.Location) << Other.Rotation;
        else
            bUpdateSimulatedPosition = True;

        // Stick
        bCollideWorld = False;
        SetPhysics(PHYS_None);
        SetHardBase(Other, BaseOffset);

        // Replicate this tick
        NetUpdateTime = Level.TimeSeconds - 1;
    }
}

simulated event PostNetReceive()
{
    local Actor RealBase;

    //gLog( "PostNetReceive" );

    if( Role != ROLE_Authority )
    {
        // Get original base, watch out for SetPhysics()
        RealBase = Base;

        // Disable physics
        if( !bCollideWorld )
            SetPhysics(PHYS_None);

        // Rebase using accurate offset
        if( RealBase != None )
            SetHardBase(RealBase, BaseOffset);

        bNetNotify = Base == None || bCollideWorld;
    }
}

function HitEffects(Actor HitActor, vector HitLocation, vector HitNormal)
{
    // Explode up
    Super.HitEffects(HitActor, HitLocation, vect(0,0,1));
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ExplosionTimer                      = 3 // 5


    // gProjectile
    bIgnoreController                   = True
    bIgnoreTeamMates                    = True
    bHitProjTarget                      = False

    Health                              = 7
    ExtraGravity                        = 1

    HitEffectClass                      = class'GEffects.gNadeExplosion'

    BounceSound                         = Sound'G_Proc.cg_nade_hit'
    BounceEmitterClass                  = None//class'gGrenadeHitWall'

    ImpactSound                         = sound'G_Proc.cg_boom_b'
    ImpactSoundVolume                   = 2.0


    // Projectile
    Speed                               = 1152
    Damage                              = 100
    DamageRadius                        = 450
    MomentumTransfer                    = 50000
    MyDamageType                        = class'gDamTypeNade'


    // Actor
    CollisionRadius                     = 4
    CollisionHeight                     = 4
    bCanBeDamaged                       = True
    bProjTarget                         = True
    bNetNotify                          = True
    bFixedRotationDir                   = True
    DesiredRotation                     = (Pitch=12000,Yaw=5666,Roll=2334)

    ForceType                           = FT_Constant
    ForceScale                          = 5.0
    ForceRadius                         = 100.0
    FluidSurfaceShootStrengthMod        = 10.0

    bUnlit                              = False
    StaticMesh                          = StaticMesh'G_Meshes.combo_nade1'
    DrawScale                           = 0.3
}