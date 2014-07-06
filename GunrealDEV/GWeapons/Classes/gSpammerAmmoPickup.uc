// ============================================================================
//  gSpammerAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerAmmoPickup extends gAmmoPickup;

DefaultProperties
{
    InventoryType           = class'gSpammerAmmo'
    PickupMessage           = "You picked up Spam Charges."

    AmmoAmount              = 20

    CollisionHeight         = 13.500000
    CollisionRadius         = 13.500000

    DrawScale               = 0.025
    PrePivot                = (X=0,Y=0,Z=2.5)
    StaticMesh              = StaticMesh'G_Meshes.Ammo.spammer_ammo1'
}