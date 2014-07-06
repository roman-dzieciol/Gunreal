// ============================================================================
//  gDestroyerAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerAttachment extends gWeaponAttachment;

DefaultProperties
{
    bWeaponLight            = False

    FlashBoneRotator        = (Pitch=0,Yaw=0,Roll=0)

    bHeavy                  = True
    bRapidFire              = False
    bAltRapidFire           = False

    Mesh                    = Mesh'G_Anims3rd.fireGun'

    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10

    RelativeLocation        = (X=-75,Y=0,Z=-5)
    DrawScale               = 0.66

    SoundRadius             = 256
    SoundVolume             = 255
    TransientSoundVolume    = 1.0
}