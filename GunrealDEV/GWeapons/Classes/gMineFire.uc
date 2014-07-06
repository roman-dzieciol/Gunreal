// ============================================================================
//  gMineFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineFire extends gTossFire;

var()   Sound               MaxMinesSound;
var()   float               MaxMinesSoundVolume;
var()   float               MaxMinesSoundRadius;
var()   Actor.ESoundSlot    MaxMinesSoundSlot;
var()   float               MaxMinesSoundTime;

// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.MaxMinesSound);
}

// ============================================================================
// Firing
// ============================================================================

simulated function bool AllowFire()
{
    if( gMineGun(Weapon).CurrentMines >= gMineGun(Weapon).MaxMines )
    {
        if( MaxMinesSound != None && MaxMinesSoundTime < Level.TimeSeconds )
        {
            Weapon.PlayOwnedSound(MaxMinesSound,MaxMinesSoundSlot,MaxMinesSoundVolume,,MaxMinesSoundRadius);
            MaxMinesSoundTime = Level.TimeSeconds + default.MaxMinesSoundTime;
        }
        return False;
    }

    return Super.AllowFire();
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    TeamProjectileClass(0)             = class'GWeapons.gMineProjectile'
    TeamProjectileClass(1)             = class'GWeapons.gMineProjectileBlue'

    MaxMinesSound               = Sound'G_Sounds.sp_fire_cant'
    MaxMinesSoundVolume         = 0.6
    MaxMinesSoundRadius         = 300
    MaxMinesSoundSlot           = SLOT_None
    MaxMinesSoundTime           = 1

    // gProjectileFire
    StartOffset                 = (X=25,Y=15,Z=-20)

    // gWeaponFire
    AccuracyBase                = 0.05
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
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
    bModeExclusive              = False

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = ""
    FireAnim                    = "landmine-fire"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = "normal-to-landmine"

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Sounds.cg_mine_fire'
    ReloadSound                 = Sound'G_Sounds.cg_reload_grp'
    NoAmmoSound                 = None

    FireRate                    = 1.1
    ProjectileClass             = class'GWeapons.gMineProjectile'

    AmmoClass                   = class'gMineAmmo'
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