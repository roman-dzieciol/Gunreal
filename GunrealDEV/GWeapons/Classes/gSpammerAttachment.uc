// ============================================================================
//  gSpammerAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerAttachment extends gWeaponAttachment;

DefaultProperties
{
    bRotary                 = True
    SpinBone                = "rotator"
    SpinBoneAxis            = (Pitch=-1,Yaw=0,Roll=0)
    RotaryClass             = class'gSpammer'

    bWeaponLight            = False

    //FlashEffectClass        = class'GEffects.gG60Flash'
    //FlashBone               = "Muzzle_top"
    FlashBoneRotator        = (Pitch=0,Yaw=0,Roll=0)

    bHeavy                  = True
    bRapidFire              = False
    bAltRapidFire           = False

    Mesh                    = Mesh'G_Anims3rd.spammer'

    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10


}
