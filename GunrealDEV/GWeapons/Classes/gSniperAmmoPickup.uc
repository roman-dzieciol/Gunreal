// ============================================================================
//  gSniperAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSniperAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gSniperAmmo'
    PickupMessage           = "You got sniper shells."

    AmmoAmount              = 10

    CollisionHeight         = 12
    CollisionRadius         = 12

    DrawScale               = 1
    PrePivot                = (X=0,Y=0,Z=0)
    StaticMesh              = StaticMesh'G_Meshes.Sniper.sniper_ammo1'
}