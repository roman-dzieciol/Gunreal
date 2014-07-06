// ============================================================================
//  gDamTypeDestroyer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeDestroyer extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    ShakeClass                  = class'GEffects.gShake_Destroyer'

    // DamageType
    DeathString                 = "%k [The Destroyer] %o"
    MaleSuicide                 = "%o [The Destroyer - Suicide]"
    FemaleSuicide               = "%o [The Destroyer - Suicide]"

    ViewFlash                   = 0.3
    ViewFog                     = (X=900.00000,Y=0.000000,Z=0.00000)

    DamageWeaponName            = "The Destroyer"

    bDetonatesGoop              = True
    bCausesBlood                = True
    bKUseOwnDeathVel            = True
    bDelayedDamage              = True
    bThrowRagdoll               = True
    bFlaming                    = True
    bExtraMomentumZ             = True

    GibModifier                 = 1.1

    FlashScale                  = 0.3
    FlashFog                    = (X=900.00000,Y=0.000000,Z=0.00000)

    KDeathVel                   = 700

    VehicleDamageScaling        = 2

    // WeaponDamageType
    WeaponClass                 = class'gDestroyer'
}