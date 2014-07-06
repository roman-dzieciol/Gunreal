// ============================================================================
//  gMachineGunAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachineGunAttachment extends gWeaponAttachment;

var byte SpinTargetByte;

replication
{
    // Variables that server should send to clients
    reliable if( bNetDirty && Role == ROLE_Authority )
        SpinTargetByte;
}

DefaultProperties
{
    bWaterSplash            = False
    bWeaponLight            = True

    bRotary                 = True
    SpinBone                = "MGun_Nozzle1"
    SpinBoneAxis            = (Pitch=0,Yaw=1,Roll=0)
    RotaryClass             = class'gMachineGun'
    SpinEffectClass         = class'gMachineGunSpinEffect'

    FlashEffectClass        = class'GEffects.gMachinegunFlash'
    FlashBone               = "Dummy02"
    FlashBoneRotator        = (Pitch=0,Yaw=32768,Roll=0)

    bHeavy                  = False
    bRapidFire              = True
    bAltRapidFire           = True

    Mesh                    = Mesh'G_Anims3rd.amgun'

    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10

    DrawScale               = 0.8
    RelativeLocation        = (X=-130,Y=10,Z=30) //X -Forward/+Backward, Y -Left/+Right, Z -Up/+Down
}