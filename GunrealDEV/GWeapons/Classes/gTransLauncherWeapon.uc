// ============================================================================
//  gTransLauncherWeapon.uc :: quite exact copy of gWeapon
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTransLauncherWeapon extends TransLauncher
    Abstract
    HideDropDown
    CacheExempt
    Config;


// AIRating constants
// Configured AIRating must be >= 2.0 && <= 3.0
// Cumulative penalties must not exceed 1.0
const RATING_Skip       = -2.0; // Don't even think about it
const RATING_Avoid      = 0.1;  // Nearly useless
const RATING_Poor       = 0.5;  // Not very effective
const RATING_Base       = 2.0;  //



// - Weapon Sway --------------------------------------------------------------

var() globalconfig byte SwayMode;
var() bool              bSwayReset;

var() float             SwayMaxRotY;            // How far the gun can sway
var() float             SwayMaxSpeedY;          // How fast the gun can sway
var() float             SwayMaxCenterSpeedY;    // How fast the gun can center
var() float             SwayMaxDeltaSpeedY;     // View rotation speed unit
var() float             SwayDisplacementY;      // View offset sway multiplier

var() float             SwayMaxRotP;            // How far the gun can sway
var() float             SwayMaxSpeedP;          // How fast the gun can sway
var() float             SwayMaxCenterSpeedP;    // How fast the gun can center
var() float             SwayMaxDeltaSpeedP;     // View rotation speed unit
var() float             SwayDisplacementP;      // View offset sway multiplier

var   float             SwayLastTime;
var   rotator           SwayRot;
var   rotator           SwayLastRot;
var   rotator           SwayDefaultPivot;
var   float             SwayCenterDurationY;
var   float             SwayCenterTimeY;
var   float             SwayCenterDurationP;
var   float             SwayCenterTimeP;


// - Render -------------------------------------------------------------------

var() bool              bSpecialDrawWeapon;
var() bool              bForceViewUpdate;


var() float             SelectSoundVolume;

var() int               ItemSize;

var   gPawn             DeadHolder;

var() float             CostWeapon;
var() float             CostAmmo;
var() float             WarrantyPercent;
var() int               WarrantyMode;
var   int               WarrantyDamage;

var() Material          IconFlashMaterial;

var() float             BotPurchaseProbMod;

var() Texture          OverrideCrosshair;

var() array<int>        AmmoShopping;

var() float             HUDAmmoWidth;
var() float             HUDAmmoHeight;

var() float             IdleAnimTween;

var() float             BarFullSteady;

var   float             InaccuracyLevel[2];


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    S.PrecacheObject(default.IconFlashMaterial);
    S.PrecacheObject(default.OverrideCrosshair);
}


// ============================================================================
//  Lifespan
// ============================================================================

simulated event PostBeginPlay()
{
    //gLog( "PostBeginPlay");
    Super.PostBeginPlay();
}

simulated event Destroyed()
{
    //gLog("Destroyed");

    Super.Destroyed();
}


// ============================================================================
//  Projectile
// ============================================================================

simulated function RegisterProjectile( gProjectile P );
simulated function UnRegisterProjectile( gProjectile P );


// ============================================================================
//  Holder
// ============================================================================

function GiveTo(Pawn Other, optional Pickup Pickup)
{
    // Do NOT override in subclasses, override GiveToEx instead!!!
    GiveToEx(Other,Pickup);
}

function GiveToEx(Pawn Other, optional Pickup Pickup, optional bool bGiveEmpty)
{
    local int i;
    local Weapon W;
    local bool bPossiblySwitch, bJustSpawned;

    //gLog( "GiveToEx" #GON(Other) #GON(Pickup) #bGiveEmpty );

    Instigator = Other;
    W = Weapon(Instigator.FindInventoryType(class));
    if( W == None || W.Class != Class )
    {
        bJustSpawned = True;
        if( Other.AddInventory( Self ) )
        {
            GotoState('');
            W = self;
        }
        else
        {
            Destroy();
            return;
        }
    }


    bPossiblySwitch = Pickup != None;

    if( gWeaponPickup(Pickup) != None && gWeaponPickup(Pickup).bBloody && gWeaponPickup(Pickup).KilledController != Instigator.Controller )
    {
        if( gWeapon(W) != None )
            gWeapon(W).WarrantyMode = 2;
    }

    for( i=0; i<NUM_FIRE_MODES; i++ )
    {
        if( FireMode[i] != None )
        {
            FireMode[i].Instigator = Instigator;
            if( !bGiveEmpty )
                W.GiveAmmo(i, WeaponPickup(Pickup), bJustSpawned);
        }
    }

    if( Instigator.Weapon != W )
        W.ClientWeaponSet(bPossiblySwitch);

    if( !bJustSpawned )
        Destroy();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
    local int i;

    bSwayReset = True;

    if( ClientState == WS_Hidden )
    {
        PlayOwnedSound(SelectSound, SLOT_None, SelectSoundVolume,,,, False); // Gunreal: Tweaked
        ClientPlayForceFeedback(SelectForce);  // jdf

        if( Instigator.IsLocallyControlled() )
        {
            if( Mesh != None && HasAnim(SelectAnim) )
                PlayAnim(SelectAnim, SelectAnimRate, 0.0);
        }

        ClientState = WS_BringUp;
        SetTimer(BringUpTime, False);
    }

    for( i=0; i<NUM_FIRE_MODES; i++ )
    {
        FireMode[i].bIsFiring = False;
        FireMode[i].HoldTime = 0.0;
        FireMode[i].bServerDelayStartFire = False;
        FireMode[i].bServerDelayStopFire = False;
        FireMode[i].bInstantStop = False;
    }

    if( PrevWeapon != None && PrevWeapon.HasAmmo() && !PrevWeapon.bNoVoluntarySwitch )
        OldWeapon = PrevWeapon;
    else
        OldWeapon = None;
}

simulated function bool CanThrow()
{
    local int i;

    if( bCanThrow )
    {
        // Don't throw while firing
        for( i=0; i<NUM_FIRE_MODES; i++ )
        {
            if( FireMode[i].NextFireTime > Level.TimeSeconds
            || (FireMode[i].bFireOnRelease && FireMode[i].bIsFiring) )
                return False;
        }

        // Drop on server alwaays, on client only if not selecting
        if( Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer
        ||  ClientState == WS_ReadyToFire || ClientState == WS_Hidden || ClientState == WS_None )
            return True;
    }
    return False;
}

function DropFrom(vector StartLocation)
{
    local int i;
    local Pickup Pickup;

    //gLog( "DropFrom" #WarrantyMode #bCanThrow );

    // Gunreal: allow dropping even if no ammo
    if( !bCanThrow )
        return;

    ClientWeaponThrown();
    for( i=0; i<NUM_FIRE_MODES; i++ )
    {
        if( FireMode[i].bIsFiring )
            StopFire(i);
    }

    if( Instigator != None )
    {
        if( Instigator.Weapon == Self )
            DetachFromPawn(Instigator);
    }

    Pickup = Spawn(PickupClass,,, StartLocation);
    if( Pickup != None )
    {
        Pickup.InitDroppedPickupFor(Self);
        Pickup.Velocity = Velocity;
        if( Instigator.Health > 0 )
            WeaponPickup(Pickup).bThrown = True;
    }

    Destroy();
}

simulated function ClientWeaponThrown()
{
    local int m;

    AmbientSound = None;

    if( Instigator.Weapon == Self )
    {
        Instigator.AmbientSound = None;
        Instigator.SoundVolume = Instigator.default.SoundVolume;
        Instigator.SoundPitch = Instigator.default.SoundPitch;
        Instigator.SoundRadius = Instigator.default.SoundRadius;
    }

    if( Level.NetMode != NM_Client )
        return;

    Instigator.DeleteInventory(self);

    for( m = 0; m < NUM_FIRE_MODES; m++ )
    {
        if( Ammo[m] != None )
            Instigator.DeleteInventory(Ammo[m]);
    }
}

simulated function ClientWeaponSet(bool bPossiblySwitch)
{
    local int Mode;

    //gLog( "ClientWeaponSet" #bPossiblySwitch #bPendingSwitch );

    Instigator = Pawn(Owner);

    bPendingSwitch = bPossiblySwitch;

    if( Instigator == None )
    {
        //gLog( "ClientWeaponSet - PendingClientWeaponSet" #bPossiblySwitch #bPendingSwitch );
        GotoState('PendingClientWeaponSet');
        return;
    }

    for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
    {
        if( FireModeClass[Mode] != None )
        {
            // laurent -- added check for vehicles (ammo not replicated but unlimited)
            if( ( FireMode[Mode] == None ) || ( FireMode[Mode].AmmoClass != None ) && !bNoAmmoInstances && Ammo[Mode] == None && FireMode[Mode].AmmoPerFire > 0 )
            {
                GotoState('PendingClientWeaponSet');
                return;
            }
        }

        FireMode[Mode].Instigator = Instigator;
        FireMode[Mode].Level = Level;
    }

    ClientState = WS_Hidden;
    GotoState('Hidden');

    if( Level.NetMode == NM_DedicatedServer || !Instigator.IsHumanControlled() )
        return;

    if( Instigator.Weapon == self || Instigator.PendingWeapon == self ) // this weapon was switched to while waiting for replication, switch to it now
    {
        if( Instigator.PendingWeapon != None )
            Instigator.ChangedWeapon();
        else
            BringUp();
        return;
    }

    if( Instigator.PendingWeapon != None && Instigator.PendingWeapon.bForceSwitch )
        return;

    if( Instigator.Weapon == None )
    {
        Instigator.PendingWeapon = self;
        Instigator.ChangedWeapon();
    }
    else if( bPossiblySwitch && !Instigator.Weapon.IsFiring() )
    {
        if( PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).bNeverSwitchOnPickup )
            return;

        if( Instigator.PendingWeapon != None )
        {
            if( RateSelf() > Instigator.PendingWeapon.RateSelf() )
            {
                Instigator.PendingWeapon = self;
                Instigator.Weapon.PutDown();
            }
        }
        else if( RateSelf() > Instigator.Weapon.RateSelf() )
        {
            Instigator.PendingWeapon = self;
            Instigator.Weapon.PutDown();
        }
    }
}

simulated function DetachFromPawn(Pawn P)
{
    Super.DetachFromPawn(P);

    P.SoundVolume = P.default.SoundVolume;
    P.SoundRadius = P.default.SoundRadius;
    P.SoundPitch = P.default.SoundPitch;
}


simulated function bool CanSelect()
{
    return True;
}


function HolderDied()
{
    //gLog( "HolderDied" #WarrantyMode #bCanThrow );

    Super.HolderDied();

    DeadHolder = gPawn(Instigator);

    // don't drop if Warranty
    if(WarrantyMode != 0) {
        bCanThrow = False;
    }
}

simulated function Weapon WeaponChange(byte F, bool bSilent)
{
    return self;
}


// ============================================================================
//  Animation
// ============================================================================

simulated event AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if( ClientState == WS_ReadyToFire )
    {
        if( anim == FireMode[0].FireAnim && HasAnim(FireMode[0].FireEndAnim) ) // rocket hack
        {
            PlayAnim(FireMode[0].FireEndAnim, FireMode[0].FireEndAnimRate, 0.0);
        }
        else if( anim == FireMode[1].FireAnim && HasAnim(FireMode[1].FireEndAnim) )
        {
            PlayAnim(FireMode[1].FireEndAnim, FireMode[1].FireEndAnimRate, 0.0);
        }
        else if( (FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) )
        {
            PlayIdle();
        }
    }
}

simulated function PlayIdle()
{
    LoopAnim(IdleAnim, IdleAnimRate, IdleAnimTween);
}


// ============================================================================
//  Firing
// ============================================================================

simulated function bool StartFire(int Mode)
{
    if( !ReadyToFire(Mode) )
        return False;

    OnStartFire(Mode);

    return Super.StartFire(Mode);
}

simulated function OnStartFire(int Mode)
{
    //gLog( "OnStartFire" #Mode #WarrantyMode );

    if( Role == ROLE_Authority )
    {
        //WarrantyMode = WarrantyMode & ~class'gShopInfo'.default.WM_Fire;

        if( Instigator != None && gPawn(Instigator).IsShopping() )
            gPawn(Instigator).ShopInfo.End(Self, True);
    }
}


// ============================================================================
//  Ammo
// ============================================================================

function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
    local bool bJustSpawnedAmmo;
    local int addAmount, InitialAmount;

    //gLog( "GiveAmmo" #m #WP #bJustSpawned );

    if( FireMode[m] != None && FireMode[m].AmmoClass != None )
    {
        Ammo[m] = Ammunition(Instigator.FindInventoryType(FireMode[m].AmmoClass));
        bJustSpawnedAmmo = False;

        if( bNoAmmoInstances )
        {
            if( (FireMode[m].AmmoClass == None) || ((m != 0) && (FireMode[m].AmmoClass == FireMode[0].AmmoClass)) )
                return;

            InitialAmount = FireMode[m].AmmoClass.Default.InitialAmount;
            if( WP != None )
            {
                InitialAmount = WP.AmmoAmount[m];
            }

            if( Ammo[m] != None )
            {
                addamount = InitialAmount + Ammo[m].AmmoAmount;
                Ammo[m].Destroy();
            }
            else
                addAmount = InitialAmount;

            AddAmmo(addAmount,m);
        }
        else
        {
            if( (Ammo[m] == None) && (FireMode[m].AmmoClass != None) )
            {
                Ammo[m] = Spawn(FireMode[m].AmmoClass, Instigator);
                Instigator.AddInventory(Ammo[m]);
                bJustSpawnedAmmo = True;
            }
            else if( (m == 0) || (FireMode[m].AmmoClass != FireMode[0].AmmoClass) )
                bJustSpawnedAmmo = ( bJustSpawned || ((WP != None) && !WP.bWeaponStay) );

            if((WP != None) && ((WP.AmmoAmount[0] > 0) || (WP.AmmoAmount[1] > 0)) )
            {
                addAmount = WP.AmmoAmount[m];
            }
            else if( bJustSpawnedAmmo )
            {
                addAmount = Ammo[m].InitialAmount;
            }

            Ammo[m].AddAmmo(addAmount);
            Ammo[m].GotoState('');
        }
    }
}

simulated function OutOfAmmo()
{
    //if( !bSwitchIfNoAmmo )
        return;

    if( Instigator == None || !Instigator.IsLocallyControlled() || HasAmmo() )
        return;

    DoAutoSwitch();
}


// ============================================================================
//  Render
// ============================================================================

simulated event RenderOverlays(Canvas C)
{
    local int i;
    local vector NewScale3D;
    local rotator CenteredRotation;

    if( Instigator == None )
        return;

    if( Instigator.Controller != None )
        Hand = Instigator.Controller.Handedness;

    if( Hand < -1.0 || Hand > 1.0 )
        return;

    // draw muzzleflashes/smoke for all fire modes so idle state won't
    // cause emitters to just disappear
    for( i = 0; i != NUM_FIRE_MODES; ++i )
    {
        if( FireMode[i] != None )
            FireMode[i].DrawMuzzleFlash(C);
    }

    if( bForceViewUpdate || Hand != RenderedHand )
    {
        newScale3D = Default.DrawScale3D;

        if( Hand != 0 )
            newScale3D.Y *= Hand;

        SetDrawScale3D(newScale3D);
        SetDrawScale(Default.DrawScale);

        CenteredRoll = Default.CenteredRoll;
        CenteredYaw = Default.CenteredYaw;
        CenteredOffsetY = Default.CenteredOffsetY;

        PlayerViewPivot = Default.PlayerViewPivot;
        SmallViewOffset = Default.SmallViewOffset;

        if( SmallViewOffset == vect(0,0,0) )
            SmallViewOffset = Default.PlayerviewOffset;

        if( Default.SmallEffectOffset == vect(0,0,0) )
            SmallEffectOffset = EffectOffset + Default.PlayerViewOffset - SmallViewOffset;
        else
            SmallEffectOffset = Default.SmallEffectOffset;

        if( Hand == 0 )
        {
            PlayerViewPivot.Roll = Default.PlayerViewPivot.Roll;
            PlayerViewPivot.Yaw = Default.PlayerViewPivot.Yaw;
        }
        else
        {
            PlayerViewPivot.Roll = Default.PlayerViewPivot.Roll * Hand;
            PlayerViewPivot.Yaw = Default.PlayerViewPivot.Yaw * Hand;
        }

        RenderedHand = Hand;

        // Gunreal: Weapon Sway
        SwayDefaultPivot = PlayerViewPivot;
        bSwayReset = True;
    }

    if( class'PlayerController'.Default.bSmallWeapons )
        PlayerViewOffset = SmallViewOffset;
    else
        PlayerViewOffset = Default.PlayerViewOffset;

    if( Hand == 0 )
        PlayerViewOffset.Y = CenteredOffsetY;
    else
        PlayerViewOffset.Y *= Hand;

    // Weapon Sway
    switch( class'gWeapon'.default.SwayMode )
    {
        case 0: CalcWeaponSway(Instigator.GetViewRotation()); break;
        case 1: CalcWeaponDrag(Instigator.GetViewRotation()); break;
        case 2:
        default: break;
    }

    SetLocation(Instigator.Location + Instigator.CalcDrawOffset(Self));

    if( Hand == 0 )
    {
        CenteredRotation = Instigator.GetViewRotation();
        CenteredRotation.Yaw += CenteredYaw;
        CenteredRotation.Roll = CenteredRoll;
        SetRotation(CenteredRotation);
    }
    else
    {
        SetRotation(Instigator.GetViewRotation());
    }

    if( bSpecialDrawWeapon )
    {
        DrawWeapon(C);
    }
    else
    {
        bDrawingFirstPerson = True;
        C.DrawActor(Self, False, False, DisplayFOV);
        bDrawingFirstPerson = False;
    }

    if( gPlayer(Instigator.Controller) != None )
        gPlayer(Instigator.Controller).OnWeaponRendered(C);

    if( Hand == 0 )
        PlayerViewOffset.Y = 0;
}

simulated function DrawWeapon( Canvas C );


// ============================================================================
//  Weapon Sway
// ============================================================================

simulated function CalcWeaponDrag(rotator ViewRot)
{
    local float OldSwayMaxSpeedY, OldSwayMaxSpeedP;

    // If SpeedY is negative and SpeedP positive we get drag behaviour
    OldSwayMaxSpeedY = SwayMaxSpeedY;
    OldSwayMaxSpeedP = SwayMaxSpeedP;
    SwayMaxSpeedY = Abs(SwayMaxSpeedY) * -1.0;
    SwayMaxSpeedP = Abs(SwayMaxSpeedP);

    CalcWeaponSway(ViewRot);

    SwayMaxSpeedY = OldSwayMaxSpeedY;
    SwayMaxSpeedP = OldSwayMaxSpeedP;
}

simulated function CalcWeaponSway(rotator ViewRot)
{
    local float DT, DeltaRotY, SwayRotY, AlphaDeltaY, AlphaSwayY, AlphaCenterY, AlphaDelayY;
    local float SpeedDeltaY, SpeedSwayY, SpeedCenterY;
    local float DeltaRotP, SwayRotP, AlphaDeltaP, AlphaSwayP, AlphaCenterP, AlphaDelayP;
    local float SpeedDeltaP, SpeedSwayP, SpeedCenterP;
    local rotator DeltaRot, DispRot;

    if( bSwayReset )
    {
        SwayRot = rot(0,0,0);
        SwayLastTime = Level.TimeSeconds;
        bSwayReset = False;
        return;
    }

    // Time
    DT = Level.TimeSeconds - SwayLastTime;
    SwayLastTime = Level.TimeSeconds;

    // Rotation
    DeltaRot = ViewRot - SwayLastRot;
    SwayLastRot = ViewRot;


    // - BEGIN YAW -------------------------------------------------------------

    // Cache
    DeltaRotY = Normalize(DeltaRot).Yaw;
    SwayRotY = Normalize(SwayRot).Yaw;

    // View rotation speed in RU/s
    // How fast the view is being rotated, 1=high
    SpeedDeltaY = DeltaRotY / DT;
    AlphaDeltaY = FClamp( SpeedDeltaY / SwayMaxDeltaSpeedY, -1, 1 );

    // How far the gun is swayed, 1=far
    // Sway speed in RU/s
    AlphaSwayY = SwayRotY / SwayMaxRotY;
    SpeedSwayY = SwayMaxSpeedY * AlphaDeltaY;

    // How fast the gun should center
    AlphaCenterY = AlphaSwayY;

    // If the view is rotating
    if( Abs(DeltaRotY) > 0 )
    {
        // Center speed fade in
        SwayCenterDurationY = 0.25; //0.2 + 0.15 * FRand();
        SwayCenterTimeY = SwayCenterDurationY;

        // Center speed
        SpeedCenterY = SwayMaxCenterSpeedY * AlphaCenterY;
    }

    // If the view doesn't rotate
    else
    {
        // Center speed fade in
        AlphaDelayY = 1 - ( SwayCenterTimeY / SwayCenterDurationY );
        SwayCenterTimeY -= FMin( DT, SwayCenterTimeY );

        // Center speed
        SpeedCenterY = SwayMaxCenterSpeedY * AlphaCenterY * AlphaDelayY;
    }

    // Add rotation speed and center speed
    SwayRot.Yaw += (SpeedSwayY - SpeedCenterY) * DT;

    // - END YAW ---------------------------------------------------------------

    // - BEGIN PITCH -----------------------------------------------------------

    // Cache
    DeltaRotP = Normalize(DeltaRot).Pitch;
    SwayRotP = Normalize(SwayRot).Pitch;

    // View rotation speed in RU/s
    // How fast the view is being rotated, 1=high
    SpeedDeltaP = DeltaRotP / DT;
    AlphaDeltaP = FClamp( SpeedDeltaP / SwayMaxDeltaSpeedP, -1, 1 );

    // How far the gun is swayed, 1=far
    // Sway speed in RU/s
    AlphaSwayP = SwayRotP / SwayMaxRotP;
    SpeedSwayP = SwayMaxSpeedP * AlphaDeltaP;

    // How fast the gun should center
    AlphaCenterP = AlphaSwayP;

    // If the view is rotating
    if( Abs(DeltaRotP) > 0 )
    {
        // Center speed fade in
        SwayCenterDurationP = 0.25; //0.2 + 0.15 * FRand();
        SwayCenterTimeP = SwayCenterDurationP;

        // Center speed
        SpeedCenterP = SwayMaxCenterSpeedP * AlphaCenterP;
    }

    // If the view doesn't rotate
    else
    {
        // Center speed fade in
        AlphaDelayP = 1 - ( SwayCenterTimeP / SwayCenterDurationP );
        SwayCenterTimeP -= FMin( DT, SwayCenterTimeP );

        // Center speed
        SpeedCenterP = SwayMaxCenterSpeedP * AlphaCenterP * AlphaDelayP;
    }

    // Add rotation speed and center speed
    SwayRot.Pitch += (SpeedSwayP - SpeedCenterP) * DT;

    // - END PITCH -------------------------------------------------------------

    // Keep sway normalized
    SwayRot = Normalize(SwayRot);

    // Weapon Pivot
    PlayerViewPivot = SwayDefaultPivot + SwayRot;

    // Weapon Offset
    DispRot.Pitch = (float(SwayRot.Pitch) * SwayDisplacementP);
    DispRot.Yaw = (float(SwayRot.Yaw) * SwayDisplacementY);
    PlayerViewOffset = PlayerViewOffset >> DispRot;

//    gLog( "CV"
//        #byte(Weapon.bInitOldMesh)
//        #DT
//        #Weapon.PlayerViewOffset
//        #Weapon.PlayerViewPivot
//    );

//    if( DeltaRotP != 0 )
//    {
//        gLog(
//            SwayRot.Pitch
//        @   DeltaRot.Pitch
//        @   ViewRot.Pitch
//        @   AlphaDeltaP
//        @   AlphaSwayP
//        @   AlphaCenterP
//        @   SpeedDeltaP
//        @   DeltaRotP
//        );
//    }
}


// ============================================================================
//  AI
// ============================================================================

function Actor GetBotTarget()
{
    local Bot B;
    local Actor Target;

    B = Bot(Instigator.Controller);

    if( B != None )
    {
        Target = B.Enemy;

        if( Target == None )
            Target = B.Target;
    }

    return Target;
}


// ============================================================================
//  Shop
// ============================================================================

static final function bool IsGunrealWeapon( class<Inventory> WC )
{
    if( class<Weapon>(WC) != None )
    {
        if(class<gWeapon>(WC) != None
        ||  WC.name == 'gTransLauncher')
            return True;
    }
    return False;
}

function Sold()
{
    local int i;

    //gLog( "Sold" #WarrantyMode );

    WarrantyMode = 0;

    ClientWeaponThrown();

    for( i = 0; i != NUM_FIRE_MODES; ++i )
    {
        if( FireMode[i].bIsFiring )
            StopFire(i);
    }

    if( Instigator != None )
        DetachFromPawn(Instigator);

    Destroy();
}

static final function class<Ammunition> StaticGetAmmoClass(int mode)
{
    if( default.FireModeClass[mode] != None )
        return default.FireModeClass[mode].default.AmmoClass;
    return None;
}

final function int LimitNewAmmo( int NewAmount )
{
    local int MaxAmount;

    if( AmmoClass[0] != None )
        MaxAmount = AmmoClass[0].default.MaxAmmo;

//    if( AmmoClass[1] != None )
//        MaxAmount = Max(MaxAmount, AmmoClass[1].default.MaxAmmo);

    return Min(NewAmount, Max(0, MaxAmount-AmmoAmount(0)));
    //return Min(NewAmount, Max(0, MaxAmount-Min(AmmoAmount(0), AmmoAmount(1))));
}

static final function int StaticLimitNewAmmo( int NewAmount, int CurrentAmount )
{
    local int MaxAmount;
    local class<Ammunition> AC[2];

    AC[0] = StaticGetAmmoClass(0);
    if( AC[0] != None )
        MaxAmount = AC[0].default.MaxAmmo;

//    AC[1] = StaticGetAmmoClass(1);
//    if( AC[1] != None )
//        MaxAmount = Max(MaxAmount, AC[1].default.MaxAmmo);

    return Min(NewAmount, Max(0, MaxAmount-CurrentAmount));
}


// ============================================================================
//  Effects
// ============================================================================

simulated function IncrementFlashCount(int Mode)
{
    if( gWeaponAttachment(ThirdPersonActor) != None )
        gWeaponAttachment(ThirdPersonActor).FlashCountIncrement(Mode);
}

simulated function ZeroFlashCount(int Mode)
{
    if( gWeaponAttachment(ThirdPersonActor) != None )
        gWeaponAttachment(ThirdPersonActor).FlashCountZero(Mode);
}


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
//  Debug
// ============================================================================
exec function EditGun()
{
    ConsoleCommand( "editobj" @name );
}

exec function EditGunD()
{
    ConsoleCommand( "editdefault class=" $class.name );
}

exec function HitCoords()
{
    if( gTracingAttachment(ThirdPersonActor) != None )
    {
        if( gTracingAttachment(ThirdPersonActor).HitGroupClass != class'gEffects.gHitGroupCoords' )
            gTracingAttachment(ThirdPersonActor).HitGroupClass = class'gEffects.gHitGroupCoords';
        else
            gTracingAttachment(ThirdPersonActor).HitGroupClass = gTracingAttachment(ThirdPersonActor).default.HitGroupClass;
    }
}

exec function EditAttachment()
{
    if( ThirdPersonActor != None )
        ConsoleCommand("editobj" @ThirdPersonActor.Name);
}

exec function EditFire(byte Mode)
{
    ConsoleCommand("editobj" @FireMode[Mode].Name);
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
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    //gWeapon
    ItemSize                        = 1
    CostWeapon                      = 750
    CostAmmo                        = 200
    WarrantyPercent                 = 0.3
    WarrantyDamage                  = 200
    BotPurchaseProbMod              = 1
    AmmoShopping                    = (1,0)

    bSpecialDrawWeapon              = False
    IdleAnimTween                   = 0.2
    SelectSoundVolume               = 0.7
    BarFullSteady                   = 0.999999

    HUDAmmoWidth                    = 140
    HUDAmmoHeight                   = 45

    IconFlashMaterial               = Material'G_FX.Interface.fb_iconsheet0_pulse'

    SwayMode                        = 0
    SwayMaxRotY                     = 2048
    SwayMaxSpeedY                   = 13500
    SwayMaxCenterSpeedY             = 12000
    SwayMaxDeltaSpeedY              = 65535
    SwayDisplacementY               = 0.67
    SwayMaxRotP                     = 1024
    SwayMaxSpeedP                   = 8192
    SwayMaxCenterSpeedP             = 10000
    SwayMaxDeltaSpeedP              = 65535
    SwayDisplacementP               = -2



    // Weapon
    FireModeClass(0)                = None
    FireModeClass(1)                = None
    PickupClass                     = None
    AttachmentClass                 = class'WeaponAttachment'

    IdleAnim                        = "Idle"
    RestAnim                        = ""
    AimAnim                         = ""
    RunAnim                         = ""
    SelectAnim                      = "Select"
    PutDownAnim                     = "Down"

    IdleAnimRate                    = 1.0
    RestAnimRate                    = 1.0
    AimAnimRate                     = 1.0
    RunAnimRate                     = 1.0
    SelectAnimRate                  = 1.0
    PutDownAnimRate                 = 1.0

    PutDownTime                     = 0.33
    BringUpTime                     = 0.33

    SelectSound                     = None

    AIRating                        = 1.0
    CurrentRating                   = 1.0

    bMeleeWeapon                    = False
    bSniping                        = False
    bShowChargingBar                = False
    bCanThrow                       = True
    bForceSwitch                    = False
    bNoVoluntarySwitch              = False
    bDebugging                      = False
    bNoInstagibReplace              = False
    bNoAmmoInstances                = True

    ItemName                        = ""
    Description                     = ""
    MessageNoAmmo                   = " has no ammo"

    DisplayFOV                      = 90
    PlayerViewOffset                = (X=0.0,Y=0.0,Z=0.0)
    PlayerViewPivot                 = (Pitch=0,Yaw=32768,Roll=0)
    SmallViewOffset                 = (X=0.0,Y=0.0,Z=0.0)
    SmallEffectOffset               = (X=0.0,Y=0.0,Z=0.0)
    EffectOffset                    = (X=0.0,Y=0.0,Z=0.0)
    CenteredOffsetY                 = 0
    CenteredRoll                    = 0
    CenteredYaw                     = 0
    BobDamping                      = 0.5

    Priority                        = 255
    InventoryGroup                  = 255
    GroupOffset                     = 0
    Charge                          = 0
    MinReloadPct                    = 0.5

    CustomCrosshair                 = -1
    CustomCrossHairColor            = (R=255,G=255,B=255,A=255)
    CustomCrossHairScale            = 0.8
    CustomCrossHairTextureName      = "G_FX.crosshair_a5"

    HudColor                        = (R=255,G=255,B=255,A=255)
    IconMaterial                    = Material'G_FX.Interface.IconSheet0'
    IconCoords                      = (X1=0,Y1=0,X2=0,Y2=0)


    // Actor
    DrawScale                       = 1.0
    DrawType                        = DT_Mesh
    Style                           = STY_Normal
    Mesh                            = None
    HighDetailOverlay               = None

    bDynamicLight                   = False
    LightType                       = LT_Steady
    LightEffect                     = LE_NonIncidence
    LightPeriod                     = 0
    LightBrightness                 = 0
    LightHue                        = 0
    LightSaturation                 = 0
    LightRadius                     = 0

    MaxLights                       = 6
    ScaleGlow                       = 1.5
    AmbientGlow                     = 0

    SoundVolume                     = 255
    SoundRadius                     = 64
    SoundPitch                      = 64

    TransientSoundVolume            = 0.3
    TransientSoundRadius            = 300.0
}