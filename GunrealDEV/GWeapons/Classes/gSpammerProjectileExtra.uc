// ============================================================================
//  gSpammerProjectileExtra.uc :: Spawned when spammer mines 'jump'
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerProjectileExtra extends gSpammerProjectileBase;


var() float      JumpLife;


simulated event PreBeginPlay()
{
    // Disable collision on client and temporarily on server
    bCollideWorld = False;
    bProjTarget = False;

    Super.PreBeginPlay();
}

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( Role == ROLE_Authority )
    {
        // Increase timer in water as the projectile moves slower
        if( PhysicsVolume.bWaterVolume )
            JumpLife *= 2;

        // Time fuse
        SetTimer(JumpLife, False);
    }
}

simulated function InitMine(gProjectile Spawner, Actor NewBase)
{
    if( Role == ROLE_Authority )
    {
        // Fixup rotation
        SetRotation(Spawner.Rotation);

        // Add base velocity
        if( Base != None )
            Velocity += NewBase.Velocity;

        // Enable collision
        bCollideWorld = True;
        bProjTarget = True;
    }
}

event Timer()
{
    // Time fuse
    Hit(Base, Location, vector(Rotation));
}

singular event HitWall(vector HitNormal, Actor Other)
{
    // Explode on collision
    if( Role == ROLE_Authority )
        Hit(Other, Location, HitNormal);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    JumpLife                = 0.133


    // gProjectile
    bRegisterProjectile     = False

    SpawnSound              = Sound'G_Sounds.sp_bounce_alert'
    SpawnSoundVolume        = 2.0
    SpawnSoundRadius        = 256
    SpawnSoundSlot          = SLOT_None


    // Projectile
    Speed                   = 800


    // Actor
    bCollideActors          = False
    bOrientToVelocity       = True
    bBounce                 = False

    PrePivot                = (X=48,Y=0,Z=0)
}