// ============================================================================
//  gShieldFader.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShieldFader extends ColorModifier;



DefaultProperties
{
    RenderTwoSided          = True
    AlphaBlend              = True
    Color                   = (R=255,G=255,B=255,A=0)

    FallbackMaterial        = Material'Engine.DefaultTexture'
}