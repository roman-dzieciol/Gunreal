// ============================================================================
//  gDamTypeMinigunHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeMinigunHE extends gDamTypeMinigun
    abstract;

DefaultProperties
{
    ShakeClass                  = class'GEffects.gShake_MiniHE'

    DamageWeaponName            = "Minigun HE"
    WeaponClass                 = class'gMinigunHE'
    VehicleDamageScaling        = 1.05

    bInstantHit                 = False
    bFastInstantHit             = False
    bDelayedDamage              = True
    bBulletHit                  = False
    bThrowRagdoll               = True
    bExtraMomentumZ             = True


    KDeathVel                   = 800
    KDeathUpKick                = 0 //200
}
