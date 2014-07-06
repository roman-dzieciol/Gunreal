// ============================================================================
//  gDestroyerProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerProjectile extends gProjectile;

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

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    AttachmentClass         = Class'GEffects.gDestroyerProjectileEmitter'
    HitEffectClass          = class'GEffects.gDestroyerExplosion'

    ImpactSound             = Sound'G_Proc.de_explode'
    ImpactSoundVolume       = 2.0
    ImpactSoundRadius       = 512

    //AmbientSound            = Sound'G_Sounds.de_ball-fly'

    // Projectile
    Speed                   = 2048
    Damage                  = 75
    DamageRadius            = 450
    MomentumTransfer        = 10000
    MyDamageType            = class'gDamTypeDestroyer'

    // Actor
    CollisionRadius         = 26
    CollisionHeight         = 26
    bOrientToVelocity       = True
}