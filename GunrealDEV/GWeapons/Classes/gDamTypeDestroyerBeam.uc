// ============================================================================
//  gDamTypeDestroyerBeam.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeDestroyerBeam extends gDamTypeWeapon
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

    bCausesBlood                = True
    bKUseOwnDeathVel            = True
    bThrowRagdoll               = True
    bFlaming                    = True

    bBulletHit                  = True
    bDetonatesGoop              = True
    bDelayedDamage              = True

    KDeathVel                   = 700
    KDeathUpKick                = 0


    GibModifier                 = 1.1

    FlashScale                  = 0.3
    FlashFog                    = (X=900.00000,Y=0.000000,Z=0.00000)


    VehicleDamageScaling        = 1

    // WeaponDamageType
    WeaponClass                 = class'gDestroyer'
}