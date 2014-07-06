// ============================================================================
//  gNadeAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gNadeAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gNadeAmmo'
    PickupMessage           = "You picked up a Grenade."

    AmmoAmount              = 1
}