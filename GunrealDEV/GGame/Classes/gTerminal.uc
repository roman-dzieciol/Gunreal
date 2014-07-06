// ============================================================================
//  gTerminal.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTerminal extends gBasePickup;


var   int                   			Health;
var() int                   			MaxHealth;
var() int                   			RegenHealth;
var() float                   			RegenHealthTimer;

var   Actor                             ReplacedActor;
var   gPawn                             Customer;
var() float                             ShopGracePeriod;

var() float                             DestroyResetTime;

var() Sound                             DestroyResetSound;

var() class<gTerminalShield>            ShieldClass;
var   gTerminalShield                   Shield;

var() class<Emitter>                    DeactivatedEmitterClass;
var() class<Emitter>                    DestroyedEmitterClass;
var() class<Emitter>                    DeadEmitterClass;
var   Emitter                           DeadEmitter;

var   gTimer							RegenTimer;
var   float								HealthSmoothing;
var   int								HealthLast;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    S.PrecacheObject(default.DestroyResetSound);

    S.PrecacheObject(default.ShieldClass);
    S.PrecacheObject(default.DeadEmitterClass);
    S.PrecacheObject(default.DestroyedEmitterClass);
    S.PrecacheObject(default.DeactivatedEmitterClass);
}


// ============================================================================
//  Replication
// ============================================================================

replication
{
    reliable if( bNetInitial && Role == ROLE_Authority )
        ReplacedActor;
        
    reliable if( bNetDirty && Role == ROLE_Authority )
        Health;
}

simulated event PostNetReceive()
{
    if( ReplacedActor != None )
    {
        SetReplaced(ReplacedActor);
        bNetNotify = False;
    }
}


// ============================================================================
//  Lifespan
// ============================================================================

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( Role == ROLE_Authority )
    {
        Shield = Spawn(ShieldClass, Self);
        if( Shield != None )
            Shield.Reset();
            
	    RegenTimer = Spawn(class'gTimer');
	    RegenTimer.OnTimer = OnRegenTimer;
	    RegenTimer.SetTimer(RegenHealthTimer,True);
    }
    
}

simulated event Destroyed()
{
    Super.Destroyed();

    if( Shield != None )
        Shield.Destroy();

    if( DeadEmitter != None )
        DeadEmitter.Destroy();
        
    if( RegenTimer != None )
        RegenTimer.Destroy();
    RegenTimer = None;
}

function Reset()
{
    GotoState('Pickup');
}

function OnRegenTimer()
{
	Health = Min(Health + RegenHealth*RegenHealthTimer, MaxHealth);
	HealthLast = Health;
	HealthSmoothing = Level.TimeSeconds;
}

simulated function float GetSmoothHealth()
{
	if( HealthLast != Health )
	{
		HealthSmoothing = Level.TimeSeconds;
		HealthLast = Health;
		return Health;
	}
	else
	{
		return FMin(HealthLast + (Level.TimeSeconds - HealthSmoothing) * RegenHealth, MaxHealth);
	}
}


simulated function RenderHealthBar(Canvas C)
{
	// Draw health bar
	class'gPawnHUD'.static.DrawGenericHealthBar(C, self, float(Health) / MaxHealth
		, CollisionRadius*2.0, Location + vect(0,0,1.2) * CollisionHeight
		, class'gTurret'.default.TeamBeaconBorderMaterial, class'gTurret'.default.TeamBeaconTexture);
}

// ============================================================================
//  AI
// ============================================================================

function float BotDesireability(Pawn Bot)
{
    return 0;
}


// ============================================================================
//  gTerminal
// ============================================================================

simulated function SetReplaced(Actor A)
{
    local WeaponLocker WL;
    local xWeaponBase WB;
    local vector HL,HN;
    local Actor TA;

    if( A != None )
    {
        ReplacedActor = A;
        Event = ReplacedActor.Event;
        Tag = ReplacedActor.Tag;

        SetLocation(A.Location);
        SetRotation(A.Rotation);

        if( WeaponLocker(A) != None )
        {
            WL = WeaponLocker(A);
            WL.Weapons.Remove(0, WL.Weapons.Length);
            WL.SetCollision(False, False);
            WL.GotoState('Disabled');
            WL.bHidden = True;
            WL.default.bHidden = True; // don't replicate bHidden
            WL.PickupBase = None;

            if( WL.MyMarker != None )
            {
                MyMarker = WL.MyMarker;
                MyMarker.MarkedItem = self;
                MyMarker.MyPickupBase = None;
                MyMarker.bSuperPickup = False;
                WL.MyMarker = None;
            }
        }
        else if( xWeaponBase(A) != None )
        {
            WB = xWeaponBase(A);
            WB.WeaponType = None;
            WB.SetCollision(False, False);
            WB.bHidden = True;
            WB.default.bHidden = True; // don't replicate bHidden

            if( WB.myEmitter != None )
                WB.myEmitter.Destroy();

            if( WB.MyMarker != None )
            {
                MyMarker = WB.MyMarker;
                MyMarker.MarkedItem = self;
                MyMarker.MyPickupBase = None;
                MyMarker.bSuperPickup = False;
                WB.MyMarker = None;
            }
        }

        SetLocation(A.Location);
        SetRotation(A.Rotation);
        TA = Trace(HL,HN,Location-vect(0,0,256),Location,False,vect(32,32,1));
        if( TA != None && TA.bWorldGeometry )
        {
            SetLocation(HL);
        }
        SetCollision(True,False);

        if( Shield != None )
            Shield.SetLocation(Location);
    }
}

function ShieldDown();


// ============================================================================
//  Pickup
// ============================================================================

auto state Pickup
{
    simulated function bool ValidTouch(Actor Other)
    {
        // Live player
        if( Pawn(Other) == None || !Pawn(Other).bCanPickupInventory || (Pawn(Other).DrivenVehicle == None && Pawn(Other).Controller == None) )
            return False;

        // Not touching through wall
        if( !FastTrace(Other.Location, Location) )
            return False;

        return True;
    }

    event UsedBy(Pawn P)
    {
        if( ValidTouch(P) && gPawn(P) != None && !gPawn(P).IsShopping() )
        {
            gPawn(P).ShopInfo.Begin(Self);
            if( gPawn(P).ShopInfo.IsShopping() )
            {
                Customer = gPawn(P);
                if( PlayerController(P.Controller) != None )
                    PlayerController(P.Controller).bSuccessfulUse = True;

                GotoState('Shopping');
            }
        }
    }

    event Touch(Actor Other)
    {
        local gBot B;
        local gPawn P;

        P = gPawn(Other);
        if( P != None )
        {
            B = gBot(P.Controller);
            if( B != None )
            {
                if( B.MoveTarget == self && P.ReachedDestination(self) && !P.IsShopping() && BotDesireability(P) > 0 )
                {
                    //gLog( "Touch StartShopping" #GON(P) #P.IsShopping() );
                    StartShopping(P);
                    B.StartShopping(Self);
                }
            }
        }
    }

    event BeginState()
    {
        //gLog( "BeginState");
    }

    event EndState()
    {
        //gLog( "EndState");
    }

    function float DetourWeight(Pawn Other,float PathWeight)
    {
        // do not stop and shop if completing objectives
        if( AIController(Other.Controller).PriorityObjective() )
            return 0;

        return BotDesireability(Other) / PathWeight;
    }

    function StartShopping(gPawn P)
    {
        Customer = P;
        GotoState('Shopping');
    }

    function float BotDesireability(Pawn Bot)
    {
        local Inventory Inv;
        local bool bShop, bFound;
        local gBot B;
        local gPawn P;

        //gLog( "BotDesireability" #GON(Bot) );

        P = gPawn(Bot);
        if( P != None )
        {
            B = gBot(P.Controller);

            // Shop only if all decent weapons need ammo, or no decent weapons
            for( Inv=Bot.Inventory; Inv!=None; Inv=Inv.Inventory )
            {
                if( gWeapon(Inv) != None && gWeapon(Inv).ItemSize > 1 )
                {
                    bFound = True;
                    if( !gWeapon(Inv).NeedAmmo(0) )
                        return 0;
                    else if( P.ShopInfo.CanRefillAmmo(gWeapon(Inv).class) )
                        bShop = True;
                }
            }

            if( bShop || !bFound )
            {
                //gLog( "BotDesireability bShop" #GON(Bot) #P.IsShopping() );
                return 1.0;
            }
        }

        return 0;
    }

Begin:
    CheckTouching();
    Sleep(0.33);
    Goto('Begin');
}


// ============================================================================
//  Shopping
// ============================================================================

state Shopping
{
    event BeginState()
    {
        //gLog( "BeginState");
        if( Shield != None )
            Shield.Activate();
    }

    event EndState()
    {
        //gLog( "EndState");
        if( Shield != None )
            Shield.Deactivate();
    }

    event UnTouch(Actor Other)
    {
        if( gPawn(Other) != None && gPawn(Other).IsShopping() )
        {
            //gLog( "UnTouch");
            gPawn(Other).ShopInfo.End(Self, True);
            GotoState('Pickup');
        }
    }

    event UsedBy(Pawn P);

    function ShieldDown()
    {
        // Grace period for shopping
        if( Customer != None )
        {
            Customer.ShopInfo.ForceCommit(self);
        }
        StartSleeping();
    }

Begin:
    // when customer is gone, go back to normal
    Sleep(0.1);

    if( Customer == None || !Customer.IsShopping() )
    {
        if( Customer != None )
            Spawn(DeactivatedEmitterClass);

        GotoState('Pickup');
    }
    else
        Goto('Begin');
}


// ============================================================================
//  Sleeping
// ============================================================================

State Sleeping
{
    ignores Touch;
    
	function OnRegenTimer()
	{
	}
	
	
	simulated function float GetSmoothHealth()
	{
		return Health;
	}

    event BeginState()
    {
        local int i;

        //gLog( "BeginState");

        for( i=0; i<ArrayCount(TeamOwner); ++i )
            TeamOwner[i] = None;

        if( DeadEmitterClass != None )
            DeadEmitter = Spawn(DeadEmitterClass);

        if( DestroyedEmitterClass != None )
            Spawn(DestroyedEmitterClass);

        NetUpdateTime = Level.TimeSeconds - 1;
    }

    event EndState()
    {
        //gLog( "EndState");
        if( DeadEmitter != None )
            DeadEmitter.Kill();

        PlaySound(DestroyResetSound, SLOT_None);
        NetUpdateTime = Level.TimeSeconds - 1;
    }

    function StartSleeping();

Begin:
    // Grace period for shopping
    if( Customer != None )
    {
        Sleep(ShopGracePeriod);
        if( Customer != None && Customer.ShopInfo != None )
            Customer.ShopInfo.End(self, True);
        Customer = None;
    }

    Sleep(DestroyResetTime);
    Health = MaxHealth;
    GotoState('Pickup');
}


// ============================================================================
//  Not Applicable
// ============================================================================

function Inventory SpawnCopy(Pawn Other)
{
    return None;
}

function AnnouncePickup(Pawn Receiver);
function SetRespawn();
function InitDroppedPickupFor(Inventory Inv);
function RespawnEffect();
event Landed(vector HitNormal);




event TakeDamage(int Damage, Pawn Instigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    //gLog( "TakeDamage" #Damage );
    if( Health <= 0 )
        return;

    Health = Max(0, Health - Damage);
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

    Health                      = 200
    MaxHealth                   = 200
    RegenHealth					= 10
    RegenHealthTimer			= 1.0
    
    ShopGracePeriod             = 2
    DestroyResetTime            = 10
    DestroyResetSound           = Sound'G_Sounds.notif_tone_1'

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 256.0

    DeadEmitterClass            = class'GEffects.gTerminalDeadEmitter'
    DestroyedEmitterClass       = class'GEffects.gTerminalDestroyedEmitter'
    DeactivatedEmitterClass     = class'GEffects.gTerminalDeactivatedEmitter'
    ShieldClass                 = class'GGame.gTerminalShield'

    RespawnEffectTime           = 0.5
    MaxDesireability            = 1.0

    PickupSound                 = None
    PickupMessage               = "You loaded up at a shopping terminal."
    MessageClass                = class'GGame.gTerminalMessage'

    RemoteRole                  = ROLE_SimulatedProxy
    bAlwaysRelevant             = True
    bGameRelevant               = True
    bOnlyDirtyReplication       = True
    bOnlyReplicateHidden        = False
    bReplicateMovement          = False
    NetPriority                 = 1.4
    NetUpdateFrequency          = 1.0

    DrawScale                   = 0.5
    DrawType                    = DT_StaticMesh
    StaticMesh                  = StaticMesh'G_Meshes.Pickups.spawner_2'
    PrePivot                    = (X=0,Y=0,Z=0)
    CullDistance                = 8000
    bAmbientGlow                = False
    bHidden                     = False

    CollisionRadius             = 24
    CollisionHeight             = 43
    bCollideActors              = False
    bCollideWorld               = False
    bOrientOnSlope              = True
    bUseCylinderCollision       = True
    bShouldBaseAtStartup        = True
    bIgnoreEncroachers          = True
    bIgnoreVehicles             = True

    bFixedRotationDir           = False
    RotationRate                = (Yaw=0)
    DesiredRotation             = (Yaw=0)
}
