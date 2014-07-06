// ============================================================================
//  gSuperHealthPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSuperHealthPickup extends gHealthPickup;


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    GlowEmitterClass        = class'GEffects.gSuperHealthPickupGlowEmitter'
    GlowProjectorClass      = class'GEffects.gSuperHealthPickupGlowProjector'

    PickupMessage           = "You picked up a Super Health Pack +"
    PickupSound             = Sound'G_Sounds.g_health_b1'

    HealingAmount           = 100
    bSuperHeal              = True
    RespawnTime             = 60.0

    StaticMesh              = StaticMesh'G_Meshes.Pickups.pickup_2'
}