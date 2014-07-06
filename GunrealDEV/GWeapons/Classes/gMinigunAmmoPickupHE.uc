// ============================================================================
//  gMinigunAmmoPickupHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAmmoPickupHE extends gMinigunAmmoPickup;

DefaultProperties
{
    InventoryType       = class'gMinigunAmmoHE'
    PickupMessage       = "You picked up HE Minigun shells."
    PickupSound         = Sound'G_Sounds.mini_pickup'
    StaticMesh          = StaticMesh'G_Meshes.Ammo.minigun_ammo_c'
}