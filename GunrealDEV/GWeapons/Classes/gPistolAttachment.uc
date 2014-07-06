// ============================================================================
//  gPistolAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistolAttachment extends gWeaponAttachment;

DefaultProperties
{
    bWeaponLight            = True

    bHeavy                  = False
    bRapidFire              = False
    bAltRapidFire           = False

    Mesh                    = Mesh'G_Anims3rd.apistol'

    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10

    DrawScale               = 0.35
    RelativeLocation        = (X=-50,Y=0,Z=0) //X -Forward/+Backward, Y -Left/+Right, Z -Up/+Down
}