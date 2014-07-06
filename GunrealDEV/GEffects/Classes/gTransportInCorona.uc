// ============================================================================
//  gTransportInCorona.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTransportInCorona extends gEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    bCorona             = True
    bFlash              = True

    LightHue            = 153
    LightSaturation     = 204

    FlashBrightness     = 0.0
    FlashRadius         = 128.0

    FlashTimeOut        = 0.5
    FlashCurveOut       = 1

    Skins(0)            = Texture'G_FX.Flares.flare2'
    ScaleGlow           = 3.000000

    Lifespan            = 0.5
}