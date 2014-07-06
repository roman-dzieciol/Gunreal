// ============================================================================
//  gMiniHealthPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMiniHealthPickup extends gHealthPickup;


// ============================================================================
//  Pickup
// ============================================================================

auto state FallingPickup
{
    event Touch(Actor Other);

    simulated event Landed(vector HitNormal)
    {
        local rotator NewRot;
        local float DotProduct;

        bCollideWorld = False;
        SetPhysics(PHYS_None);

        NewRot = rotator(HitNormal);
        NewRot.Pitch -= 16384;
        SetRotation(NewRot);

        DotProduct = HitNormal dot Vect(0, 0, -1);
        if( DotProduct == -1.0 )
            SetLocation(Location + vect(0, 0, 1) * 10);

        Super.Landed(HitNormal);
    }
}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    SpawnEmitterClass           = None
    PickupEmitterClass          = class'GEffects.gMiniHealthPickupPickupEmitter'
    GlowEmitterClass            = class'GEffects.gMiniHealthPickupGlowEmitter'
    GlowProjectorClass          = None

    PickupMessage               = "You picked up a Mini Health Pack +"
    PickupSound                 = Sound'G_Sounds.g_minihealth_1'
    PickupForce                 = "MiniHealthPack"

    AcidRemoval                 = 2
    HealingAmount               = 5
    bSuperHeal                  = True
    RespawnTime                 = 60.0
    MaxDesireability            = 0.3

    CollisionRadius             = 24.0
    CollisionHeight             = 14.0
    bFixedRotationDir           = False
    bOrientOnSlope              = False
    Physics                     = PHYS_Falling

    DrawType                    = DT_None
    StaticMesh                  = None
    DrawScale                   = 0.35
    CullDistance                = 4500.0
}