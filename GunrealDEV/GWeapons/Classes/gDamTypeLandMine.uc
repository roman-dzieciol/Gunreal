// ============================================================================
//  gDamTypeLandMine.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeLandMine extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    ShakeClass                  = class'GEffects.gShake_Mine'

    DeathString                 = "%k [Land Mine] %o"
    MaleSuicide                 = "%o [Land Mine - Suicide]"
    FemaleSuicide               = "%o [Land Mine - Suicide]"

    WeaponClass                 = class'gMineGun'
    bDetonatesGoop              = True
    KDamageImpulse              = 20000
    VehicleMomentumScaling      = 4.0
    VehicleDamageScaling        = 2.0
    bThrowRagdoll               = True
    GibPerterbation             = 0.15

    bFlaming                    = False
    bNeverSevers                = True
    bDelayedDamage              = True
    bExtraMomentumZ             = True
}