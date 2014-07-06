// ============================================================================
//  gDestroyerAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerAmmo extends gAmmo;

DefaultProperties
{
    ItemName            = "Pyro-Cell"
    PickupClass         = class'gDestroyerAmmoPickup'
    MaxAmmo             = 420
    InitialAmount       = 70
}