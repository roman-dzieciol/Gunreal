// ============================================================================
//  gHealthPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHealthPickup extends gPickup;


var() int           HealingAmount;
var() bool          bSuperHeal;
var() float         AcidRemoval;


// ============================================================================
//  Pickup
// ============================================================================

simulated static function UpdateHUD(HUD H)
{
    Super.UpdateHUD(H);
    H.LastHealthPickupTime = H.Level.Timeseconds;
}

static function string GetLocalString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2
    )
{
    return default.PickupMessage $ default.HealingAmount;
}

function float DetourWeight(Pawn Other,float PathWeight)
{
    local int Heal;

    if( PathWeight > 500 && HealingAmount < 10 )
        return 0;

    Heal = Min(GetHealMax(Other),Other.Health + HealingAmount) - Other.Health;
    if( AIController(Other.Controller).PriorityObjective() && Other.Health > 65 )
        return (0.01 * Heal) / PathWeight;

    return (0.02 * Heal) / PathWeight;
}

function float BotDesireability(Pawn Bot)
{
    local float Desire;
    local int HealMax;

    HealMax = GetHealMax(Bot);
    Desire = Min(HealingAmount, HealMax - Bot.Health);

    if( Bot.Weapon != None && Bot.Weapon.AIRating > 0.5 )
        Desire *= 1.7;

    if( bSuperHeal || Bot.Health < 45 )
    {
        return FMin(0.03 * Desire, 2.2);
    }
    else
    {
        if( Desire > 6 )
            Desire = FMax(Desire,25);
        else if( Bot.Controller.bHuntPlayer )
            return 0;

        return FMin(0.017 * desire, 2.0);
    }
}

function int GetHealMax(Pawn P)
{
    if( bSuperHeal )
        return P.SuperHealthMax;

    return P.HealthMax;
}


function PickupTouch(Actor Other)
{
    local Pawn P;

    if( ValidTouch(Other) )
    {
        P = Pawn(Other);
        if( P.GiveHealth(HealingAmount, GetHealMax(P)) || (bSuperHeal && !Level.Game.bTeamGame) )
        {
            class'gAcidTimer'.static.DecreaseAcidTimer(P, AcidRemoval);
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
    OverlayClass            = class'GEffects.gOverlay_HealthPickup'
    GlowEmitterClass        = class'GEffects.gHealthPickupGlowEmitter'
    GlowProjectorClass      = class'GEffects.gHealthPickupGlowProjector'

    PickupMessage           = "You picked up a Health Pack +"
    PickupForce             = "HealthPack"
    PickupSound             = Sound'G_Sounds.g_health_a1'
    TransientSoundVolume    = 0.7

    AcidRemoval             = -1
    HealingAmount           = 25
    MaxDesireability        = 0.7
}