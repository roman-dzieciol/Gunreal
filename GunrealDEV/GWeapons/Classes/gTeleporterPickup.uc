// ============================================================================
//  gTeleporterPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterPickup extends gWeaponPickup;

DefaultProperties
{
    InventoryType       = class'gTeleporterGun'
    PickupMessage       = "You got the Teleporter Gun."
    StaticMesh          = StaticMesh'newweaponpickups.translocatorcenter'
    DrawType            = DT_StaticMesh
    DrawScale           = 0.2
}