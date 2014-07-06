// ============================================================================
//  gMinigunPickupHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunPickupHE extends gMinigunPickup;

DefaultProperties
{
    InventoryType       = class'gMinigunHE'
    PickupMessage       = "You got the HE Minigun."
    StaticMesh          = StaticMesh'G_Weapons.pkup_minigun_c'
}