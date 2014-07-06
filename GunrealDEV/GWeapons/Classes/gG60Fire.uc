// ============================================================================
//  gG60Fire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60Fire extends gInstantFire;

// - Muzzle Flash -------------------------------------------------------------

var() rotator                       SmokeBoneRotator2nd;
var() name                          SmokeBone2nd;

var() rotator                       FlashBoneRotator2nd;
var() name                          FlashBone2nd;

var() rotator                       ShellBoneRotator2nd;
var() name                          ShellBone2nd;

var   Emitter                       SmokeEffect2nd;
var   Emitter                       FlashEffect2nd;
var   Emitter                       ShellEffect2nd;


simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
    local vector V;

    V = Instigator.Location + Instigator.EyePosition();

    if( gG60Gun(Weapon).ShotsFired % 2 != 0 )
        V += gG60Gun(Weapon).Get2ndBarrelOffset();

    return V;
}

// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
}

event ModeDoFire()
{
    local float AmmoOld, AmmoNew;

    if( !AllowFire() )
        return;

    // Store ammo amount
    AmmoOld = Weapon.AmmoAmount(ThisModeNum);

    Super.ModeDoFire();

    // simulate Weapon.ConsumeAmmo() on net client
    AmmoNew = Weapon.AmmoAmount(ThisModeNum);
    if( Level.NetMode == NM_Client && AmmoNew == AmmoOld )
        AmmoNew -= AmmoPerFire;

    if( AmmoNew <= 0 )
    {
        Weapon.ClientStopFire(ThisModeNum);
        GPlayFireEnd();
    }
}

// ============================================================================
// Effects
// ============================================================================
simulated function DestroyEffects()
{
    Super.DestroyEffects();

    if( SmokeEffect2nd != None )
        SmokeEffect2nd.Destroy();

    if( FlashEffect2nd != None )
        FlashEffect2nd.Destroy();

    if( ShellEffect2nd != None )
        ShellEffect2nd.Destroy();
}

simulated function InitEffects()
{
    Super.InitEffects();

    if( Level.NetMode == NM_DedicatedServer || gPlayer(Instigator.Controller) == None )
        return;

    if( SmokeEffectClass != None && (SmokeEffect2nd == None || SmokeEffect2nd.bDeleteMe) )
    {
        SmokeEffect2nd = Spawn(SmokeEffectClass);

        if( SmokeEffect2nd != None && SmokeBone2nd != '' )
        {
            Weapon.AttachToBone(SmokeEffect2nd, SmokeBone2nd);

            if( SmokeBoneRotator2nd != rot(0, 0, 0) )
                Weapon.SetBoneRotation( SmokeBone2nd, SmokeBoneRotator2nd, 0, 1 );
        }
    }

    if( FlashEffectClass != None && (FlashEffect2nd == None || FlashEffect2nd.bDeleteMe) )
    {
        FlashEffect2nd = Spawn(FlashEffectClass);

        if( FlashEffect2nd != None && FlashBone2nd != '' )
        {
            Weapon.AttachToBone(FlashEffect2nd, FlashBone2nd);

            if( FlashBoneRotator2nd != rot(0, 0, 0) )
                Weapon.SetBoneRotation( FlashBone2nd, FlashBoneRotator2nd, 0, 1 );
        }
    }

    if( ShellEffectClass != None && (ShellEffect2nd == None || ShellEffect2nd.bDeleteMe) )
    {
        ShellEffect2nd = Spawn(ShellEffectClass);

        if( ShellEffect2nd != None && ShellBone2nd != '' )
        {
            if( ShellBoneRotator2nd != rot(0, 0, 0) )
                Weapon.SetBoneRotation(ShellBone2nd, ShellBoneRotator2nd, 0, 1);
        }
    }
}


function DrawMuzzleFlash(Canvas C)
{
    // Draw smoke first

    if( gG60Gun(Weapon).ShotsFired % 2 == 0 )
    {
        if( SmokeEffect != None && SmokeEffect.Base != Weapon )
        {
            SmokeEffect.SetLocation(Weapon.GetEffectStart());
            C.DrawActor(SmokeEffect, False, False, Weapon.DisplayFOV);
        }

        if( FlashEffect != None && FlashEffect.Base != Weapon )
        {
            FlashEffect.SetLocation(Weapon.GetEffectStart());
            C.DrawActor(FlashEffect, False, False, Weapon.DisplayFOV);
        }
    }
    else
    {
        if( SmokeEffect2nd != None && SmokeEffect2nd.Base != Weapon )
        {
            SmokeEffect2nd.SetLocation(Weapon.GetEffectStart());
            C.DrawActor(SmokeEffect2nd, False, False, Weapon.DisplayFOV);
        }

        if( FlashEffect2nd != None && FlashEffect2nd.Base != Weapon )
        {
            FlashEffect2nd.SetLocation(Weapon.GetEffectStart());
            C.DrawActor(FlashEffect2nd, False, False, Weapon.DisplayFOV);
        }
    }
}

function FlashMuzzleFlash()
{
    if( Instigator == None || !Instigator.IsFirstPerson() )
        return;

    if( gG60Gun(Weapon).ShotsFired % 2 == 0 )
    {
        if( FlashEffect != None )
            FlashEffect.Trigger(Weapon, Instigator);

        if( ShellEffect != None && Level.DetailMode >= ShellDetailMode )
        {
            ShellEffect.SetLocation( Weapon.GetBoneCoords(ShellBone).Origin );
            ShellEffect.SetRotation( Weapon.GetBoneRotation(ShellBone,0) );
            ShellEffect.Trigger(Weapon, Instigator);
        }
    }
    else
    {
        if( FlashEffect2nd != None )
            FlashEffect2nd.Trigger(Weapon, Instigator);

        if( ShellEffect2nd != None && Level.DetailMode >= ShellDetailMode )
        {
            ShellEffect2nd.SetLocation( Weapon.GetBoneCoords(ShellBone2nd).Origin );
            ShellEffect2nd.SetRotation( Weapon.GetBoneRotation(ShellBone2nd,0) );
            ShellEffect2nd.Trigger(Weapon, Instigator);
        }
    }
}

function StartMuzzleSmoke()
{
    if( gG60Gun(Weapon).ShotsFired % 2 == 0 )
    {
        if( SmokeEffect != None && !Level.bDropDetail )
            SmokeEffect.Trigger(Weapon, Instigator);
    }
    else
    {
        if( SmokeEffect2nd != None && !Level.bDropDetail )
            SmokeEffect2nd.Trigger(Weapon, Instigator);
    }
}


function PlayPreFire();

function PlayStartHold();

function PlayFiring()
{
    if( Weapon.Mesh != None )
    {
        if( Weapon.HasAnim(FireLoopAnim) )
            Weapon.LoopAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
    }

    Weapon.PlayOwnedSound(FireSound, SLOT_Interact, TransientSoundVolume,, TransientSoundRadius, default.FireAnimRate / FireAnimRate, False);
    ClientPlayForceFeedback(FireForce);  // jdf

    FireCount++;
}

function PlayFireEnd()
{
    if( Weapon.AmmoAmount(ThisModeNum) > 0 )
    {
        GPlayFireEnd();
    }
}

function GPlayFireEnd()
{
    if( Weapon.Mesh != None )
        Weapon.LoopAnim(FireEndAnim, FireEndAnimRate, 0.2);

    Weapon.PlayOwnedSound(FireEndSound, SLOT_Misc, TransientSoundVolume,, TransientSoundRadius, default.FireAnimRate / FireAnimRate, False);
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // G60
    FlashBone2nd                = "Muzzle_bot"
    ShellBone2nd                = "Shells_bot"
    FlashBoneRotator2nd         = (Pitch=0,Yaw=32768,Roll=0)
    FireEndSound                = Sound'G_Sounds.g60.g60_fireseg_end'

    // gInstantFire
    DamageType                  = class'GWeapons.gDamTypeG60Shell'
    DamageMin                   = 8
    DamageMax                   = 8
    DamageRadius                = 0
    TraceRange                  = 16384
    Momentum                    = 5000
    bHeadShots                  = True
    DamageAttenHeadShot         = 1.5
    DamageTypeHeadShot          = class'GWeapons.gDamTypeG60HeadShot'

    // gWeaponFire
    FlashEffectClass            = class'GEffects.gG60Flash'
    ShellEffectClass            = None
    FlashBone                   = "Muzzle_top"
    ShellBone                   = "Shells_top"
    FlashBoneRotator            = (Pitch=0,Yaw=32768,Roll=0)

    AccuracyBase                = 0.02
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 2.0
    AccuracyRecoilRegen         = 0.33
    AccuracyRecoilShots         = 6

    FireSoundVolume             = 1.3
    FireSoundRadius             = 256
    FireSoundSlot               = SLOT_Interact //SLOT_None

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
    FireLoopAnim                = "FireLoop"
    FireEndAnim                 = "Idle"
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.1

    FireSound                   = Sound'G_Proc.g60.g60_g_fireseg'
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireForce                   = "AssaultRifleFire"

    FireRate                    = 0.1

    AmmoClass                   = class'gG60Ammo'
    AmmoPerFire                 = 1

    ShakeOffsetMag              = (X=1.0,Y=1.0,Z=1.0)
    ShakeOffsetRate             = (X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate                = (X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime                = 2

    ProjectileClass             = None

    BotRefireRate               = 0.9

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    AimError                    = 800

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}