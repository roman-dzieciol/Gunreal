// ============================================================================
//  gRoxFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRoxFire extends gProjectileFire;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // gProjectileFire
    StartOffset                 = (X=25,Y=15,Z=-20)

    // gWeaponFire
    AccuracyBase                = 0.05
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 0.5
    AccuracyRecoilShots         = 1

    // WeaponFire
    bSplashDamage               = True
    bSplashJump                 = True
    bRecommendSplashDamage      = True
    bLeadTarget                 = True
    bInstantHit                 = False

    bPawnRapidFireAnim          = False
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = False
    bModeExclusive              = True

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = ""
    FireAnim                    = "Fire"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Sounds.rl_fire1'
    FireSoundVolume             = 2.0
    FireSoundRadius             = 256
    FireSoundSlot               = SLOT_Interact

    ReloadSound                 = None
    NoAmmoSound                 = None

    FireRate                    = 1.5
    ProjectileClass             = class'GWeapons.gRoxProjectile'

    AmmoClass                   = class'gRoxAmmo'
    AmmoPerFire                 = 1

    ShakeOffsetMag              = (X=-20.0,Y=0.00,Z=0.00)
    ShakeOffsetRate             = (X=-1000.0,Y=0.0,Z=0.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotRate                = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotTime                = 2

    BotRefireRate               = 0.5

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}