// ============================================================================
//  gHRLAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gHRLAmmo'
    PickupMessage           = "You picked 3 AV Rockets."

    AmmoAmount              = 3

    CollisionHeight         = 13.5
    CollisionRadius         = 13.5

    DrawScale               = 0.025
    PrePivot                = (X=0,Y=0,Z=2.5)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.hrl_ammo0'
}