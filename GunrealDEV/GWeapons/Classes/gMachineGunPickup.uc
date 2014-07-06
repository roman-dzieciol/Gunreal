// ============================================================================
//  gMachineGunPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachineGunPickup extends gWeaponPickup;

DefaultProperties
{
    InventoryType       = class'gMachineGun'
    PickupMessage       = "You got the Acid Machinegun."
    StaticMesh          = StaticMesh'G_Weapons.pkup_acidmachgun'
    DrawScale           = 1.4
}