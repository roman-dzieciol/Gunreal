// ============================================================================
//  gGibUpperArm.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibUpperArm extends gGib;

DefaultProperties
{
    DrawType            = DT_StaticMesh
    DrawScale           = 0.13
    StaticMesh          = StaticMesh'GibOrganicUpperArm'
    Skins               = (Texture'GibOrganicRed')

    TrailClass          = class'BloodJet'

    CollisionHeight     = 6.0
    CollisionRadius     = 6.0
}
