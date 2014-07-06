// ============================================================================
//  gSpammerAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerAmmo extends gAmmo;

DefaultProperties
{
    ItemName            = "Spammer Ammo"
    PickupClass         = class'gSpammerAmmoPickup'
    MaxAmmo             = 100
    InitialAmount       = 20
}