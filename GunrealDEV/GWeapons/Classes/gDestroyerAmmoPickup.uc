// ============================================================================
//  gDestroyerAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gDestroyerAmmo'
    PickupMessage           = "You picked up Destroyer ammo."

    AmmoAmount              = 1000

    CollisionHeight         = 12.8
    CollisionRadius         = 12.8

    DrawScale               = 0.8
    PrePivot                = (X=0,Y=0,Z=16)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.firegun_ammo1'
}