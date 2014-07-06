// ============================================================================
//  gInvShieldLight.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gInvShieldLight extends gLightEffect;

DefaultProperties
{
    LightRadius         = 32
    LightBrightness     = 255
    LightSaturation     = 102
    LightHue            = 189
    LightType           = LT_Steady
    LightEffect         = LE_None
    bDynamicLight       = True

    bFlash              = True
    FlashRadius         = 22
    FlashBrightness     = 1024
    FlashTimeIn         = 0.2
    FlashTimeIdle       = 0.8
    FlashTimeOut        = 0.4
    FlashCurveIn        = 2.0
    FlashCurveOut       = 0.3
    FlashTypeIdle       = LT_Flicker
    FlashTypeOut        = LT_Steady
}