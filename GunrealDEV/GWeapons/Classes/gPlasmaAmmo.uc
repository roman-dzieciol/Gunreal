// ============================================================================
//  gPlasmaAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaAmmo extends gAmmo;

DefaultProperties
{
    ItemName            = "Plasma Ammo"
    PickupClass         = class'gPlasmaAmmoPickup'
    MaxAmmo             = 100
    InitialAmount       = 20
}