// ============================================================================
//  gMinigunProjectileHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunProjectileHE extends gMinigunProjectile;


DefaultProperties
{
    // gProjectile
    HitGroupClass               = class'GEffects.gHitGroupHE'


    // Projectile
    Speed                       = 10000
    Damage                      = 50
    DamageRadius                = 300
    MomentumTransfer            = 50000
    MyDamageType                = class'gDamTypeMinigunHE'
    bSwitchToZeroCollision      = True


    // Actor
    CollisionRadius             = 2
    CollisionHeight             = 2
}
