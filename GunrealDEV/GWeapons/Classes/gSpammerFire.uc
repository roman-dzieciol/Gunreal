// ============================================================================
//  gSpammerFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerFire extends gTossFire;


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
    if( gSpammer(Weapon).CurrentMines >= gSpammer(Weapon).MaxMines )
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
// Anim
// ============================================================================

function PlayPreFire()
{
}

function PlayStartHold()
{
}

function PlayFiring()
{
    if( Weapon.AmmoAmount(ThisModeNum) == 0 )
    {
        Weapon.LoopAnim(Weapon.IdleAnim, Weapon.IdleAnimRate, 0.0);
        return;
    }

    if( Weapon.Mesh != None )
    {
        Weapon.LoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
    }

    Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,Default.FireAnimRate/FireAnimRate,False);
    ClientPlayForceFeedback(FireForce);
    FireCount++;
}

function PlayFireEnd()
{
    if( Weapon.Mesh != None )
    {
        Weapon.PlayAnim(FireEndAnim, FireEndAnimRate, TweenTime);
    }
}




// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // gSpammerFire

    TeamProjectileClass(0)      = class'gSpammerProjectileRed'
    TeamProjectileClass(1)      = class'gSpammerProjectileBlue'

    MaxMinesSound               = Sound'G_Sounds.sp_fire_cant'
    MaxMinesSoundVolume         = 0.6
    MaxMinesSoundRadius         = 300
    MaxMinesSoundSlot           = SLOT_None
    MaxMinesSoundTime           = 1

    // gProjectileFire
    StartOffset             = (X=40,Y=20,Z=-10)

    // gWeaponFire
    AccuracyBase                = 0.05
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 0.5
    AccuracyRecoilShots         = 8

    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = True
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
    FireAnim                    = ""
    FireLoopAnim                = "Fire"
    FireEndAnim                 = "FireEnd"
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.3

    FireSound                   = Sound'G_Proc.sp_p_fire'
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireRate                    = 0.25
    ProjectileClass             = class'GWeapons.gSpammerProjectile'

    AmmoClass                   = class'gSpammerAmmo'
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
