// ============================================================================
//  gMachineGunAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachineGunAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gMachineGunAmmo'
    PickupMessage           = "You picked up 10 Mini Acid Vial Rounds."

    AmmoAmount              = 10

    CollisionHeight         = 13.5
    CollisionRadius         = 13.5

    DrawScale               = 0.025
    PrePivot                = (X=0,Y=0,Z=2.5)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.Acid_ammo_mg'
}
