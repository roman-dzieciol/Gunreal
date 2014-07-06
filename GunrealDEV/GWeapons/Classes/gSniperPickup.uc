// ============================================================================
//  gSniperPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSniperPickup extends gWeaponPickup;

DefaultProperties
{
    InventoryType       = class'gSniperCannon'
    PickupMessage       = "You got the Sniper Cannon."
    StaticMesh          = StaticMesh'G_Weapons.pkup_snipercannon'
}