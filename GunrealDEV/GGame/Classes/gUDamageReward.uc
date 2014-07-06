// ============================================================================
//  gUDamageReward.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gUDamageReward extends gUDamagePickup;


var() class<gEmitter>   DroppedEmitterClass;
var   gEmitter          DroppedEmitter;

var() float             FadeTime;
var   float             UDamageCharge;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.DroppedEmitterClass);
}


// ============================================================================
//  Lifespan
// ============================================================================

simulated event PreBeginPlay()
{
    // Disable collision until actor is initialized
    SetCollision(False);

    if( DroppedEmitterClass != None )
    {
        DroppedEmitter = Spawn(DroppedEmitterClass, Self);
        DroppedEmitter.SetBase(self);
    }

    Super.PreBeginPlay();
}

simulated event Destroyed()
{
    Super.Destroyed();

    if( DroppedEmitter != None )
        DroppedEmitter.Destroy();
}


// ============================================================================
//  Pickup
// ============================================================================

function InitDrop(float RemainingCharge)
{
    //gLog( "InitDrop" #RemainingCharge);

    UDamageCharge = RemainingCharge;
    FadeTime = 50 + Level.TimeSeconds;

    // Falling dropped pickup
    SetPhysics(PHYS_Falling);
    GotoState('FallingPickup');
    bDropped = True;
    bIgnoreEncroachers = False;
    bIgnoreVehicles = True;

    // Bots care less about pickups with less udamage time remaining
    MaxDesireability *= (RemainingCharge / 30);

    bAlwaysRelevant = False;
    NetUpdateFrequency = RemainingCharge;
    bUpdateSimulatedPosition = True;
    bOnlyReplicateHidden = False;
    LifeSpan = RemainingCharge * 2;

    SetCollision(True);
}

function PickupTouch(Actor Other)
{
    local Pawn P;
    local float NewTime;

    //gLog( "PickupTouch" #Other #Owner);

    if( ValidTouch(Other) && Other != Owner )
    {
        NewTime = UDamageCharge;
        P = Pawn(Other);

        // Add this pickup's remaining time to any UDamage time the pawn already had
        if( xPawn(P) != None )
            NewTime += Max( xPawn(P).UDamageTime - Level.TimeSeconds, 0);

        P.EnableUDamage(NewTime);
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

    event BeginState()
    {
        Super.BeginState();

        if( bDropped )
        {
            SetTimer(FadeTime - Level.TimeSeconds, False);
            BroadcastLocalizedMessage(BroadcastMessageClass, 2);
        }
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

    event BeginState()
    {
        Super.BeginState();
        SetTimer(FadeTime - Level.TimeSeconds, False);
    }
}

final static function ThrowUDamage(Controller Killer, xPawn Killed)
{
    local vector x, y, z, ThrowVector;
    local gUDamageReward Reward;

    //Log( "ThrowUDamage" #Killer #Killed );

    Killed.GetAxes(Killed.Rotation, X,Y,Z);
    ThrowVector = vector(Killed.GetViewRotation());
    ThrowVector = ThrowVector * ((Killed.Velocity Dot ThrowVector) + 100) + Vect(0,0,200);

    // This chain of events based on the way that weapon pickups are dropped when a pawn dies
    // See Pawn.Died()
    Reward = Killed.Spawn(default.class,Killed,,, rot(0,0,0));
    Reward.SetLocation(Killed.Location + 0.8 * Killed.CollisionRadius * X + -0.5 * Killed.CollisionRadius * Y);
    Reward.Velocity = ThrowVector;

    // Since we are spawning this pickup on the server only, tweak the pickup's replication-related properties
    // so that the new pickup appears for clients
    Reward.InitDrop(Killed.UDamageTime - Killed.Level.TimeSeconds);
}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    RespawnTime             = 0.0
    CollisionHeight         = 36
    DroppedEmitterClass     = class'GEffects.gUDamagePickupDroppedEmitter'
}