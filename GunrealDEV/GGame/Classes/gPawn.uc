// ============================================================================
//  gPawn.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPawn extends xPawn;


#EXEC OBJ LOAD FILE="G_Sounds.uax"


// - JumpZ Scaling ------------------------------------------------------------
//
//  JumpHeight  = JumpZ*(JumpZ/(2*950))-0.5*(2*950)*((JumpZ/(2*950))**2)
//  JumpHeight ~= 0.0002625*JumpZ*JumpZ
//  ScaledJumpZ = (ScaledJumpHeight/0.0002625)**0.5
//


// - Movement collisions ------------------------------------------------------

var() float                 RamTime;            // Min time between collision damage
var() int                   RamPawnTicks;
var   int                   BumpTick;          // How many frames ago Bump was calle

// - Stamina ------------------------------------------------------------------

var() float                 StaminaRegen;       // Regeneration rate
var() float                 StaminaCostJump;    // Fixed jump cost
var() float                 StaminaCostSprint;  // Degeneration rate while sprinting
var   float                 StaminaPoints;
var   float                 StaminaDrain;
var   float                 StaminaHit;

// - Physics ------------------------------------------------------------------

var() bool                  bLimitStrafeSpeed;      // Limit strafe speed to walking speed
var() float                 SwimPct;                // Swimming "walking" speed multiplier
var() float                 JumpCrouchBonus;        // Jump height multiplier for crouching

// - Aim Error ----------------------------------------------------------------

var   float                 InaccuracyXhairScale;
var   float                 InaccuracyXhairStance;
var() float                 InaccuracyXhairStanceSpeed;

// - Hit Effects --------------------------------------------------------------

var() Range                 GibSpeed;
var() bool                  GibUseCollision;
var   bool                  bHeadGibbed;
var() class<Actor>          WallBloodDecal;
var() class<Emitter>        HeadShotEmitter;
var() class<Actor>          BloodGibClass;
var() class<Actor>          BloodEmitClass;

// - UDamage ------------------------------------------------------------------

var() float                 UDamageSoundVolume;
var() float                 UDamageSoundRadius;
var() ESoundSlot            UDamageSoundSlot;

var() Sound                 UDamageLoopEndSound;
var() float                 UDamageLoopEndSoundVolume;
var() float                 UDamageLoopEndSoundRadius;
var() ESoundSlot            UDamageLoopEndSoundSlot;

var() class<Emitter>        UDamageEmitterClass;
var   Emitter               UDamageEmitter;

// - Ram ----------------------------------------------------------------------

var() float                 RamSelfDamage;      // Damage amount
var() float                 RamPawnDamage;      // Damage amount
var() Range                 RamYawRange;        // Angle at which hit player will be propelled

var() vector                RamRotMag;          // how far to rotate view as it shakes
var() vector                RamRotRate;         // how fast to rotate view
var() float                 RamRotTime;         // how long to rotate view
var() vector                RamOffsetMag;       // max view offset
var() vector                RamOffsetRate;      // how fast to offset view
var() float                 RamOffsetTime;      // how long to offset view (number of shakes)

var() Sound                 RamSound;
var() float                 RamSoundVolume;
var() float                 RamSoundRadius;
var() Actor.ESoundSlot      RamSoundSlot;

var() class<DamageType>     RamDamageType;

var() float                 RamDamageCurve;


// - Turret -------------------------------------------------------------------

var   class<gTurret>        TurretClass;
var   gTurret               Turret;

// ----------------------------------------------------------------------------

var   float                 CrouchEndTime;
var() float                 JumpCrouchTime;

var   Sound                 RagImpactSound;
var   class<Actor>          SpawnInEffects[2];

var   gMutator.EBonusMode   PendingBonusMode;
var   gMutator.EBonusMode   BonusMode;
var   gShopInfo             ShopInfo;

var   int                   LastDamageAmount; // EMB - to make sure we don't gib if less than 80 dmg or so


var   float                 LastDamageTime;
var   float                 RegenPauseTime;

var   float                 ShieldTime;
var() float                 ShieldDuration;
var() float                 ShieldRecharge;
var() class<Emitter>        ShieldEmitterClass;

var() int                   BonusMoney;

var   Weapon                SelectedWeapon;

var transient gAvoidMarker  LastMarker;

var() config byte           ClothingType;
var() array<Sound>          ClothingSounds;
var() array<Sound>          ClothingJumpSounds;

var   bool                  bAcidFX;
var() float                 AcidAmbientScaling;

var   float                 LastDamageSoundTime;

var() float SpawnInFOV;

var() class<gOverlayTemplate> SpawnOverlayClass;
var() class<gOverlayTemplate> UDamageOverlayClass;

var float   BloodSpawnTime;

var   gPawnHUD              PawnHUD;
var   gPawnInventory        PawnInventory;
var   gPawnAccuracy         PawnAccuracy;

var() array< class<gGib> > HeadGiblets;
var   bool bUseShopping;

var   Actor                 LastTeleporter; // Fix Teleporter not setting bOut

var byte RepStaminaDrain;
var Actor GibletCam;

var() float RagdollLifeSpanMax;
var() float RagImpactMinVolume;
var() float RagImpactMaxVolume;
var() float RagImpactMinSpeed;
var() float RagImpactMaxSpeed;

var   float HealingWardTime;
var() float HealingWardTimeBase;
var   gTimer HealingWardTimer;
var   vector HealingWardLocation;
var() float HealingWardRadius;
var() float HealingWardHeal;
var() class<Actor> HealingWardEffect;
var() class<Actor> HealingWardHealEffect;
var() class<gOverlayTemplate> HealingWardOverlay;



// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    local int i;

    class'gPawnHUD'.static.PrecacheScan(S);


    S.PrecacheObject(default.UDamageLoopEndSound);
    S.PrecacheObject(default.RagImpactSound);

    for( i=0; i<default.ClothingSounds.Length; ++i )
        S.PrecacheObject(default.ClothingSounds[i]);

    for( i=0; i<default.ClothingJumpSounds.Length; ++i )
        S.PrecacheObject(default.ClothingJumpSounds[i]);

    S.PrecacheObject(default.WallBloodDecal);
    S.PrecacheObject(default.HeadShotEmitter);
    S.PrecacheObject(default.BloodGibClass);
    S.PrecacheObject(default.BloodEmitClass);
    S.PrecacheObject(default.UDamageEmitterClass);
    S.PrecacheObject(default.ShieldEmitterClass);
    S.PrecacheObject(default.SpawnOverlayClass);
    S.PrecacheObject(default.UDamageOverlayClass);
    S.PrecacheObject(default.RamSound);

    for( i=0; i<ArrayCount(default.SpawnInEffects); ++i )
        S.PrecacheObject(default.SpawnInEffects[i]);

}

// ============================================================================
// Replication
// ============================================================================
replication
{
    // Variables the server should send to the owning client.
    reliable if( bNetOwner && bNetDirty && Role == ROLE_Authority )
         RepStaminaDrain, LastDamageAmount, bAcidFX, bUseShopping, PendingBonusMode, BonusMode;

    // Variables the server should send to the clients.
    reliable if( bNetDirty && Role == ROLE_Authority )
        Turret;

    // Functions server should call on client
    unreliable if( Role == ROLE_Authority )
        ClientUpdateStamina, ClientPlayCameraEffects, ClientShieldUse;

    // Functions server should call on client
    reliable if( Role == ROLE_Authority )
        ClientSwitchToGunrealWeapon, ClientSwitchToWeapon, ClientSetHealingWardTime;
}

// ============================================================================
// LifeSpan
// ============================================================================
event PreBeginPlay()
{
    if( InstagibCTF(Level.Game) == None )
    {
        bUseShopping = True;
    }

    Super.PreBeginPlay();
}

simulated event PostBeginPlay()
{
    //gLog( "PostBeginPlay");

    if( PawnHUD == None )
        PawnHUD = new(self) class'gPawnHUD';

    if( PawnInventory == None )
        PawnInventory = new(self) class'gPawnInventory';

    if( PawnAccuracy == None )
        PawnAccuracy = new(self) class'gPawnAccuracy';

    Super.PostBeginPlay();
}


simulated event Destroyed()
{
    //gLog( "Destroyed");

    if( PawnHUD != None )
        PawnHUD.Free();
    PawnHUD = None;

    if( PawnInventory != None )
        PawnInventory.Free();
    PawnInventory = None;

    if( PawnAccuracy != None )
        PawnAccuracy.Free();
    PawnAccuracy = None;

	if( HealingWardTimer != None )
		HealingWardTimer.Destroy();
	HealingWardTimer = None;
	
    Super.Destroyed();
}

function Reset()
{
    //gLog( "Reset");
    if( ShopInfo != None )
        ShopInfo.PawnReset(self);

    Super.Reset();
}

function PossessedBy(Controller C)
{
    //glog( "PossessedBy" @C);

    Super.PossessedBy(C);

    if( gBot(C) != None )
        Turret = gBot(C).Turret;
    else if( gPlayer(C) != None )
        Turret = gPlayer(C).Turret;
}

function GibbedBy(Actor Other)
{
    if( Role < ROLE_Authority )
        return;

    if( Pawn(Other) != None )
    {
        if( Pawn(Other).Weapon != None && Pawn(Other).Weapon.IsA('Translauncher') )
            Died(Pawn(Other).Controller, Pawn(Other).Weapon.GetDamageType(), Location);
        else
            Died(Pawn(Other).Controller, class'GGame.gDamTypeTelefragged', Location);
    }
    else
        Died(None, class'GGame.gDamTypeGibbed', Location);
}

simulated event Tick(float DeltaTime)
{
    local float f;

    ++BumpTick;

    if( gWeapon(Weapon) != None )
    {
        //gLog( "" #gWeapon(Weapon).InaccuracyLevel[0] #gWeapon(Weapon).InaccuracyLevel[1] );
        InaccuracyXhairScale = FMax(gWeapon(Weapon).InaccuracyLevel[0], gWeapon(Weapon).InaccuracyLevel[1]);
    }
    else
        InaccuracyXhairScale = 0;

    if( Level.NetMode == NM_DedicatedServer )
        return;

    f = PawnAccuracy.GetStanceSpread();
    if( InaccuracyXhairStance > f )
    {
        InaccuracyXhairStance = FMax(f, InaccuracyXhairStance - DeltaTime * InaccuracyXhairStanceSpeed * FMax(1.0, f));
    }
    else if( InaccuracyXhairStance < f )
    {
        InaccuracyXhairStance = FMin(f, InaccuracyXhairStance + DeltaTime * InaccuracyXhairStanceSpeed * FMax(1.0, f));
    }

    Super.Tick(DeltaTime);
}

function HoldGameObject(GameObject gameObj, name GameObjBone)
{
	Super.HoldGameObject(gameObj, gameObjBone);
	
	if( gameObj != None )
	{
		class'gRegenCTFTimer'.static.GetRegenCTFTimer(self,True);
	}
	
	if( HealingWardTimer == None )
	{
		HealingWardTimer = Spawn(class'gTimer',self);
		HealingWardTimer.OnTimer = HealingWardTimerPop;
		HealingWardTimer.SetTimer(0.2,True);
	}
}


// ============================================================================
// Inventory
// ============================================================================

function EnableUDamage(float Amount)
{
    //gLog( "EnableUDamage" #Amount);

    Super.EnableUDamage(Amount);

    SetWeaponOverlay(UDamageWeaponMaterial, UDamageTime - Level.TimeSeconds, True);
    SetOverlayMaterial(UDamageWeaponMaterial, UDamageTime - Level.TimeSeconds, True);

    if( gPlayer(Controller) != None )
        gPlayer(Controller).ClientAmbientOverlay(UDamageOverlayClass);

    if( UDamageEmitter == None )
        UDamageEmitter = Spawn(UDamageEmitterClass, Self);
}

function DisableUDamage()
{
    //gLog( "DisableUDamage" );

    Super.DisableUDamage();

    SetWeaponOverlay(None, 0, True);
    SetOverlayMaterial(None, 0, True);
    PlaySound(UDamageLoopEndSound, UDamageLoopEndSoundSlot, UDamageLoopEndSoundVolume, False, UDamageLoopEndSoundRadius);

    if( gPlayer(Controller) != None )
        gPlayer(Controller).ClientFadeAmbientOverlay(UDamageOverlayClass);

    if( UDamageEmitter != None )
    {
        UDamageEmitter.AmbientSound = None;
        UDamageEmitter.Kill();
        UDamageEmitter = None;
    }
}


// ============================================================================
//  Collision
// ============================================================================

event Bump(Actor Other)
{
    //gLog( "Bump" #BumpTick #Level.TimeSeconds-RamTime );

    if( Role == ROLE_Authority &&  BumpTick > RamPawnTicks && RamTime < Level.TimeSeconds &&  Pawn(Other) != None )
    {
        RamPawn(Pawn(Other), True);
    }

    BumpTick = 0;

    Super.Bump(Other);
}

simulated event Landed(vector HitNormal)
{
    //Log("Landed");

    if( Level.NetMode != NM_DedicatedServer && Velocity.Z < -150 )
    {
        //Log(Self @ "Velocity.Z=" @ Velocity.Z);
        //Log(Self @ "SoundVolume=" @ FMin(1, -0.6 * Velocity.Z / JumpZ) @ "sound="@ClothingJumpSounds[default.ClothingType]);
        PlayOwnedSound(ClothingJumpSounds[Clamp(default.ClothingType, 0,ClothingJumpSounds.Length-1)], , FMin(1, -0.6 * Velocity.Z / JumpZ),, 400);
        // TODO: super plays the original landing sound.. do we want to get rid of that?
    }

    BumpTick = 0;

    super.Landed(HitNormal);
}


// ============================================================================
//  Shopping
// ============================================================================

final function bool IsShopping()
{
    return ShopInfo != None && ShopInfo.IsShopping();
}


// ============================================================================
// Stamina
// ============================================================================

simulated function UpdateStamina(float DeltaTime)
{
    //gLog( "UpdateStamina" #StaminaPoints #StaminaHit #StaminaDrain #RepStamina #RepStaminaDrain);

    if( Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer )
    {
        RepStaminaDrain = FClamp(-StaminaDrain, 0, 255);
    }
    else if( Level.NetMode == NM_Client )
    {
        StaminaDrain = -RepStaminaDrain;
    }

    if( StaminaHit == 0 && StaminaDrain == 0 )
    {
        StaminaPoints += StaminaRegen * DeltaTime;
    }
    else
    {
        if( StaminaHit != 0 )
        {
            if( Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer )
            {
                ClientUpdateStamina(FClamp(-StaminaHit, 0, 255), FClamp(StaminaPoints, 0, 255));
            }

            StaminaPoints += StaminaHit;
            StaminaHit = 0;
        }

        if( StaminaDrain != 0 )
        {
            StaminaPoints += StaminaDrain * DeltaTime;
            StaminaDrain = 0;
        }
    }

    StaminaPoints = FClamp(StaminaPoints, 0, default.StaminaPoints);
}

final simulated function ClientUpdateStamina(byte Hit, byte Amount)
{
    //gLog("ClientUpdateStamina" #Hit #Amount #StaminaPoints);

    if( Abs(StaminaPoints - Amount) > 10 )
    {
        //gLog("FORCE STAMINA UpdateStamina" #Amount #StaminaPoints);
        StaminaPoints = Amount;
    }

    StaminaPoints = FClamp(StaminaPoints - Hit, 0, default.StaminaPoints);
}

// Armor Shields

function int CanUseShield(int ShieldAmount)
{
    ShieldStrength = Max(ShieldStrength,0);
    if ( ShieldStrength <= ShieldStrengthMax )
    {
        //if ( ShieldAmount == 50 )
        //    ShieldAmount = 50 - SmallShieldStrength;
        return (Min(ShieldStrengthMax, ShieldStrength + ShieldAmount) - ShieldStrength);
    }
    return 0;
}

function bool AddShieldStrength(int ShieldAmount)
{
    local int OldShieldStrength;

    OldShieldStrength = ShieldStrength;
    ShieldStrength += CanUseShield(ShieldAmount);
    /*if ( ShieldAmount == 50 )
    {
        SmallShieldStrength = 50;
        if ( ShieldStrength < 50 )
            ShieldStrength = 50;
    }*/
    return (ShieldStrength != OldShieldStrength);
}

function HealingWardTimerPop()
{
	local Pawn P;
	local float HealAlpha;
	
	// if active
	if( HealingWardTime != -1 )
	{
		// Cancel
		if( Health <= 0
		||  PlayerReplicationInfo == None
		||  PlayerReplicationInfo.HasFlag == None
		||  !bIsCrouched
		||  VSize(HealingWardLocation-Location) > CollisionRadius )
		{
			HealingWardStop();
		}
		
		// Activate Healing Ward
		else if( GetHealingWardTime() >= HealingWardTimeBase )
		{
			// Effects
			Spawn(HealingWardEffect, self,, Location + vect(0,0,1)*(75.0f-CollisionHeight));
						
			// Heal all around
	        foreach VisibleCollidingActors(class'Pawn', P, HealingWardRadius)
	        {
	            if( P == None || P.bDeleteMe || P.Health <= 0 )
	                continue;
	                
				// Heal
				HealAlpha = 1.0f - FClamp(VSize(P.Location-Location)/HealingWardRadius, 0, 1);
				P.GiveHealth(HealingWardHeal * HealAlpha, 199);
				
				// Effects
			    if( gPlayer(P.Controller) != None )
			        gPlayer(P.Controller).ClientFlashOverlay(HealingWardOverlay);
			        
			    if( P != self )
					P.Spawn(HealingWardHealEffect,P);
	        }
        
        	// Reset
			HealingWardStart();
		}
	}
	else
	{
		// Start
		if( PlayerReplicationInfo != None
		&&  PlayerReplicationInfo.HasFlag != None
		&&  bIsCrouched )
		{
			HealingWardStart();
		}
	}
}

function HealingWardStart()
{
	// Replicate delta for smooth clientside timer
    HealingWardTime = Level.TimeSeconds;
    HealingWardLocation = Location;
    ClientSetHealingWardTime();
}

function HealingWardStop()
{	
	// Replicate stop
    HealingWardTime = -1;
    ClientSetHealingWardTime(,True);
}

final simulated function ClientSetHealingWardTime( optional float DeltaTime, optional bool bHalt )
{
    if( bHalt )
        HealingWardTime = -1;
    else
        HealingWardTime = Level.TimeSeconds + DeltaTime;
}

final simulated function float GetHealingWardTime()
{
    if( HealingWardTime >= 0 )
        return Level.TimeSeconds - HealingWardTime;
    return -1;
}


// ============================================================================
// Movement
// ============================================================================

event StartCrouch(float HeightAdjust)
{
    Super.StartCrouch(HeightAdjust);
}

event EndCrouch(float HeightAdjust)
{	
    //gLog( "EndCrouch" #HeightAdjust #CollisionHeight #CollisionRadius );
	
    CrouchEndTime = Level.TimeSeconds;
    Super.EndCrouch(HeightAdjust);
}

simulated event ModifyVelocity(float DeltaTime, vector OldVelocity)
{
    local vector X, Y, Z, RX, RY, RZ;
    local float Speed, ForwardSpeed, StrafeSpeed, OldSpeed, MaxSpeed;

    if( Physics == PHYS_Walking )
    {
        // Limit sprint strafing speed to walk strafing speed
        if( bLimitStrafeSpeed )
        {
            GetAxes(rotator(Velocity),X,Y,Z);
            GetAxes(Rotation,RX,RY,RZ);
            Speed = VSize(Velocity);
            ForwardSpeed = Speed * X Dot vector(Rotation);
            StrafeSpeed = Speed * Y Dot vector(Rotation);
            StrafeSpeed = FClamp( StrafeSpeed, -GroundSpeed*WalkingPct, GroundSpeed*WalkingPct );
            Velocity = RX * ForwardSpeed - RY * StrafeSpeed;

            //VarWatch( "Speed", Abs(VSize(Velocity)/GroundSpeed), True );
            //VarWatch( "ForwardSpeed", Abs(ForwardSpeed/GroundSpeed), True );
            //VarWatch( "StrafeSpeed", Abs(StrafeSpeed/GroundSpeed), True );
        }

        // If somehow running without stamina, make us walk
        if( StaminaPoints <= 0 &&!bIsWalking )
        {
            bIsWalking = True;
            ChangeAnimation();
            Velocity = Normal(Velocity) * FMin(VSize(Velocity), GroundSpeed * WalkingPct);
        }
    }
    else if( Physics == PHYS_Falling )
    {
        // when walking do not let air accel increase XY speed past walking speed
        if( bIsWalking )
        {
            Speed = VSize(Velocity*vect(1,1,0));
            OldSpeed = VSize(OldVelocity*vect(1,1,0));
            if( Speed > OldSpeed )
            {
                MaxSpeed = AirSpeed * WalkingPct;
                if( OldSpeed > MaxSpeed )
                    Speed = OldSpeed;
                else
                    Speed = FMin( Speed, MaxSpeed );

                Velocity = Normal(Velocity*vect(1,1,0)) * Speed + Velocity*vect(0,0,1);
            }
        }
    }

    //gLog( "MV" #Physics #DeltaTime #VSize(Velocity) #VSize(SprintLastVelocity) #VSize(Acceleration) );
}

function AddVelocity(vector NewVelocity)
{
    if( bIgnoreForces || NewVelocity == vect(0,0,0) )
        return;

    if( Physics == PHYS_Falling && AIController(Controller) != None )
        ImpactVelocity += NewVelocity;

    // Gunreal: allow pawn to be pushed around easily when not crouching
    if( (Physics == PHYS_Walking && (!bIsCrouched || NewVelocity.Z > Default.JumpZ) )
    ||((Physics == PHYS_Ladder || Physics == PHYS_Spider) && NewVelocity.Z > Default.JumpZ))
        SetPhysics(PHYS_Falling);

    if( Velocity.Z > 380 && NewVelocity.Z > 0 )
        NewVelocity.Z *= 0.5;

    Velocity += NewVelocity;
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
    // No dodging
    return False;
}


function bool PerformDodge(eDoubleClickDir DoubleClickMove, vector Dir, vector Cross)
{
	return false;
}

function bool CanDoubleJump()
{
    return False;
}

function bool CanMultiJump()
{
    return False;
}

function bool DoJump(bool bUpdating)
{
    // Gunreal: Allow jumping while crouched
    if( Physics == PHYS_Walking || Physics == PHYS_Ladder || Physics == PHYS_Spider )
    {
        if( Role == ROLE_Authority )
        {
            if( Level.Game != None && Level.Game.GameDifficulty > 2 )
                MakeNoise(0.1 * Level.Game.GameDifficulty);

            if( bCountJumps && Inventory != None )
                Inventory.OwnerEvent('Jumped');
        }

        if( Physics == PHYS_Spider )
            Velocity = JumpZ * Floor;
        else if( Physics == PHYS_Ladder )
            Velocity.Z = 0;
        else if( bIsWalking )
            Velocity.Z = Default.JumpZ;
        else
            Velocity.Z = JumpZ;

        if( Base != None && !Base.bWorldGeometry )
            Velocity.Z += Base.Velocity.Z;

        // Gunreal: Boost jump height if crouched
        if( bIsCrouched || bWantsToCrouch || Level.TimeSeconds - CrouchEndTime < JumpCrouchTime )
            Velocity.Z += JumpZ * JumpCrouchBonus;

        SetPhysics(PHYS_Falling);

        if( !bUpdating )
            PlayOwnedSound(GetSound(EST_Jump), SLOT_Pain, GruntVolume,,80);

        return True;
    }

    return False;
}


// ============================================================================
//  Camera
// ============================================================================

simulated function vector WeaponBob(float BobDamping)
{
    Local vector WBob;

    WBob = BobDamping * WalkBob;
    WBob.Z += LandBob;
    return WBob;
}

simulated function vector EyePosition()
{
    return EyeHeight * vect(0,0,1);
}


// ============================================================================
//  Inventory
// ============================================================================

function AddDefaultInventory() {
    PawnInventory.AddDefaultInventory();
}

function CreateInventory(string InventoryClassName) {
    PawnInventory.CreateInventory(InventoryClassName);
}

function bool AddInventory(Inventory NewItem) {
    return PawnInventory.AddInventory(NewItem);
}

simulated function PrevWeapon() {
    PawnInventory.PrevWeapon();
}

simulated function NextWeapon() {
    PawnInventory.NextWeapon();
}

simulated function PrevUTWeapon() {
    Super.PrevWeapon();
}

simulated function NextUTWeapon() {
    Super.NextWeapon();
}

simulated function ClientSwitchToGunrealWeapon() {
    PawnInventory.SwitchToGunrealWeapon();
}

simulated function ClientSwitchToWeapon(Weapon W) {
    PawnInventory.SwitchToWeapon(W);
}

simulated function SwitchWeapon(byte F) {
    PawnInventory.SwitchWeapon(F);
}

simulated function SwitchUTWeapon(byte F) {
    Super.SwitchWeapon(F);
}

function TossWeapon(vector TossVel) {
    PawnInventory.TossWeapon(TossVel);
}

simulated function Fire(optional float F)
{
    if( SelectedWeapon != None )
        PawnInventory.SwitchToSelected();

    Super.Fire(F);
}

simulated function AltFire(optional float F)
{
    if( SelectedWeapon != None )
        PawnInventory.SwitchToSelected();

    Super.AltFire(F);
}

simulated function StartFiring(bool bHeavy, bool bRapid)
{
    if( HasUDamage() )
    {
        PlaySound(UDamageSound, UDamageSoundSlot, UDamageSoundVolume, False, UDamageSoundRadius);
        LastUDamageSoundTime = Level.TimeSeconds;
    }

    Super.StartFiring(bHeavy, bRapid);
}

simulated function bool CanThrowWeapon()
{
    if( Level.Game.bAllowWeaponThrowing )
    {
        if( (SelectedWeapon != None && SelectedWeapon.CanThrow() )
        || (Weapon != None && Weapon.CanThrow()))
            return True;
    }
    return False;
}


// ============================================================================
// Driving
// ============================================================================

simulated event StartDriving(Vehicle V)
{
    // Adjust driver
    SetDrawScale(class'xPawn'.default.DrawScale);

    Super.StartDriving(V);
}

simulated event StopDriving(Vehicle V)
{
    // Reset driver
    SetDrawScale(default.DrawScale);

    Super.StopDriving(V);
}


// ============================================================================
// HUD
// ============================================================================

simulated function DrawHUD(Canvas C)
{
    PawnHUD.DrawHUD(C);
}

simulated function SpecialDrawCrosshair(Canvas C)
{
    PawnHUD.SpecialDrawCrosshair(C);
}

final simulated function SetCrosshairScale(float f)
{
    InaccuracyXhairScale = f;
}


// ============================================================================
// Damage
// ============================================================================
event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
//    if( HitLocation == vect(0,0,0) )
//        log(self@"TakeDamage: HitLocation=(0,0,0), params:"@Damage@InstigatedBy@HitLocation@Momentum@DamageType);

    if( Turret != None && InstigatedBy == Turret )
        return;

    if( ShieldTime + ShieldDuration > Level.TimeSeconds )
        return;

    // Terminal shield protects from all damage except poison timer
    if( IsShopping() && class<gDamTypePoison>(DamageType) == None )
        return;

    // DamageType must exist
    if( DamageType == None )
        DamageType = class'DamageType';

    LastDamageAmount = Damage;
    LastDamageTime = Level.TimeSeconds;

    if( DamageType == class'DamageType' || !DamageType.default.bCausedByWorld )
        RegenPauseTime = LastDamageTime;

    //gLog( "TakeDamage" #Damage #GON(InstigatedBy) #Vsize(HitLocation-Location) #VSize(Momentum) #GON(DamageType) );

    Super.TakeDamage(Damage, InstigatedBy, Hitlocation, Momentum, DamageType);
}

function bool HealDamage(int Amount, Controller Healer, class<DamageType> DamageType)
{
    if( Health > 0 && Health < SuperHealthMax )
    {
        Health = Min( Health+Amount, SuperHealthMax );
        MakeNoise(1.0);
        return True;
    }
    return False;
}

function bool ShieldUse()
{
    if( BonusMode == BM_Shield && ShieldTime + ShieldDuration + ShieldRecharge < Level.TimeSeconds )
    {
        ShieldTime = Level.TimeSeconds;
        Spawn(ShieldEmitterClass, Self);
        ClientShieldUse();
        return True;
    }
    return False;
}

final simulated function ClientShieldUse()
{
    ShieldTime = Level.TimeSeconds;
}

event UsedBy(Pawn User)
{
    if( User == Self && (TurretUse() || ShieldUse()) )
    {
        if( gPlayer(Controller) != None )
            gPlayer(Controller).bSuccessfulUse = True;
    }
}

function IncrementSpree()
{
    spree++;

    // Spree reward
    if( Controller != None )
        class'gMoneyRewards'.static.SpreeReward(Controller, spree);
}


// ============================================================================
//  Turret
// ============================================================================

function bool InCurrentCombo()
{
    return Turret != None;
}

function bool TurretUse()
{
    local vector HL, HN, TE, TS, X,Y;
    local Actor A;

    // See if there's a turret in front of us
    TS = Location + EyePosition();
    TE = TS + (vector(GetViewRotation()) * 16384);
    A = Trace(HL, HN, TE, TS, True, vect(8,8,8));
    if( A == None )
        HL = TE;

    // Turret upgrades
    if( gTurret(A) != None
    &&  gTurret(A).CanUpgrade(self) )
    {
        if( gTurret(A).Upgrade() )
        {
            Controller.Adrenaline -= gTurret(A).UpgradeCost;
            return true;
        }
    }

    // Turret placing
    if( Turret == None && TurretClass != None && Controller.Adrenaline >= 100 && Base != None && Base.bWorldGeometry
	&& (LastStartSpot == None || VSize(LastStartSpot.Location-Location) > 100) )
    {
        // Trace
        TE = Location - vect(0,0,1) * CollisionHeight;
        A = Trace(HL,HN,TE,Location, False, vect(1,1,0)*TurretClass.default.CollisionRadius + vect(0,0,1)*TurretClass.default.CollisionHeight);
        if( A != None )
        {
            // Use same direction as player but align to surface
            Y = HN cross vector(Rotation);
            X = Y cross HN;

            // Spawn
            Turret = Spawn(TurretClass,,, HL, rotator(X));
            if( Turret != None )
            {
                Turret.SetDeployer(Controller);
                Controller.Adrenaline = 0;
                return True;
            }
        }
    }
    return False;
}

// ============================================================================
//  Hit Effects
// ============================================================================

/*function class<Gib> GetGibClass(xPawnGibGroup.EGibType gibType)
{
    return default.GibGroupClass.static.GetGibClass(gibType);
}*/

simulated function Setup(xUtil.PlayerRecord rec, optional bool bLoadNow)
{
    Super.Setup(rec, bLoadNow);
    GibGroupClass = default.GibGroupClass;
}

//simulated function ChunkUp(rotator HitRotation, float ChunkPerterbation)
//{
//    //gLog( "ChunkUp" );
//    Super.ChunkUp(HitRotation, ChunkPerterbation);
//}

function Died(Controller Killer, class<DamageType> damageType, vector HitLocation)
{
    local Vector            TossVel;
    local Trigger           T;
    local NavigationPoint   N;

    if(UDamageEmitter != None) {
        UDamageEmitter.Kill();
        // lets make damn sure this thing dies everywhere it should
    }

    if( bDeleteMe || Level.bLevelChange || Level.Game == None )
        return; // already destroyed, or level is being cleaned up

    if( DamageType.default.bCausedByWorld && (Killer == None || Killer == Controller) && LastHitBy != None )
        Killer = LastHitBy;

    // mutator hook to prevent deaths
    // WARNING - don't prevent bot suicides - they suicide when really needed
    if( Level.Game.PreventDeath(self, Killer, damageType, HitLocation) )
    {
        Health = max(Health, 1); //mutator should set this higher
        return;
    }
    Health = Min(0, Health);

    if( Weapon != None && (DrivenVehicle == None || DrivenVehicle.bAllowWeaponToss) )
    {
        if( Controller != None )
            Controller.LastPawnWeapon = Weapon.Class;
        Weapon.HolderDied();
        TossVel = Vector(GetViewRotation());
        TossVel = TossVel * ((Velocity Dot TossVel) + 500) + Vect(0,0,200);
        TossWeapon(TossVel);
    }

    if( DrivenVehicle != None )
    {
        Velocity = DrivenVehicle.Velocity;
        DrivenVehicle.DriverDied();
    }

    if( Controller != None )
    {
        Controller.WasKilledBy(Killer);
        Level.Game.Killed(Killer, Controller, self, damageType);
    }
    else
        Level.Game.Killed(Killer, Controller(Owner), self, damageType);

    DrivenVehicle = None;

    if( Killer != None )
        TriggerEvent(Event, self, Killer.Pawn);
    else
        TriggerEvent(Event, self, None);

    // make sure to untrigger any triggers requiring player touch
    if( IsPlayerPawn() || WasPlayerPawn() )
    {
        PhysicsVolume.PlayerPawnDiedInVolume(self);
        ForEach TouchingActors(class'Trigger',T)
            T.PlayerToucherDied(self);

        // event for HoldObjectives
        //for ( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
        //  if ( N.bStatic && N.bReceivePlayerToucherDiedNotify )
        ForEach TouchingActors(class'NavigationPoint', N)
            if( N.bReceivePlayerToucherDiedNotify )
                N.PlayerToucherDied( Self );
    }

    // remove powerup effects, etc.
    RemovePowerups();

    Velocity.Z *= 1.3;
    if( IsHumanControlled() )
        PlayerController(Controller).ForceDeathUpdate();

    if( DamageType != None && (DamageType.default.bAlwaysGibs || (DamageType.default.bDelayedDamage && LastDamageAmount >= 80)) )
    {
        ChunkUp( Rotation, DamageType.default.GibPerterbation );
    }
    else
    {
        NetUpdateFrequency = Default.NetUpdateFrequency;
        PlayDying(DamageType, HitLocation);
        if( Level.Game.bGameEnded )
            return;

        if( !bPhysicsAnimUpdate && !IsLocallyControlled() )
            ClientDying(DamageType, HitLocation);
    }
}

simulated function ProcessHitFX()
{
    local Coords boneCoords;
    local class<xEmitter> HitEffects[4];
    local int i,j;
    local float GibPerterbation;

    if( Level.NetMode == NM_DedicatedServer || bSkeletized || Mesh == SkeletonMesh || class'GameInfo'.static.NoBlood() )
    {
        SimHitFxTicker = HitFxTicker;
        return;
    }

    for( SimHitFxTicker=SimHitFxTicker; SimHitFxTicker!=HitFxTicker; SimHitFxTicker=(SimHitFxTicker + 1) % ArrayCount(HitFX) )
    {
        j++;
        if( j > 30 )
        {
            SimHitFxTicker = HitFxTicker;
            return;
        }

        if( (HitFX[SimHitFxTicker].damtype == None) || (Level.bDropDetail && (Level.TimeSeconds - LastRenderTime > 3) && !IsHumanControlled()) )
            continue;

        boneCoords = GetBoneCoords( HitFX[SimHitFxTicker].bone );

        if( !Level.bDropDetail && !bSkeletized && !class'GameInfo'.static.NoBlood() )
        {
            AttachActorEffect( BloodEmitClass, HitFX[SimHitFxTicker].bone, boneCoords.Origin, HitFX[SimHitFxTicker].rotDir );
            HitFX[SimHitFxTicker].damtype.static.GetHitEffects( HitEffects, Health );

            // don't attach effects under water
            if( !PhysicsVolume.bWaterVolume )
            {
                for( i = 0; i < ArrayCount(HitEffects); i++ )
                {
                    if( HitEffects[i] == None )
                        continue;

                    AttachEffect( HitEffects[i], HitFX[SimHitFxTicker].bone, boneCoords.Origin, HitFX[SimHitFxTicker].rotDir );
                }
            }
        }

        if( class'GameInfo'.static.UseLowGore() )
            HitFX[SimHitFxTicker].bSever = False;

        if( HitFX[SimHitFxTicker].bSever )
        {
            GibPerterbation = HitFX[SimHitFxTicker].damtype.default.GibPerterbation;
            bFlaming = HitFX[SimHitFxTicker].DamType.Default.bFlaming;

            switch( HitFX[SimHitFxTicker].bone )
            {
                case 'head':
                    if( GibCountHead > 0 )
                    {
                        AttachActorEffect(HeadShotEmitter, 'head', boneCoords.Origin, HitFX[SimHitFxTicker].rotDir);
                        SpawnHeadGiblets(boneCoords.Origin, HitFX[SimHitFxTicker].rotDir, GibPerterbation);
                        GibCountHead--;
                        HideBone(HitFX[SimHitFxTicker].bone);
                    }
                    break;
            }
        }
    }
}

simulated function HideBone(name BoneName)
{
    if( BoneName == 'head' )
    {
        if( gPlayer(OldController) != None && gPlayer(OldController).ViewTarget == self )
        {
            gPlayer(OldController).ClientFlashOverlay( class'GEffects.gOverlay_Headshot' );
        }

        Super.HideBone(BoneName);
    }
}


simulated function SpawnGiblet(class<Gib> GibClass, Vector Location, Rotator Rotation, float GibPerterbation)
{
    local Gib Giblet;
    local vector Direction, Dummy;

    //gLog(GibClass);

    if( GibClass == None || class'GameInfo'.static.UseLowGore() || class'GameInfo'.static.NoBlood() )
        return;

    if((Level.bAggressiveLOD && Frand() > 0.5) || (Level.bDropDetail && Frand() > 0.75))
        return;

    Instigator = Self;
    if( EffectIsRelevant(Location, False) )
    {
        Giblet = Spawn(GibClass,,, Location, Rotation);
        if( Giblet != None )
        {
            Giblet.bFlaming = bFlaming;
            Giblet.SpawnTrail();

            GibPerterbation *= 32768.0;
            Rotation.Pitch += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;
            Rotation.Yaw += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;
            Rotation.Roll += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;

            GetAxes(Rotation, Dummy, Dummy, Direction);

            Giblet.Velocity = VRand() * RandRange(GibSpeed.Min, GibSpeed.Max);
            Giblet.Velocity.Z = Direction.Z * RandRange(GibSpeed.Min, GibSpeed.Max);
            //glog(self@"Giblet"@Giblet@"Velocity="@Giblet.Velocity);

            GibletCam = Giblet;
        }
    }
}

simulated function SpawnHeadGiblets(vector HitLocation, rotator HitRotation, float GibPerterbation)
{
    local gGib Giblet;
    local vector Direction, Dummy;
    local int i;

    if( class'GameInfo'.static.UseLowGore() || class'GameInfo'.static.NoBlood() )
        return;

    GibPerterbation *= 32768.0;
    Instigator = Self;
    if( EffectIsRelevant(HitLocation, False) )
    {
        for( i=0; i<HeadGiblets.Length; ++i )
        {
            if((Level.bAggressiveLOD && Frand() > 0.5) || (Level.bDropDetail && Frand() > 0.75))
                continue;

            Giblet = Spawn(HeadGiblets[i],,, HitLocation, HitRotation);
            if( Giblet != None )
            {
                Giblet.bFlaming = bFlaming;
                Giblet.SpawnTrail();

                HitRotation.Pitch += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;
                HitRotation.Yaw += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;
                HitRotation.Roll += (FRand() * 2.0 * GibPerterbation) - GibPerterbation;

                GetAxes(HitRotation, Dummy,Dummy,Direction);

                Giblet.Velocity = VRand() * RandRange(GibSpeed.Min * 0.5, GibSpeed.Max * 0.5);
                Giblet.Velocity.Z = Direction.Z * RandRange(GibSpeed.Min, GibSpeed.Max);
                //glog(self@"Giblet"@Giblet@"Velocity="@Giblet.Velocity);

                GibletCam = Giblet;
            }
        }
    }
}

simulated function SpawnGibs(rotator HitRotation, float ChunkPerterbation)
{
    bGibbed = True;
    PlayDyingSound();

    if( !PhysicsVolume.bNoDecals )
        Spawn(class'gBloodSplatterGibExplosion',,, Location, rotator(vect(0,0,-1)));

    if( GibCountTorso + GibCountHead + GibCountForearm + GibCountUpperArm > 3 )
    {
        if( class'GameInfo'.static.UseLowGore() )
        {
            if( !class'GameInfo'.static.NoBlood() )
                GibletCam = Spawn(GibGroupClass.default.LowGoreBloodGibClass,,, Location);
        }
        else
        {
            GibletCam = Spawn(BloodGibClass,,, Location);
        }
    }

    if( !class'GameInfo'.static.UseLowGore() && !class'GameInfo'.static.NoBlood() )
    {
        SpawnGiblet(class'gGibExplosionA', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionA', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionA', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionA', Location, HitRotation, ChunkPerterbation);

        SpawnGiblet(class'gGibExplosionB', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionB', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionB', Location, HitRotation, ChunkPerterbation);

        SpawnGiblet(class'gGibExplosionD', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionD', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionD', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionD', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionD', Location, HitRotation, ChunkPerterbation);

        SpawnGiblet(class'gGibExplosionG', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionG', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionG', Location, HitRotation, ChunkPerterbation);
        SpawnGiblet(class'gGibExplosionG', Location, HitRotation, ChunkPerterbation);
    }

    if( gPlayer(OldController) != None && gPlayer(OldController).ViewTarget == self && GibletCam != None )
    {
        gPlayer(OldController).SetViewTarget(GibletCam);
        gPlayer(OldController).bBehindView = False;
        gPlayer(OldController).ClientFlashOverlay( class'GEffects.gOverlay_Gibbed' );
    }
}

simulated function AttachActorEffect( class<Actor> EmitterClass, Name BoneName, Vector Location, Rotator Rotation )
{
    local Actor a;
    local int i;

    if( bSkeletized || (BoneName == 'None') )
        return;

    for( i = 0; i < Attached.Length; i++ )
    {
        if( Attached[i] == None )
            continue;

        if( Attached[i].AttachmentBone != BoneName )
            continue;

        if( ClassIsChildOf( EmitterClass, Attached[i].Class ) )
            return;
    }

    a = Spawn( EmitterClass,,, Location, Rotation );

    if( !AttachToBone( a, BoneName ) )
    {
        log( "Couldn't attach "$EmitterClass$" to "$BoneName, 'Error' );
        a.Destroy();
        return;
    }

    for( i = 0; i < Attached.length; i++ )
    {
        if( Attached[i] == a )
            break;
    }

    a.SetRelativeRotation( Rotation );
}

function PlayHit(float Damage, Pawn InstigatedBy, vector HitLocation, class<DamageType> damageType, vector Momentum)
{
    local Vector HitNormal, HitRay, HL, HN, TE;
    local Name HitBone;
    local float HitBoneDist;
    local Actor BloodHit;

    //gLog( "PlayHit" #Damage #GON(InstigatedBy) #VSize(HitLocation-Location) #GON(damageType) #VSize(Momentum) );

    Super(Pawn).PlayHit(Damage,InstigatedBy,HitLocation,DamageType,Momentum);

    if( Damage <= 0 )
        return;

    if( !( Level.NetMode != NM_Standalone
        || Level.TimeSeconds - LastRenderTime < 2.5
        || (InstigatedBy != None && PlayerController(InstigatedBy.Controller) != None)
        || PlayerController(Controller) != None ) )
        return;

    // Calc hit coords

    if( InstigatedBy != None )
        HitRay = Normal(HitLocation-(InstigatedBy.Location+(vect(0,0,1)*InstigatedBy.EyeHeight)));

    if( DamageType.default.bLocationalHit )
        CalcHitLoc( HitLocation, HitRay, HitBone, HitBoneDist );
    else
    {
        HitLocation = Location;
        HitBone = 'None';
        HitBoneDist = 0.0f;
    }

    if( DamageType.default.bAlwaysSevers && DamageType.default.bSpecial )
        HitBone = 'head';

    if( InstigatedBy != None )
        HitNormal = Normal( Normal(InstigatedBy.Location-HitLocation) + VRand() * 0.2 + vect(0,0,2.8) );
    else
        HitNormal = Normal( Vect(0,0,1) + VRand() * 0.2 + vect(0,0,2.8) );

    // Blood
    if( DamageType.Default.bCausesBlood )
    {
        if( !class'GameInfo'.static.NoBlood() )
        {
            //gLog( "PlayHit BLOOD" #VSize(HitLocation-Location) #HitBone #rotator(HitNormal) );
            BloodHit = Spawn( BloodEmitClass, InstigatedBy,, HitLocation, rotator(HitNormal) );
        }
    }

    // Spawn blood decals on walls behind if hit with trace weapon
    if( InstigatedBy != None
    &&  DamageType != None
    && !DamageType.default.bDelayedDamage
    &&  Level.TimeSeconds > BloodSpawnTime
    && !PhysicsVolume.bNoDecals
    && !class'GameInfo'.static.NoBlood() )
    {
        TE = HitLocation + Normal(HitLocation - (InstigatedBy.Location + InstigatedBy.EyeHeight * vect(0,0,1))) * 1024;
        if( Trace(HL, HN, TE, HitLocation, False) != None )
        {
            Spawn(WallBloodDecal,,, HL + 5 * (HN + VRand()), rotator(-HN));
            BloodSpawnTime = Level.TimeSeconds + default.BloodSpawnTime;
        }
    }

    // Gibbing
    DoDamageFX( HitBone, Damage, DamageType, Rotator(HitNormal) );

    // Mesh overlay
    if( DamageType.default.DamageOverlayMaterial != None )
        SetOverlayMaterial( DamageType.default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, false );

    // Screen overlay
    if( gPlayer(Controller) != None && class<gDamTypeWeapon>(DamageType) != None && class<gDamTypeWeapon>(DamageType).default.HitOverlay != None )
        gPlayer(Controller).ClientFlashOverlay( class<gDamTypeWeapon>(DamageType).default.HitOverlay );
}

function PlayTakeHit(vector HitLocation, int Damage, class<DamageType> DamageType)
{
    local Sound DesiredSound;

    // Play hit anim
    PlayDirectionalHit(HitLocation);

    // Play hit sounds
    if( Level.TimeSeconds - LastPainSound >= MinTimeBetweenPainSounds )
    {
        LastPainSound = Level.TimeSeconds;

        // Play pawn hit sound
        if( HeadVolume.bWaterVolume )
        {
            // In water play drowning sound only
            if( DamageType.IsA('Drowned') )
                PlaySound( GetSound(EST_Drown), SLOT_Pain,1.5*TransientSoundVolume );
            else
                PlaySound( GetSound(EST_HitUnderwater), SLOT_Pain,1.5*TransientSoundVolume );
        }
        else
        {
            PlaySound(SoundGroupClass.static.GetHitSound(), SLOT_Pain,2*TransientSoundVolume,,200);
        }

        // Play extra hit sound according to the DamageType
        DesiredSound = DamageType.Static.GetPawnDamageSound();
        if( DesiredSound != None )
            PlayOwnedSound(DesiredSound,SLOT_None,1.0);
    }
}

simulated event PlayDying(class<DamageType> DamageType, vector HitLoc)
{
    //gLog("PlayDying" #GON(DamageType) #HitLoc );

    if( HitDamageType != None && HitDamageType.default.bAlwaysGibs )
    {
        ChunkUp(Rotation, HitDamageType.default.GibPerterbation);
    }
    else
    {
        if( gPlayer(Controller) != None && class<gDamTypeWeapon>(DamageType) != None && class<gDamTypeWeapon>(DamageType).default.DeathOverlay != None )
        {
            gPlayer(Controller).ClientFlashOverlay( class<gDamTypeWeapon>(DamageType).default.DeathOverlay );
        }

        Super.PlayDying(DamageType,HitLoc);
    }
}

// There will be no dismembering, only headshots, and gibs. right?
function DoDamageFX( Name boneName, int Damage, class<DamageType> DamageType, rotator r )
{
    //gLog( "DoDamageFX" #Damage #GON(DamageType) #boneName #r );

    switch(boneName)
    {
        case 'lfoot':
            boneName = 'lthigh';
            break;

        case 'rfoot':
            boneName = 'rthigh';
            break;

        case 'rhand':
            boneName = 'rfarm';
            break;

        case 'lhand':
            boneName = 'lfarm';
            break;

        case 'rshoulder':
        case 'lshoulder':
            boneName = 'spine';
            break;
    }

    HitFX[HitFxTicker].damtype = DamageType;
    HitFX[HitFxTicker].bone = boneName;
    HitFX[HitFxTicker].rotDir = r;
    HitFX[HitFxTicker].bSever = False;

    // Headshot
    if( Health <= 0 && boneName == 'head' && DamageType.default.bAlwaysSevers && DamageType.default.bSpecial )
    {
        HitFX[HitFxTicker].bSever = True;
    }

    HitFxTicker = HitFxTicker + 1;
    if( HitFxTicker > ArrayCount(HitFX)-1 )
        HitFxTicker = 0;
}

event KImpact(Actor other, vector pos, vector impactVel, vector impactNorm)
{
    local float ImpVolume;

    //gLog("KImpact" #VSize(impactVel) #VSize(Velocity) #(Level.TimeSeconds @(RagLastSoundTime + RagImpactSoundInterval)) );

    if( Level.TimeSeconds > RagLastSoundTime + RagImpactSoundInterval )
    {
        impactvel = Normal(impactvel) * FMax(VSize(Velocity), VSize(impactVel));

        ImpVolume = Lerp( FClamp(FMax(0,VSize(impactvel)-RagImpactMinSpeed) / (RagImpactMaxSpeed-RagImpactMinSpeed),0,1), RagImpactMinVolume, RagImpactMaxVolume);
        //gLog("KImpact" #VSize(impactVel) #ImpVolume );
        PlaySound(RagImpactSound, SLOT_None, ImpVolume);
        if( VSize(impactvel) > RagImpactMaxSpeed + RagImpactMinSpeed )
            PlaySound(RagImpactSound, SLOT_None, ImpVolume,, 0.75f);
        if( VSize(impactvel) > RagImpactMaxSpeed + RagImpactMaxSpeed )
            PlaySound(RagImpactSound, SLOT_None, ImpVolume,,, 0.5f);
        RagLastSoundTime = Level.TimeSeconds;
    }
}


// ============================================================================
//  Ambient Effects
// ============================================================================

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
    //gLog( "SetOverlayMaterial" #mat #time #bOverride );

    // UDamage overlay cannot be overriden with another one
    if( mat != None && OverlayMaterial != None && mat != OverlayMaterial && OverlayMaterial == class'gPawn'.default.UDamageWeaponMaterial )
        return;

    // UDamage always overrides
    if( mat == class'gPawn'.default.UDamageWeaponMaterial )
        bOverride = True;

    Super.SetOverlayMaterial(mat,time,bOverride);
}


// ============================================================================
//  Collision damage
// ============================================================================

function RamPawn(Pawn P, bool bHandleOther)
{
    local float SpeedS, AngleS, AlphaS; // Stuff this pawn causes to other one
    local float SpeedP, AngleP, AlphaP; // Stuff other pawn causes to this one
    local vector HNS, HNP;
    //local vector HLS, HLP;

    if( gPawn(P) != None && (!Level.Game.bTeamGame || GetTeamNum() != P.GetTeamNum()) )
    {
        HNS = Normal(Location - P.Location);
        HNP = Normal(P.Location - Location);

        AngleS = FMax(0,-(HNS dot Normal(Velocity)));
        AngleP = FMax(0,-(HNP dot Normal(P.Velocity)));

        SpeedS = VSize(Velocity) * AngleS;
        SpeedP = VSize(P.Velocity) * AngleP;

        if( SpeedS > 0 )
            AlphaS = FMax(0,(SpeedS/GroundSpeed)-WalkingPct) / (1-WalkingPct);

        if( SpeedP > 0 )
            AlphaP = FMax(0,(SpeedP/GroundSpeed)-WalkingPct) / (1-WalkingPct);

//        HLS = Location + (P.Location - Location)*0.5;
//        HLP = P.Location + (Location - P.Location)*0.5;
//        DrawStayingDebugLine( HLS, HLS+HNS*64,255,0,0);
//        DrawStayingDebugLine( HLP, HLP+HNP*64,0,255,0);
//        gLog( GetHumanReadableName() #(AngleS @AlphaS @SpeedS) #(AngleP @AlphaP @SpeedP) );

        // Other was rammed
        if( SpeedS > SpeedP )
        {
            // Damage this pawn
            AlphaP = FMin( AngleP * FMin(AlphaP,1), 1.0 );
            Rammed( AlphaP * RamPawnDamage, AlphaP, P );

            // Damage other pawn
            AlphaS *= AngleS;
            gPawn(P).Rammed( AlphaS * RamPawnDamage, AlphaS, self );

            // Push other pawn
            P.AddVelocity( Velocity + vect(0,0,75) );
        }

        // This pawn was rammed
        else
        {
            // Damage this pawn
            AlphaP *= AngleP;
            Rammed( AlphaP * RamPawnDamage, AlphaP, P );

            // Damage other pawn
            AlphaS = FMin( AngleS * FMin(AlphaS,1), 1.0 );
            gPawn(P).Rammed( AlphaS * RamPawnDamage, AlphaS, self );

            // Push this pawn
            AddVelocity( P.Velocity + vect(0,0,75) );
        }
    }
}

function Rammed(float Damage, float Alpha, Pawn InstigatedBy)
{
    //gLog( "Rammed" #GetHumanReadableName() #Damage #Alpha #InstigatedBy.GetHumanReadableName() );

    if( Controller != None )
        Controller.ShakeView(RamRotMag, RamRotRate, RamRotTime, RamOffsetMag, RamOffsetRate, RamOffsetTime);

    if( RamSound != None )
        PlaySound(RamSound, RamSoundSlot, RamSoundVolume * Alpha, False, RamSoundRadius);

    PlayHit(Damage, InstigatedBy, Location, RamDamageType, vect(0,0,0));
    TakeDamage(Damage, InstigatedBy, Location, vect(0,0,0), RamDamageType);

    RamTime = Level.TimeSeconds + default.RamTime;
}


// ============================================================================
// Teleport Effects
// ============================================================================
function PlayTeleportEffect(bool bOut, bool bSound)
{
    //gLog("PlayTeleportEffect" #bOut #bSound #GON(PendingTouch));

    // Fix Teleporter not setting bOut
    if( !bOut && Teleporter(PendingTouch) != None && LastTeleporter == None )
    {
        LastTeleporter = PendingTouch;
        bOut = True;
    }
    else
        LastTeleporter = None;

    if( gPlayer(Controller) != None )
    {
        ClientPlayCameraEffects();
    }

    if( !bSpawnIn && (Level.TimeSeconds - SpawnTime < Max(1, DeathMatch(Level.Game).SpawnProtectionTime)) )
    {
        bSpawnIn = True;
        SetOverlayMaterial(ShieldHitMat, Max(1, DeathMatch(Level.Game).SpawnProtectionTime), False);

        if( PlayerReplicationInfo == None ||  PlayerReplicationInfo.Team == None ||  PlayerReplicationInfo.Team.TeamIndex == 0 )
            Spawn(SpawnInEffects[0],,, Location + CollisionHeight * vect(0,0,0.75));
        else
            Spawn(SpawnInEffects[1],,, Location + CollisionHeight * vect(0,0,0.75));
    }
    else if( bOut )
    {
        DoTranslocateOut(Location);
    }
    else
    {
        if( PlayerReplicationInfo == None ||  PlayerReplicationInfo.Team == None ||  PlayerReplicationInfo.Team.TeamIndex == 0 )
            Spawn(TransEffects[0], Self,, Location + CollisionHeight * vect(0,0,0.75));
        else
            Spawn(TransEffects[1], Self,, Location + CollisionHeight * vect(0,0,0.75));
    }

    MakeNoise(1.0);
}

simulated function ClientPlayCameraEffects()
{
    //gLog("ClientPlayCameraEffects" @Controller @OldController);
    if( gPlayer(Controller) != None )
    {
        Controller.FOVAngle = SpawnInFOV;
        gPlayer(Controller).ClientFlashOverlay( SpawnOverlayClass );
    }
}

function CheckBob(float DeltaTime, vector Y)
{
    local float OldBobTime;
    local int m,n;
    local float Speed2D;

    OldBobTime = BobTime;

    if( bWeaponBob )
    {
        Bob = FClamp(Bob, -0.01, 0.01);
        if( Physics == PHYS_Walking )
        {
            Speed2D = VSize(Velocity);
            if( Speed2D < 10 )
                BobTime += 0.2 * DeltaTime;
            else
                BobTime += DeltaTime * (0.3 + 0.7 * Speed2D/GroundSpeed);
            WalkBob = Y * Bob * Speed2D * sin(8 * BobTime);
            AppliedBob = AppliedBob * (1 - FMin(1, 16 * deltatime));
            WalkBob.Z = AppliedBob;
            if( Speed2D > 10 )
                WalkBob.Z = WalkBob.Z + 0.75 * Bob * Speed2D * sin(16 * BobTime);
        }
        else if( Physics == PHYS_Swimming )
        {
            BobTime += DeltaTime;
            Speed2D = Sqrt(Velocity.X * Velocity.X + Velocity.Y * Velocity.Y);
            WalkBob = Y * Bob *  0.5 * Speed2D * sin(4.0 * BobTime);
            WalkBob.Z = Bob * 1.5 * Speed2D * sin(8.0 * BobTime);
        }
        else
        {
            BobTime = 0;
            WalkBob = WalkBob * (1 - FMin(1, 8 * deltatime));
        }
    }
    else
    {
        BobTime = 0;
        WalkBob = Vect(0,0,0);
        return;
    }

    if( (Physics != PHYS_Walking) || (VSize(Velocity) < 10 )
        || ((PlayerController(Controller) != None) && PlayerController(Controller).bBehindView) )
        return;

    m = int(0.5 * Pi + 9.0 * OldBobTime/Pi);
    n = int(0.5 * Pi + 9.0 * BobTime/Pi);

    if( (m != n) && !bIsCrouched )
        FootStepping(0);
    else if( !bWeaponBob && bPlayOwnFootSteps && !bIsCrouched && (Level.TimeSeconds - LastFootStepTime > 0.35) )
    {
        LastFootStepTime = Level.TimeSeconds;
        FootStepping(0);
    }
}

simulated function FootStepping(int Side)
{
    local float VolumeMod;

    //gLog("FootStepping" #Side);

    Super.FootStepping(Side);

    if( default.ClothingType < ClothingSounds.Length && ClothingSounds[default.ClothingType] != None )
    {
        if( !bIsWalking )
            VolumeMod = 2.5;
        else if( bIsCrouched )
            VolumeMod = 1.3;
        else
            VolumeMod = 2;

        PlaySound(ClothingSounds[default.ClothingType],, FootstepVolume * VolumeMod,, 400);
    }
}


// ============================================================================
// DYING
// ============================================================================
state Dying
{
    simulated event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
    {
        local Vector PushLinVel, PushAngVel, PushImpulse;
        local Name HitBone;
        local float HitBoneDist;
        local vector TS,TE,HL,HN;
        local Actor A;

        //gLog( "TakeDamage" #Damage #GON(InstigatedBy) #HitLocation #Momentum #GON(DamageType) #bDeRes #bRubbery );
        //Spawn(class'GEffects.gCoordsEmitter',,,HitLocation, rotator(Momentum) );

        // DamageType must exist
        if( DamageType == None )
            DamageType = class'DamageType';

        //log(self@"takedamage while dead ("@damage@")");
        LastDamageAmount = Damage;
        //GibGroupClass = default.GibGroupClass;
        if( damageType != class'Crushed' )
            PlayHit(Damage, InstigatedBy,HitLocation,damageType,Momentum);

        // Gunreal: Spawn blood decals on walls behind if hit with trace weapon
        if( !DamageType.default.bDelayedDamage && InstigatedBy != None && !PhysicsVolume.bNoDecals )
        {
            //Damage = 0;
            TS = HitLocation;
            TE = TS + Normal(TS-(InstigatedBy.Location+InstigatedBy.EyeHeight*vect(0,0,1))) * 1024;
            //TE = TS + Normal(Momentum) * 1024;
            A = Trace(HL,HN,TE,TS,False);

            if( A != None )
            {
                if( WallBloodDecal != None ) {
                    A = Spawn( WallBloodDecal,,,HL + 5 * (HN + VRand()), rotator(-HN));
                }
            }
        }

        // Ragdoll effects
        if( Physics == PHYS_KarmaRagdoll
        && !bDeRes
        && !bFrozenBody
        && !DamageType.default.bLeaveBodyEffect
        && !DamageType.default.bRubbery )
        {
            // Calc momentum if none
            if( Momentum == vect(0,0,0) && InstigatedBy != None )
                Momentum = HitLocation - InstigatedBy.Location;

            // get velocities
            if( DamageType.default.bKUseOwnDeathVel )
            {
                RagDeathVel = DamageType.default.KDeathVel;
                RagDeathUpKick = DamageType.default.KDeathUpKick;
            }
            else
            {
                RagDeathVel = default.RagDeathVel;
                RagDeathUpKick = default.RagDeathUpKick;
            }

            // get impulse strength
            if( DamageType.default.KDamageImpulse > 0 )
            {
                RagShootStrength = DamageType.default.KDamageImpulse;
            }
            else
            {
                RagShootStrength = default.RagShootStrength;
            }

            // Calc forces
            PushImpulse = Normal(Momentum) * RagShootStrength;
            PushLinVel = Normal(Momentum) * RagDeathVel + vect(0,0,1) * RagDeathUpKick;
            PushAngVel = Normal(Normal(Momentum) Cross vect(0, 0, 1)) * -8000;

            // Adjust forces according to damage type
            if( damageType.Default.bThrowRagdoll )
            {
                // throw ragdoll up
                PushLinVel.Z += 350;
            }
            else if( damageType.Default.bRagdollBullet )
            {
            }

            // Apply forces
            HitBone = GetClosestBone( HitLocation, Normal(Momentum), HitBoneDist );
            KAddImpulse( PushImpulse, HitLocation, HitBone );
            KSetSkelVel( PushLinVel, PushAngVel, true );

            // Extend ragdoll lifespan
            if( LifeSpan > 0 )
                LifeSpan = FMin(LifeSpan + 1.0, RagdollLifeSpan);

            if( DamageType.Default.DamageOverlayMaterial != None && Level.DetailMode != DM_Low && !Level.bDropDetail )
                SetOverlayMaterial(DamageType.Default.DamageOverlayMaterial, DamageType.default.DamageOverlayTime, true);

        }

        if( Health < 1 )
        {
            if( LastDamageAmount > 49 && DamageType.default.bDelayedDamage )
            {
                ChunkUp( Rotation, DamageType.default.GibPerterbation );
            }
        }
    }

    simulated event BeginState()
    {
        local KarmaParamsSkel skelParams;

        bNetNotify=True;
        Super.BeginState();
        bSpecialCalcView = True;
        LifeSpan = RagdollLifeSpan;
        RagdollLifeSpanMax = Level.TimeSeconds + default.RagdollLifeSpanMax;
        skelParams = KarmaParamsSkel(KParams);
        skelParams.KImpactThreshold = RagImpactMinSpeed;
    }

    simulated event Timer()
    {
        local KarmaParamsSkel skelParams;
        local Pawn P;

        //gLog( "Timer" #LifeSpan );

        skelParams = KarmaParamsSkel(KParams);

        // Stay around if controller looking at it
        if( gPlayer(OldController) != None
        &&  gPlayer(OldController).ViewTarget == self
        &&  Viewport(gPlayer(OldController).Player) != None )
        {
            skelParams.bKImportantRagdoll = true;

            // Extend ragdoll lifespan
            if( LifeSpan > 0 )
                LifeSpan = FMin(LifeSpan + 1.0, RagdollLifeSpan);

            RagdollLifeSpanMax = Level.TimeSeconds + default.RagdollLifeSpanMax;
            SetTimer(1.0, false);
            return;
        }
        else
        {
            if( RagdollLifeSpanMax < Level.TimeSeconds )
            {
                // Die if max timelimit exceeded
                Destroy();
                return;
            }
            else
            {
                // Stay around if someone's nearby
                foreach VisibleCollidingActors(class'Pawn', P, 4096)
                {
                    if( P.Health > 0 )
                    {
                        skelParams.bKImportantRagdoll = false;

                        // Extend ragdoll lifespan
                        if( LifeSpan > 0 )
                            LifeSpan = FMin(LifeSpan + 1.0, RagdollLifeSpan);

                        SetTimer(1.0, false);
                        return;
                    }
                }
            }
        }

        // Dissapear
        if( LifeSpan < 2.0 )
            Destroy();
        else
            SetTimer(1.0, false);
    }

    simulated event PostNetReceive()
    {
        super.PostNetReceive();
        if( HitDamageType != None
        && (HitDamageType.default.bAlwaysGibs || (LastDamageAmount > 49 && HitDamageType.default.bDelayedDamage))  )
            ChunkUp(Rotation, HitDamageType.default.GibPerterbation);
    }

    simulated function bool SpectatorSpecialCalcView( PlayerController Viewer, out Actor ViewActor, out vector CameraLocation, out rotator CameraRotation )
    {
        local coords C;
        local vector X,Y,Z;
        local KarmaParamsSkel SkelParams;

        if( Viewer.bBehindView )
        {
            if( OldController == Viewer )
                Viewer.bBehindView = False;
            else
                return False;
        }

        if( GibletCam != None )
        {
            CameraLocation = GibletCam.Location;
            CameraRotation = GibletCam.Rotation;
        }
        else
        {
            C = GetBoneCoords('head');
            if( C.Origin == vect(0,0,0) )
                return False;

            // UT2004 bipeds head rotation hack
            X = -C.YAxis;
            Y = -C.ZAxis;
            Z = C.XAxis;

            CameraLocation = C.Origin;
            CameraRotation = OrthoRotation(X,Y,Z);
        }

        SkelParams = KarmaParamsSkel(KParams);
        SkelParams.bKImportantRagdoll = True;

        return True;
    }

    event KVelDropBelow()
    {
        global.KVelDropBelow();
    }
}

event KVelDropBelow()
{
}

simulated function StartDeRes()
{
    Destroy();
}

function DoComboName(string ComboClassName);
function DoCombo(class<Combo> ComboClass);

// ============================================================================
// Debug
// ============================================================================
simulated final function float GetSpeedXY()
{
    return VSize(Velocity*vect(1,1,0));
}

simulated final function float GetSpeedZ()
{
    return Abs(Velocity.Z);
}

exec function EditPawn()
{
    ConsoleCommand( "editobj" @name );
}

exec function EditPawnD()
{
    ConsoleCommand( "editdefault class=" @class.name );
}

exec function DumpInventory()
{
    local Inventory Inv;
    local int i;

    for( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
    {
        gLog( "DumpInventory" #i #GON(Inv) );
        if( ++i > 200 )
            break;
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
	HealingWardTime						= -1
	HealingWardTimeBase					= 4
	HealingWardRadius					= 512
	HealingWardHeal						= 100
	HealingWardEffect					= Class'GEffects.gHealingWardEmitter'
	HealingWardHealEffect				= Class'GEffects.gHealingWardHeal'
	HealingWardOverlay					= Class'GEffects.gOverlay_HealthPickup'

    RamRotMag                           = (X=5,Y=5,Z=25)
    RamRotRate                          = (X=50,Y=50,Z=130)
    RamRotTime                          = 0
    RamOffsetMag                        = (X=10,Y=10,Z=50)
    RamOffsetRate                       = (X=200,Y=200,Z=800)
    RamOffsetTime                       = 3
    RamYawRange                         = (Min=6000,Max=10000)

    RamSelfDamage                       = 7
    RamPawnDamage                       = 15
    RamDamageCurve                      = 14
    RamDamageType                       = class'GGame.gDamTypeRam'

    RamSound                            = Sound'G_Sounds.g_ram_a'
    RamSoundVolume                      = 2.0
    RamSoundRadius                      = 128
    RamSoundSlot                        = SLOT_Misc

    BloodSpawnTime                      = 0.25

    InaccuracyXhairStanceSpeed          = 4.0

    SoundRadius                         = 160
    SoundVolume                         = 255


    SpawnOverlayClass                   = class'gEffects.gOverlay_Spawn'
    UDamageOverlayClass                 = class'GEffects.gOverlay_UDamage'

    ClothingSounds(0)                   = Sound'G_Proc.clothing_gunreal'
    ClothingSounds(1)                   = Sound'G_Proc.clothing_military'

    ClothingJumpSounds(0)               = Sound'G_Proc.clothing_gunreal_jump'
    ClothingJumpSounds(1)               = Sound'G_Proc.clothing_military_jump'

    BonusMoney                          = 600

    ShieldDuration                      = 1
    ShieldRecharge                      = 5
    ShieldEmitterClass                  = class'GEffects.gInvShieldEmitter'

    RagImpactSound                      = Sound'G_Proc.gore_g_ragdoll_hits'

    JumpCrouchTime                      = 0.3

    // gPawn

    StaminaPoints                       = 100
    StaminaRegen                        = 12
    StaminaCostJump                     = 15
    StaminaCostSprint                   = 12

    bLimitStrafeSpeed                   = True

    SwimPct                             = 0.7

    JumpCrouchBonus                     = 0.38

    RamTime                             = 0.5
    RamPawnTicks                        = 3

    GibSpeed                            = (Min=700,Max=1000)
    GibUseCollision                     = True

    WallBloodDecal                      = class'gBloodSplatterTrajectory' //class'BloodSplatter'

    // Other
    AmbientSoundScaling                 = 1.0

    RequiredEquipment(0)                = "GWeapons.gPistonGun"
    RequiredEquipment(1)                = ""

    bSpecialHUD                         = True
    bSpecialCrosshair                   = True
    bCanDoubleJump                      = False
    bCanWalkOffLedges                   = True
    bStopAtLedges                       = False
    bAvoidLedges                        = True
    bDirectHitWall                      = False

    ControllerClass                     = class'GGame.gBot'

    DrawScale                           = 1.4 //1
    PrePivot                            = (X=0.0,Y=0.0,Z=-5)

    JumpZ                               = 424 //340

    WalkingPct                          = 0.7
    CrouchedPct                         = 0.33

    GroundSpeed                         = 440 //440
    AirSpeed                            = 440
    WaterSpeed                          = 300
    LadderSpeed                         = 200
    DodgeSpeedZ                         = 210

    AccelRate                           = 2048 //2048

    BaseEyeHeight                       = 53.2 //38
    EyeHeight                           = 53.2 //38

    CollisionHeight                     = 61.6 //44
    CollisionRadius                     = 35 //25

    CrouchHeight                        = 40.6 //29
    CrouchRadius                        = 35 //25

    DrivingHeight                       = 28 //20
    DrivingRadius                       = 30.8 //22

    HeadRadius                          = 12.6 //9
    HeadHeight                          = 8.4 //6

    WalkAnims(0)                        = RunF
    WalkAnims(1)                        = RunB
    WalkAnims(2)                        = RunL
    WalkAnims(3)                        = RunR

    GibGroupClass                       = class'GGame.gGibGroup'
    GibCountHead                        = 1

    HeadGiblets(0)      = class'gGibHeadShotA'
    HeadGiblets(1)      = class'gGibHeadShotB'
    HeadGiblets(2)      = class'gGibHeadShotC'
    HeadGiblets(3)      = class'gGibHeadShotD'
    HeadGiblets(4)      = class'gGibHeadShotE'
    HeadGiblets(5)      = class'gGibHeadShotF'
    HeadGiblets(6)      = class'gGibHeadShotG'
    HeadGiblets(7)      = class'gGibHeadShotH'
    HeadGiblets(8)      = class'gGibHeadShotI'
    HeadGiblets(9)      = class'gGibHeadShotJ'
    HeadGiblets(10)     = class'gGibHeadShotK'

    SpawnInEffects(0)                   = class'GEffects.gSpawnEmitter'
    SpawnInEffects(1)                   = class'GEffects.gSpawnEmitter'

    TransOutEffect(0)                   = class'GEffects.gTransportOut'
    TransOutEffect(1)                   = class'GEffects.gTransportOut'
    TransEffects(0)                     = class'GEffects.gTransportIn'
    TransEffects(1)                     = class'GEffects.gTransportIn'

    bDynamicLight                       = False
    LightType                           = LT_Steady
    LightEffect                         = LE_QuadraticNonIncidence
    LightBrightness                     = 255
    LightHue                            = 159
    LightSaturation                     = 96
    LightRadius                         = 16

    UDamageWeaponMaterial               = Material'G_FX.udamage_shad'

    UDamageSound                        = Sound'G_Sounds.g_damage_1'
    UDamageSoundVolume                  = 1.0
    UDamageSoundRadius                  = 700
    UDamageSoundSlot                    = SLOT_None


    UDamageLoopEndSound                 = Sound'G_Sounds.g_udamage_ambloop_end1'
    UDamageLoopEndSoundVolume           = 1.0
    UDamageLoopEndSoundRadius           = 700
    UDamageLoopEndSoundSlot             = SLOT_None

    UDamageEmitterClass                 = class'GEffects.gUDamageEmitter'

    HeadShotEmitter                     = class'GEffects.gHeadShotEmitter'

    BloodGibClass                       = Class'GEffects.gGibExplosionEmitter'
    BloodEmitClass                      = class'GEffects.gBodyHitEmitter'

    SpawnInFOV                          = 170

    RagImpactSoundInterval              = 0.06
    RagImpactMinVolume                  = 0.5
    RagImpactMaxVolume                  = 2.5
    RagImpactMinSpeed                   = 256
    RagImpactMaxSpeed                   = 768

    AmbientGlow                         = 0
    bDramaticLighting                   = True
    bUnlit                              = False
    bShadowCast                         = True
    bStaticLighting                     = True

    Begin Object Class=KarmaParamsSkel Name=PawnKParams
        KConvulseSpacing=(Max=2.200000)
        KLinearDamping=0.150000
        KAngularDamping=0.050000
        KBuoyancy=1.000000
        KStartEnabled=True
        KVelDropBelowThreshold=50.000000
        bHighDetailOnly=False
        KFriction=2.0
        KRestitution=0.300000
        KImpactThreshold=250.000000
        bKNonSphericalInertia=True
    End Object
    KParams=KarmaParamsSkel'GGame.gPawn.PawnKParams'

    RagdollLifeSpan=15
    RagdollLifeSpanMax=60
    DeResTime=1

    bCanWallDodge               = False

    FootstepVolume              = 0.3
    RagDeathUpKick              = 0

    TurretClass                 = class'gTurret'

    ShieldStrengthMax           = 200   // This is for "Armor" shields, not invul-shields.
}
