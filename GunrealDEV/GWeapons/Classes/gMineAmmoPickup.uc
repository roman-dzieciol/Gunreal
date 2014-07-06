// ============================================================================
//  gMineAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gMineAmmo'
    PickupMessage           = "You picked up a Land Mine."

    AmmoAmount              = 1
}