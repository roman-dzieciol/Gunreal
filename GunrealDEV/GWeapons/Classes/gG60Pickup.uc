// ============================================================================
//  gG60Pickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60Pickup extends gWeaponPickup;

DefaultProperties
{
    InventoryType       = class'gG60Gun'
    PickupMessage       = "You got the G-60."
    StaticMesh          = StaticMesh'G_Weapons.pkup_G60'
}