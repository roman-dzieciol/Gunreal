// ============================================================================
//  gPistolFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistolFire extends gProjectileFire;

var float RotateDelay;

event ModeDoFire()
{
    if( !AllowFire() )
        return;

    // server and client may go out of sync here
    if( ++gPistol(Weapon).ShotsFired % 2 == 0 )
    {
        FireRate = default.FireRate + RotateDelay;
        FireAnim = 'primaryfire';
        SetTimer(0.4, False);
    }
    else
    {
        FireRate = default.FireRate;
        FireAnim = default.FireAnim;
    }
    Super.ModeDoFire();
}

event Timer()
{
    if( FireLoopSound != None )
        Weapon.PlayOwnedSound(FireLoopSound, FireLoopSoundSlot, FireLoopSoundVolume,, FireLoopSoundRadius);
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    RotateDelay                 = 1.0

    // gProjectileFire
    ProjPerFire                 = 1
    StartOffset                 = (X=25,Y=9,Z=-10)

    // gWeaponFire
    AccuracyBase                = 0.01
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 0.5
    AccuracyRecoilShots         = 8

    FireLoopSound               = Sound'G_Sounds.ap_switch'
    FireLoopSoundVolume         = 1.0
    FireLoopSoundRadius         = 256
    FireLoopSoundSlot           = SLOT_Misc

    // WeaponFire
    bSplashDamage               = True
    bSplashJump                 = False
    bRecommendSplashDamage      = False
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
    FireAnim                    = "primfire_1stshell"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Proc.ap_p_fire'
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireForce                   = "TranslocatorFire"

    FireRate                    = 0.4

    ProjectileClass             = class'GWeapons.gPistolBullet'

    AmmoClass                   = class'gPistolAmmo'
    AmmoPerFire                 = 1

    ShakeOffsetMag              = (X=1.0,Y=1.0,Z=1.0)
    ShakeOffsetRate             = (X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate                = (X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime                = 2

    BotRefireRate               = 0.9

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    AimError                    = 700

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}