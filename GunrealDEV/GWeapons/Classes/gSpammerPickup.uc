// ============================================================================
//  gSpammerPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerPickup extends gWeaponPickup;

DefaultProperties
{
    InventoryType       = class'gSpammer'
    PickupMessage       = "You got the Proximity Spammer."
    StaticMesh          = StaticMesh'G_Weapons.pkup_Spammer'
}