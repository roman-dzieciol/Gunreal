// ============================================================================
//  gDamTypeHRLRocket.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeHRLRocket extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    ShakeClass                  = class'GEffects.gShake_HRL'

    // WeaponDamageType
    WeaponClass                 = class'gHRL'

    // DamageType
    DeathString                 = "%k [HRL] %o"
    MaleSuicide                 = "%o [HRL - Suicide]"
    FemaleSuicide               = "%o [HRL - Suicide]"

    ViewFlash                   = 0.3
    ViewFog                     = (X=900.00000,Y=0.000000,Z=0.00000)
    DamageEffect                = None
    DamageWeaponName            = "Heavy Rocket Launcher"
    bInstantHit                 = False
    bFastInstantHit             = False
    bAlwaysGibs                 = False
    bLocationalHit              = False
    bAlwaysSevers               = False
    bSpecial                    = False
    bDetonatesGoop              = True
    bSkeletize                  = False
    bCauseConvulsions           = False
    bSuperWeapon                = False
    bCausesBlood                = True
    bKUseOwnDeathVel            = True
    bKUseTearOffMomentum        = False
    bDelayedDamage              = True
    //bNeverSevers                = False
    bThrowRagdoll               = True
    bLeaveBodyEffect            = False
    bExtraMomentumZ             = True

    //bFlaming                    = True
    bFlaming                    = False
    bNeverSevers                = True
    bRubbery                    = False
    bCausedByWorld              = False
    bBulletHit                  = False
    bVehicleHit                 = False

    GibModifier                 = 1.1

    PawnDamageEffect            = None
    PawnDamageEmitter           = None
    PawnDamageSounds            = None

    LowGoreDamageEffect         = None
    LowGoreDamageEmitter        = None
    LowGoreDamageSounds         = None

    LowDetailEffect             = None
    LowDetailEmitter            = None

    FlashScale                  = 0.3
    FlashFog                    = (X=900.00000,Y=0.000000,Z=0.00000)

    DamageDesc                  = 1
    DamageThreshold             = 1
    DamageKick                  = (X=0.0,Y=0.0,Z=0.0)
    DamageOverlayMaterial       = None
    DeathOverlayMaterial        = None
    DamageOverlayTime           = 0
    DeathOverlayTime            = 0

    GibPerterbation             = 0.15


    KDeathVel                   = 800
    KDeathUpKick                = 0 //200

    VehicleDamageScaling        = 1.75
    VehicleMomentumScaling      = 1.75
}