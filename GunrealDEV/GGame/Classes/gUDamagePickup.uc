// ============================================================================
//  gUDamagePickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gUDamagePickup extends gPickup;


var() class<LocalMessage> BroadcastMessageClass;


// ============================================================================
//  Pickup
// ============================================================================

function RespawnEffect()
{
    Super.RespawnEffect();
    BroadcastLocalizedMessage(BroadcastMessageClass, 0);
}

function AnnouncePickup(Pawn Receiver)
{
    Super.AnnouncePickup(Receiver);
    BroadcastLocalizedMessage(BroadcastMessageClass, 1);
}



function PickupTouch(Actor Other)
{
    local Pawn P;

    if( ValidTouch(Other) )
    {
        P = Pawn(Other);
        P.EnableUDamage(30);
        AnnouncePickup(P);
        SetRespawn();
    }
}


auto state Pickup
{
    event Touch(Actor Other)
    {
        PickupTouch(Other);
    }
}

state FadeOut //extends Pickup
{
    event Touch(Actor Other)
    {
        PickupTouch(Other);
    }
}

state FallingPickup //extends Pickup
{
    event Touch(Actor Other)
    {
        PickupTouch(Other);
    }
}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    OverlayClass            = class'GEffects.gOverlay_UDamagePickup'
    GlowEmitterClass        = class'GEffects.gUDamagePickupGlowEmitter'
    GlowProjectorClass      = class'GEffects.gUDamagePickupGlowProjector'
    BroadcastMessageClass   = class'GGame.gUDamageMessage'

    PickupMessage           = "DOUBLE DAMAGE!"
    PickupForce             = "UDamagePickup"

    PickupSound             = Sound'G_Sounds.g_udamage_1'
    TransientSoundRadius    = 600.0

    RespawnTime             = 90.0
    MaxDesireability        = 2.0
    bPredictRespawns        = True

    StaticMesh              = StaticMesh'G_Meshes.Pickups.pickup_2'
}