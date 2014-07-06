// ============================================================================
//  gDestroyerPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerPickup extends gWeaponPickup;

DefaultProperties
{
    InventoryType       = class'gDestroyer'
    PickupMessage       = "You got The Destroyer."
    StaticMesh          = StaticMesh'G_Weapons.pkup_firegun'
}