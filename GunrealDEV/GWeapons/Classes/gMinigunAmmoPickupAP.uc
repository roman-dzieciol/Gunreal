// ============================================================================
//  gMinigunAmmoPickupAP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAmmoPickupAP extends gMinigunAmmoPickup;

DefaultProperties
{
    InventoryType       = class'gMinigunAmmoAP'
    PickupMessage       = "You picked up AP Minigun shells."
    PickupSound         = Sound'G_Sounds.mini_pickup'
    StaticMesh          = StaticMesh'G_Meshes.Ammo.minigun_ammo_b'
}