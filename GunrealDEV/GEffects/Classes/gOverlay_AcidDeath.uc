// ============================================================================
//  gOverlay_AcidDeath.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gOverlay_AcidDeath extends gOverlayTemplate;



DefaultProperties
{
    Duration            = 0.5
    FadeInTime          = 1.5
    FadeOutTime         = 10.0
    FadeInCurve         = 1.0
    FadeOutCurve        = 1.0
    BaseColor           = (R=146,G=180,B=151,A=255)
    FadeColor           = (R=127,G=127,B=127,A=255)
    DrawColor           = (R=255,G=255,B=255,A=255)
    Blending            = FB_Modulate
    OnDeath             = OA_Fade
    OnRespawn           = OA_Clear
}
