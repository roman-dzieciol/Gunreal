// ============================================================================
//  gWeaponPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWeaponPickup extends UTWeaponPickup
    abstract;


var() float BounceDecay;
var() float ExtraGravity;

var() class<Emitter> WeaponFadeEffect;

var() class<Projector> BloodProjectorClass;
var   Projector BloodProjector;
var   bool bBloody;
var   Controller KilledController;

var() float Timeout;
var() float TimeoutExtra;
var() float TimeoutDist;

var int WarrantyMode;



// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    S.PrecacheObject(default.BloodProjectorClass);
    S.PrecacheObject(default.WeaponFadeEffect);
}


// ============================================================================
//  Replication
// ============================================================================
replication
{
    // Variables the server should send to the clients.
    reliable if( bNetInitial && Role == ROLE_Authority )
        bBloody;
}


// ============================================================================
//  Lifespan
// ============================================================================

simulated event PostNetBeginPlay()
{
    Super.PostNetBeginPlay();

    if( bBloody )
        SpawnBloodProjector();

    Acceleration = PhysicsVolume.default.Gravity * ExtraGravity;
}

simulated event Destroyed()
{
    Super.Destroyed();

    if( BloodProjector != None )
        BloodProjector.Destroy();
}

simulated event ClientTrigger()
{
    bHidden = True;
    if(EffectIsRelevant(Location, False) && !Level.GetLocalPlayerController().BeyondViewDistance(Location, CullDistance) )
        Spawn(WeaponFadeEffect,self);
}


// ============================================================================
//  Pickup
// ============================================================================

simulated function SpawnBloodProjector()
{
    local float BoundingRadius;

    if( BloodProjector == None && BloodProjectorClass != None )
        BloodProjector = Spawn(BloodProjectorClass, Self,, Location, rot(-16384,0,0));

    if( BloodProjector != None )
    {
        Tag = Name;
        BloodProjector.ProjectTag = Tag;
        BoundingRadius = GetRenderBoundingSphere().W;
        BloodProjector.MaxTraceDistance = VSize(BloodProjector.PrePivot) + 1;
        BloodProjector.FOV = atan(BoundingRadius, BloodProjector.MaxTraceDistance)*180/pi;
        BloodProjector.MaxTraceDistance += BoundingRadius;
    }
}

event TakeDamage(int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    if( bDropped )
    {
        SetTimer(FMax(TimeoutExtra,TimerRate), False);
        Velocity += Momentum/Mass;
        SetPhysics(PHYS_Falling);
    }
}

function AnnouncePickup(Pawn Receiver)
{
    Receiver.HandlePickup(self);
    PlaySound(PickupSound, SLOT_None);
}

function InitDroppedPickupfor( Inventory Inv )
{
    local gWeapon GW;

    Super.InitDroppedPickupFor(Inv);

    GW = gWeapon(Inv);
    if( GW != None )
    {
        //gLog( "AA" #AmmoAmount[0] #AmmoAmount[1] );
        if( GW.DeadHolder != None && !GW.DeadHolder.bDeleteMe )
        {
            if( Instigator != None )
                KilledController = Instigator.Controller;

            bBloody = True;
            SpawnBloodProjector();
        }
        
        WarrantyMode = GW.WarrantyMode;
    }

    LifeSpan = 0;
    SetTimer(Timeout, False);
}

simulated function bool CanUse(Pawn User)
{
    return False;
}

event UsedBy(Pawn User)
{
    local Inventory Copy;

    if( CanUse(User) )
    {
        Copy = SpawnCopy(User);
        AnnouncePickup(User);
        SetRespawn();

        if( Copy != None )
        {
            Copy.PickupFunction(User);
            if( PlayerController(User.Controller) != None )
                PlayerController(User.Controller).bSuccessfulUse = True;
        }
    }
}

event Touch(actor Other)
{
}

simulated event PhysicsVolumeChange( PhysicsVolume Volume )
{
    if( ExtraGravity != 0 )
    {
        Acceleration = Volume.default.Gravity * ExtraGravity;
    }
}


// ============================================================================
//  states
// ============================================================================

state Pickup
{
    event Touch(actor Other)
    {
        if( gPawn(Other) != None
        &&  gBot(gPawn(Other).Controller) != None
        &&  gBot(gPawn(Other).Controller).MoveTarget == self )
        {
            UsedBy(gPawn(Other));
        }
    }

    simulated function bool CanUse(Pawn User)
    {
        return ValidTouch(User);
    }

    event Timer()
    {
        local Pawn P;

        if( bDropped )
        {
            // if there are live pawns around, stay for a little longer
            foreach VisibleCollidingActors(class'Pawn', P, TimeoutDist)
            {
                if( P.Health > 0 )
                {
                    SetTimer(FMax(TimerRate,TimeoutExtra), True);
                    return;
                }
            }

            // otherwise die
            SetTimer(0, False);
            GotoState('FadeOut');
        }
    }
}

State WaitingForMatch
{
    ignores Touch, UsedBy;
}

State Sleeping
{
    ignores Touch, UsedBy;
}

State FadeOut
{
    ignores Touch;

    simulated function bool CanUse(Pawn User)
    {
        return ValidTouch(User);
    }
}

state FallingPickup
{
    ignores Touch;

    event BeginState()
    {
        Super.BeginState();
        SetTimer(0, False);
    }

    simulated function bool CanUse(Pawn User)
    {
        return ValidTouch(User);
    }

    event HitWall(vector HitNormal, Actor Other)
    {
        local vector X,Y,Z;

        // Bounce or stick
        if( VSize(Velocity) > 150 )
        {
            Velocity = BounceDecay*((Velocity dot HitNormal) * HitNormal * (-2.0) + Velocity);
        }
        else
        {
            SetCollisionSize(52, 30);
            SetPhysics(PHYS_None);
            GotoState('Pickup','Begin');
        }

        // Align to surface
        if( HitNormal.Z > MINFLOORZ )
        {
            GetAxes(Rotation,X,Y,Z);
            Z = HitNormal;
            Y = Z cross X;
            X = Y cross Z;
            DesiredRotation = OrthoRotation(X,Y,Z);
            bRotateToDesired = True;
        }

        NetUpdateTime = Level.TimeSeconds - 1.0;
    }

    event Landed(vector HitNormal)
    {
        HitWall(HitNormal, None);
    }
}


// ============================================================================
//  AI
// ============================================================================

function float DetourWeight(Pawn Other, float PathWeight)
{
    local Weapon AlreadyHas;

    //gLog( "DetourWeight" #GON(Other) #PathWeight );

    AlreadyHas = Weapon(Other.FindInventoryType(InventoryType));
    if( AlreadyHas != None )
    {
        // skip if already has but doesn't need ammo
        if( AlreadyHas.AmmoMaxed(0) )
            return 0;
    }

    return MaxDesireability / PathWeight;
}

function float BotDesireability(Pawn Bot)
{
    local Weapon AlreadyHas;
    local class<Pickup> AmmoPickupClass;
    local float Desire;

    //gLog( "BotDesireability" #GON(Bot) );

    // Ignore when hunting
    if( Bot.Controller.bHuntPlayer )
        return 0;

    // Let bot adjust desire
    Desire = MaxDesireability * (1 + Bot.Controller.AdjustDesireFor(self));

    // See if bot already has a weapon of this type
    AlreadyHas = Weapon(Bot.FindInventoryType(InventoryType));
    if( AlreadyHas != None )
    {
        if( AlreadyHas.AmmoMaxed(0) )
            return 0;

        // Bot wants this weapon for the ammo it holds
        if( AlreadyHas.AmmoAmount(0) > 0 )
        {
            AmmoPickupClass = AlreadyHas.AmmoPickupClass(0);

            if( AmmoPickupClass == None )
                return 0.05;
            else
                return FMax( 0.25 * Desire,
                        AmmoPickupClass.Default.MaxDesireability
                        * FMin(1, 0.15 * AlreadyHas.MaxAmmo(0)/AlreadyHas.AmmoAmount(0)) );
        }
        else
            return 0.05;
    }

    // Incentivize bot to get this weapon if it doesn't have a good weapon already
    if( Bot.Weapon == None || Bot.Weapon.AIRating < 0.5 )
        return 2.0*Desire;

    return Desire;
}


// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog( coerce string S ){
    class'GDebug.gDbg'.static.aLog( self, Level, S, gDebugString() );}

simulated function string gDebugString();

// ============================================================================
//  Debug String
// ============================================================================
simulated final static function string StrShort( coerce string S ){
    return class'GDebug.gDbg'.static.StrShort( S );}

simulated final static operator(112) string # ( coerce string A, coerce string B ){
    return class'GDebug.gDbg'.static.Pound_StrStr( A,B );}

simulated final static function name GON( Object O ){
    return class'GDebug.gDbg'.static.GON( O );}

simulated final function string GPT( string S ){
    return class'GDebug.gDbg'.static.GPT( self, S );}

// ============================================================================
//  Debug Visual
// ============================================================================
simulated final function DrawAxesRot( vector Loc, rotator Rot, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesRot( self, Loc, Rot, Length, bStaying );}

simulated final function DrawAxesCoords( Coords C, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesCoords( self, C, Length, bStaying );}

simulated final function DrawAxesXYZ( vector Loc, vector X, vector Y, vector Z, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesXYZ( self, Loc, X, Y, Z, Length, bStaying );}

simulated final static function VarWatch( coerce string Desc, coerce string Value, optional bool bGraph ){
    class'GDebug.gDbg'.static.VarWatch( Desc, Value, bGraph );}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    BloodProjectorClass         = class'gWeaponPickupProjector'
    WeaponFadeEffect            = class'gWeaponFadeEffect'

    PickupSound                 = Sound'G_Sounds.selection.grp_weapon_pickup_a'
    PickupForce                 = "SniperRiflePickup"
    PickupMessage               = "You got the Weapon."

    Timeout                     = 15
    TimeoutExtra                = 5
    TimeoutDist                 = 512

    ExtraGravity                = 1.0
    BounceDecay                 = 0.5

    bFixedRotationDir           = False
    RotationRate                = (Pitch=150000,Yaw=150000,Roll=150000)
    DesiredRotation             = (Pitch=0,Yaw=0,Roll=0)

    CollisionRadius             = 36
    CollisionHeight             = 30
    bUseCylinderCollision       = False
    bBounce                     = True
    bCollideActors              = True
    bCollideWorld               = True
    bBlockKarma                 = False
    bOrientOnSlope              = False
    bProjTarget                 = False

    DrawType                    = DT_StaticMesh
    DrawScale                   = 0.5
    Standup                     = (X=0,Y=0,Z=0)

    bAmbientGlow                = False
    AmbientGlow                 = 0

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 300.0

    MessageClass                = class'GGame.gPickupMessage'
}
