//// ============================================================================
//  gTurretProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurretProjectile extends gProjectile;

simulated event PreBeginPlay()
{
    if( Role == ROLE_Authority )
    {
        // Add whizz-by volume
        Spawn(class'gTurretWhizzBy', Self);
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


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gProjectile
    HitGroupClass               = class'GEffects.gHitGroupTurret'
    AttachmentClass             = Class'GEffects.gTurretTracer'


    // Projectile
    Speed                       = 10000
    Damage                      = 15
    MomentumTransfer            = 15000
    MyDamageType                = class'gDamTypeTurret'
    bSwitchToZeroCollision      = True


    // Actor
    CollisionRadius             = 2
    CollisionHeight             = 2
    
    AmbientSound                = Sound'G_Sounds.pl_ballfly'
    SoundRadius                 = 192
}