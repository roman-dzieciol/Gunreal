// ============================================================================
//  gShieldPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShieldPickup extends gPickup;


var() int           ShieldAmount;


// ============================================================================
//  Pickup
// ============================================================================

simulated static function UpdateHUD(HUD H)
{
    Super.UpdateHUD(H);
    H.LastArmorPickupTime = H.LastPickupTime;
}

static function string GetLocalString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2
    )
{
    return Default.PickupMessage $ Default.ShieldAmount;
}

function float DetourWeight(Pawn Other,float PathWeight)
{
    local float Need;

    Need = Other.CanUseShield(ShieldAmount);
    if( Need <= 0 )
        return 0;

    if( AIController(Other.Controller).PriorityObjective() && (Need < 0.4 * Other.GetShieldStrengthMax()) )
        return (0.005 * MaxDesireability * Need) / PathWeight;

    return (0.013 * MaxDesireability * Need) / PathWeight;
}

function float BotDesireability(Pawn Bot)
{
    return (0.013 * MaxDesireability * Bot.CanUseShield(ShieldAmount));
}

function PickupTouch(Actor Other)
{
    local Pawn P;

    if( ValidTouch(Other) )
    {
        P = Pawn(Other);
        if( P.AddShieldStrength(ShieldAmount) || !Level.Game.bTeamGame )
        {
            AnnouncePickup(P);
            SetRespawn();
        }
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
    OverlayClass            = class'GEffects.gOverlay_ShieldPickup'
    GlowEmitterClass        = class'GEffects.gShieldPickupGlowEmitter'
    GlowProjectorClass      = class'GEffects.gShieldPickupGlowProjector'

    PickupMessage           = "You picked up a Shield Pack +"
    PickupSound             = Sound'G_Sounds.g_armor_a'
    PickupForce             = "ShieldPack"

    ShieldAmount            = 50
    MaxDesireability        = 1.5
    bPredictRespawns        = True
}