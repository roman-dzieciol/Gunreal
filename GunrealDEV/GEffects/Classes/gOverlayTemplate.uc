// ============================================================================
//  gOverlayTemplate.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gOverlayTemplate extends Object;

enum EOverlayAction
{
    OA_None
,   OA_Fade
,   OA_Clear
};

var() float Duration;
var() float FadeInTime;
var() float FadeOutTime;
var() float FadeInCurve;
var() float FadeOutCurve;
var() color BaseColor;
var() color FadeColor;
var() color DrawColor;
var() FinalBlend.EFrameBufferBlending Blending;
var() Texture DrawTexture;
var() EOverlayAction OnDeath;
var() EOverlayAction OnRespawn;

DefaultProperties
{
    Duration            = 0.0
    FadeInTime          = 0.0
    FadeOutTime         = 1.0
    FadeInCurve         = 1.0
    FadeOutCurve        = 1.0
    BaseColor           = (R=255,G=255,B=255,A=255)
    FadeColor           = (R=255,G=255,B=255,A=0)
    DrawColor           = (R=255,G=255,B=255,A=255)
    Blending            = FB_AlphaBlend
    DrawTexture         = Texture'Engine.WhiteTexture'

    OnDeath             = OA_Fade
    OnRespawn           = OA_Clear
}