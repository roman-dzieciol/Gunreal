// ============================================================================
//  gHitEmitterHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitEmitterHE extends gHitEmitterNet;

DefaultProperties
{
    SpawnSound            = Sound'G_Proc.mini_p_he_explosion'
    SpawnSoundVolume      = 2.5
    SpawnSoundRadius      = 340

    LightRadius         = 32
    LightBrightness     = 222
    LightSaturation     = 141
    LightHue            = 35
    LightType           = LT_Steady
    LightEffect         = LE_None
    bDynamicLight       = True

    bFlash              = True
    FlashRadius         = 22
    FlashBrightness     = 111
    FlashTimeIn         = 0.2
    FlashTimeOut        = 0.1
    FlashCurveIn        = 2.0
    FlashCurveOut       = 0.3
}
