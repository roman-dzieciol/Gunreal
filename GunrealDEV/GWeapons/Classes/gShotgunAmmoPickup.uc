// ============================================================================
//  gShotgunAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotgunAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gShotgunAmmo'
    PickupMessage           = "You picked Shotgun shells."

    AmmoAmount              = 8

    CollisionHeight         = 13.5
    CollisionRadius         = 13.5

    DrawScale               = 0.025
    PrePivot                = (X=0,Y=0,Z=2.5)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.shotgun_ammo'
}