// ============================================================================
//  gMineProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineProjectile extends gMineProjectileBase;


simulated event PreBeginPlay()
{
    if( Role != ROLE_Authority )
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
    }

    Super.PreBeginPlay();
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
        // Client just bounces
        if( Vehicle(Other) == None )
            Bounce(Other, HitNormal);
    }
}

simulated function AlignTo(Actor Other, out vector HitLocation, out vector HitNormal, out rotator HitRotation)
{
    local vector X,Y,Z;

    Super.AlignTo(Other, HitLocation, HitNormal, HitRotation);

    // Get "forward" rotation from "up" normal
    if( Abs(HitNormal dot vect(0,0,1)) > 0.999 )
    {
        HitRotation = rot(0,0,0);
    }
    else
    {
        Z = HitNormal;
        Y = Normal(vect(0,0,1) Cross Z);
        X = Normal(Y Cross Z);
        HitRotation = OrthoRotation(X,Y,Z);
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

    // gProjectile
    MineClass                   = class'gMineProjectileMine'

    BounceEmitterClass          = None//class'gLandMineHitWall'
    BounceSound                 = Sound'G_Sounds.cg_mine_disc_impact'
    BounceSoundVolume           = 1.0
    BounceSoundVolumeCurve      = 4.0
    BounceSoundRadius           = 230
    BounceSoundSlot             = SLOT_None

    ExtraGravity                = 1
    DampenFactor                = 0.1
    DampenFactorParallel        = 0.3
    StuckThreshold              = 1.0
    BounceThreshold             = 50
    BounceFXThreshold           = 300


    // Projectile
    Speed                       = 500
    bSwitchToZeroCollision      = True
}
