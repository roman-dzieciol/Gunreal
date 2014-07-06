// ============================================================================
//  gSniperAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSniperAttachment extends gTracingAttachment;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    bHeavy                  = False
    bRapidFire              = False
    bAltRapidFire           = False

    Mesh                    = Mesh'G_Anims3rd.sniper'

    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10

    DrawScale               = 0.32
    RelativeLocation        = (X=40,Y=0,Z=-10) //X -Forward/+Backward, Y -Left/+Right, Z -Up/+Down

    IgnoredMode             = 1

    HitGroupClass           = class'GEffects.gHitGroupJHP'
    bTracer                 = False

    FlashEffectClass        = class'GEffects.gSniperFlash'
    FlashBone               = "Muzzle"
    FlashBoneRotator        = (Pitch=0,Yaw=0,Roll=0)
}