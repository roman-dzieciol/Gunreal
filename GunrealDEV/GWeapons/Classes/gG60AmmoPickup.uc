// ============================================================================
//  gG60AmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60AmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gG60Ammo'
    PickupMessage           = "You picked up G60 shells."

    AmmoAmount              = 40

    CollisionHeight         = 12.8
    CollisionRadius         = 12.8

    DrawScale               = 0.8
    PrePivot                = (X=0,Y=0,Z=16)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.g60_ammo'
}
