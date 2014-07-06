// ============================================================================
//  gPistolAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistolAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gPistolAmmo'
    PickupMessage           = "You picked up 10 High Caliber Acid Vial Rounds."

    AmmoAmount              = 10

    CollisionHeight         = 13.5
    CollisionRadius         = 13.5

    DrawScale               = 0.025
    PrePivot                = (X=0,Y=0,Z=2.5)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.acid_ammo_p'
}