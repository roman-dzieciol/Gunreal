// ============================================================================
//  gPlasmaGun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaGun extends gWeapon;


var() HUDBase.SpriteWidget      BoostWidgetIcon;        // Icon widget
var() HUDBase.NumericWidget     BoostWidgetTime;        // Time widget

var() class<Actor>              BoostCoronaClass;       //
var   gPlasmaBoostCorona        BoostCorona;            //

var() float                     BoostRange;             // AI aim range
var() float                     BoostDmgAtten;          // Damage multiplier
var() float                     BoostTimePerDmg;        // How many seconds of boost per 1 damage
var   float                     BoostTime;


replication
{
    reliable if( Role == ROLE_Authority )
        ClientSetBoostTime;
}


// ============================================================================
//  Weapon
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.BoostWidgetIcon.WidgetTexture);
    S.PrecacheObject(default.BoostCoronaClass);
}

simulated event PostBeginPlay()
{
    if( BoostCoronaClass != None
    &&  Level.NetMode != NM_DedicatedServer
    && (Level.NetMode != NM_ListenServer || Instigator != None && Instigator.Controller == Level.GetLocalPlayerController()) )
        BoostCorona = gPlasmaBoostCorona(Spawn(BoostCoronaClass, Instigator));

    Super.PostBeginPlay();
}

simulated event Destroyed()
{
    if( BoostCorona != None )
        BoostCorona.Destroy();

    Super.Destroyed();
}


// ============================================================================
//  Boost
// ============================================================================

final function float GetBoostDamageAtten()
{
    if( BoostTime > Level.TimeSeconds )
        return BoostDmgAtten;

    return 1.0;
}

final function AddBoost( float Amount )
{
    local gPlasmaBoostAmbient BoostAmbient;
    local float BoostTimeLeft;

    //gLog( "AddBoost" #Amount );

    // Calc
    BoostTimeLeft = FMax(BoostTime - Level.TimeSeconds, 0) + Amount * BoostTimePerDmg;
    if( BoostTimeLeft > 0 )
    {
        // Update BoostTime
        BoostTime = Level.TimeSeconds + BoostTimeLeft;

        // Update ambient sound and corona
        BoostAmbient = class'gPlasmaBoostAmbient'.static.GetActor(Instigator, True);
        BoostAmbient.Lifespan = BoostTimeLeft;
        ClientSetBoostTime(BoostTimeLeft);
    }
}

final simulated function ClientSetBoostTime( float TimeLeft )
{
    BoostTime = Level.TimeSeconds + TimeLeft;
    BoostCorona.AddTime(TimeLeft);
}

final simulated function BeginCharging()
{
    if( BoostCorona != None )
        BoostCorona.BeginCharging();
}

final simulated function EndCharging()
{
    if( BoostCorona != None )
        BoostCorona.EndCharging(FMax(BoostTime - Level.TimeSeconds, 0));
}


// ============================================================================
//  Render
// ============================================================================

simulated function DrawWeapon(Canvas C)
{
    bDrawingFirstPerson = True;

    // Draw weapon
    C.DrawActor(self, False, False, DisplayFOV);

    // Draw corona
    if( BoostCorona != None && BoostCorona.FadeAlpha > 0 )
    {
        BoostCorona.SetLocation(GetBoneCoords('Glow').Origin);
        C.DrawActor(BoostCorona, False, False, DisplayFOV);
    }

    bDrawingFirstPerson = False;
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
    local HUDBase H;

    if( BoostTime > Level.TimeSeconds && PlayerController(Instigator.Controller) != None )
    {
        // Draw boost icon
        H = HUDBase(PlayerController(Instigator.Controller).MyHUD);
        if( H != None )
        {
            // Draw icon
            H.DrawSpriteWidget(C, BoostWidgetIcon);

            // Draw time
            BoostWidgetTime.Value = BoostTime - Level.TimeSeconds;
            H.DrawNumericWidget(C, BoostWidgetTime, class'HudCDeathmatch'.default.DigitsBig);
        }
    }
}

simulated function float ChargeBar()
{
    return FMin( 1, FireMode[1].HoldTime / gPlasmaFireAlt(FireMode[1]).ChargeTime );
}


// ============================================================================
// Boost
// ============================================================================

final simulated function bool SameTeam(Pawn A, Pawn B)
{
    return (Level.Game.bTeamGame
            && A != None
            && A.PlayerReplicationInfo != None
            && B != None
            && B.PlayerReplicationInfo != None
            && A.PlayerReplicationInfo.Team == B.PlayerReplicationInfo.Team);
}

final simulated function SetWeaponOverlay(Material mat, float time, bool override)
{
    SetOverlayMaterial(mat, time, override);
    if( ThirdPersonActor != None )
        ThirdPersonActor.SetOverlayMaterial(mat, time, override);
}


// ============================================================================
//  Effects
// ============================================================================

simulated function vector GetEffectStart()
{
    local Coords C;

    if( Instigator.IsFirstPerson() )
    {
        if( WeaponCentered() )
            return CenteredEffectStart();

        C = GetBoneCoords('Muzzle');
        return C.Origin + 32 * C.XAxis;
    }

    return Super.GetEffectStart();
}


// ============================================================================
//  Firing
// ============================================================================

simulated function bool StartFire(int Mode)
{
    local SquadAI S;
    local Bot B;
    local vector AimDir;

    // If instigator is a leader, make his AI squadmates boost him
    if( Role == ROLE_Authority
    && PlayerController(Instigator.Controller) != None
    && UnrealTeamInfo(Instigator.PlayerReplicationInfo.Team) != None )
    {
        S = UnrealTeamInfo(Instigator.PlayerReplicationInfo.Team).AI.GetSquadLedBy(Instigator.Controller);

        if( S != None )
        {
            AimDir = vector(Instigator.Controller.Rotation);

            for( B=S.SquadMembers; B!=None; B=B.NextSquadMember )
            {
                //gLog( "StartFire" @ B.PlayerReplicationInfo.PlayerName @ HoldSpot(B.GoalScript) );
                if( HoldSpot(B.GoalScript) == None
                &&  B.Pawn != None
                &&  gPlasmaGun(B.Pawn.Weapon) != None
                &&  B.Pawn.Weapon.FocusOnLeader(True) )
                {
                    //gLog( "StartFire2" @ B.Name @ HoldSpot(B.GoalScript) );
                    B.FireWeaponAt(Instigator);
                }
            }
        }
    }

    return Super.StartFire(Mode);
}


// ============================================================================
//  AI
// ============================================================================

function float RangedAttackTime()
{
    return 0.0;
}

function bool RecommendRangedAttack()
{
    local Bot B;

    // Keep moving
    return False;

    B = Bot(Instigator.Controller);
    if( B == None || B.Enemy == None )
        return True;

    // Move into range then stop and attack
    return gWeaponFire(FireMode[BotMode]).IsInTossRange(B.Enemy);
}

function bool RecommendLongRangedAttack()
{
    return False;
}

function bool FocusOnLeader(bool bLeaderFiring)
{
    local Bot B;
    local Pawn LeaderPawn;
    local Vehicle V;

    B = Bot(Instigator.Controller);

    if( B == None )
        return False;

    // Find leader

    // Try leader's vehicle
    V = B.Squad.GetLinkVehicle(B);

    if( V != None )
    {
        // Focus if can be healed
        bLeaderFiring = V.Health < V.HealthMax && V.LinkHealMult > 0 && (B.Enemy == None || V.bKeyVehicle);
        LeaderPawn = V;
    }
    else
    {
        // Try player leader
        if( PlayerController(B.Squad.SquadLeader) != None )
        {
            LeaderPawn = B.Squad.SquadLeader.Pawn;
        }
        // Try bot leader
        else
        {
            LeaderPawn = B.Squad.SquadLeader.Pawn;
        }

        if( LeaderPawn == None )
            return False;

        // Focus if can and want to be boosted
        if( gPlasmaGun(LeaderPawn.Weapon) != None &&  LeaderPawn.Weapon.IsFiring() )
            bLeaderFiring = True;
    }

    //gLog( "FocusOnLeader" @bLeaderFiring @ LeaderPawn.PlayerReplicationInfo.PlayerName );

    // Don't focus on leader if no reason to fire
    if( !bLeaderFiring )
        return False;

    // Don't focus on self
    if( LeaderPawn == B.Pawn )
        return False;

    // in range
    // and there's line of sight
    if( gWeaponFire(FireMode[BotMode]).IsInTossRange(LeaderPawn )
    &&  Instigator.Controller.LineOfSightTo(LeaderPawn) )
    {
        B.GoalString = "Boost";
        B.Focus = LeaderPawn;
        return True;
    }

    // Nothing to see here
    return False;
}

function SetAITarget(Actor T);

function byte BestMode()
{
    local float EnemyDist;
    local bot B;
    local Vehicle V;

    // No ammo, no mines
    if( AmmoAmount(1) < gPlasmaFireAlt(FireMode[1]).AmmoPerFire )
        return 0;

    // Default
    B = Bot(Instigator.Controller);
    if( B == None )
        return 0;

    // Objective
    if( ((DestroyableObjective(B.Squad.SquadObjective) != None && B.Squad.SquadObjective.TeamLink(B.GetTeamNum()) )
        || (B.Squad.SquadObjective == None && DestroyableObjective(B.Target) != None && B.Target.TeamLink(B.GetTeamNum())) )
        && VSize(B.Squad.SquadObjective.Location - B.Pawn.Location) < BoostRange
        && (B.Enemy == None || !B.EnemyVisible()) )
        return 0;

    // Boost leader
    if( FocusOnLeader(B.Focus == B.Squad.SquadLeader.Pawn) )
        return 0;

    // Key/SquadLeader vehicle
    V = B.Squad.GetLinkVehicle(B);
    if( V != None
        &&  VSize(Instigator.Location - V.Location) < BoostRange
        &&  V.Health < V.HealthMax
        &&  V.LinkHealMult > 0
        &&  B.LineOfSightTo(V) )
        return 0;

    // MoveTarget vehicle
    V = Vehicle(B.MoveTarget);
    if( V != None &&  V == B.Target )
        return 0;

    // Enemy
    if( B.Enemy == None )
    {
        return 1;
    }
    else
    {
        EnemyDist = VSize(B.Enemy.Location - Instigator.Location);
//      if( EnemyDist < 512 )
//          return 1;
    }

    return 0;
}

function float SuggestAttackStyle()
{
    local Bot B;
    local float EnemyDist;
    local vector EnemyDelta;

    //gLog("SuggestAttackStyle");

    B = Bot(Instigator.Controller);
    if( B != None )
    {
        // Stand still if no enemy
        if( B.Enemy == None )
            return 0.0;

        EnemyDelta = B.Enemy.Location - Instigator.Location;
        EnemyDist = VSize(EnemyDelta);

        // Retreat if too close
        if( EnemyDist < 384 )
        {
            //gLog( "SuggestAttackStyle: BACK" @MaxRange @EnemyDist );
            return -1.0;
        }

        if( !gWeaponFire(FireMode[BotMode]).IsInTossRange( B.Enemy ) )
        {
            //gLog( "SuggestAttackStyle: NOT IN RANGE" @MaxRange @EnemyDist );
            return 10.0;
        }
    }

    // Approach slowly
    return 0.1;
}

function float SuggestDefenseStyle()
{
    return SuggestAttackStyle();
}

function bool ShouldFireWithoutTarget()
{
    local ONSPowerCore OPC;

    // Advanced AI required
    return False;

    // No ammo, no mines
    if(AmmoAmount(1) < gPlasmaFireAlt(FireMode[1]).AmmoPerFire )
        return False;

    // Advanced AI required!
    //return False;

    // Plant mines on pathnodes around powernode
    if( ShootTarget(Instigator.Controller.Target) != None )
    {
        OPC = ONSPowerCore(Instigator.Controller.Target.Owner);
        if( OPC != None && OPC.Shield.bHidden )
        {
            Instigator.Controller.Target = OPC.PathList[Rand(OPC.PathList.Length)].End;
            return Instigator.Controller.Target != None;
        }
    }

    return True;
}

function float GetAIRating()
{
    local Bot B;
    local DestroyableObjective O;
    local Vehicle V;

    B = Bot(Instigator.Controller);

    if( B == None )
        return AIRating;

    // Plant mines
    if( B.Formation( )
        &&  B.Squad.SquadObjective != None
        &&  B.Squad.SquadObjective.BotNearObjective(B) )
    {
        return 2.0;
    }

    if( PlayerController(B.Squad.SquadLeader) != None
        &&  B.Squad.SquadLeader.Pawn != None
        &&  gPlasmaGun(B.Squad.SquadLeader.Pawn.Weapon) != None )
        return 2.0;

    V = B.Squad.GetLinkVehicle(B);
    if( V != None
        &&  VSize(Instigator.Location - V.Location) < 1.5 * BoostRange
        &&  V.Health < V.HealthMax
        &&  V.LinkHealMult > 0 )
        return 2.0;

    if( Vehicle(B.RouteGoal) != None
        &&  B.Enemy == None
        &&  VSize(Instigator.Location - B.RouteGoal.Location) < 1.5 * BoostRange
        &&  Vehicle(B.RouteGoal).TeamLink(B.GetTeamNum()) )
        return 2.0;

    O = DestroyableObjective(B.Squad.SquadObjective);
    if( O != None
        &&  B.Enemy == None
        &&  O.TeamLink(B.GetTeamNum())
        &&  O.Health < O.DamageCapacity
        &&  VSize(Instigator.Location - O.Location) < 1.1 * BoostRange && B.LineOfSightTo(O) )
        return 2.0;

    return AIRating * FMin(Pawn(Owner).DamageScaling, 1.5);
}

function bool CanAttack(Actor Other)
{
    local float CheckDist;
    local vector HitLocation, HitNormal,X,Y,Z, projStart;
    local actor HitActor;
    local int m;
    local bool bInstantHit;

    if( Instigator == None || Instigator.Controller == None )
        return False;

    // check that target is within range
    if( !gWeaponFire(FireMode[BotMode]).IsInTossRange(Other) )
        return False;

    // check that can see target
    if( !Instigator.Controller.LineOfSightTo(Other) )
        return False;

    for( m=0; m<NUM_FIRE_MODES; m++ )
    {
        if( FireMode[m].bInstantHit )
        {
            bInstantHit = True;
        }
        else
        {
            CheckDist = FMax(CheckDist, 0.5 * FireMode[m].ProjectileClass.Default.Speed);
            CheckDist = FMax(CheckDist, 300);
            CheckDist = FMin(CheckDist, VSize(Other.Location - Location));
        }
    }
    // check that would hit target, and not a friendly
    GetAxes(Instigator.Controller.Rotation, X, Y, Z);
    projStart = GetFireStart(X, Y, Z);

    if( bInstantHit )
    {
        HitActor = Trace(HitLocation, HitNormal, Other.Location + Other.CollisionHeight * vect(0,0,0.8), projStart, True);
    }
    else
    {
        // for non-instant hit, only check partial path (since others may move out of the way)
        HitActor = Trace(HitLocation, HitNormal,
                projStart + CheckDist * Normal(Other.Location + Other.CollisionHeight * vect(0,0,0.8) - Location),
                projStart, True);
    }

    if( HitActor == None || HitActor == Other )
        return True;

    if( Pawn(HitActor) == None )
        return !HitActor.BlocksShotAt(Other);

    if( Pawn(HitActor).Controller == None || !Instigator.Controller.SameTeamAs(Pawn(HitActor).Controller) )
        return True;

    return False;
}

function bool CanHeal(Actor Other)
{
    if( DestroyableObjective(Other) != None && DestroyableObjective(Other).LinkHealMult > 0 )
        return True;

    if( Vehicle(Other) != None && Vehicle(Other).LinkHealMult > 0 )
        return True;

    return False;
}



// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gPlasmaGun
    BoostTimePerDmg         = 0.1
    BoostRange              = 4096
    BoostDmgAtten           = 1.65

    BoostWidgetIcon         = (WidgetTexture=Texture'G_FX.Plasmafx.Icon_Boost1',PosX=0.95,PosY=0.6,OffsetX=0,OffsetY=0,DrawPivot=DP_MiddleMiddle,RenderStyle=STY_Alpha,TextureCoords=(X1=0,Y1=0,X2=128,Y2=128),TextureScale=0.5,ScaleMode=SM_Right,Scale=1.000000,Tints[0]=(G=255,R=255,B=255,A=255),Tints[1]=(G=255,R=255,B=255,A=255))
    BoostWidgetTime         = (RenderStyle=STY_Alpha,TextureScale=0.49,DrawPivot=DP_MiddleMiddle,PosX=0.95,PosY=0.6,OffsetX=0,OffsetY=0,Tints[0]=(B=255,G=255,R=255,A=255),Tints[1]=(B=255,G=255,R=255,A=255))

    BoostCoronaClass        = class'GEffects.gPlasmaBoostCorona'


    // gWeapon
    CostWeapon              = 400
    CostAmmo                = 100
    ItemSize                = 3
    bSpecialDrawWeapon      = True

    BotPurchaseProbMod      = 5


    // Weapom
    bShowChargingBar        = True
    AIRating                = 2.6
    CurrentRating           = 2.6

    FireModeClass(0)        = class'gPlasmaFire'
    FireModeClass(1)        = class'gPlasmaFireAlt'
    AttachmentClass         = class'gPlasmaAttachment'
    PickupClass             = class'gPlasmaPickup'

    ItemName                = "Plasma Gun"
    Description             = "A plasma weapon that fires decompressed balls of plasma at fast rate, and alt-fires a much more concentrated ball that has to be charged up before firing, which is capable of sticking to a surface while at it's peak temperature and becoming a mine. Plasma can also be used to give teammates a boost of power for their plasma weapons, as well as repair ruptured vehicles, structures, and energy-based equipment."

    DisplayFOV              = 80
    PlayerViewOffset        = (X=55,Y=25,Z=-33)
    PlayerViewPivot         = (Pitch=1024,Roll=0,Yaw=32768)
    EffectOffset            = (X=0,Y=0,Z=0)
    SmallViewOffset         = (X=55,Y=25,Z=-33)
    SmallEffectOffset       = (X=0,Y=0,Z=0)
    CenteredOffsetY         = 10
    CenteredYaw             = 888
    CenteredRoll            = 444

    SelectSound             = Sound'G_Sounds.grp_select_med'

    HudColor                = (R=159,G=64,B=191,A=255)
    IconCoords              = (X1=255,Y1=63,X2=445,Y2=125)


    // Actor
    bDynamicLight           = True
    LightType               = LT_Steady
    LightEffect             = LE_None
    LightBrightness         = 28
    LightHue                = 189
    LightSaturation         = 108
    LightPeriod             = 0
    LightRadius             = 4

    Mesh                    = Mesh'G_Anims.Plasma'
}
