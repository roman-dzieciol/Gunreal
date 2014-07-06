// ============================================================================
//  gNadeFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gNadeFire extends gTossFire;



function bool PlayReload()
{   
    if( !Weapon.HasAmmo() )
        return false;

    if( Weapon.Mesh != None && Weapon.HasAnim(ReloadAnim) )
        Weapon.PlayAnim(ReloadAnim, ReloadAnimRate, 0.0);
    else
        return false;
        
    if( ReloadSound != None )
        Weapon.PlayOwnedSound(ReloadSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);
    
    return true;
}

// ============================================================================
// AI
// ============================================================================
function rotator AdjustAim(vector Start, float InAimError)
{
    // Override bot aim adjustment
    if( Bot(Instigator.Controller) != None )
        return AdjustTossAim(Start, InAimError, Bot(Instigator.Controller));

    return Super.AdjustAim(Start, InAimError);
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gProjectileFire
    StartOffset                 = (X=25,Y=5,Z=-20)

    // gWeaponFire
    AccuracyBase                = 0.001
    AccuracyMultStance          = 0.2
    AccuracyMultRecoil          = 0.2
    AccuracyRecoilRegen         = 0.5
    AccuracyRecoilShots         = 1

    // WeaponFire
    bSplashDamage               = False
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
    FireAnim                    = "grenade-fire"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = "normal-down"

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Sounds.cg_nade_fire'
    ReloadSound                 = Sound'G_Sounds.cg_reload_grp'
    NoAmmoSound                 = None

    FireRate                    = 1.66
    ProjectileClass             = class'GWeapons.gNadeProjectile'

    AmmoClass                   = class'gNadeAmmo'
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
