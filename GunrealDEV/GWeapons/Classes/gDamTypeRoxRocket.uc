// ============================================================================
//  gDamTypeRoxRocket.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeRoxRocket extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    ShakeClass                  = class'GEffects.gShake_RL'

    DeathString                 = "%k [Rocket] %o."
    MaleSuicide                 = "%o [Rocket - Suicide]"
    FemaleSuicide               = "%o [Rocket - Suicide]"

    WeaponClass                 = class'gRox'
    bDetonatesGoop              = True
    KDamageImpulse              = 20000
    VehicleMomentumScaling      = 2.5
    VehicleDamageScaling        = 2.5
    bThrowRagdoll               = True
    GibPerterbation             = 0.15

    bFlaming                    = False
    bNeverSevers                = True
    bDelayedDamage              = True
    bExtraMomentumZ             = True
}