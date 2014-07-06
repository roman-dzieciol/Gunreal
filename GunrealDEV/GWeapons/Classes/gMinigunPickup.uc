// ============================================================================
//  gMinigunPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunPickup extends gWeaponPickup
    abstract;

DefaultProperties
{
    InventoryType       = class'gMinigun'
    PickupMessage       = "You got the Minigun."
    StaticMesh          = StaticMesh'G_Weapons.pkup_minigun_a'
}