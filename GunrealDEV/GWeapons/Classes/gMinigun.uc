// ============================================================================
//  gMinigun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigun extends gRotaryWeapon
    Abstract
    HideDropDown
    CacheExempt;


// ============================================================================
//  AI
// ============================================================================

function float GetAIRating()
{
    return AIRating;
}

function byte BestMode()
{
    return 0;
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
    SpinBone                    = "barrel_a"
    SpinBoneAxis                = (Pitch=0,Yaw=0,Roll=1)
    SpinMode                    = 0
    SpinModeAlt                 = 1
    SpinUpTime                  = 1
    SpinDownTime                = 1
    RoundsPerRotation           = 1.66

    WindUpSound                 = Sound'G_Sounds.mini_w_windup'
    WindDownSound               = Sound'G_Sounds.mini_w_winddown'

    WindSoundSlot               = SLOT_Misc
    WindSoundVolume             = 1
    WindSoundRadius             = 256

    SpinSound                   = Sound'G_Sounds.mini_w_spin'
    SpinSoundVolume             = 255
    SpinSoundPitch              = 64


    // gWeapon
    bSpecialDrawWeapon          = False
    bForceViewUpdate            = False
    ItemSize                    = 4

    BotPurchaseProbMod          = 5


    // Weapon
    ItemName                    = "Minigun"
    Description                 = "A moddable minigun, with the ability to operate using three different types of ammo, each with a unique set of barrels. It fires standard Minigun shells, Anti-Armor rounds, and Explosive rounds. It can only be modded at a spawn terminal, where you choose your barrel and ammo type - anti-armor and explosive shells being more expensive."

    FireModeClass(0)            = class'gMinigunFire'
    FireModeClass(1)            = class'gMinigunFireAlt'
    AttachmentClass             = class'gMinigunAttachment'
    PickupClass                 = class'gMinigunPickup'

    DisplayFOV                  = 68
    PlayerViewOffset            = (X=32,Y=15,Z=-27)
    PlayerViewPivot             = (Pitch=0,Roll=-1222,Yaw=31888)
    EffectOffset                = (X=0,Y=0,Z=0)
    SmallViewOffset             = (X=32,Y=15,Z=-27)
    SmallEffectOffset           = (X=0,Y=0,Z=0)
    CenteredOffsetY             = 10
    CenteredYaw                 = 888
    CenteredRoll                = 444

    SelectSound                 = Sound'G_Sounds.grp_select_med'
    

    bShowChargingBar            = True
    bSniping                    = True
    AIRating                    = 2.0
    CurrentRating               = 2.0

    HudColor                    = (r=255,g=255,b=255,a=255)
    IconCoords                  = (X1=246,Y1=80,X2=332,Y2=106)


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

    Mesh                        = Mesh'G_Anims.minigun_a'
}