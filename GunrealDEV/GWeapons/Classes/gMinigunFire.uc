// ============================================================================
//  gMinigunFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunFire extends gInstantFire;

// ============================================================================
// Anim
// ============================================================================
function PlayPreFire();
function PlayStartHold();

function PlayFiring()
{
    if( Weapon.Mesh != None )
        Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);

    Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,Default.FireAnimRate/FireAnimRate,False);
    ClientPlayForceFeedback(FireForce);
    FireCount++;
}

function PlayFireEnd()
{
    if( Weapon.Mesh != None )
        Weapon.PlayAnim(FireEndAnim, FireEndAnimRate, TweenTime);
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // Minigun

    // gInstantFire
    FlashEffectClass            = class'GEffects.gMinigunFlash'
    FlashBone                   = "Muzzle"
    FlashBoneRotator            = (Pitch=0,Yaw=0,Roll=0)

    ShellActorClass             = class'gEffects.gShellMinigunJHP'
    ShellBone                   = "Shells"
    ShellBoneRotator            = (Pitch=0,Yaw=0,Roll=0)

    // Instant
    DamageType                  = class'GWeapons.gDamTypeMinigun'
    DamageMin                   = 15
    DamageMax                   = 15
    TraceRange                  = 16384

    // gWeaponFire
    AccuracyBase                = 0.05
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 1.0
    AccuracyRecoilShots         = 6


    FireSoundVolume     = 1.3

    ShellDetailMode             = DM_SuperHigh

    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = False
    bInstantHit                 = True

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
    FireAnim                    = ""
    FireLoopAnim                = "Fire"
    FireEndAnim                 = "Idle"
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.3

    FireSound                   = None
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireForce                   = "minifireb"

    FireRate                    = 0.107

    AmmoClass                   = class'gMinigunAmmo'
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

    AimError                    = 900

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}