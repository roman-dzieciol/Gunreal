// ============================================================================
//  gNadeAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gNadeAmmo extends gAmmo;

DefaultProperties
{
    ItemName            = "Grenades"
    PickupClass         = class'gNadeAmmoPickup'
    MaxAmmo             = 20
    InitialAmount       = 1
}