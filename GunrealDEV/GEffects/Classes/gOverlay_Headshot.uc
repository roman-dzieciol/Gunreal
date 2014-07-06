// ============================================================================
//  gOverlay_Headshot.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gOverlay_Headshot extends gOverlayTemplate;

DefaultProperties
{

    Duration            = 1000
    FadeInTime          = 0.3
    FadeOutTime         = 0.3
    FadeInCurve         = 1.0
    FadeOutCurve        = 1.0
    FadeColor           = (R=127,G=127,B=127,A=255)
    BaseColor           = (R=127,G=0,B=0,A=255)
    DrawColor           = (R=255,G=255,B=255,A=255)
    Blending            = FB_Modulate
    OnDeath             = OA_Fade
    OnRespawn           = OA_Clear
}