// ============================================================================
//  gGibForearm.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibForearm extends gGib;

DefaultProperties
{
    DrawType            = DT_StaticMesh
    DrawScale           = 1.3
    StaticMesh          = StaticMesh'GibOrganicForearm'
    Skins               = (Texture'GibOrganicRed')

    TrailClass          = class'BloodJet'

    CollisionHeight     = 6.0
    CollisionRadius     = 6.0
}
