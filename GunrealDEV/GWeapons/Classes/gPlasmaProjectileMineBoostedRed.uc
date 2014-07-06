// ============================================================================
//  gPlasmaProjectileMineBoostedRed.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaProjectileMineBoostedRed extends gPlasmaProjectileMineBoosted;

DefaultProperties
{
    AttachmentClass     = Class'GEffects.gPlasmaEmitterMineBoostedRed'
    Mesh                = Mesh'GResources.pmine'
    ExplosionDecal      = class'GEffects.gPlasmaScorchMineRed'
    Skins(0)            = Material'G_FX.Plasmafx.plasmamine_red'
}