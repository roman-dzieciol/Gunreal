// ============================================================================
//  gMachineGunAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachineGunAmmo extends gAmmo;

DefaultProperties
{
    ItemName            = "Acid Shot"
    PickupClass         = class'gMachineGunAmmoPickup'
    MaxAmmo             = 200
    InitialAmount       = 40
}