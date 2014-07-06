// ============================================================================
//  gPlasmaProjectileMineRed.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaProjectileMineRed extends gPlasmaProjectileMine;

DefaultProperties
{
    AttachmentClass     = Class'GEffects.gPlasmaEmitterMineRed'
    ExplosionDecal      = class'GEffects.gPlasmaScorchMineRed'
    Skins(0)            = Material'G_FX.Plasmafx.plasmamine_red'
}