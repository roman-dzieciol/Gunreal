// ============================================================================
//  gMinigunPickupAP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunPickupAP extends gMinigunPickup;

DefaultProperties
{
    InventoryType       = class'gMinigunAP'
    PickupMessage       = "You got the AP Minigun."
    StaticMesh          = StaticMesh'G_Weapons.pkup_minigun_b'
}