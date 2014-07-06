// ============================================================================
//  gDestroyerFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerFire extends gProjectileFire;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // gProjectileFire
    StartOffset                 = (X=40,Y=10,Z=0)

    // gWeaponFire
    AccuracyBase                = 0.05
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 1.0
    AccuracyRecoilShots         = 3

    // WeaponFire
    bSplashDamage               = True
    bSplashJump                 = False
    bRecommendSplashDamage      = True
    bLeadTarget                 = True
    bInstantHit                 = False

    bPawnRapidFireAnim          = True
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = False
    bModeExclusive              = False

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
    TweenTime                   = 0.05

    FireSound                   = Sound'G_Sounds.de_fire_proc'
    FireSoundVolume             = 5.0
    
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireRate                    = 0.8

    AmmoClass                   = class'gDestroyerAmmo'
    AmmoPerFire                 = 7

    ShakeOffsetMag              = (X=1.0,Y=1.0,Z=1.0)
    ShakeOffsetRate             = (X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate                = (X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime                = 2

    ProjectileClass             = class'gDestroyerProjectile'

    BotRefireRate               = 0.99

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}