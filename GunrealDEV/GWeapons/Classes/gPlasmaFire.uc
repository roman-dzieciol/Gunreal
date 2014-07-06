// ============================================================================
//  gPlasmaFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaFire extends gPlasmaFireBase;

// =============================================================================
// Anim
// =============================================================================
function PlayFiring()
{
    Super.PlayFiring();

    if( BoostedFireSound != None && gPlasmaGun(Weapon).GetBoostDamageAtten() > 1 )
        Weapon.PlayOwnedSound(BoostedFireSound, SLOT_None, BoostedFireSoundVolume,, BoostedFireSoundRadius);
}

function ServerPlayFiring()
{
    Super.ServerPlayFiring();

    if( BoostedFireSound != None && gPlasmaGun(Weapon).GetBoostDamageAtten() > 1 )
        Weapon.PlayOwnedSound(BoostedFireSound, SLOT_None, BoostedFireSoundVolume,, BoostedFireSoundRadius);
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // gWeaponFire
    AccuracyBase                        = 0.01
    AccuracyMultStance                  = 1.0
    AccuracyMultRecoil                  = 1.0
    AccuracyRecoilRegen                 = 0.4
    AccuracyRecoilShots                 = 5 //3

    bIsAltFire                          = False
    FlashEffectClass                    = class'GEffects.gPlasmaFlash'
    FlashBone                           = "Muzzle"

    BoostedProjectileClass              = class'gPlasmaProjectileBoosted'
    TeamProjectileClass(0)              = class'gPlasmaProjectileRed'
    TeamProjectileClass(1)              = class'gPlasmaProjectile'
    BoostedTeamProjectileClass(0)       = class'gPlasmaProjectileBoostedRed'
    BoostedTeamProjectileClass(1)       = class'gPlasmaProjectileBoosted'

    BoostedFireSound                    = Sound'G_Sounds.pl_boostfire'
    BoostedFireSoundVolume              = 1.0
    BoostedFireSoundRadius              = 512

    bSplashDamage                       = False
    bSplashJump                         = False
    bRecommendSplashDamage              = False
    bLeadTarget                         = True
    bInstantHit                         = False

    bPawnRapidFireAnim                  = False
    bReflective                         = False
    bFireOnRelease                      = False
    bWaitForRelease                     = False
    bModeExclusive                      = True

    bAttachSmokeEmitter                 = False
    bAttachFlashEmitter                 = False

    PreFireTime                         = 0
    MaxHoldTime                         = 0

    PreFireAnim                         = "PreFire"
    FireAnim                            = "alt-fire"
    FireLoopAnim                        = "FireLoop"
    FireEndAnim                         = "FireEnd"
    ReloadAnim                          = "Reload"

    PreFireAnimRate                     = 1.0
    FireAnimRate                        = 1.0
    FireLoopAnimRate                    = 1.0
    FireEndAnimRate                     = 1.0
    ReloadAnimRate                      = 1.0
    TweenTime                           = 0.1

    FireSound                           = Sound'G_Proc.pl_p_fire'
    ReloadSound                         = None
    NoAmmoSound                         = None

    FireRate                            = 0.2 //0.4

    AmmoClass                           = class'gPlasmaAmmo'
    AmmoPerFire                         = 1

    ShakeRotMag                         = (X=70.0,Y=0.0,Z=0.0)
    ShakeRotRate                        = (X=1000.0,Y=0.0,Z=0.0)
    ShakeRotTime                        = 1.8
    ShakeOffsetMag                      = (X=0.0,Y=0.0,Z=-2.0)
    ShakeOffsetRate                     = (X=0.0,Y=0.0,Z=1000.0)
    ShakeOffsetTime                     = 1.8

    ProjectileClass                     = class'gPlasmaProjectile'

    BotRefireRate                       = 0.66

    FlashEmitterClass                   = None
    SmokeEmitterClass                   = None

    TransientSoundVolume                = 1.0
    TransientSoundRadius                = 512
}