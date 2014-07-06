// ============================================================================
//  gSuperShieldPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSuperShieldPickup extends gShieldPickup;




// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    GlowEmitterClass        = class'GEffects.gSuperShieldPickupGlowEmitter'

    PickupMessage           = "You picked up a Super Shield Pack +"
    PickupSound             = Sound'G_Sounds.g_armor_b'

    ShieldAmount            = 100
    RespawnTime             = 60.0

    StaticMesh              = StaticMesh'G_Meshes.Pickups.pickup_2'
}