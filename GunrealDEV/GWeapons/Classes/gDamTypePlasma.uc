// ============================================================================
//  gDamTypePlasma.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypePlasma extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    // DamageType
    DeathString                 = "%k [Plasma] %o"
    MaleSuicide                 = "%o [Plasma - Suicide]"
    FemaleSuicide               = "%o [Plasma - Suicide]"

    ViewFlash                   = 0.3
    ViewFog                     = (X=900.00000,Y=0.000000,Z=0.00000)
    DamageEffect                = None
    DamageWeaponName            = "Plasma Gun"
    bInstantHit                 = False
    bFastInstantHit             = False
    bAlwaysGibs                 = False
    bLocationalHit              = False
    bAlwaysSevers               = False
    bSpecial                    = False
    bDetonatesGoop              = True
    bSkeletize                  = False
    bCauseConvulsions           = True
    bSuperWeapon                = True
    bCausesBlood                = True
    bKUseOwnDeathVel            = True
    bKUseTearOffMomentum        = False
    bDelayedDamage              = True
    bNeverSevers                = False
    bLeaveBodyEffect            = False
    bFlaming                    = True
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
    DamageOverlayMaterial       = Material'UT2004Weapons.ShockHitShader'
    DeathOverlayMaterial        = Material'UT2004Weapons.ShockHitShader'
    DamageOverlayTime           = 1
    DeathOverlayTime            = 3

    GibPerterbation             = 0.1


    KDeathVel                   = 0
    KDeathUpKick                = 0

    VehicleDamageScaling        = 1
    VehicleMomentumScaling      = 1

    // WeaponDamageType
    WeaponClass                 = class'gPlasmaGun'
}