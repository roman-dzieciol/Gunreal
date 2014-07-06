// ============================================================================
//  gG60Ammo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60Ammo extends gAmmo;

DefaultProperties
{
    ItemName            = "G60 Ammo"
    PickupClass         = class'gG60AmmoPickup'
    MaxAmmo             = 200
    InitialAmount       = 40
}