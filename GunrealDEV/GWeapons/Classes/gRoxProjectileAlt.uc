// ============================================================================
//  gRoxProjectileAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRoxProjectileAlt extends gRoxProjectileBase;


simulated event PreBeginPlay()
{
    if( Role != ROLE_Authority )
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
        bCollideWorld = False;
    }

    Super.PreBeginPlay();
}

simulated singular event HitWall(vector HitNormal, Actor Other)
{
    //gLog( "HitWall" #GON(Other) #HitNormal );
    if( Role == ROLE_Authority )
    {
        // Stick to everything
        Stick(Other, Location, HitNormal);
    }
}

simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "TouchTarget" #GON(Other) #HitLocation #HitNormal );
    if( Role == ROLE_Authority )
    {
        // Stick to everything
        Stick(Other, HitLocation, HitNormal);
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gProjectile
    MineClass                   = class'gRoxProjectileMine'
    bIgnoreTeamMates            = True
    bIgnoreController           = True
    bHitProjTarget              = False
    Health                      = 1


    // Projectile
    Speed                       = 1536
    bSwitchToZeroCollision      = True


    // Actor
    CollisionRadius             = 2
    CollisionHeight             = 2
    bCanBeDamaged               = True
    bProjTarget                 = True
    bUseCollisionStaticMesh     = True
    bFixedRotationDir           = True
    RotationRate                = (Roll=50000)
    DesiredRotation             = (Roll=30000)

    bUnlit                      = False
}
