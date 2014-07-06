// ============================================================================
//  gGibHead.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibHead extends gGib;

DefaultProperties
{
    DrawType            = DT_StaticMesh
    DrawScale           = 0.3
    StaticMesh          = StaticMesh'GibOrganicHead'
    Skins               = (Texture'GibOrganicRed')

    TrailClass          = class'BloodJet'

    CollisionHeight     = 5.0
    CollisionRadius     = 6.0
}
