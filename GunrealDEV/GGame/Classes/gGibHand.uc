// ============================================================================
//  gGibHand.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibHand extends gGib;

DefaultProperties
{
    DrawType            = DT_StaticMesh
    DrawScale           = 1.3
    StaticMesh          = StaticMesh'GibOrganicHand'
    Skins               = (Texture'GibOrganicRed')

    TrailClass          = class'BloodJet'

    CollisionHeight     = 4.0
    CollisionRadius     = 4.0
}
