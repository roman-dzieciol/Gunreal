// ============================================================================
//  gHRLFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLFire extends gTossFire;

var() class<Emitter>    BlowbackClass;
var() name              BlowbackBone;

// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.BlowbackClass);
}

// ============================================================================
// Firing
// ============================================================================
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

function StartMuzzleSmoke()
{
    local Emitter E;

    Super.StartMuzzleSmoke();

    if( BlowbackClass != None )
        E = Spawn(BlowbackClass,,, Weapon.GetBoneCoords(BlowbackBone).Origin, Weapon.GetBoneRotation(BlowbackBone, 0));
}

simulated function bool AllowFire()
{
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
    if( gPawn(Target) != None )
    {
        // aim at feet so rocket can deal splash damage
        if( Target.Location.Z < Instigator.Location.Z )
            return Target.Location - vect(0,0,0.9) * Target.CollisionHeight;
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
    BlowbackClass               = class'GEffects.gHRLBlowback'
    BlowbackBone                = "blowback"

    ProjectileClass             = class'GWeapons.gHRLProjectile'
    StartOffset                 = (X=50,Y=6,Z=-20)

    FlashEffectClass            = None
    ShellActorClass             = None

    // gWeaponFire
    AccuracyBase                = 0.05
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 1.0
    AccuracyRecoilShots         = 3

    // WeaponFire
    bSplashDamage               = True
    bSplashJump                 = True
    bRecommendSplashDamage      = True
    bLeadTarget                 = True
    bInstantHit                 = False

    bPawnRapidFireAnim          = True
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = False
    bModeExclusive              = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = ""
    FireAnim                    = "Fire"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 3.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Sounds.hrl_fire'
    FireSoundVolume             = 2.0
    FireSoundRadius             = 256
    FireSoundSlot               = SLOT_Interact

    FireEndSoundVolume          = 4.0
    FireEndSoundRadius          = 256
    FireEndSoundSlot            = SLOT_None

    ReloadSound                 = Sound'G_Sounds.hrl_reload'
    ReloadFailSound             = Sound'G_Sounds.hrl_reload_empty'
    NoAmmoSound                 = Sound'g_Sounds.hrl_fire_noammo'

    FireRate                    = 4.0

    AmmoClass                   = class'gHRLAmmo'
    AmmoPerFire                 = 1

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