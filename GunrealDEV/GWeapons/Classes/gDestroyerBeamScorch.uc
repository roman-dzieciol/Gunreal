// ============================================================================
//  gDestroyerBeamScorch.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerBeamScorch extends gScorch;

DefaultProperties
{
    LifeSpan                = 10
    bHighDetail             = True
    DrawScale               = 0.4
    FrameBufferBlendingOp   = PB_AlphaBlend
    ProjTexture             = Material'G_FX.Burn_Decal_6'
    RandomOrient            = False
    bClipStaticMesh         = True
    CullDistance            = 0
    MaxTraceDistance        = 256
}