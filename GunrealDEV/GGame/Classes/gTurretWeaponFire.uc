// ============================================================================
//  gTurretWeaponFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurretWeaponFire extends gProjectileFire;






// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
}


// ============================================================================
// Firing
// ============================================================================
function DoFireEffect()
{
    local vector StartTrace, HL, HN;
    local rotator R;
    local Actor HitActor;
    local vector X,Y,Z;

    if( Instigator == None )
        return;

    Instigator.MakeNoise(1.0);

    // Get starting points
    Weapon.GetViewAxes(X, Y, Z);
    StartTrace = gTurret(Instigator).GetFireStart() + X*StartOffset.X + Z*StartOffset.Z;

    if( gTurretWeapon(Weapon).ShotsFired % 2 != 0 )
        StartTrace += gTurretWeapon(Weapon).Get2ndBarrelOffset();
    else
        StartTrace -= gTurretWeapon(Weapon).Get2ndBarrelOffset();

    HitActor = gTurret(Instigator).CalcWeaponFire(HL, HN);
    R = rotator(Normal(HL - StartTrace) + VRand() * FRand() * Spread);
    //Weapon.DrawStayingDebugLine( StartTrace, HL, 255, 0, 0);
    SpawnProjectile(StartTrace, R);
}

simulated function bool AllowFire()
{
    return True;
}

simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
    local vector V;

    V = Instigator.Location + Instigator.EyePosition() + X*StartOffset.X + Z*StartOffset.Z;

    if( gTurretWeapon(Weapon).ShotsFired % 2 != 0 )
        V += gTurretWeapon(Weapon).Get2ndBarrelOffset();
    else
        V -= gTurretWeapon(Weapon).Get2ndBarrelOffset();

    return V;
}


// ============================================================================
// Effects
// ============================================================================
simulated function DestroyEffects()
{
}

simulated function InitEffects()
{
}


function DrawMuzzleFlash(Canvas C)
{
}

function FlashMuzzleFlash()
{
}

function StartMuzzleSmoke()
{
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{

    ProjectileClass             = class'GGame.gTurretProjectile'
    StartOffset                 = (X=0,Y=0,Z=24)

    // gWeaponFire
    FlashEffectClass            = class'GEffects.gTurretFlash'
    ShellEffectClass            = None
    FlashBone                   = "left_muzzle"
    ShellBone                   = "left_muzzle"
    FlashBoneRotator            = (Pitch=0,Yaw=32768,Roll=0)

    AccuracyBase                = 0.02
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 2.0
    AccuracyRecoilRegen         = 0.33
    AccuracyRecoilShots         = 6

    FireSoundVolume             = 1.3
    FireSoundRadius             = 256
    FireSoundSlot               = SLOT_None

    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = False
    bInstantHit                 = True

    bPawnRapidFireAnim          = False
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = False
    bModeExclusive              = False

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0
    MaxHoldTime                 = 0

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
    TweenTime                   = 0.1

    FireSound                   = Sound'G_Sounds.t_fire_a1'
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireForce                   = "AssaultRifleFire"

    FireRate                    = 0.15

    AmmoClass                   = class'Ammo_Dummy'
    AmmoPerFire                 = 0

    ShakeOffsetMag              = (X=1.0,Y=1.0,Z=1.0)
    ShakeOffsetRate             = (X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate                = (X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime                = 2

    BotRefireRate               = 0.99

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    AimError                    = 800
    Spread                      = 0.1

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}