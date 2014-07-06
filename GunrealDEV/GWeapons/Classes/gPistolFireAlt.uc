// ============================================================================
//  gPistolFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistolFireAlt extends gProjectileFire;

function PlayFiring()
{
    if( Weapon.Mesh != None )
    {
        if( FireCount > 0 )
        {
            if( Weapon.HasAnim(FireLoopAnim) )
            {
                Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
            }
            else
            {
                Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
            }
        }
        else
        {
            Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
        }
    }
    Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,Default.FireAnimRate/FireAnimRate,False);
    ClientPlayForceFeedback(FireForce);  // jdf

    if( FireLoopSound != None )
        Weapon.PlayOwnedSound( FireLoopSound, FireLoopSoundSlot, FireLoopSoundVolume,, FireLoopSoundRadius );

    FireCount++;
}

function PlayFireEnd()
{
    local name Seq;
    local float Frame, Rate;

    if( Weapon.Mesh != None && Weapon.HasAnim(FireEndAnim) )
    {
        Weapon.GetAnimParams( 0, Seq, Frame, Rate );
        if( Seq != FireLoopAnim )
        {
            Weapon.PlayAnim(FireEndAnim, FireEndAnimRate, 0.0, 0);
        }
    }

    if( FireEndSound != None )
    {
        Weapon.PlayOwnedSound( FireEndSound, FireEndSoundSlot, FireEndSoundVolume,, FireEndSoundRadius );
    }
}

function PlayPreFire()
{
    if( Weapon.Mesh != None && Weapon.HasAnim(PreFireAnim) )
    {
        Weapon.AnimBlendParams(1,1,0,0);
        Weapon.PlayAnim(PreFireAnim, PreFireAnimRate, TweenTime, 0);
    }

    if( PreFireSound != None )
    {
        Weapon.PlayOwnedSound( PreFireSound, PreFireSoundSlot, PreFireSoundVolume,, PreFireSoundRadius );
    }
}

DefaultProperties
{
    // gProjectileFire
    ProjPerFire                 = 1
    StartOffset                 = (X=25,Y=9,Z=-12)

    // gWeaponFire
    AccuracyBase                = 0.05
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 0.5
    AccuracyRecoilShots         = 8

    PreFireSound                = Sound'G_Sounds.ap_spinup'
    PreFireSoundVolume          = 1.0
    PreFireSoundRadius          = 256
    PreFireSoundSlot            = SLOT_Misc

    FireLoopSound               = Sound'G_Sounds.ap_spin_loop'
    FireLoopSoundVolume         = 1.0
    FireLoopSoundRadius         = 256
    FireLoopSoundSlot           = SLOT_Misc

    FireEndSound                = Sound'G_Sounds.ap_spindown'
    FireEndSoundVolume          = 1.0
    FireEndSoundRadius          = 256
    FireEndSoundSlot            = SLOT_Misc

    // WeaponFire
    bSplashDamage               = True
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = True
    bInstantHit                 = False

    bPawnRapidFireAnim          = True
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = False
    bModeExclusive              = True

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0.17
    MaxHoldTime                 = 0.0

    PreFireAnim                 = "altbegin"
    FireAnim                    = "altfireloop"
    FireLoopAnim                = "altfireloop"
    FireEndAnim                 = "altend"
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

    FireRate                    = 0.25
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

    AimError                    = 800

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}