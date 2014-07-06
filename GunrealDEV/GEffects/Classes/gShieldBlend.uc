// ============================================================================
//  gShieldBlend.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShieldBlend extends FinalBlend;



DefaultProperties
{
    FrameBufferBlending     = FB_AlphaBlend
    ZWrite                  = False
    ZTest                   = True
    AlphaTest               = False
    TwoSided                = True
    AlphaRef                = 0

    FallbackMaterial        = Material'Engine.DefaultTexture'
}