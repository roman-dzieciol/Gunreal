// ============================================================================
//  gShotgunPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotgunPickup extends gWeaponPickup;

DefaultProperties
{
    InventoryType       = class'gShotgun'
    PickupMessage       = "You got the Shotgun."
    StaticMesh          = StaticMesh'G_Weapons.pkup_shotgun'
}