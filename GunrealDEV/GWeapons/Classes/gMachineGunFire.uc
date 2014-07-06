// ============================================================================
//  gMachineGunFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachineGunFire extends gMinigunProjectileFire;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ProjectileClass             = class'gMachineGunBullet'
    StartOffset                 = (X=25,Y=5,Z=-10)

    FlashEffectClass            = class'GEffects.gMachinegunFlash'
    FlashBone                   = "Dummy02"
    FlashBoneRotator            = (Pitch=0,Yaw=32768,Roll=0)

    ShellActorClass             = None
    ShellBone                   = "Shells"
    ShellBoneRotator            = (Pitch=0,Yaw=0,Roll=0)

    // gWeaponFire
    AccuracyBase                = 0.025
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 1.0
    AccuracyRecoilShots         = 3

    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = False
    bInstantHit                 = False

    bPawnRapidFireAnim          = True
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
    FireLoopAnim                = "Fire"
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 3.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Proc.amg_p_fire'
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireRate                    = 0.23

    AmmoClass                   = class'gMachineGunAmmo'
    AmmoPerFire                 = 1

    ShakeOffsetMag              = (X=1.0,Y=1.0,Z=1.0)
    ShakeOffsetRate             = (X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate                = (X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime                = 2

    BotRefireRate               = 0.99

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}