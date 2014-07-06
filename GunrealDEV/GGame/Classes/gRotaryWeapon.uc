// ============================================================================
//  gRotaryWeapon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRotaryWeapon extends gWeapon
    Abstract
    HideDropDown
    CacheExempt;


var() name              SpinBone;
var() rotator           SpinBoneAxis;
var() byte              SpinMode;
var() byte              SpinModeAlt;
var() float             SpinUpTime;
var() float             SpinDownTime;
var() float             RoundsPerRotation;
var() bool              bPlayPartialSpinDown;

var() Sound             SpinSound;
var() float             SpinSoundVolume;
var() float             SpinSoundPitch;
var() float             SpinSoundRadius;
var() bool              bSpinFullVolume;

var() Sound             WindUpSound;
var() Sound             WindDownSound;

var() ESoundSlot        WindSoundSlot;
var() float             WindSoundVolume;
var() float             WindSoundRadius;

var   bool              bSpin;
var   bool              bSpinLast;
var   float             SpinAlpha;
var   float             RollSpeed;
var   float             RollCounter;
var   float             RotationsPerSecond;


// ============================================================================
//  Weapon
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.SpinSound);
    S.PrecacheObject(default.WindUpSound);
    S.PrecacheObject(default.WindDownSound);
}

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    RotationsPerSecond = 1.0 / (FireMode[SpinMode].FireRate * RoundsPerRotation);
    RollSpeed = 65536.0 * RotationsPerSecond;
}

simulated event WeaponTick( float DT )
{
    //gLog("Tick");

    if( bSpin )
    {
        if( SpinAlpha != 1 )
            SpinAlpha = FMin( 1, SpinAlpha + (DT/SpinUpTime) );

        if( !bSpinLast && WindUpSound != None )
            Instigator.PlaySound(WindUpSound,WindSoundSlot,WindSoundVolume,,WindSoundRadius);
    }
    else
    {
        if( bSpinLast && WindDownSound != None && (bPlayPartialSpinDown || SpinAlpha == 1 ) )
            Instigator.PlaySound(WindDownSound,WindSoundSlot,WindSoundVolume,,WindSoundRadius);

        if( SpinAlpha != 0 )
            SpinAlpha = FMax( 0, SpinAlpha - (DT/SpinDownTime) );
    }

    bSpinLast = bSpin;

    if( Level.NetMode == NM_DedicatedServer )
        return;

    RollCounter += DT * SpinAlpha * RollSpeed;
    RollCounter = RollCounter % 65536.0;

    SetBoneRotation( SpinBone, SpinBoneAxis * RollCounter, 0, 1 );
}


// ============================================================================
// Firing
// ============================================================================

simulated function OutOfAmmo()
{
    if( Instigator == None || !Instigator.IsLocallyControlled() || HasAmmo() )
        return;

    DoAutoSwitch();
}

simulated function bool StartFire( int Mode )
{
    //gLog( "StartFire" #Mode );

    if( !ReadyToFire(Mode) )
        return False;

    OnStartFire(Mode);

    if( Mode == SpinMode )
        FireMode[Mode].PreFireTime = SpinUpTime * (1-SpinAlpha);

    if( Mode == SpinMode || Mode == SpinModeAlt )
    {
        bSpin = True;
        if( gWeaponAttachment(ThirdPersonActor) != None )
        {
            gWeaponAttachment(ThirdPersonActor).bSpin = bSpin;
            ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
        }
    }

    FireMode[Mode].bIsFiring = True;
    FireMode[Mode].NextFireTime = Level.TimeSeconds + FireMode[Mode].PreFireTime;

    //gLog( level.TimeSeconds - FireMode[Mode].NextFireTime );

    if( Instigator.IsLocallyControlled() )
    {
        if( FireMode[Mode].PreFireTime > 0.0 )
            FireMode[Mode].PlayPreFire();
        FireMode[Mode].FireCount = 0;
    }

    return True;
}

simulated event StopFire( int Mode )
{
    //gLog( "StopFire" #Mode );

    if( FireMode[Mode].bIsFiring )
        FireMode[Mode].bInstantStop = True;

    if( Instigator.IsLocallyControlled() && !FireMode[Mode].bFireOnRelease )
        FireMode[Mode].PlayFireEnd();

    FireMode[Mode].bIsFiring = False;
    FireMode[Mode].StopFiring();

    if( !FireMode[Mode].bFireOnRelease )
        ZeroFlashCount(Mode);

    if( FireMode[SpinMode].bIsFiring == False && FireMode[SpinModeAlt].bIsFiring == False )
    {
        bSpin = False;
        if( gWeaponAttachment(ThirdPersonActor) != None )
        {
            gWeaponAttachment(ThirdPersonActor).bSpin = bSpin;
            ThirdPersonActor.NetUpdateTime = Level.TimeSeconds - 1;
        }
    }
}


// ============================================================================
//  HUD
// ============================================================================

simulated function float ChargeBar()
{
    return FClamp(SpinAlpha, 0, BarFullSteady);
}


// ============================================================================
//  AI
// ============================================================================

function float RangedAttackTime()
{
    if( BotMode == 0 )
        return (1.0-SpinAlpha)*SpinUpTime;
    return 0;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gRotaryWeapon
    SpinBone                    = ""
    SpinBoneAxis                = (Pitch=0,Yaw=0,Roll=1)
    SpinMode                    = 0
    SpinModeAlt                 = 0
    SpinUpTime                  = 1
    SpinDownTime                = 1
    RoundsPerRotation           = 1.5

    bPlayPartialSpinDown        = True

    WindUpSound                 = None
    WindDownSound               = None

    WindSoundSlot               = SLOT_Misc
    WindSoundVolume             = 1
    WindSoundRadius             = 256

    SpinSound                   = None
    SpinSoundVolume             = 255
    SpinSoundPitch              = 64
    SpinSoundRadius             = 512
    bSpinFullVolume             = False
}
