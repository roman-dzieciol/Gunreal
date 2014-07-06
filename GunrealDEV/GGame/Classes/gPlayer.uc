// ============================================================================
//  gPlayer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlayer extends xPlayer;


// - Movement -----------------------------------------------------------------

var() protected gPlayerInput            GunrealInput;
var() protected gCheatManager           GunrealCheats;

var             bool                    bSprintJump;
var             byte                    bWantsToRun;
var             byte                    bWantsToDuck;
var             bool                    bKeepRunning;
var             bool                    bDodgeRun;
var             bool                    bWaitForStamina;
var             byte                    bRunOld;


// - Camera -------------------------------------------------------------------

var()           float                   ZoomSpeed;

var() config    float                   TPCamDistance;
var()           vector                  TPCamLookat; // Look at location in vehicle space
var()           vector                  TPCamWorldOffset; // Applied in world space after vehicle transform.

// - Debug --------------------------------------------------------------------

var             int                     SlowIterations;
var             bool                    bRestoreWeaponBar;

// - Shop ---------------------------------------------------------------------

// OPTIMIZE: Turn Glove and Weapons indexes into manifest items
// OPTIMIZE: Pack everything into bitfield
// OPTIMIZE: Replicate manifest list instead of manifest contents
// OPTIMIZE: Do not send manifest everytime?
// OPTIMIZE: Move replication to own class? gGPRI?

struct sShopLoadout
{
    var() class<gWeapon> Weapons[3];
    var() int Ammo[3];
    var() byte Warranty[3];
    var() gMutator.EBonusMode BonusMode;
    var() gMutator.EBonusMode PendingBonusMode;
    var() class<Weapon> Glove;
    var() int GloveAmmo;
    var() class<gShopManifest> Manifest;
    var() int ID;
};

var             gPRI                    CachedGPRI;
var             gShopInfo               ShopInfo;
var             gTimer                  ShopTimer;
//var             class<gShopManifest>    ShopManifest;
var             bool                    bReceivingShopData;

var             sShopLoadout            ServerLoadout;
var             sShopLoadout            ServerLastLoadout;
var             sShopLoadout            OpenedServerLoadout;

var()           string                  ShopMenu;
var()           float                   ShopTimerRate;
var()           float                   ShopAutoDelay;          // delay opening shop menu when killed, so player can see his death
var()           float                   ShopClientDelay;        // make client wait a bit before proceeding to open the menu, so ie change to dead state is replicated
var()           bool                    bShopBeforeRespawn;     // don't let client spawn nor open midgame menu until shop menu was used



// ----------------------------------------------------------------------------


var config      bool                    bHitSounds;
var config      bool                    bShowMineOwner;
var config      bool                    bAdrenalineTracks;

var             Sound                   AdrenalineReady;

var()           bool                    bForceDramaticLighting;
var()           float                   ForceDramaticLighting;

var()           float                   FOVAdjustSpeed;

var()           gWorldOverlay           AmbientOverlay;
var()           gWorldOverlay           FlashOverlay;

var             bool                    bGunrealShake;
var             gShakeView              GunrealShakeModel;

// rank sounds (eww)

var             int                     MyPreviousRanking;

var globalconfig bool                   bGunrealCrosshair;

var() gPlayerHUD PlayerHUD;

var   float                     DingDamageTime;
var() Sound                     DingVehicle;
var() Sound                     DingHeadshot;
var() Sound                     DingPlayer;

var() Sound                     DingHeadshotDeath;
var() Sound                     DingPlayerDeath;
var   bool                      bUseShopping;

var   config bool               bDebugGunreal;

var   gTurret                   Turret;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    class'gPlayerHUD'.static.PrecacheScan(S);
}

// ============================================================================
//  Replication
// ============================================================================
replication
{
    // Functions server can call.
    reliable if( Role == ROLE_Authority )
        ToggleZoomWithParams, ContinueZoomWithParams
        , ClientCloseShopMenu;

    // Functions server can call.
    unreliable if( Role == ROLE_Authority )
        ClientDamageTypeShake
      , ClientFlashOverlay, ClientAmbientOverlay, ClientFadeAmbientOverlay;

    // Functions client can call.
    reliable if( Role < ROLE_Authority )
        ServerShopMenuCancelled, ServerShopBuyLoadout, ServerSetHitSounds;

    // Variables server should replicate
    reliable if( bNetOwner && bNetDirty && Role == ROLE_Authority )
        /*ShopManifest,*/ ServerLoadout, bUseShopping;
}


event PostNetReceive()
{
    // TODO: prevent midgame menu from auto-opening until shop menu is closed

    if( bReceivingShopData )
    {
        // clients delay opening shop menu untill all relevant data is received
        if( /*ShopManifest != None &&*/ ServerLoadout != ServerLastLoadout && GetGPRI() != None )
        {
            ServerLastLoadout = ServerLoadout;
            bReceivingShopData = False;
            ReceivedShopData();
            ReceivedServerLoadout();
        }
    }
    else
    {
        if( ServerLoadout != ServerLastLoadout )
        {
            ShopClientDelay = Level.TimeSeconds + default.ShopClientDelay;
            ServerLastLoadout = ServerLoadout;
            ReceivedServerLoadout();
        }
    }

    Super.PostNetReceive();
}

function bool NeedNetNotify()
{
    return Super.NeedNetNotify()
        || bReceivingShopData
        || True;
}


// ============================================================================
//  Lifespan
// ============================================================================


function LogMultiKills(float Reward, bool bEnemyKill)
{
    local int BoundedLevel;

    if( bEnemyKill && (Level.TimeSeconds - LastKillTime < 4) )
    {
        AwardAdrenaline( Reward );
        if( TeamPlayerReplicationInfo(PlayerReplicationInfo) != None )
        {
            BoundedLevel = Min(MultiKillLevel,6);
            TeamPlayerReplicationInfo(PlayerReplicationInfo).MultiKills[BoundedLevel] += 1;
            if( (MultiKillLevel > 0) && (TeamPlayerReplicationInfo(PlayerReplicationInfo).MultiKills[BoundedLevel-1] > 0) )
                TeamPlayerReplicationInfo(PlayerReplicationInfo).MultiKills[BoundedLevel-1] -= 1;
        }
        MultiKillLevel++;
        UnrealMPGameInfo(Level.Game).SpecialEvent(PlayerReplicationInfo,"multikill_"$MultiKillLevel);

        // Multikill Reward
        class'gMoneyRewards'.static.MultiKillReward(self, MultiKillLevel);
    }
    else
        MultiKillLevel=0;

    if( bEnemyKill )
        LastKillTime = Level.TimeSeconds;
}

simulated event PreBeginPlay()
{
    Super.PreBeginPlay();
    if( bDeleteMe )
        return;

    if( InstagibCTF(Level.Game) == None )
    {
        bUseShopping = True;
        if( ShopInfo == None && Role == ROLE_Authority )
            ShopInfo = new(self) class'gShopInfoPlayer';
    }
}

simulated event PostBeginPlay()
{
    if( PlayerHUD == None )
        PlayerHUD = new(self) class'gPlayerHUD';

    if( !bGunrealCrosshair )
    {
        PlayerHUD.SetupGunrealCrosshair();
    }

    Super.PostBeginPlay();

    ShopTimer = Spawn(class'gTimer');
    ShopTimer.OnTimer = ShopWaitingForPlayer;

    GunrealShakeModel = new class'gShakeView';
}

function Reset()
{
    //gLog( "Reset");
    if( ShopInfo != None )
        ShopInfo.PawnReset(Pawn);
    Super.Reset();
}

simulated event FinishedInterpolation()
{
    //gLog( "FinishedInterpolation");
    Super.FinishedInterpolation();

    // cancel all shopping
    if( ShopInfo != None && Role == ROLE_Authority )
        ShopInfo.End(Self,True);
}

simulated function StartInterpolation()
{
    //gLog( "StartInterpolation");
    Super.StartInterpolation();

    // begin shopping
    if( ShopInfo != None && Role == ROLE_Authority )
        ShopInfo.Begin(Self);
}

event InitInputSystem()
{
    Super.InitInputSystem();

    InitInteractions();
}

function InitPlayerReplicationInfo()
{
    Super.InitPlayerReplicationInfo();
}

function InitInteractions()
{
    local ZoneInfo Z;

    if( class'gPlayer'.default.bDebugGunreal )
    {
        Player.InteractionMaster.AddInteraction("GDebug.gVarGraph", Player);
        //Player.InteractionMaster.AddInteraction("GDebug.gKeyWatch", Player);
        //Player.InteractionMaster.AddInteraction("GDebug.gDynObjList", Player);
    }

    if( bForceDramaticLighting )
    {
        foreach AllActors(class'ZoneInfo',Z)
        {
            Z.AmbientBrightness = 0;
            Z.AmbientHue = 0;
            Z.AmbientSaturation = 0;
            Z.AmbientVector = vect(0,0,0);
            Z.DramaticLightingScale = ForceDramaticLighting;
        }
    }

    if( Viewport(Player) != None )
    {
        AmbientOverlay = new class'gWorldOverlay';
        AmbientOverlay.Init(self);

        FlashOverlay = new class'gWorldOverlay';
        FlashOverlay.Init(self);
    }
}

event PlayerTick(float DeltaTime)
{
    // Kill framerate
    if( SlowIterations > 0 )
        KillFrameRate();

    TickOverlays(DeltaTime);

    Super.PlayerTick(DeltaTime);
}


function DoCombo( class<Combo> ComboClass );

function ServerChangeTeam( int NewTeam )
{
    local int OldTeam;
    local gProjectile P;

    OldTeam = GetTeamNum();
    if( OldTeam != NewTeam )
    {
        foreach DynamicActors(class'gProjectile', P)
        {
            if( P.InstigatorController == self )
            {
                P.NotifyControllerTeamChange(OldTeam, NewTeam);
            }
        }

        if( Turret != None )
            Turret.TakeDamage(Turret.Health * 10, Turret, Turret.Location, vect(0,0,1), class'Suicided');
    }

    Super.ServerChangeTeam(NewTeam);
}

simulated event Destroyed()
{
    local gProjectile P;

    if( PlayerHUD != None )
        PlayerHUD.Free();

    PlayerHUD = None;

    //gLog( "Destroyed" );

    foreach DynamicActors(class'gProjectile', P)
    {
        if( P.InstigatorController == self )
        {
            P.NotifyControllerDestroyed();
        }
    }

    if( ShopInfo != None )
        ShopInfo.Free();

    ShopInfo = None;

    GunrealInput = None;
    GunrealCheats = None;
    GunrealShakeModel = None;

    if( FlashOverlay != None )
        FlashOverlay.Free(self);
    FlashOverlay = None;

    if( AmbientOverlay != None )
        AmbientOverlay.Free(self);
    AmbientOverlay = None;

    if( ShopTimer != None )
        ShopTimer.Destroy();
    ShopTimer = None;

    Super.Destroyed();
}

function AwardAdrenaline(float Amount)
{
    local float Atten;

    if( bAdrenalineEnabled )
    {
        if( Adrenaline < AdrenalineMax && (Adrenaline + Amount >= AdrenalineMax) && (Pawn == None || !Pawn.InCurrentCombo()) )
        {
            Atten = 2.0 * FClamp(0.1 + float(AnnouncerVolume) * 0.225, 0.2, 1.0);
            ClientPlaySound(AdrenalineReady, True, Atten, SLOT_Talk);
        }

        Super(Controller).AwardAdrenaline(Amount);
    }
}

final simulated function PlayDamageDing(Pawn Injured, class<DamageType> DamageType)
{
    if( DingDamageTime != Level.TimeSeconds )
    {
        // vehicle hit
        if( Vehicle(Injured) != None )
        {
            //log("vehicle hit");
            ClientPlaySound(DingVehicle,,,SLOT_None);
            DingDamageTime = Level.TimeSeconds;
        }

        // infantry headshot
        // cant get headshots on vehicles, only the pawn inside
        else if( class<gDamTypeWeapon>(DamageType) != None && class<gDamTypeWeapon>(DamageType).default.bIsHeadShot )
        {
            //log("headshot");
            ClientPlaySound(DingHeadshot,,,SLOT_None);
            DingDamageTime = Level.TimeSeconds;
        }

        // infantry hit
        // cant hit infantry when in vehicle
        else if( Injured.DrivenVehicle == None )
        {
            //log("hit");
            ClientPlaySound(DingPlayer,,,SLOT_None);
            DingDamageTime = Level.TimeSeconds;
        }
    }
}

final simulated function PlayKillDing(Pawn Injured, class<DamageType> DamageType)
{
    if( class<gDamTypeWeapon>(DamageType) != None && class<gDamTypeWeapon>(DamageType).default.bIsHeadShot )
    {
        //log("headshot death");
        ClientPlaySound(DingHeadshotDeath,,,SLOT_None);
    }
    else
    {
        //log("death");
        ClientPlaySound(DingPlayerDeath,,,SLOT_None);
    }
}

final function ServerSetHitSounds(bool bSet)
{
    bHitSounds = bSet;
}


// ============================================================================
//  Zoom
// ============================================================================
function ToggleZoomWithParams(float MaxLevel, float Speed, float MinLevel)
{
    //gLog( "ToggleZoomWithParams" #bZooming #MaxLevel #Speed #MinLevel #ZoomLevel #DesiredZoomLevel );

    if( !bZooming )
    {
        MyHUD.FadeZoom();
        DesiredZoomLevel = MaxLevel;
        ZoomLevel = MinLevel;
        ZoomSpeed = Speed;
        bZooming = True;
    }
    else
    {
        EndZoom();
    }
}

// For adjusting the zoom level with the prev/next weapon buttons
// Called from Weapon.CanAdjustZoom(float Dir)
function ContinueZoomWithParams(float MaxLevel, float Speed)
{
    //gLog( "ContinueZoomWithParams" #bZooming #MaxLevel #Speed #ZoomLevel #DesiredZoomLevel );

    ZoomSpeed = Speed;
    DesiredZoomLevel = MaxLevel;
    bZooming = True;
}

function StopZoom()
{
    //gLog( "StopZoom" #bZooming #ZoomLevel #DesiredZoomLevel );

    DesiredZoomLevel = ZoomLevel;
    ZoomSpeed = default.ZoomSpeed;
}

function EndZoom()
{
    //gLog( "EndZoom" #bZooming #ZoomLevel #DesiredZoomLevel );

    if( bZooming )
        myHUD.FadeZoom();

    bZooming = False;
    DesiredFOV = DefaultFOV;
    FOVAngle = DefaultFOV;
    ZoomSpeed = default.ZoomSpeed;
}

function AdjustView(float DeltaTime)
{
    local float Alpha;

    // teleporters affect your FOV, so adjust it back down
    if( FOVAngle != DesiredFOV )
    {
        if( FOVAngle > DesiredFOV )
        {
            Alpha = 1.0+FClamp((FOVAngle - DesiredFOV)/90.0, 0, 1)**4;
            FOVAngle = FMax(FOVAngle-FOVAdjustSpeed*DeltaTime*Alpha, DesiredFOV);
        }
        else
        {
            Alpha = 1.0+FClamp((DesiredFOV - FOVAngle)/90.0, 0, 1)**4;
            FOVAngle = FMin(FOVAngle+FOVAdjustSpeed*DeltaTime*Alpha, DesiredFOV);
        }
    }

    // adjust FOV for weapon zooming
    if( bZooming )
    {
        if( ZoomLevel != DesiredZoomLevel )
        {
            if( ZoomLevel > DesiredZoomLevel )
            {
                ZoomLevel = FMax(ZoomLevel - (1.0-ZoomLevel)*DeltaTime*ZoomSpeed, DesiredZoomLevel);
            }
            else
            {
                ZoomLevel = FMin(ZoomLevel + (1.0-ZoomLevel)*DeltaTime*ZoomSpeed, DesiredZoomLevel);
            }
        }

        FOVAngle = FClamp(90.0 - (ZoomLevel * 88.0), 1, 170);
        DesiredFOV = FOVAngle;

        //gLog( "AdjustView" #FOVAngle #ZoomLevel #DesiredZoomLevel);
    }
}

// ============================================================================
//  Weapon
// ============================================================================
function ServerThrowWeapon()
{
    gPawn(Pawn).PawnInventory.ThrowWeapon();
}

exec function SwitchToBestWeapon()
{
    //gLog( "SwitchToBestWeapon" #Pawn.Weapon #Pawn.PendingWeapon );
    Super.SwitchToBestWeapon();
}

// ============================================================================
//  Thirdperson View
// ============================================================================

event PlayerCalcView(out actor ViewActor, out vector CameraLocation, out rotator CameraRotation )
{
    local Pawn PTarget;

    //Log( "PlayerCalcView" #GON(ViewActor) #CameraLocation #CameraRotation #GON(ViewTarget) );

    // If desired, call the pawn's own special callview
    if( Pawn != None && bBehindView && ViewTarget == Pawn && Vehicle(Pawn) == None )
    {
        // try the 'special' calcview. This may return False if its not applicable, and we do the usual.
        CalcThirdpersonView(ViewActor, CameraLocation, CameraRotation);
        CacheCalcView(ViewActor, CameraLocation, CameraRotation);

        return;
    }

    if( LastPlayerCalcView == Level.TimeSeconds && CalcViewActor != None && CalcViewActor.Location == CalcViewActorLocation )
    {
        ViewActor   = CalcViewActor;
        CameraLocation  = CalcViewLocation;
        CameraRotation  = CalcViewRotation;
        return;
    }

    // If desired, call the pawn's own special callview
    if( Pawn != None && Pawn.bSpecialCalcView && (ViewTarget == Pawn) )
    {
        // try the 'special' calcview. This may return False if its not applicable, and we do the usual.
        if( Pawn.SpecialCalcView(ViewActor, CameraLocation, CameraRotation) )
        {
            CacheCalcView(ViewActor,CameraLocation,CameraRotation);
            return;
        }
    }

    if( (ViewTarget == None) || ViewTarget.bDeleteMe )
    {
        if( bViewBot && (GunrealCheats != None) )
            GunrealCheats.ViewBot();
        else if( (Pawn != None) && !Pawn.bDeleteMe )
            SetViewTarget(Pawn);
        else if( RealViewTarget != None )
            SetViewTarget(RealViewTarget);
        else
            SetViewTarget(self);
    }

    ViewActor = ViewTarget;
    CameraLocation = ViewTarget.Location;

    if( ViewTarget == Pawn )
    {
        if( bBehindView ) //up and behind
            CalcBehindView(CameraLocation, CameraRotation, CameraDist * Pawn.Default.CollisionRadius);
        else
            CalcFirstPersonView( CameraLocation, CameraRotation );

        CacheCalcView(ViewActor,CameraLocation,CameraRotation);
        return;
    }
    if( ViewTarget == self )
    {
        if( bCameraPositionLocked )
            CameraRotation = GunrealCheats.LockedRotation;
        else
            CameraRotation = Rotation;

        CacheCalcView(ViewActor,CameraLocation,CameraRotation);
        return;
    }

    if( ViewTarget.IsA('Projectile') )
    {
        if( Projectile(ViewTarget).bSpecialCalcView && Projectile(ViewTarget).SpecialCalcView(ViewActor, CameraLocation, CameraRotation, bBehindView) )
        {
            CacheCalcView(ViewActor,CameraLocation,CameraRotation);
            return;
        }

        if( !bBehindView )
        {
            CameraLocation += (ViewTarget.CollisionHeight) * vect(0,0,1);
            CameraRotation = Rotation;

            CacheCalcView(ViewActor,CameraLocation,CameraRotation);
            return;
        }
    }


    CameraRotation = ViewTarget.Rotation;
    PTarget = Pawn(ViewTarget);
    if( PTarget != None )
    {
        // hack: force eyeheight update for whatever pawn you're looking at
        PTarget.bUpdateEyeHeight = True;

        if( (Level.NetMode == NM_Client) || (bDemoOwner && (Level.NetMode != NM_Standalone)) )
        {
            PTarget.SetViewRotation(TargetViewRotation);
            CameraRotation = BlendedTargetViewRotation;

            PTarget.EyeHeight = TargetEyeHeight;
        }
        else if( PTarget.IsPlayerPawn() )
            CameraRotation = PTarget.GetViewRotation();

        if( PTarget.bSpecialCalcView && PTarget.SpectatorSpecialCalcView(self, ViewActor, CameraLocation, CameraRotation) )
        {
            CacheCalcView(ViewActor, CameraLocation, CameraRotation);
            return;
        }

        if( !bBehindView )
            CameraLocation += PTarget.EyePosition();
    }
    if( bBehindView )
    {
        CameraLocation = CameraLocation + (ViewTarget.Default.CollisionHeight - ViewTarget.CollisionHeight) * vect(0,0,1);
        CalcBehindView(CameraLocation, CameraRotation, CameraDist * ViewTarget.Default.CollisionRadius);
    }

    CacheCalcView(ViewActor,CameraLocation,CameraRotation);
}

simulated function CalcThirdpersonView(out Actor ViewActor, out vector CameraLocation, out rotator CameraRotation)
{
    local vector CamLookAt, HitLocation, HitNormal, OffsetVector;
    local Actor HitActor;
    //local vector x, y, z;

    ViewActor = Self;
    CamLookAt = Pawn.Location + Pawn.EyePosition() + (TPCamLookat >> Rotation) + TPCamWorldOffset;

    OffsetVector = vect(0, 0, 0);
    OffsetVector.X = -1.0 * TPCamDistance;

    CameraLocation = CamLookAt + (OffsetVector >> Rotation);

    HitActor = Trace(HitLocation, HitNormal, CameraLocation, CamLookAt, True, vect(40, 40, 40));

    if( HitActor != None && (HitActor.bWorldGeometry || HitActor == Pawn || Trace(HitLocation, HitNormal, CameraLocation, CamLookAt, False, vect(40, 40, 40)) != None) )
        CameraLocation = HitLocation;

    //CameraRotation = Normalize(Rotation + ShakeRot);
    CameraRotation = Rotation;

    //GetAxes(Rotation, x, y, z);
    //CameraLocation = CameraLocation + ShakeOffset.X * x + ShakeOffset.Y * y + ShakeOffset.Z * z;
}

function rotator GetViewRotation()
{
    return Rotation;
}

function rotator AdjustAim(FireProperties FiredAmmunition, vector projStart, int aimerror)
{
    local vector FireDir, AimSpot, HitNormal, HitLocation, OldAim, AimOffset;
    local Actor BestTarget;
    local float bestAim, bestDist, projspeed;
    local Actor HitActor;
    local bool bNoZAdjust, bLeading;
    local rotator AimRot;

    FireDir = vector(Rotation);

    if( FiredAmmunition.bInstantHit )
        HitActor = Trace(HitLocation, HitNormal, projStart + 10000 * FireDir, projStart, True);
    else
        HitActor = Trace(HitLocation, HitNormal, projStart + 4000 * FireDir, projStart, True);

    if( HitActor != None && HitActor.bProjTarget )
    {
        BestTarget = HitActor;
        bNoZAdjust = True;
        OldAim = HitLocation;
        BestDist = VSize(BestTarget.Location - Pawn.Location);
    }
    else
    {
        // adjust aim based on FOV
        bestAim = 0.90;

        if( Level.NetMode == NM_Standalone && bAimingHelp )
        {
            bestAim = 0.93;

            if( FiredAmmunition.bInstantHit )
                bestAim = 0.97;

            if( FOVAngle < DefaultFOV - 8 )
                bestAim = 0.99;
        }
        else if( FiredAmmunition.bInstantHit )
        {
            bestAim = 1.0;
        }

        BestTarget = PickTarget(bestAim, bestDist, FireDir, projStart, FiredAmmunition.MaxRange);

        if( BestTarget == None )
            return Rotation;

        OldAim = projStart + FireDir * bestDist;
    }

    InstantWarnTarget(BestTarget,FiredAmmunition,FireDir);
    ShotTarget = Pawn(BestTarget);

    if( !bAimingHelp || Level.NetMode != NM_Standalone )
        return Rotation;

    // aim at target - help with leading also
    if( !FiredAmmunition.bInstantHit )
    {
        projspeed = FiredAmmunition.ProjectileClass.default.speed;
        BestDist = vsize(BestTarget.Location + BestTarget.Velocity * FMin(1, 0.02 + BestDist/projSpeed) - projStart);
        bLeading = True;
        FireDir = BestTarget.Location + BestTarget.Velocity * FMin(1, 0.02 + BestDist/projSpeed) - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
        // if splash damage weapon, try aiming at feet - trace down to find floor

        if( FiredAmmunition.bTrySplash && (BestTarget.Velocity != vect(0,0,0) || BestDist > 1500) )
        {
            HitActor = Trace(HitLocation, HitNormal, AimSpot - BestTarget.CollisionHeight * vect(0,0,2), AimSpot, False);
            if( HitActor != None && FastTrace(HitLocation + vect(0,0,4), projstart) )
                return rotator(HitLocation + vect(0,0,6) - projStart);
        }
    }
    else
    {
        FireDir = BestTarget.Location - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
    }

    AimOffset = AimSpot - OldAim;

    // adjust Z of shooter if necessary
    if( bNoZAdjust || (bLeading && (Abs(AimOffset.Z) < BestTarget.CollisionHeight)) )
        AimSpot.Z = OldAim.Z;
    else if( AimOffset.Z < 0 )
        AimSpot.Z = BestTarget.Location.Z + 0.4 * BestTarget.CollisionHeight;
    else
        AimSpot.Z = BestTarget.Location.Z - 0.7 * BestTarget.CollisionHeight;

    if( !bLeading )
    {
        // if not leading, add slight random error ( significant at long distances )
        if( !bNoZAdjust )
        {
            AimRot = rotator(AimSpot - projStart);

            if( FOVAngle < DefaultFOV - 8 )
                AimRot.Yaw = AimRot.Yaw + 200 - Rand(400);
            else
                AimRot.Yaw = AimRot.Yaw + 375 - Rand(750);
            return AimRot;
        }
    }
    else if( !FastTrace(projStart + 0.9 * bestDist * Normal(FireDir), projStart) )
    {
        FireDir = BestTarget.Location - projStart;
        AimSpot = projStart + bestDist * Normal(FireDir);
    }

    return rotator(AimSpot - projStart);
}

// ============================================================================
//  Pawn
// ============================================================================
function Possess(Pawn P)
{
    local gPRI GPRI;

    //gLog( "Possess" #P );

    Super.Possess(P);

    if( Role == ROLE_Authority )
    {
        if( ShopInfo != None )
            ShopInfo.PawnPossessed();

        GPRI = GetGPRI();
        if( GPRI != None )
            GPRI.PawnPossessed(P);
    }

    if( AmbientOverlay != None )
        AmbientOverlay.NotifyRespawn();

    if( FlashOverlay != None )
        FlashOverlay.NotifyRespawn();
}

function PawnDied(Pawn P)
{
    local gPRI GPRI;

    //gLog( "PawnDied" #P );

    if( Role == ROLE_Authority )
    {
        GPRI = GetGPRI();
        if( GPRI != None )
            GPRI.PawnDied(P);

        if( ShopInfo != None )
            ShopInfo.PawnDied();
    }

    Super.PawnDied(P);
}

function SetPawnClass(string inClass, string inCharacter)
{
    local class<xPawn> pClass;

    if( inClass != "" )
    {
        pClass = class<xPawn>(DynamicLoadObject(inClass, class'Class', True));
        if( pClass != None && pClass.Default.bCanPickupInventory )
            PawnClass = pClass;
    }

    // Replace xPawns with gPawns
    // Watch for GameInfo.RestartPlayer() and UnrealTeamInfo.AddToTeam()
    if( PawnClass != None && PawnClass.name == 'xPawn' )
        PawnClass = default.PawnClass;

    PawnSetupRecord = class'xUtil'.static.FindPlayerRecord(inCharacter);
    PlayerReplicationInfo.SetCharacterName(inCharacter);
}

// ============================================================================
//  Movement
// ============================================================================
function HandleWalking()
{
    // Walk by default
    if( gPawn(Pawn) != None )
        gPawn(Pawn).SetWalking((bRun == 0) && !Region.Zone.IsA('WarpZoneInfo'));
}

simulated event bool NotifyHitWall(vector HitNormal, Actor Wall)
{
    // WTF: PHYS_Swimming pawn will go PHYS_Falling after receiving HitWall()
    return True;
}

// ============================================================================
//  PlayerWalking
// ============================================================================
state PlayerWalking
{
    ignores SeePlayer, HearNoise, Bump;

    event bool NotifyHitWall(vector HitNormal, Actor Wall)
    {
        return False;
    }

    function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
    {
        local vector OldAccel;
        local bool OldCrouch;
        local gPawn P;

        // Gunreal: gPawn only
        P = gPawn(Pawn);
        if( P == None )
            return;

        // Update stamina
        P.UpdateStamina(DeltaTime);

        // Dodge
        if( DoubleClickMove == DCLICK_Active && Pawn.Physics == PHYS_Falling )
        {
            DoubleClickDir = DCLICK_Active;
        }
        else if( DoubleClickMove != DCLICK_None && DoubleClickMove < DCLICK_Active )
        {
            if( UnrealPawn(Pawn).Dodge(DoubleClickMove) )
            {
                DoubleClickDir = DCLICK_Active;

                // Dodging drains stamina
                if( Role == ROLE_Authority )
                    P.StaminaHit -= P.StaminaCostJump;
            }
        }

        // Accel
        OldAccel = Pawn.Acceleration;
        if( Pawn.Acceleration != NewAccel )
            Pawn.Acceleration = NewAccel;

        // Sprinting drains stamina
        if( Role == ROLE_Authority && P.Physics == PHYS_Walking && !P.bIsWalking && NewAccel != vect(0,0,0) )
        {
            P.StaminaDrain -= P.StaminaCostSprint;
        }

        // Jumping
        if( bPressedJump )
        {
            if( P.DoJump(bUpdating) )
            {
                // Jumping drains stamina
                if( Role == ROLE_Authority )
                {
                    if( Level.TimeSeconds - P.CrouchEndTime < P.JumpCrouchTime )
                        P.StaminaHit -= P.StaminaCostJump * 2;
                    else
                        P.StaminaHit -= P.StaminaCostJump;
                }
            }
        }

        // Rotation
        Pawn.SetViewPitch(Rotation.Pitch);

        // Crouching
        if( Pawn.Physics != PHYS_Falling )
        {
            OldCrouch = Pawn.bWantsToCrouch;
            if( bDuck == 0 )
                Pawn.ShouldCrouch(False);
            else if( Pawn.bCanCrouch )
                Pawn.ShouldCrouch(True);
        }
    }

    function PlayerMove( float DeltaTime )
    {
        local vector X,Y,Z, NewAccel;
        local eDoubleClickDir DoubleClickMove;
        local rotator OldRotation, ViewRotation;
        local bool  bSaveJump;
        local byte bSaveRun;
        local gPawn P;

        P = gPawn(Pawn);
        if( P == None )
        {
            GotoState('Dead'); // this was causing instant respawns in mp games
            return;
        }

        GetAxes(Pawn.Rotation,X,Y,Z);

        // Update acceleration.
        NewAccel = aForward*X + aStrafe*Y;
        NewAccel.Z = 0;
        if( VSize(NewAccel) < 1.0 )
            NewAccel = vect(0,0,0);

        DoubleClickMove = GunrealInput.CheckForDoubleClickMove(1.1*DeltaTime/Level.TimeDilation);

        // Jumping requires stamina
        if( Level.TimeSeconds - P.CrouchEndTime < P.JumpCrouchTime )
        {
            if( P.StaminaPoints < P.StaminaCostJump * 2 )
                bPressedJump = False;
        }
        else
        {
            if( P.StaminaPoints < P.StaminaCostJump )
                bPressedJump = False;
        }

        // Dodging requires stamina
        if( P.StaminaPoints < P.StaminaCostJump
        &&  DoubleClickMove != DCLICK_NONE && DoubleClickMove != DCLICK_Forward && DoubleClickMove != DCLICK_Active )
        {
            DoubleClickMove = DCLICK_NONE;
        }

        // Save bRun state as we may want to modify it without breaking the button state
        bSaveRun = bRun;

        // Handler for dodge-activated sprint
        if( bDodgeRun )
        {
            // Disable dodge sprint if no accel or sprint key was pressed
            if( NewAccel == vect(0,0,0) )
            {
                bDodgeRun = False;
            }
            // Otherwise if we aren't waiting for stamina, keep running
            else if( !bWaitForStamina )
            {
                bRun = 1;
            }
        }
        else
        {
            // Dodge forward activates sprint
            if( DoubleClickMove == DCLICK_Forward )
            {
                bRun = 1;
                bDodgeRun = True;
                bWaitForStamina = False;
                DoubleClickMove = DCLICK_NONE;
            }
        }

        // Handler for running out of stamina and resuming the sprint when you have enough again
        // sprinting won't resume automatically until sprint key is pressed again or movement input is stopped, or player jumps
        if( bWaitForStamina )
        {
            if( NewAccel == vect(0,0,0) || (bRun == 1 && bRunOld == 0) || bPressedJump || DoubleClickMove != DCLICK_NONE )
            {
                //gLog("STAMINA WAIT START" #NewAccel #bRun #bRunOld #P.StaminaPoints );
                bWaitForStamina = False;
            }
        }
        else
        {
            if( P.StaminaPoints == 0 )
            {
                //gLog("STAMINA WAIT STOP" #NewAccel #bRun #bRunOld #P.StaminaPoints );
                bWaitForStamina = True;
            }
        }

        // If ran out of stamina, force walk
        if( bWaitForStamina )
        {
            bRun = 0;
        }

        // Update pawn if bRun changed
        HandleWalking();

        GroundPitch = 0;
        ViewRotation = Rotation;
        if( Pawn.Physics == PHYS_Walking )
        {
            // tell pawn about any direction changes to give it a chance to play appropriate animation
            //if walking, look up/down stairs - unless player is rotating view
             if( bLook == 0
             &&((Pawn.Acceleration != Vect(0,0,0) && bSnapToLevel) || !bKeyboardLook) )
            {
                if( bLookUpStairs || bSnapToLevel )
                {
                    GroundPitch = FindStairRotation(deltaTime);
                    ViewRotation.Pitch = GroundPitch;
                }
                else if( bCenterView )
                {
                    ViewRotation.Pitch = ViewRotation.Pitch & 65535;
                    if( ViewRotation.Pitch > 32768 )
                        ViewRotation.Pitch -= 65536;
                    ViewRotation.Pitch = ViewRotation.Pitch * (1 - 12 * FMin(0.0833, deltaTime));
                    if( Abs(ViewRotation.Pitch) < 250 && ViewRotation.Pitch < 100 )
                        ViewRotation.Pitch = -249;
                }
            }
        }
        else
        {
            if( !bKeyboardLook && (bLook == 0) && bCenterView )
            {
                ViewRotation.Pitch = ViewRotation.Pitch & 65535;
                if( ViewRotation.Pitch > 32768 )
                    ViewRotation.Pitch -= 65536;
                ViewRotation.Pitch = ViewRotation.Pitch * (1 - 12 * FMin(0.0833, deltaTime));
                if( Abs(ViewRotation.Pitch) < 250 && ViewRotation.Pitch < 100 )
                    ViewRotation.Pitch = -249;
            }
        }
        Pawn.CheckBob(DeltaTime, Y);

        // Update rotation.
        SetRotation(ViewRotation);
        OldRotation = Rotation;
        UpdateRotation(DeltaTime, 1);
        bDoubleJump = False;

        if( bPressedJump && Pawn.CannotJumpNow() )
        {
            bSaveJump = True;
            bPressedJump = False;
        }
        else
            bSaveJump = False;

        // then save this move and replicate it
        if( Role < ROLE_Authority )
            ReplicateMove(DeltaTime, NewAccel, DoubleClickMove, OldRotation - Rotation);
        else
            ProcessMove(DeltaTime, NewAccel, DoubleClickMove, OldRotation - Rotation);
        bPressedJump = bSaveJump;

        // Restore bRun state and store it for comparison next tick
        bRun = bSaveRun;
        bRunOld = bRun;
    }
}


// ============================================================================
//  PlayerSwimming
// ============================================================================
state PlayerSwimming
{
    ignores SeePlayer, HearNoise, Bump;

    function ProcessMove( float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot )
    {
        local vector X,Y,Z, OldAccel;
        local bool bUpAndOut;
        local gPawn P;

        P = gPawn(Pawn);
        if( P == None )
            return;

        // Update stamina
        P.UpdateStamina(DeltaTime);

        // Sprinting drains stamina
        if( Role == ROLE_Authority && P.Physics == PHYS_Swimming && !P.bIsWalking && NewAccel != vect(0,0,0) )
        {
            P.StaminaDrain -= P.StaminaCostSprint;
        }

        // Acceleration
        OldAccel = Pawn.Acceleration;
        if( Pawn.Acceleration != NewAccel )
            Pawn.Acceleration = NewAccel;

        // bUpAndOut
        GetAxes(Rotation,X,Y,Z);
        bUpAndOut = ((X Dot Pawn.Acceleration) > 0) && ((Pawn.Acceleration.Z > 0) || (Rotation.Pitch > 2048));
        if( Pawn.bUpAndOut != bUpAndOut )
            Pawn.bUpAndOut = bUpAndOut;

        // Check for waterjump
        if( !Pawn.PhysicsVolume.bWaterVolume )
            NotifyPhysicsVolumeChange(Pawn.PhysicsVolume);
    }

    function PlayerMove(float DeltaTime)
    {
        local rotator oldRotation;
        local vector X,Y,Z, NewAccel;
        local eDoubleClickDir DoubleClickMove;
        local byte bSaveRun;
        local gPawn P;

        P = gPawn(Pawn);
        if( P == None )
            return;

        GetAxes(Rotation,X,Y,Z);

        NewAccel = aForward*X + aStrafe*Y + aUp*vect(0,0,1);
        if( VSize(NewAccel) < 1.0 )
            NewAccel = vect(0,0,0);

        // Allow dodge forward in water to activate sprint
        DoubleClickMove = GunrealInput.CheckForDoubleClickMove(1.1*DeltaTime/Level.TimeDilation);
        if( DoubleClickMove != DCLICK_Forward )
        {
            DoubleClickMove = DCLICK_NONE;
        }

        // Save bRun state as we may want to modify it without breaking the button state
        bSaveRun = bRun;

        // Handler for dodge-activated sprint
        if( bDodgeRun )
        {
            // Disable dodge sprint if no accel or sprint key was pressed
            if( NewAccel == vect(0,0,0) )
            {
                bDodgeRun = False;
            }
            // Otherwise if we aren't waiting for stamina, keep running
            else if( !bWaitForStamina )
            {
                bRun = 1;
            }
        }
        else
        {
            // Dodge forward activates sprint
            if( DoubleClickMove == DCLICK_Forward )
            {
                bRun = 1;
                bDodgeRun = True;
                bWaitForStamina = False;
                DoubleClickMove = DCLICK_NONE;
            }
        }

        // Handler for running out of stamina and resuming the sprint when you have enough again
        // sprinting won't resume automatically until sprint key is pressed again or movement input is stopped
        if( bWaitForStamina )
        {
            if( NewAccel == vect(0,0,0) || (bRun == 1 && bRunOld == 0) )
            {
                //gLog("STAMINA WAIT START" #NewAccel #bRun #bRunOld #P.StaminaPoints );
                bWaitForStamina = False;
            }
        }
        else
        {
            if( P.StaminaPoints == 0 )
            {
                //gLog("STAMINA WAIT STOP" #NewAccel #bRun #bRunOld #P.StaminaPoints );
                bWaitForStamina = True;
            }
        }

        // If ran out of stamina, force walk
        if( bWaitForStamina )
        {
            bRun = 0;
        }

        // Update pawn if bRun changed
        HandleWalking();

        // add bobbing when swimming
        Pawn.CheckBob(DeltaTime, Y);

        // Update rotation.
        oldRotation = Rotation;
        UpdateRotation(DeltaTime, 2);

        // then save this move and replicate it
        if( Role < ROLE_Authority )
            ReplicateMove(DeltaTime, NewAccel, DCLICK_None, OldRotation - Rotation);
        else
            ProcessMove(DeltaTime, NewAccel, DCLICK_None, OldRotation - Rotation);

        bPressedJump = False;

        // Restore bRun state and store it for comparison next tick
        bRun = bSaveRun;
        bRunOld = bRun;
    }
}

auto simulated state PlayerWaiting
{
    ignores SeePlayer, HearNoise, NotifyBump, TakeDamage, PhysicsVolumeChange, NextWeapon, PrevWeapon, SwitchToBestWeapon;

    simulated event RenderOverlays(Canvas C)
    {
        PlayerHUD.RenderOverlaysWaiting(C);
    	PlayerHUD.RenderLoadingScreen(C);
    }

    function bool CanRestartPlayer()
    {
        //gLog( "CanRestartPlayer" #ShopInfo.IsShopping() );
        return ((ShopInfo == None || !ShopInfo.IsShopping()) && Super.CanRestartPlayer());
    }

    function ServerRestartPlayer()
    {
        //gLog( "ServerReStartPlayer" #ShopInfo.IsShopping() );
        if( ShopInfo == None || !ShopInfo.IsShopping() )
            Super.ServerRestartPlayer();
    }

    function ServerUse()
    {
        //gLog("ServerUse");
        if( ShopInfo != None && !ShopInfo.IsShopping() )
            ShopInfo.Begin(Self);
    }

    function bool ShopCouldRespawn()
    {
        return True;
    }

    function ReplicateShopMenuCancelled( int ID )
    {
        Global.ReplicateShopMenuCancelled(ID);
        bShopBeforeRespawn = False;
    }

    function ReplicateClientLoadout( sShopLoadout L )
    {
        //gLog( "ReplicateClientLoadout" #L.ID );
        LoadPlayers();
        ServerShopBuyLoadout(L, !bForcePrecache && Level.TimeSeconds > 0.2);
        bShopBeforeRespawn = False;
    }

    exec function Fire( optional float F )
    {
        //gLog("Fire");

        // don't send respawn request nor open midgame menu before the shop menu is closed
        if( bUseShopping && bShopBeforeRespawn )
            return;

        Super.Fire(F);
    }

    event BeginState()
    {
        //gLog("BeginState");

        bShopBeforeRespawn = default.bShopBeforeRespawn;

        Super.BeginState();

        // begin shopping
        if( ShopInfo != None && Role == ROLE_Authority )
            ShopInfo.Begin(Self);
    }

    event EndState()
    {
        //gLog("EndState");

        Super.EndState();

        // cancel all shopping
        if( ShopInfo != None && Role == ROLE_Authority )
            ShopInfo.End(Self,True);
    }

Begin:
    //gLog("Begin");
}

simulated state Dead
{
    ignores SeePlayer, HearNoise, KilledBy, SwitchWeapon, NextWeapon, PrevWeapon;

    simulated event RenderOverlays(Canvas C)
    {
        PlayerHUD.RenderOverlaysDead(C);
    	PlayerHUD.RenderLoadingScreen(C);
    }

    function bool CanRestartPlayer()
    {
        //gLog( "CanRestartPlayer" #ShopInfo.IsShopping() );
        return ((ShopInfo == None || !ShopInfo.IsShopping()) && Super.CanRestartPlayer());
    }

    function ServerRestartPlayer()
    {
        //gLog( "ServerReStartPlayer" #ShopInfo.IsShopping() );
        if( ShopInfo == None || !ShopInfo.IsShopping() )
            Super.ServerRestartPlayer();
    }

    exec function Use()
    {
        //gLog("Use");

        // disable auto-delay
        ShopAutoDelay = 0;

        if( !IsFrozen() )
        {
            if( Level.Game != None )
                Level.Game.DeadUse(self);

            Global.Use();
        }
    }

    function ServerUse()
    {
        //gLog("ServerUse");
        if( ShopInfo != None && !ShopInfo.IsShopping() )
            ShopInfo.Begin(Self);
    }

    function bool ShopCouldRespawn()
    {
        return True;
    }

    function ReplicateShopMenuCancelled( int ID )
    {
        Global.ReplicateShopMenuCancelled(ID);
        bShopBeforeRespawn = False;
    }

    function ReplicateClientLoadout( sShopLoadout L )
    {
        //gLog( "ReplicateClientLoadout" #L.ID );

        bShopBeforeRespawn = False;

        if( PlayerReplicationInfo.bOutOfLives )
        {
            ServerSpectate();
            return;
        }

        if( IsFrozen() )
        {
            ServerShopBuyLoadout(L, False);
        }
        else
        {
            LoadPlayers();

            if( bMenuBeforeRespawn )
            {
                bMenuBeforeRespawn = False;
                ShowMidGameMenu(False);
                ServerShopBuyLoadout(L, False);
            }
            else
            {
                ServerShopBuyLoadout(L, True);
            }
        }
    }

    function bool ReceivedServerLoadout()
    {
        //gLog( "ReceivedServerLoadout" #Player #bFrozen );

        // delay if auto-delay
        if( ShopAutoDelay > Level.TimeSeconds )
        {
            //gLog( "ReceivedServerLoadout - AUTO DELAY" );
            ShopTimer.SetTimer(ShopTimerRate,False);
            return False;
        }

        Global.ReceivedServerLoadout();
    }

    exec function Fire( optional float F )
    {
        //gLog("Fire");

        // don't send respawn request nor open midgame menu before the shop menu is closed
        if( bUseShopping && bShopBeforeRespawn )
            return;

        Super.Fire(F);
    }

    event BeginState()
    {
        //gLog("BeginState");

        bShopBeforeRespawn = default.bShopBeforeRespawn;
        ShopAutoDelay = Level.TimeSeconds + default.ShopAutoDelay;

        Super.BeginState();

        if( AmbientOverlay != None )
            AmbientOverlay.NotifyDeath();

        if( FlashOverlay != None )
            FlashOverlay.NotifyDeath();

        // begin shopping
        if( ShopInfo != None && Role == ROLE_Authority )
            ShopInfo.Begin(Self);
    }

    event EndState()
    {
        //gLog("EndState");

        Super.EndState();

        // cancel all shopping
        if( ShopInfo != None && Role == ROLE_Authority )
            ShopInfo.End(Self,True);
    }

Begin:
    //gLog("Begin");

    Sleep(1.0);
    if( ViewTarget == None || ViewTarget == self || VSize(ViewTarget.Velocity) < 1.0 )
    {
        Sleep(1.0);
        if( myHUD != None )
            myHUD.bShowScoreBoard = True;
    }
    else
        Goto('Begin');
}


// ============================================================================
//  Use
// ============================================================================

// The player wants to use something in the level.
exec function Use()
{
    //gLog("Use");
    ServerUse();
}

function ServerUse()
{
    local Actor A;
    local gWeaponPickup wp;
    local gTerminal term;
    local Vehicle DrivenVehicle, EntryVehicle, V;

    bSuccessfulUse = False;

    if( Role < ROLE_Authority )
        return;

    if( Level.Pauser == PlayerReplicationInfo )
    {
        SetPause(False);
        return;
    }

    if( Pawn == None )
        return;

    if( !Pawn.bCanUse )
        return;

    foreach Pawn.TouchingActors(class'gWeaponPickup', wp)
    {
        wp.UsedBy(Pawn);

        if( bSuccessfulUse )
            return;
    }

    foreach Pawn.TouchingActors(class'gTerminal', term)
    {
        term.UsedBy(Pawn);

        if( bSuccessfulUse )
            return;
    }

    DrivenVehicle = Vehicle(Pawn);

    if( DrivenVehicle != None )
    {
        DrivenVehicle.KDriverLeave(False);
        return;
    }

    // Check for nearby vehicles
    foreach Pawn.VisibleCollidingActors(class'Vehicle', V, VehicleCheckRadius)
    {
        // Found a vehicle within radius
        EntryVehicle = V.FindEntryVehicle(Pawn);

        if( EntryVehicle != None && EntryVehicle.TryToDrive(Pawn) )
            return;
    }

    Pawn.UsedBy(Pawn);

    if( !bSuccessfulUse )
    {
        // Send the 'DoUse' event to each actor player is touching.
        foreach Pawn.TouchingActors(class'Actor', A)
            A.UsedBy(Pawn);

        if( Pawn.Base != None )
            Pawn.Base.UsedBy(Pawn);
    }
}


// ============================================================================
//  Shop
// ============================================================================
simulated final function gPRI GetGPRI()
{
    if( CachedGPRI == None )
        CachedGPRI = class'gPRI'.static.GetGPRI(PlayerReplicationInfo);

    return CachedGPRI;
}

function ReceivedShopData()
{
    //gLog( "ReceivedShopData" );
}

// called on listen server, standalone and client
// if local player isn't ready yet, called until he is
function bool ReceivedServerLoadout()
{
    //gLog( "ReceivedServerLoadout" #Player );

    if( NetConnection(Player) != None )
    {
        // filter out remote gPlayers on listen server
        //gLog( "ReceivedServerLoadout - NET ABORT" );
        ShopTimer.SetTimer(0.0,False);
        return False;
    }

    if( ShopClientDelay > Level.TimeSeconds )
    {
        // don't open immediately, let some other things replicate
        //gLog( "ReceivedServerLoadout - RECEIVE DELAY" );
        ShopTimer.SetTimer(ShopTimerRate,False);
        return False;
    }

    if( Player != None )
    {
        ShopTimer.SetTimer(0.0,False);
        if( !IsShopMenuOpen() )
        {
            if( Player.GUIController.OpenMenu(ShopMenu, string(ServerLoadout.ID)) )
            {
                // opened succesfully
                //gLog( "ReceivedServerLoadout - MENU OPENED" );
                OpenedServerLoadout = ServerLoadout;
                return True;
            }
            else
            {
                // menu failed to open
                //gLog( "ReceivedServerLoadout - MENU FAILED" );
                ReplicateShopMenuCancelled(ServerLoadout.ID);
                return False;
            }
        }
        else
        {
            // menu alread exists, cancel? update? replace?
            //gLog( "ReceivedServerLoadout - MENU ALREADY OPENED" );
            ReplicateShopMenuCancelled(OpenedServerLoadout.ID);
            return False;
        }
    }
    else
    {
        // no player, failed to open, delay?
        //gLog( "ReceivedServerLoadout - NO PLAYER" );
        ShopTimer.SetTimer(ShopTimerRate,False);
        return False;
    }
}

function ShopWaitingForPlayer()
{
    //gLog( "ShopWaitingForPlayer" );
    ReceivedServerLoadout();
}

function bool IsShopMenuOpen()
{
    return Player != None && GUIController(Player.GUIController).FindMenuIndexByName(ShopMenu) != -1;
}

function bool ShopCouldRespawn()
{
    return False;
}

function ReplicateClientLoadout( sShopLoadout L )
{
    //gLog( "ReplicateClientLoadout" #L.ID );
    ServerShopBuyLoadout(L);
}

function ServerShopBuyLoadout(sShopLoadout L, optional bool bRespawn)
{
    //gLog( "ShopBuyLoadout" #L.ID #ShopInfo.TransactionID #bRespawn );
    if( ShopInfo.IsShopping() )
    {
        ShopInfo.BuyLoadout(L);
        ShopInfo.End(self);
        if( bRespawn && ShopCouldRespawn( )
        &&( xTeamGame(Level.Game) == None || Level.Game.class == class'xTeamGame' ) )
            ServerReStartPlayer();
    }
}

function ReplicateServerLoadout( sShopLoadout L )
{
    //gLog( "ReplicateServerLoadout" #L.ID #ServerLoadout.ID #Player );
    if( L != ServerLoadout )
    {
        ServerLoadout = L;
        if( Level.NetMode == NM_Standalone || Level.NetMode == NM_ListenServer )
        {
            ShopClientDelay = 0;
            ReceivedServerLoadout();
        }
    }
}

function ReplicateShopMenuCancelled( int ID )
{
    //gLog( "ReplicateShopMenuCancelled" #ID );
    ServerShopMenuCancelled(ID);
}

function ServerShopMenuCancelled( int ID )
{
    //gLog( "ServerShopMenuCancelled" #ID );
    ShopInfo.MenuClosed(ID);
}

function ClientCloseShopMenu(bool bCommit)
{
    //gLog( "ClientCloseShopMenu" );
    OnShopCloseMenu(bCommit);
}

delegate OnShopCloseMenu(bool bCommit);


// ============================================================================
//  HUD
// ============================================================================
simulated event RenderOverlays(Canvas C)
{
    PlayerHUD.RenderOverlays(C);
    PlayerHUD.RenderLoadingScreen(C);
}

simulated function ClientSetHUD(class<HUD> newHUDClass, class<Scoreboard> newScoringClass)
{
    Super.ClientSetHUD(NewHUDClass, newScoringClass);
    PlayerHUD.ClientSetHUD(newHUDClass, newScoringClass);
    ServerSetHitSounds(bHitSounds);
}

simulated function ClientFlashOverlay( class<gOverlayTemplate> Template )
{
    //gLog( "ClientFlashOverlay" #Template );
    if( FlashOverlay != None && Template != None )
        FlashOverlay.ShowOverlay( Template );
}

simulated function ClientAmbientOverlay( class<gOverlayTemplate> Template )
{
    //gLog( "ClientAmbientOverlay" #Template );
    if( AmbientOverlay != None && Template != None )
        AmbientOverlay.ShowOverlay( Template );
}

simulated function ClientFadeAmbientOverlay( class<gOverlayTemplate> Template )
{
    //gLog( "ClientFadeAmbientOverlay" #Template );
    if( AmbientOverlay != None && Template != None )
        AmbientOverlay.FadeOverlay( Template );
}

// this is rendered after world and the first person weapon but before hud
final simulated function OnWeaponRendered( Canvas C )
{
    if( AmbientOverlay != None )
        AmbientOverlay.PostRender(C);

    if( FlashOverlay != None )
        FlashOverlay.PostRender(C);
}

final simulated function TickOverlays( float DeltaTime )
{
    if( AmbientOverlay != None )
        AmbientOverlay.Tick(self,DeltaTime);

    if( FlashOverlay != None )
        FlashOverlay.Tick(self,DeltaTime);
}


function NotifyTakeHit(pawn InstigatedBy, vector HitLocation, int Damage, class<DamageType> damageType, vector Momentum)
{
    local int iDam;
    local vector AttackLoc;

    Super(PlayerController).NotifyTakeHit(InstigatedBy,HitLocation,Damage,DamageType,Momentum);

    DamageTypeShake(Damage,damageType);
    iDam = Clamp(Damage,0,250);
    if( InstigatedBy != None )
        AttackLoc = InstigatedBy.Location;

    NewClientPlayTakeHit(AttackLoc, hitLocation - Pawn.Location, iDam, damageType);
}

function DamageTypeShake(int damage, class<DamageType> damageType)
{
    ClientDamageTypeShake(damage,damageType);
}

function ClientDamageTypeShake(int damage, class<DamageType> damageType)
{
    if( class<gDamTypeWeapon>(DamageType) != None && class<gDamTypeWeapon>(DamageType).default.ShakeClass != None )
    {
        GunrealShake( class<gDamTypeWeapon>(DamageType).default.ShakeClass, damage );
    }
    else
    {
        // todo: add properties!
        ShakeView( Damage * vect(30,0,0),
                   120000 * vect(1,0,0),
                   0.15 + 0.005 * damage,
                   damage * vect(0,0,0.03),
                   vect(1,1,1),
                   0.2);
    }
}

function GunrealShake( class<gShakeView> Template, optional float Amount )
{
    if( GunrealShakeModel != None )
    {
        bGunrealShake = GunrealShakeModel.InitFrom( Level.TimeSeconds, Template, Amount );
    }
}

function CalcFirstPersonView( out vector CameraLocation, out rotator CameraRotation )
{
    local vector x, y, z, AmbShakeOffset, GunrealShakeOffset;
    local rotator AmbShakeRot, GunrealShakeRot;
    local float FalloffScaling;

    GetAxes(Rotation, x, y, z);

    if( bGunrealShake )
    {
        bGunrealShake = GunrealShakeModel != None
                     && GunrealShakeModel.CalcShake( Level.TimeSeconds, GunrealShakeOffset, GunrealShakeRot );
    }

    if( bEnableAmbientShake )
    {
        if( AmbientShakeFalloffStartTime > 0 && Level.TimeSeconds - AmbientShakeFalloffStartTime > AmbientShakeFalloffTime )
            bEnableAmbientShake = False;
        else
        {
            if( AmbientShakeFalloffStartTime > 0 )
            {
                FalloffScaling = 1.0 - ((Level.TimeSeconds - AmbientShakeFalloffStartTime) / AmbientShakeFalloffTime);
                FalloffScaling = FClamp(FalloffScaling, 0.0, 1.0);
            }
            else
                FalloffScaling = 1.0;

            AmbShakeOffset = AmbientShakeOffsetMag * FalloffScaling *
            sin(Level.TimeSeconds * AmbientShakeOffsetFreq * 2 * Pi);

            AmbShakeRot = AmbientShakeRotMag * FalloffScaling *
            sin(Level.TimeSeconds * AmbientShakeRotFreq * 2 * Pi);
        }
    }

    // First-person view.
    CameraRotation = Normalize(Rotation + ShakeRot + AmbShakeRot + GunrealShakeRot);
    CameraLocation = CameraLocation + Pawn.EyePosition() + Pawn.WalkBob +
                     ShakeOffset.X * x +
                     ShakeOffset.Y * y +
                     ShakeOffset.Z * z +
                     GunrealShakeOffset.X * x +
                     GunrealShakeOffset.Y * y +
                     GunrealShakeOffset.Z * z +
                     AmbShakeOffset;
}

// ============================================================================
//  FrameRate Killer
// ============================================================================
function KillFrameRate()
{
    local int i;

    for( i=0; i<SlowIterations; i++ )
        SlowFunction();
}

function SlowFunction()
{
    local TerrainInfo.TerrainLayer              Layers[256];
    local TerrainInfo.DecorationLayer           DecoLayers[256];
    local TerrainInfo.DecorationLayerData       DecoLayerData[256];

    Layers[0]           = Layers[255];
    DecoLayers[0]       = DecoLayers[255];
    DecoLayerData[0]    = DecoLayerData[255];
}

exec function Slow(int i)
{
    if( Level.Netmode != NM_Standalone )
        return;
        
    SlowIterations = i;
}

// ============================================================================
//  Debug
// ============================================================================
function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
    local gPRI GPRI;

    Super.DisplayDebug(Canvas, YL, YPos);

    GPRI = GetGPRI();
    if( GPRI != None )
    {
        YPos += YL;
        Canvas.SetDrawColor(255, 255, 255);
        Canvas.SetPos(4,YPos);
        Canvas.DrawText("Money" @GPRI.GetMoney());
    }

    YPos += YL;
    Canvas.SetPos(4, YPos);
}

simulated function QueueAnnouncement(name ASoundName, byte AnnouncementLevel,
                                     optional AnnouncerQueueManager.EAPriority Priority, optional byte Switch)
{
    if( AnnouncementLevel > AnnouncerLevel || Level.NetMode == NM_DedicatedServer || GameReplicationInfo == None )
        return;

    if( AnnouncerQueueManager == None )
    {
        AnnouncerQueueManager = Spawn(class'gAnnouncerQueueManager');
        AnnouncerQueueManager.InitFor(Self);
    }

    if( AnnouncerQueueManager != None )
        AnnouncerQueueManager.AddItemToQueue(ASoundName, Priority, Switch);
}

final function bool IsFrozen()
{
    if( bFrozen )
    {
        if( TimerRate <= 0.0 || TimerRate > 1.0 )
        {
            bFrozen = False;
        }
    }
    return bFrozen;
}




function ClientSetMusic( string NewSong, EMusicTransition NewTransition )
{
	local float FadeIn, FadeOut;
	
	gLog("ClientSetMusic"  #Song #Transition #NewSong #NewTransition );

	switch (NewTransition)
	{
	case MTRAN_Segue:
		FadeIn = 7.0;
		FadeOut = 3.0;
		break;

	case MTRAN_Fade:
		FadeIn = 3.0;
		FadeOut = 3.0;
		break;

	case MTRAN_FastFade:
		FadeIn = 1.0;
		FadeOut = 1.0;
		break;

	case MTRAN_SlowFade:
		FadeIn = 5.0;
		FadeOut = 5.0;
		break;
	}

    StopAllMusic( FadeOut );

    if ( NewSong != "" )
	    PlayMusic( NewSong, FadeIn );

    Song        = NewSong;
    Transition  = NewTransition;
    if (Player!=None && Player.Console!=None)
    	Player.Console.SetMusic(NewSong);
}


event ClientOpenMenu (string Menu, optional bool bDisconnect,optional string Msg1, optional string Msg2)
{
	ReplaceLoginHelpMenu(Menu);
	Super.ClientOpenMenu(Menu,bDisconnect,Msg1,Msg2);
}

event ClientReplaceMenu(string Menu, optional bool bDisconnect,optional string Msg1, optional string Msg2)
{
	ReplaceLoginHelpMenu(Menu);
	Super.ClientReplaceMenu(Menu,bDisconnect,Msg1,Msg2);
}

simulated function ReplaceLoginHelpMenu(string Menu)
{
	local class<UT2K4PlayerLoginMenu> LoginClass;
	local int i;

	LoginClass = class<UT2K4PlayerLoginMenu>(DynamicLoadObject(Menu, class'Class', True));
	if( LoginClass != None )
	{
		for( i=0; i<LoginClass.default.Panels.Length; ++i )
		{
			if( InStr(Caps(LoginClass.default.Panels[i].ClassName),Caps("GUI2K4.UT2K4Tab_MidGameHelp")) != -1 )
			{
				LoginClass.default.Panels[i].ClassName = "GMenu.g2K4Tab_MidGameHelp";
			}
		}
	}
}

// ============================================================================
//  Precache
// ============================================================================

simulated function UpdatePrecacheMaterials()
{
    class'gPrecacheMerged'.static.StaticPrecacheMaterials(Level);

    Super.UpdatePrecacheMaterials();
}

simulated function UpdatePrecacheStaticMeshes()
{
    class'gPrecacheMerged'.static.StaticPrecacheStaticMeshes(Level);
    class'gPrecacheMerged'.static.StaticPrecacheSkelMeshes(Level);
    class'gPrecacheMerged'.static.StaticPrecacheSounds(Level);

    Super.UpdatePrecacheStaticMeshes();
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
    bHitSounds                  = True

    DingHeadshotDeath           = sound'G_Sounds.notif_waz_0'
    DingPlayerDeath             = sound'G_Sounds.notif_waz_1'

    DingVehicle                 = sound'G_Sounds.notif_waz_5'
    DingHeadshot                = sound'G_Sounds.notif_click_1'
    DingPlayer                  = sound'G_Sounds.notif_hit_0'

    bReceivingShopData          = True
    bShopBeforeRespawn          = True
    ShopAutoDelay               = 1.5
    ShopClientDelay             = 0.2
    ShopTimerRate               = 0.1
    ShopMenu                    = "GMenu.gShopMenu"

    bForceDramaticLighting      = True
    FOVAdjustSpeed              = 90
    ForceDramaticLighting       = 1.3

    PawnClass                   = class'GGame.gPawn'
    InputClass                  = class'GGame.gPlayerInput'
    CheatClass                  = class'GGame.gCheatManager'

    MinHitWall                  = 1
    bNotifyFallingHitWall       = True

    ZoomSpeed                   = 1

    TPCamDistance               = 200
    TPCamLookat                 = (X=0,Y=0,Z=50)
    TPCamWorldOffset            = (X=0,Y=0,Z=0)

    AdrenalineReady             = Sound'G_Sounds.g_adren_ready1'
}
