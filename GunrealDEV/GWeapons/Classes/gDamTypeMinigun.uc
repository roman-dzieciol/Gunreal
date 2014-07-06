// ============================================================================
//  gDamTypeMinigun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeMinigun extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    // DamageType
    DeathString                 = "%k [Minigun] %o"
    MaleSuicide                 = "%o [Minigun - Suicide]"
    FemaleSuicide               = "%o [Minigun - Suicide]"

    ViewFlash                   = 0.3
    ViewFog                     = (X=900.00000,Y=0.000000,Z=0.00000)
    DamageEffect                = None
    DamageWeaponName            = "Minigun"
    bInstantHit                 = True
    bFastInstantHit             = True
    bAlwaysGibs                 = False
    bLocationalHit              = True
    bAlwaysSevers               = False
    bSpecial                    = False
    bDetonatesGoop              = False
    bSkeletize                  = False
    bCauseConvulsions           = False
    bSuperWeapon                = False
    bCausesBlood                = True
    bKUseOwnDeathVel            = True
    bKUseTearOffMomentum        = False
    bDelayedDamage              = False
    bNeverSevers                = False
    bLeaveBodyEffect            = False
    bFlaming                    = False
    bRubbery                    = False
    bCausedByWorld              = False
    bBulletHit                  = True
    bVehicleHit                 = False

    GibModifier                 = 1.2

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

    GibPerterbation             = 0.1


    KDeathVel                   = 0
    KDeathUpKick                = 0

    VehicleDamageScaling        = 1
    VehicleMomentumScaling      = 1

    // WeaponDamageType
    WeaponClass                 = class'gMinigun'
}