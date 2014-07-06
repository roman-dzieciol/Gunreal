// ============================================================================
//  gSpammerProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerProjectile extends gSpammerProjectileBase;


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
    //gLog( "HitWall" #GON(Other) );

    if( Role == ROLE_Authority )
    {
        // Explode on vehicles
        if( Vehicle(Other) != None )
            Hit(Other, Location, HitNormal);

        // Stick on everything else
        else
            Stick(Other, Location, HitNormal);
    }
}

simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "TouchTarget" #GON(Other) #HitLocation #HitNormal );

    // Reflect off sticked projectiles
    if( gSpammerProjectileMine(Other) != None )
    {
        Velocity = VSize(Velocity) * 0.33 * Normal(vector(Other.Rotation)*0.9 + VRand() * 0.1);
        Other.Trigger(self,None);
    }

    // Detonate on everything else
    else
        Hit(Other, Location, HitNormal);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gProjectile
    Health                      = 40
    ExtraGravity                = 0.5
    DetonateDelay               = (Min=0.05,Max=0.25)
    bHitProjTarget              = True

    MineClass                   = class'gSpammerProjectileMine'

    // Projectile
    Speed                       = 1024


    // Actor
    bCanBeDamaged               = True
    bProjTarget                 = True
    bUseCollisionStaticMesh     = True
    LifeSpan                    = 0
    bFixedRotationDir           = True
    RotationRate                = (Pitch=-131070,Yaw=0,Roll=0)
}
