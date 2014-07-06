// ============================================================================
//  gSniperAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSniperAmmo extends gAmmo;

DefaultProperties
{
    ItemName            = "Sniper Cannon Shells"
    PickupClass         = class'gSniperAmmoPickup'
    MaxAmmo             = 40
    InitialAmount       = 8
}