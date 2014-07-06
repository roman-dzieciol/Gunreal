// ============================================================================
//  gMineAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineAmmo extends gAmmo;

DefaultProperties
{
    ItemName            = "Land mines"
    PickupClass         = class'gMineAmmoPickup'
    MaxAmmo             = 5
    InitialAmount       = 1
}