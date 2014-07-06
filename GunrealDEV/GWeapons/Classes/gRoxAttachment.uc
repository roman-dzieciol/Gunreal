// ============================================================================
//  gRoxAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRoxAttachment extends gWeaponAttachment;

DefaultProperties
{
    bWeaponLight            = False

    //FlashEffectClass        = class'GFX.gRoxFlash'
    //FlashBone               = "Roxtip"
    FlashBoneRotator        = (Pitch=0,Yaw=0,Roll=0)

    bHeavy                  = True
    bRapidFire              = False
    bAltRapidFire           = False

    Mesh                    = Mesh'G_Anims3rd.rox'

    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10

    DrawScale               = 0.45
    RelativeLocation        = (X=0,Y=0,Z=-20) //X -Forward/+Backward, Y -Left/+Right, Z -Up/+Down
}
