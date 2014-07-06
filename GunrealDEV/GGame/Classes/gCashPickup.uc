// ============================================================================
//  gCashPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCashPickup extends gVirtualPickup
    notplaceable;


var() int                       CashAmount;
var   gCashPickupDetector       PickupDetector;

var() class<Emitter>            PickupEmitterClass;
var   Emitter                   PickupEmitter;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.PickupEmitterClass);
}


// ============================================================================
//  Lifespan
// ============================================================================

simulated event PreBeginPlay()
{
    Instigator = None;
    bReplicateInstigator = True;

    if( Level.NetMode != NM_DedicatedServer )
        PickupEmitter = Spawn(PickupEmitterClass, Self);

    Super.PreBeginPlay();
}


// ============================================================================
//  Pickup
// ============================================================================

function AnnouncePickup(Pawn Receiver)
{
    Super.AnnouncePickup(Receiver);

    Instigator = Receiver;
    NetUpdateTime = Level.TimeSeconds - 1;
}

function SetRespawn()
{
    GotoState('TimingOut');
}

state TimingOut extends Disabled
{
    simulated event BeginState()
    {
        MaxDesireability = 0;
        bHidden = True;
        ResetStaticFilterState();
        SetCollision(False, False, False);
        Lifespan = 0.5;
    }
}

function VirtualPickup(Pawn P)
{
    local gPRI GPRI;

    GPRI = class'gPRI'.static.GetGPRI(P.PlayerReplicationInfo);
    if( GPRI != None )
        GPRI.UpdateMoney(CashAmount, class'gCashPickupMessage',,,, True);
}

function float BotDesireability(Pawn Bot)
{
    local gPRI GPRI;

    GPRI = class'gPRI'.static.GetGPRI(Bot.PlayerReplicationInfo);
    if( GPRI != None && GPRI.GetMoney() < GPRI.MoneyLimit )
        return MaxDesireability;

    return 0;
}

function bool PickupValidTouch(Actor Other)
{
    local gPRI GPRI;

    //gLog( "PickupValidTouch" #GON(Other) );

    if( Pawn(Other) != None )
    {
        GPRI = class'gPRI'.static.GetGPRI(Pawn(Other).PlayerReplicationInfo);
        if( GPRI != None && GPRI.GetMoney() < GPRI.MoneyLimit)
        {
    		// make sure its a live player
    		if( Pawn(Other) == None || !Pawn(Other).bCanPickupInventory || (Pawn(Other).DrivenVehicle == None && Pawn(Other).Controller == None) )
    			return false;

    		// make sure not touching through wall
    		if( !FastTrace(Other.Location, Location) )
    			return false;

    		// make sure game will let player pick me up
    		if( !Level.Game.PickupQuery(Pawn(Other), self) )
    		  return false;

    		TriggerEvent(Event, self, Pawn(Other));
    		return true;
        }
    }
    return False;
}

auto state Pickup
{
    event BeginState()
    {
        Super.BeginState();
        SetTimer(60, False);
    }

    function bool ValidTouch(Actor Other)
    {
        return PickupValidTouch(Other);
    }

    function CheckTouching()
    {
        Super.CheckTouching();
        if( PickupDetector != None )
            PickupDetector.CheckTouching();
    }
}

state FadeOut //extends Pickup
{
    function bool ValidTouch(Actor Other)
    {
        return PickupValidTouch(Other);
    }

    function CheckTouching()
    {
        Super.CheckTouching();
        if( PickupDetector != None )
            PickupDetector.CheckTouching();
    }
}

state FallingPickup
{
    event BeginState()
    {
        Super.BeginState();
        SetTimer(60, False);
    }

    function bool ValidTouch(Actor Other)
    {
        return PickupValidTouch(Other);
    }

    function CheckTouching()
    {
        Super.CheckTouching();
        if( PickupDetector != None )
            PickupDetector.CheckTouching();
    }

    simulated event Landed(vector HitNormal)
    {
        bCollideWorld = False;
        SetPhysics(PHYS_None);

        if( Role == ROLE_Authority )
            PickupDetector = Spawn(class'GGame.gCashPickupDetector', Self);

        if( PickupEmitter != None && PickupEmitter.Base == self )
        {
            PickupEmitter.SetBase(None);
            PickupEmitter.SetRotation(rotator(HitNormal)-rot(16384,0,0));
        }

        SetCollisionSize(24,24);
        NetUpdateTime = Level.TimeSeconds - 1.0;

        Super.Landed(HitNormal);
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    CashAmount                  = 100

    MaxDesireability            = 2.0
    bPredictRespawns            = False
    RespawnTime                 = 0.0

    PickupEmitterClass          = class'gCashPickupEmitter'
    MessageClass                = class'gCashPickupMessage'

    PickupSound                 = Sound'G_Proc.money_b'
    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 300.0

    Mass                        = 10.0
    RemoteRole                  = ROLE_DumbProxy
    bShouldBaseAtStartup        = False
    DrawType                    = DT_None
    AmbientGlow                 = 254

    CollisionRadius             = 0.0
    CollisionHeight             = 0.0
}