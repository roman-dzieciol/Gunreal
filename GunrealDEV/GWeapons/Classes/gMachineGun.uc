// ============================================================================
//  gMachineGun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachineGun extends gRotaryWeapon;


var   float SpinTarget;
var   float SpinTargetLast;
var   float SpinAlphaLast;


// ============================================================================
// Rotary
// ============================================================================

simulated event WeaponTick(float DT)
{
    if( SpinTarget > 0 )
    {
        if( SpinTargetLast == 0 )
            if( Instigator.IsLocallyControlled() )
                PlayAnim('WindUp', 1, 0);

        if( SpinAlpha < SpinTarget )
            SpinAlpha = FMin( SpinTarget, SpinAlpha + (DT/SpinUpTime) );
        else if( SpinAlpha > SpinTarget )
            SpinAlpha = FMax( SpinTarget, SpinAlpha - (DT/SpinUpTime) );
    }
    else
    {
        if( SpinAlpha != 0 )
        {
            SpinAlpha = FMax( 0, SpinAlpha - (DT/SpinDownTime) );

            if( SpinTargetLast > 0 )
            {
                if( Instigator.IsLocallyControlled() )
                {
                    PlayAnim('WindDown', 1, 0);
                    Instigator.PlaySound(WindDownSound,WindSoundSlot,WindSoundVolume,,WindSoundRadius);
                }
            }
        }
    }

    SpinTargetLast = SpinTarget;
    SpinAlphaLast = SpinAlpha;

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

    Instigator.AmbientSound = None;
    Instigator.SoundVolume = Instigator.default.SoundVolume;
    DoAutoSwitch();
}

simulated function bool StartFire(int Mode)
{
    //gLog( "StartFire" #Mode );

    if( !ReadyToFire(Mode) )
        return False;

    OnStartFire(Mode);

    if( Mode == 0 )
        SpinTarget = 0.5;

    if( Mode == 1 )
        SpinTarget = 1;

    if( SpinTarget > SpinAlpha )
        FireMode[Mode].PreFireTime = FMax(0,SpinUpTime * (SpinTarget-SpinAlpha));
    else if( SpinTarget < SpinAlpha )
        FireMode[Mode].PreFireTime = FMax(0,SpinUpTime * (SpinAlpha-SpinTarget));
    else
        FireMode[Mode].PreFireTime = 0;

    if( gMachineGunAttachment(ThirdPersonActor) != None )
        gMachineGunAttachment(ThirdPersonActor).SpinTargetByte = SpinTarget*255;

    FireMode[Mode].bIsFiring = True;
    FireMode[Mode].NextFireTime = Level.TimeSeconds + FireMode[Mode].PreFireTime;

    if( Instigator.IsLocallyControlled() )
    {
        FireMode[Mode].FireCount = 0;

        if( FireMode[Mode].PreFireTime > 0.0 && SpinAlpha == 0.0 )
        {
            FireMode[Mode].PlayPreFire();
            Instigator.PlaySound(WindUpSound,WindSoundSlot,WindSoundVolume,,WindSoundRadius);
        }
    }

    return True;
}

simulated event StopFire(int Mode)
{
    //gLog( "StopFire" #Mode );

    if( FireMode[Mode].bIsFiring )
        FireMode[Mode].bInstantStop = True;

    FireMode[Mode].bIsFiring = False;
    FireMode[Mode].StopFiring();

    if( !FireMode[Mode].bFireOnRelease )
        ZeroFlashCount(Mode);

    if( !FireMode[0].bIsFiring && !FireMode[1].bIsFiring )
    {
        SpinTarget = 0;

        if( gMachineGunAttachment(ThirdPersonActor) != None )
            gMachineGunAttachment(ThirdPersonActor).SpinTargetByte = SpinTarget*255;
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

function float GetAIRating()
{
    local Bot B;
    local float Dist, Rating, ZDiff;
    local vector Delta;
    local Actor Target;

    B = Bot(Instigator.Controller);
    if( B == None )
        return AIRating;

    Target = GetBotTarget();
    if( Target == None )
        return AIRating;

    Delta = Target.Location - Instigator.Location;
    Dist = VSize(Delta);
    ZDiff = Delta.Z;
    Rating = AIRating;

    return Rating;
}

function byte BestMode()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target == None )
        return 0;

    Dist = VSize(Target.Location - Instigator.Location);

    if( Dist > 2048 )
        return 0;

    return 1;
}

function bool RecommendRangedAttack()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target == None )
        return False;

    Dist = VSize(Target.Location - Instigator.Location);
    return (Dist > 2000 * (1 + FRand()) );
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gRotaryWeapon
    SpinBone                    = "MGun_Nozzle1"
    SpinBoneAxis                = (Pitch=0,Yaw=1,Roll=0)
    SpinMode                    = 1
    SpinModeAlt                 = 1
    SpinUpTime                  = 1
    SpinDownTime                = 1
    RoundsPerRotation           = 4

    WindUpSound                 = Sound'G_Sounds.amg_clamp_up'
    WindDownSound               = Sound'G_Sounds.amg_clamp_dwn'

    WindSoundSlot               = SLOT_Misc
    WindSoundVolume             = 0.33
    WindSoundRadius             = 256

    SpinSound                   = Sound'G_Sounds.amg_spin_loop'
    SpinSoundVolume             = 220
    SpinSoundPitch              = 64


    // gWeapon
    CostWeapon                  = 250
    CostAmmo                    = 50
    ItemSize                    = 2
    BotPurchaseProbMod          = 5

    bSpecialDrawWeapon          = False
    bForceViewUpdate            = False


    // Weapon
    ItemName                    = "Acid Machinegun"
    Description                 = "NA"

    DisplayFOV                  = 65
    PlayerViewOffset            = (X=80,y=15,Z=-30)
    PlayerViewPivot             = (Pitch=0,Yaw=32768,Roll=0)
    EffectOffset                = (X=0,Y=0,Z=0)
    SmallViewOffset             = (X=80,y=15,Z=-30)
    SmallEffectOffset           = (X=0,Y=0,Z=0)
    CenteredOffsetY             = 10
    CenteredYaw                 = 888
    CenteredRoll                = 444

    FireModeClass(0)            = class'gMachineGunFire'
    FireModeClass(1)            = class'gMachineGunFireAlt'
    AttachmentClass             = class'gMachineGunAttachment'
    PickupClass                 = class'gMachineGunPickup'

    SelectSound                 = Sound'G_Sounds.grp_select_small'


    AIRating                    = 2.4
    CurrentRating               = 2.4

    bShowChargingBar            = True
    bSniping                    = True

    IconCoords                  = (X1=254,Y1=0,X2=382,Y2=63)
    HudColor                    = (r=255,g=255,b=255,a=255)


    // Actor
    bUseCollisionStaticMesh     = False

    bDynamicLight               = False
    LightType                   = LT_Steady
    LightEffect                 = LE_NonIncidence
    LightPeriod                 = 3
    LightBrightness             = 127
    LightHue                    = 30
    LightSaturation             = 170
    LightRadius                 = 10

    Mesh                        = Mesh'G_Anims.amgun'
}