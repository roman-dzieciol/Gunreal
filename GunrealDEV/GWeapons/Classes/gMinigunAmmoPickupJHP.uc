// ============================================================================
//  gMinigunAmmoPickupJHP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAmmoPickupJHP extends gMinigunAmmoPickup;

DefaultProperties
{
    InventoryType       = class'gMinigunAmmoJHP'
    PickupMessage       = "You picked up JHP Minigun shells."
    PickupSound         = Sound'G_Sounds.mini_pickup'
    StaticMesh          = StaticMesh'G_Meshes.Ammo.minigun_ammo_a'
}