// ============================================================================
//  gRoxAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRoxAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gRoxAmmo'
    PickupMessage           = "You picked 6 Rockets."

    AmmoAmount              = 6

    CollisionHeight         = 13.5
    CollisionRadius         = 13.5

    DrawScale               = 0.025
    PrePivot                = (X=0,Y=0,Z=2.5)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.rl_ammo1'
}