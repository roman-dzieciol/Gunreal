// ============================================================================
//  gSniperZoom.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSniperZoom extends gNoFire;

function DoFireEffect()
{
    //gLog( "DoFireEffect" );
}

function PlayPreFire();
function PlayStartHold();
function PlayFiring();
function PlayFireEnd();


DefaultProperties
{
    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = False
    bInstantHit                 = True

    bPawnRapidFireAnim          = False
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = True
    bModeExclusive              = False

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = ""
    FireAnim                    = ""
    FireLoopAnim                = ""
    FireEndAnim                 = ""
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

    FireRate                    = 0.075

    AmmoClass                   = None
    AmmoPerFire                 = 0

    ShakeOffsetMag              = (X=0.0,Y=0.0,Z=0.0)
    ShakeOffsetRate             = (X=0.0,Y=0.0,Z=0.0)
    ShakeOffsetTime             = 0
    ShakeRotMag                 = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotRate                = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotTime                = 0

    ProjectileClass             = None

    BotRefireRate               = 0.3

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}