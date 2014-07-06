// ============================================================================
//  gGibExplosionG.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibExplosionG extends gGib;

DefaultProperties
{
    DrawType            = DT_StaticMesh
    StaticMesh          = StaticMesh'G_Meshes.Gibs.headshot_g'
    TrailClass          = class'BloodJet'
    Skins(0)            = Material'G_FX.Gibs.headshot_b'
}