// ============================================================================
//  gScorchBullet.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gScorchBullet extends gScorch;

DefaultProperties
{
    LifeSpan            = 10
    bHighDetail         = True
    DrawScale           = 0.10
    ProjTexture         = Material'G_FX.Decals.bullet_1c'
    RandomOrient        = True
    bClipStaticMesh     = True
    CullDistance        = 0
}