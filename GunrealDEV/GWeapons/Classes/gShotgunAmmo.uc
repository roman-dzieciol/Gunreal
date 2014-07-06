// ============================================================================
//  gShotgunAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotgunAmmo extends gAmmo;

DefaultProperties
{
    ItemName            = "Shotgun Shells"
    PickupClass         = class'gShotgunAmmoPickup'
    MaxAmmo             = 40
    InitialAmount       = 8
}