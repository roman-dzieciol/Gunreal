// ============================================================================
//  gTurret.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurret extends Vehicle;


var   Controller    Deployer;
var   bool          bActive;
var   bool          bOldActive;
var   Sound         OpenCloseSound;

var   Rotator       OriginalRotation;

var() String        DefaultWeaponClassName;     // Weapon class
var() Vector        VehicleProjSpawnOffset;     // Projectile Spawn Offset
var() class<Actor>  ExplosionEffect;

var   float         LastCalcWeaponFire; // avoid multiple traces the same tick
var   Actor         LastCalcHA;
var   vector        LastCalcHL;
var   vector        LastCalcHN;

var   vector        BotError;
var   Actor         OldTarget;

var   float         RotationChangeTime;
var   rotator       OldRotation;
var   Sound         RotationSound;
var   Sound         RotationEndSound;

var   bool          bUpgraded;
var   int           UpgradeCost;
var   Sound         UpgradeSound;
var   class<Actor>  UpgradeClass;

var   Actor         Armor;
var   Actor			Foot;

var   class<Emitter> BallClass[3];
var   Emitter		Ball;

var   class<Emitter>		BallDamagedClass;
var   class<Emitter>		BallDamagedMoreClass;
var   Emitter		BallDamage;
var   bool			bTurretFiring;
var   bool			bTurretFiringOld;

replication
{
    reliable if( (bNetInitial || bNetDirty) && Role == ROLE_Authority )
        bActive, Deployer, bUpgraded, bTurretFiring;

    reliable if ( bNetInitial && Role==ROLE_Authority)
        OriginalRotation;
}

static function PrecacheScan( gPrecacheScan S )
{
    S.PrecacheObject(default.ExplosionEffect);
    S.PrecacheObject(default.OpenCloseSound);
    S.PrecacheObject(default.AutoTurretControllerClass);
    S.PrecacheObject(class'GGame.gTurretWeapon');

}

// Function override
function PlayHit(float Damage, Pawn InstigatedBy, vector HitLocation, class<DamageType> damageType, vector Momentum) {}
function ClientDying(class<DamageType> DamageType, vector HitLocation) {}
simulated function Tick(float DeltaTime)
{
    if( Level.NetMode != NM_DedicatedServer )
    {
        if( OldRotation != Rotation )
        {
            RotationChangeTime = Level.TimeSeconds + default.RotationChangeTime;
            OldRotation = Rotation;
            AmbientSound = RotationSound;
        }
        else if( RotationChangeTime < Level.TimeSeconds )
        {
            if( AmbientSound != None )
            {
                AmbientSound = None;
                PlaySound(RotationEndSound, SLOT_None);
            }
        }
	}
    
    if( Role == ROLE_Authority )
    {
        bTurretFiring = IsFiring();
		if( bTurretFiring != bTurretFiringOld )
		{	
			UpdateTurretAnim();
		}
    }
}

final simulated function UpdateTurretAnim()
{   
	if( bTurretFiring != bTurretFiringOld )
	{	
		bTurretFiringOld = bTurretFiring;
	    if( bTurretFiring )
	    {
	    	LoopAnim('Firing', 1, 0.0);
	    }
	    else
	    {
    		LoopAnim('Idle', 1, 0.0);
	    }
    }
}

simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if( Anim == 'Deploy' )
    {
		LoopAnim('Idle', 1, 0.0);
    }
}


function bool RecommendLongRangedAttack()
{
    return true;
}

simulated event SetInitialState()
{
    Super.SetInitialState();
    Enable('Tick');
}

simulated event DrivingStatusChanged()
{
    Super.DrivingStatusChanged();
    Enable('Tick');
}

event PreBeginPlay()
{
    Super(Pawn).PreBeginPlay();
}
simulated event PostBeginPlay()
{	
    if( Role == Role_Authority )
    {
    	// Save original Rotation to place client versions well...
        OriginalRotation = Rotation;
    }

    super.PostBeginPlay();

    if( Level.Game != None )
        BotError = (1000 - 50 * Level.Game.GameDifficulty) * VRand();

    // TODO: get updated turret mesh
    //SetBoneDirection('t_foot2', OriginalRotation,, 1.0, 1);

    // Hack to instance correctly the skeletal collision boxes
    GetBoneCoords('');
    SetCollision(false, false);
    SetCollision(true, true);

    // Play deploy anim
    if( Role == Role_Authority )
    {
        PlayAnim('Deploy', 1, 0.0);
    }
    
    Foot = Spawn(class'gTurretBase',self);
    Foot.SetLocation(Location + PrePivot);
}

simulated event Destroyed()
{
    // Destroy Weapon
    if( Level.Game != None )
        Level.Game.DiscardInventory( Self );

    if( Armor != None )
        Armor.Destroy();

    if( Foot != None )
        Foot.Destroy();

    if( Ball != None )
        Ball.Destroy();
        
    if( BallDamage != None )
        BallDamage.Destroy();

    Super.Destroyed();
}

simulated function bool CanUpgrade(Pawn Other)
{
    if(!bUpgraded
    &&  Other != None
    &&  Other.Controller != None
    &&  Other.Controller.Adrenaline > UpgradeCost
    &&  VSize(Other.Location - Location) < 192
    &&  GetTeamNum() == Other.GetTeamNum() )
        return true;
    return false;
}

function bool Upgrade()
{
    // Upgrade FX
    PlaySound(UpgradeSound, SLOT_None);
    Armor = Spawn(UpgradeClass, self);
    Armor.AmbientGlow = AmbientGlow;
    Armor.SetDrawScale(DrawScale);
    AttachToBone(Armor,'ArmorSocket');
    

    bUpgraded = True;
    return true;
}

function AddDefaultInventory()
{
    // Setup Weapon
    GiveWeapon( DefaultWeaponClassName );
    if( Controller != None )
        Controller.ClientSwitchToBestWeapon();
}

function PossessedBy(Controller C)
{
    Level.Game.DiscardInventory( Self );

    Super.PossessedBy( C );

    NetUpdateTime = Level.TimeSeconds - 1;
    bStasis = false;
    C.Pawn  = Self;

    // Setup Weapon
    AddDefaultInventory();
    if( Weapon != None )
    {
        Weapon.NetUpdateTime = Level.TimeSeconds - 1;
        Weapon.Instigator = Self;
        PendingWeapon = None;
        Weapon.BringUp();
    }
}

function UnPossessed()
{
    // Setup Weapon
    if( Weapon != None )
    {
        Weapon.PawnUnpossessed();
        Weapon.ImmediateStopFire();
        Weapon.ServerStopFire( 0 );
        Weapon.ServerStopFire( 1 );
    }
    NetUpdateTime = Level.TimeSeconds - 1;
    super.UnPossessed();
}


simulated event PostNetReceive()
{
    Super.PostNetReceive();

    // Play deploy
    if( bActive != bOldActive )
    {
        bOldActive = bActive;
        if( bActive )
            PlayAnim('Deploy', 1, 0.0);
    }

    if( bUpgraded && Armor == None )
    {
        Upgrade();
    }
        
	if( bTurretFiring != bTurretFiringOld )
	{	
		UpdateTurretAnim();
    }
}

function SetDeployer(Controller C)
{
	local class<Emitter> TeamBallClass;
	
    // Link deployer with turret
    Deployer = C;

    if( gBot(C) != None )
        gBot(C).Turret = self;
    else if( gPlayer(C) != None )
        gPlayer(C).Turret = self;

    SetTeamNum(C.GetTeamNum());
    
    if( Role == Role_Authority )
    {    
    	// Spawn proper ball class
        TeamBallClass = BallClass[2];
        if( Level.Game.bTeamGame && C.GetTeamNum() < 2 )
            TeamBallClass = BallClass[C.GetTeamNum()];

	    Ball = Spawn(TeamBallClass, self);	    
	    AttachToBone(Ball,'core_emitter');
    }
}


simulated function bool HasAmmo()
{
    return true;
}

simulated function rotator GetViewRotation()
{
    return Rotation;
}

function Controller GetKillerController()
{
    return Deployer;
}

simulated function PlayFiring(optional float Rate, optional name FiringMode)
{
}

/* Returns world location of vehicle fire start */
simulated function vector GetFireStart( optional float XOffset )
{
    local Vector X, Y, Z;

    GetAxes(Rotation, X, Y, Z);
    return Location + X*(VehicleProjSpawnOffset.X+XOffset) + Y*VehicleProjSpawnOffset.Y + Z*VehicleProjSpawnOffset.Z;
}

function vector GetBotError(vector StartLocation)
{
    Controller.ShotTarget = Pawn(Controller.Target);
    if( Controller.Target != OldTarget )
    {
        BotError = (1500 - 100 * Level.Game.GameDifficulty) * VRand();
        OldTarget = Controller.Target;
    }
    BotError += 100 * VRand() + (100 - 200 *FRand()) * Normal(Controller.Target.Velocity);
    if( Pawn(OldTarget) != None && Pawn(OldTarget).bStationary )
        BotError *= 0.6;

    BotError = Normal(BotError) * FMin(VSize(BotError), FMin(1500 - 100*Level.Game.GameDifficulty,0.2 * VSize(Controller.Target.Location - StartLocation)));
    return BotError;
}

/* Trace from View to CrossHair, and return HitActor, HitLocation and HitNormal */
simulated function Actor CalcWeaponFire( out vector HitLocation, out Vector HitNormal )
{
    local vector    X, Y, Z, Target, StartLocation;
    local Actor     A;
    local float     Angle;

    // Avoid multiple traces the same tick
    if( LastCalcWeaponFire == Level.TimeSeconds )
    {
        //log("CalcWeaponFire" @ Level.TimeSeconds );
        HitLocation = LastCalcHL;
        HitNormal   = LastCalcHN;
        return LastCalcHA;
    }

    StartLocation = GetFireStart();
    Target = StartLocation + vector(Rotation) * 65535;

    // Add error
    if( Controller != None )
    {
        if( Controller.Target == None )
            Controller.Target = Controller.Enemy;
        if( Controller.Target != None )
            Target += GetBotError(StartLocation);
    }

    // Trace
    bBlockZeroExtentTraces = False;
    A = Trace(HitLocation, HitNormal, Target, StartLocation, true);
    if( A == None )
    {
        HitLocation = Target;
        HitNormal   = vect(0,0,0);
    }
    bBlockZeroExtentTraces = True;

    // Make sure Turret cannot hit something located behind it's Cannon.
    GetAxes(Rotation, X, Y, Z);
    Angle = (HitLocation - StartLocation) Dot X;
    if( A == None || Angle < 0 )
    {
        HitLocation = Target;
        HitNormal   = vect(0,0,0);
    }

    // Save results, because can be called several times per tick
    LastCalcWeaponFire  = Level.TimeSeconds;
    LastCalcHA          = A;
    LastCalcHL          = HitLocation;
    LastCalcHN          = HitNormal;

    return A;
}


simulated function bool StopWeaponFiring()
{
    if( Weapon == None )
        return false;

    Weapon.PawnUnpossessed();

    if( Weapon.IsFiring() )
    {
        if( Controller != None )
        {
            if( !Controller.IsA('PlayerController') )
                Weapon.ServerStopFire( Weapon.BotMode );
            else
            {
                Controller.StopFiring();
                Weapon.ServerStopFire( 0 );
                Weapon.ServerStopFire( 1 );
            }
        }
        else
        {
            Weapon.ServerStopFire( 0 );
            Weapon.ServerStopFire( 1 );
        }
        return true;
    }

    return false;
}

event TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType)
{
    //gLog( "TakeDamage" #Damage #GON(InstigatedBy) #Vsize(HitLocation-Location) #VSize(Momentum) #GON(DamageType) );

    // Can't hurt it yourself
    if( InstigatedBy != None && InstigatedBy.Controller == Deployer )
        return;

    // Upgraded stops 60% damage
    if( bUpgraded )
        Damage *= 0.4;

    Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
    
    // Ball damage effect
    if( Role == ROLE_Authority && Health > 0 )
    	CheckBallDamage();
}

function CheckBallDamage()
{
	local class<Emitter> DamageEmitter, CurrentDamageEmitter;
	
	// get needed
    if( Health / HealthMax < 0.5 )
    	DamageEmitter = BallDamagedMoreClass;
    else if( Health / HealthMax < 0.8 )
    	DamageEmitter = BallDamagedClass;
    	
    // get current
    if( BallDamage != None )
    	CurrentDamageEmitter = BallDamage.class;
    	
    // handle swapping
    if( DamageEmitter != CurrentDamageEmitter )
    {
    	if( BallDamage != None )
    		BallDamage.Destroy();
    	
    	if( DamageEmitter != None )
    	{
	    	BallDamage = Spawn(DamageEmitter,self);
	    	AttachToBone(BallDamage,'core_emitter');
    	}
    }
}


function bool HealDamage(int Amount, Controller Healer, class<DamageType> DamageType)
{
    // Ball damage effect
    if( Role == ROLE_Authority )
    	CheckBallDamage();
    	
    return Super.HealDamage(Amount, Healer, DamageType);
}

// Spawn Explosion FX
simulated function Explode( vector HitLocation, vector HitNormal )
{
    if( Level.NetMode != NM_DedicatedServer )
        Spawn(class'gTurretExplosion', Self,, HitLocation, Rotation);
}

simulated event PlayDying(class<DamageType> DamageType, vector HitLoc)
{
    Explode( Location, vect(0,0,1) );

    if( Level.Game != None )
        Level.Game.DiscardInventory( Self );

    bCanTeleport = false;
    bReplicateMovement = false;
    bTearOff = true;
    bPlayedDeath = true;

    GotoState('Dying');
}


function name GetWeaponBoneFor(Inventory I)
{
    return '';
}


simulated event PostRender2D(Canvas C, float ScreenLocX, float ScreenLocY)  // called if bScriptPostRender is true, overrides native team beacon drawing code
{
	local PlayerController PC;
	
	PC = Level.GetLocalPlayerController();
	if( PC == None )
		return;
	
	// Only for deployer or team mates
	if( PC == Deployer || (PC.GameReplicationInfo != None && PC.GameReplicationInfo.bTeamGame && TeamLink(PC.GetTeamNum()))  )
	{
		// Draw health bar
		class'gPawnHUD'.static.DrawGenericHealthBar(C, self, Health / HealthMax
			, CollisionRadius, Location + vect(0,0,2) * CollisionHeight
			, TeamBeaconBorderMaterial, TeamBeaconTexture);
	}
}


// ============================================================================
//  STATE Dying
// ============================================================================
state Dying
{
ignores Trigger, Bump, HitWall, HeadVolumeChange, PhysicsVolumeChange, Falling, BreathTimer;

    event ChangeAnimation() {}
    event StopPlayFiring() {}
    function PlayFiring(float Rate, name FiringMode) {}
    function PlayWeaponSwitch(Weapon NewWeapon) {}
    function PlayTakeHit(vector HitLoc, int Damage, class<DamageType> damageType) {}
    simulated function PlayNextAnimation() {}
    event FellOutOfWorld(eKillZType KillType) { }
    function Landed(vector HitNormal) { }
    function ReduceCylinder() { }
    function LandThump() {  }
    event AnimEnd(int Channel) {    }
    function LieStill() {}
    singular function BaseChange() {    }
    function Died(Controller Killer, class<DamageType> damageType, vector HitLocation) {}
    event TakeDamage( int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, class<DamageType> damageType) {}
    function DriverDied();

    simulated function Timer()
    {
        if( !bDeleteMe )
            Destroy();
    }

    function BeginState()
    {
        AmbientSound    = None;
        Velocity        = vect(0,0,0);
        Acceleration    = Velocity;
        bHidden         = true;

        SetPhysics( PHYS_None );
        SetCollision(false, false, false);

        // If server, wait a second for replication
        if( Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer )
        {
            SetTimer(1.f, false);
        }
        else
        {
            // Destroy right away
            if( Controller != None )
                Controller.PawnDied( Self );

            Destroy();
        }

    }
}



// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog ( coerce string S ){
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
	bScriptPostRender			= True

	BallClass(0)				= class'GEffects.gTurretBallRed'
	BallClass(1)				= class'GEffects.gTurretBallBlue'
	BallClass(2)				= class'GEffects.gTurretBallNeutral'

	BallDamagedClass			= class'GEffects.gTurretDamaged'
	BallDamagedMoreClass		= class'GEffects.gTurretDamagedMore'

    UpgradeSound                = Sound'G_Sounds.t_upgrade_shield_a1'
    UpgradeCost                 = 50
    UpgradeClass                = class'gTurretArmor'

    RotationChangeTime          = 0.1
    RotationSound               = Sound'G_Sounds.t_rotating_a1'
    RotationEndSound            = Sound'G_Sounds.t_rotating_end_a1'

    DefaultWeaponClassName      = "GGame.gTurretWeapon"
    AutoTurretControllerClass   = class'GGame.gTurretController'
    OpenCloseSound              = Sound'AssaultSounds.Sentinel.Ceiling_Open_Close'

    TeamBeaconTexture           = Texture'ONSInterface-TX.HealthBar'
    TeamBeaconBorderMaterial    = Material'InterfaceContent.BorderBoxD'

    bDrawVehicleShadow          = false
    bDesiredBehindView          = true
    bShowDamageOverlay          = true
    bRemoteControlled           = true
    VehiclePositionString       = "manning a turret"
    VehicleNameString           = "Turret"

    bCanClimbLadders            = false
    bCanPickupInventory         = false
    bCanTeleport                = false
    BaseEyeHeight               = 0.0
    EyeHeight                   = 0.0

    bAutoTurret                 = True
    bNonHumanControl            = True
    bDefensive                  = True
    bStationary                 = False
    SightRadius                 = 32768.0
    PeripheralVision            = -1 // full circle

    Health                      = 500
    HealthMax                   = 500

    AirSpeed                    = 0.0
    WaterSpeed                  = 0.0
    AccelRate                   = 0.0
    JumpZ                       = 0.0
    MaxFallSpeed                = 0.0

    bSimulateGravity            = False
    bIgnoreForces               = True
    bShouldBaseAtStartup        = False
    bCanBeBaseForPawns          = False
    bNoTeamBeacon               = False

    bPathColliding              = true
    bBlockKarma                 = true
    bCollideActors              = true
    bCollideWorld               = False
    bBlockActors                = true
    bIgnoreEncroachers          = True
    bUseCylinderCollision       = false
    CollisionHeight             = 32.0
    CollisionRadius             = 64.0
    Physics                     = PHYS_Rotating
    RotationRate                = (Pitch=16384,Yaw=16384,Roll=0)

    bStasis                     = false
    bNetNotify                  = True
    bNetInitialRotation         = true
    RemoteRole                  = ROLE_SimulatedProxy

    AmbientGlow                 = 0
    DrawType                    = DT_Mesh
    Mesh                        = SkeletalMesh'G_Anims.Turret'
    DrawScale                   = 0.33
    PrePivot                    = (Z=-12)

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 256
    SoundRadius                 = 256
    SoundVolume                 = 255
}