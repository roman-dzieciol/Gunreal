// ============================================================================
//  gMinigunAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAttachment extends gTracingAttachment
    abstract;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    IgnoredMode             = 1

    bRotary                 = True
    SpinBone                = "barrel_a"
    SpinBoneAxis            = (Pitch=0,Yaw=0,Roll=1)
    RotaryClass             = class'gMinigun'

    TracerClass             = class'GEffects.gTracerEmitter'
    TracerSpeed             = 10000.0

    FlashEffectClass        = class'GEffects.gMinigunFlash'
    FlashBone               = "Muzzle"
    ShellBone               = "Shells"

    bHeavy                  = True
    bRapidFire              = True
    bAltRapidFire           = True

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