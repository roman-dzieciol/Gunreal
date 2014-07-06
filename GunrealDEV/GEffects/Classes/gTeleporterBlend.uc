// ============================================================================
//  gTeleporterBlend.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterBlend extends FinalBlend;

DefaultProperties
{
    FrameBufferBlending     = FB_AlphaBlend
    ZWrite                  = True
    ZTest                   = True
    AlphaTest               = False
    TwoSided                = False
    AlphaRef                = 0

    FallbackMaterial        = Material'Engine.DefaultTexture'

}
