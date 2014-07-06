// ============================================================================
//  gOverlay_Acid.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gOverlay_Acid extends gOverlayTemplate;



DefaultProperties
{
    Duration            = 1000000.0
    FadeOutTime         = 1.5
    FadeOutCurve        = 1.0
    BaseColor           = (R=96,G=127,B=96,A=255)
    FadeColor           = (R=127,G=127,B=127,A=255)
    Blending            = FB_Modulate
    OnDeath             = OA_Fade
    OnRespawn           = OA_Clear
}