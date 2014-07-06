// ============================================================================
//  gGibCalf.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibCalf extends gGib;

DefaultProperties
{
    DrawType            = DT_StaticMesh
    DrawScale           = 0.2
    StaticMesh          = StaticMesh'GibOrganicCalf'
    Skins               = (Texture'GibOrganicRed')

    TrailClass          = class'BloodJet'

    CollisionHeight     = 6.0
    CollisionRadius     = 6.0
}
