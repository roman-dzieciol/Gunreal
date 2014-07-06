// ============================================================================
//  gMinigunAttachmentHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAttachmentHE extends gWeaponAttachment;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    IgnoredMode             = 1

    bWaterSplash            = False
    bWeaponLight            = True

    bRotary                 = True
    SpinBone                = "Barrel_C"
    SpinBoneAxis            = (Pitch=0,Yaw=0,Roll=1)
    RotaryClass             = class'gMinigunHE'

    FlashEffectClass        = class'GEffects.gMinigunFlash'
    FlashBone               = "Muzzle"

    ShellActorClass         = class'gEffects.gShellMinigunHE'
    ShellBone               = "Shells"

    bHeavy                  = True
    bRapidFire              = True
    bAltRapidFire           = True

    Mesh                    = Mesh'G_Anims3rd.minigun_c'

    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10

    RelativeRotation        = (Pitch=0,Yaw=32768,Roll=32768)
    RelativeLocation        = (X=-20,Y=20,Z=20) //X -Forward/+Backward, Y -Left/+Right, Z -Up/+Down
}