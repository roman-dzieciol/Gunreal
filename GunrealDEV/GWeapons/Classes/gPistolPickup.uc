// ============================================================================
//  gPistolPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistolPickup extends gWeaponPickup;

DefaultProperties
{
    InventoryType       = class'gPistol'
    PickupMessage       = "You got the Acid Pistol."
    StaticMesh          = StaticMesh'G_Weapons.pkup_acidpistol'
    DrawScale           = 1.4
}