// ============================================================================
//  gGibTorso.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibTorso extends gGib;

DefaultProperties
{
    DrawType            = DT_StaticMesh
    DrawScale           = 0.4
    StaticMesh          = StaticMesh'GibOrganicTorso'
    Skins               = (Texture'GibOrganicRed')

    TrailClass          = class'BloodJet'

    CollisionHeight     = 10.0
    CollisionRadius     = 10.0
}
