// ============================================================================
//  gHRLFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLFireAlt extends gTossFire;

// ============================================================================
// Firing
// ============================================================================
/*function PlayFiring()
{
    if( Weapon.Mesh != None )
    {
        if( FireCount > 0 )
        {
            if( Weapon.HasAnim(FireLoopAnim) )
            {
                Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);

                if( FireLoopSound != None )
                    Weapon.PlayOwnedSound(FireLoopSound, FireLoopSoundSlot, FireLoopSoundVolume,, FireLoopSoundRadius);
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

    Weapon.PlayOwnedSound(FireSound, SLOT_Interact, TransientSoundVolume,, TransientSoundRadius, default.FireAnimRate / FireAnimRate,False);
    ClientPlayForceFeedback(FireForce);  // jdf

    if( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire )
        Weapon.PlayOwnedSound(ReloadSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);
    else
        Weapon.PlayOwnedSound(ReloadFailSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);

    FireCount++;
}*/

event Timer()
{
    if( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire )
        Weapon.PlayOwnedSound(ReloadSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);
    else
        Weapon.PlayOwnedSound(ReloadFailSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);
}

function PlayFiring()
{
    Super.PlayFiring();

    SetTimer(1.0, False);

    /*if( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire )
        Weapon.PlayOwnedSound(ReloadSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);
    else
        Weapon.PlayOwnedSound(ReloadFailSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);*/
}

function ServerPlayFiring()
{
    Super.ServerPlayFiring();

    SetTimer(1.0, False);

    /*if( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire )
        Weapon.PlayOwnedSound(ReloadSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);
    else
        Weapon.PlayOwnedSound(ReloadFailSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);*/
}

simulated function bool AllowFire()
{
    if( Bot(Instigator.Controller) != None )
    {
        if( !IsInTossRange(gWeapon(Weapon).GetBotTarget()) )
        {
            Bot(Instigator.Controller).StopFiring();

            return False;
        }
    }

    return Super(gProjectileFire).AllowFire();
}

function Projectile SpawnProjectile(vector Start, rotator Dir)
{
    local Projectile P;

    P = Super.SpawnProjectile(Start, Dir);

    if( P != None )
        gHRL(Weapon).NotifyProjectileSpawned(ThisModeNum, P);

    return P;
}

// ============================================================================
// AI
// ============================================================================
simulated function vector AdjustTossDest(Actor Target)
{
    local vector Dir;

    if( gPawn(Target) != None )
    {
        // aim at feet so rocket can deal splash damage
        Dir = Target.Location-Instigator.Location;

        if( Target.Base != None && Dir.Z < 0 && gPawn(Target) != None )
        {
            Dir = Target.Location-Instigator.Location;
            return Target.Location - vect(0,0,1.0)*Target.CollisionHeight - Normal(Dir*vect(1,1,0))*Target.CollisionRadius*1.5;
        }
    }

    return Target.Location;
}

function float MaxRange()
{
    return 16384;
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ProjectileClass             = class'GWeapons.gHRLBeacon'
    StartOffset                 = (X=50,Y=6,Z=-20)

    // gWeaponFire
    bAccuracyBase               = False
    bAccuracyRecoil             = False
    bAccuracyStance             = False

    // WeaponFire
    bSplashDamage               = True
    bSplashJump                 = True
    bRecommendSplashDamage      = True
    bLeadTarget                 = True
    bInstantHit                 = False

    bPawnRapidFireAnim          = False
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = True
    bModeExclusive              = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = ""
    FireAnim                    = "alt"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 3.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Sounds.hrl_homing_fire'
    ReloadSound                 = Sound'G_Sounds.hrl_homing_reload'
    ReloadFailSound             = Sound'G_Sounds.hrl_homing_reload_empty'
    NoAmmoSound                 = Sound'g_Sounds.hrl_fire_noammo'

    FireRate                    = 3.0

    AmmoClass                   = class'gHRLBeaconAmmo'
    AmmoPerFire                 = 0

    ShakeOffsetMag              = (X=-20.0,Y=0.00,Z=0.00)
    ShakeOffsetRate             = (X=-1000.0,Y=0.0,Z=0.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotRate                = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotTime                = 2


    BotRefireRate               = 0.99

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}
