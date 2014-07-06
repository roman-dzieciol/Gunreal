// ============================================================================
//  gMinigunAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAmmo extends gAmmo
    abstract;

DefaultProperties
{
    ItemName            = "Minigun Ammo"
    PickupClass         = class'gMinigunAmmoPickup'
    MaxAmmo             = 500
    InitialAmount       = 100
}