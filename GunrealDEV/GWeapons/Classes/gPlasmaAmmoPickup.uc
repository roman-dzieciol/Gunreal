// ============================================================================
//  gPlasmaAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gPlasmaAmmo'
    PickupMessage           = "You picked up plasma cells."

    AmmoAmount              = 25

    CollisionHeight         = 12.8
    CollisionRadius         = 12.8

    DrawScale               = 0.4
    PrePivot                = (X=0,Y=0,Z=32)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.plasma_ammo1'
}