// ============================================================================
//  gGibHeadShotK.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibHeadShotK extends gGibHeadshot;

DefaultProperties
{
    DrawType            = DT_StaticMesh
    StaticMesh          = StaticMesh'G_Meshes.Gibs.headshot_k'
    TrailClass          = class'BloodJet'
    //Skins(0)          = Material'G_FX.Gibs.headshot_b'
    DrawScale           = 0.4
}