// ============================================================================
//  gMinigunAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAmmoPickup extends gAmmoPickup
    abstract;

DefaultProperties
{
    InventoryType           = class'gMinigunAmmo'
    PickupMessage           = "You picked up Minigun shells."

    AmmoAmount              = 1000

    CollisionHeight         = 12.8
    CollisionRadius         = 12.8

    DrawScale               = 0.4
    PrePivot                = (X=0,Y=0,Z=16)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.minigun_ammo_a'
}