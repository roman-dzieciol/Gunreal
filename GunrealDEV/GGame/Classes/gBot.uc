// ============================================================================
//  gBot.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gBot extends InvasionBot dependsOn(gWeapon);

var gPRI CachedGPRI;

var gShopInfo ShopInfo;
/*
struct SAvoidInfo
{
    gAvoidMarker    M;
    bool            bAware;
    float           LastTime;
    float           LOSTime;
};

var float NotifyAvoidTime;
*/

var float LastFearTime;
var Actor Mine;
var bool bStartleMine;
var float UncrouchTime;

var rotator LastViewRotation;
var() float SmoothTurnSpeed;

var int MultiKillLevel;
var float LastKillTime;

var bool bUseShopping;

var   gTurret                   Turret;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S );



// ============================================================================
//  Lifespan
// ============================================================================
simulated event PreBeginPlay()
{
    Super.PreBeginPlay();
    if( bDeleteMe )
        return;

    if( InstagibCTF(Level.Game) == None )
    {
        bUseShopping = True;
    }

    Enable('Tick');
}

function Reset()
{
    //gLog( "Reset" );
    if( ShopInfo != None )
        ShopInfo.PawnReset(Pawn);
    Super.Reset();
}

simulated event Destroyed()
{
    //gLog( "Destroyed" );

    if( ShopInfo != None )
        ShopInfo.Free();
    ShopInfo = None;

    Super.Destroyed();
}

event Tick( float DeltaTime )
{
    local gPawn P;

    P = gPawn(Pawn);
    if( P != None )
    {
        //gLog( "Tick AUTO CROUCH" #(Level.TimeSeconds-UncrouchTime) #Pawn.bIsCrouched #Pawn.Physics #Pawn.bWantsToCrouch #Pawn.bTryToUncrouch );
        // uncrouch if crouched in notifyHitWall
        if( Level.TimeSeconds > UncrouchTime )
        {
            if( P.bWantsToCrouch
            && !P.bTryToUncrouch )
                P.bWantsToCrouch = False;
        }

        // Make bot sprint whenever it can
        if( P.bIsWalking )
        {
            if( P.StaminaPoints > P.StaminaCostSprint )
                P.SetWalking(false);
        }
        else if( !P.bIsWalking )
        {

            if( P.Physics == PHYS_Walking && P.Acceleration != vect(0,0,0))
                P.StaminaDrain -= P.StaminaCostSprint;
            if( P.StaminaPoints <= 0 )
                P.SetWalking(true);
        }

        P.UpdateStamina(DeltaTime);
    }
}

function InitPlayerReplicationInfo()
{
    Super.InitPlayerReplicationInfo();

    if( ShopInfo == None && bUseShopping )
        ShopInfo = new(self) class'gShopInfoBot';
}


// ============================================================================
//  Hit avoidance
// ============================================================================
event DelayedWarning()
{
    local vector X,Y,Z, Dir, LineDist, FuturePos, HitLocation, HitNormal;
    local actor HitActor;
    local float dist;

    //gLog( "DelayedWarning" #gPawn(Pawn).BonusMode );
    if( gPawn(Pawn) != None
    &&  gPawn(Pawn).BonusMode == BM_Shield
    && (FRand() < 0.4 + 0.5*(FMin(0,Skill) / 7.0))
    &&  WarningProjectile != None
    && (Normal((WarningProjectile.Location - Pawn.Location) * vect(1,1,0)) dot Normal(vector(Rotation) * vect(1,1,0)) > 0.7) )
    {
        gPawn(Pawn).ShieldUse();
    }

    if( (Pawn == None) || (WarningProjectile == None) || (WarningProjectile.Velocity == vect(0,0,0)) )
        return;

    if( Enemy == None )
    {
        Squad.SetEnemy(self, WarningProjectile.Instigator);
        return;
    }

    // check if still on target, else ignore

    Dir = Normal(WarningProjectile.Velocity);
    FuturePos = Pawn.Location + Pawn.Velocity * VSize(WarningProjectile.Location - Pawn.Location)/VSize(WarningProjectile.Velocity);
    LineDist = FuturePos - (WarningProjectile.Location + (Dir Dot (FuturePos - WarningProjectile.Location)) * Dir);
    dist = VSize(LineDist);
    if( dist > 230 + Pawn.CollisionRadius )
        return;


    if( dist > 1.2 * Pawn.CollisionHeight )
    {
        if( WarningProjectile.Damage <= 40 )
            return;

        if( (WarningProjectile.Physics == PHYS_Projectile) && (dist > Pawn.CollisionHeight + 100) && !WarningProjectile.IsA('ShockProjectile') )
        {
            HitActor = Trace(HitLocation, HitNormal, WarningProjectile.Location + WarningProjectile.Velocity, WarningProjectile.Location, False);
            if( HitActor == None )
                return;
        }
    }

    GetAxes(Pawn.Rotation,X,Y,Z);
    X.Z = 0;
    Dir = WarningProjectile.Location - Pawn.Location;
    Dir.Z = 0;

    // make sure still looking at projectile
    if( (Normal(Dir) Dot Normal(X)) < 0.7 )
        return;

    // decide which way to duck
    if( (WarningProjectile.Velocity Dot Y) > 0 )
    {
        Y *= -1;
        TryToDuck(Y, True);
    }
    else
        TryToDuck(Y, False);
}


/* Receive warning now only for instant hit shots and vehicle run-over warnings */
function ReceiveWarning(Pawn shooter, float projSpeed, vector FireDir)
{
    local float enemyDist, projTime;
    local vector X,Y,Z, enemyDir;
    local bool bResult;

    //gLog("ReceiveWarning" #shooter #projSpeed );

    LastUnderFire = Level.TimeSeconds;

    // AI controlled creatures may duck if not falling
    if( Pawn.bStationary || !Pawn.bCanStrafe || (Pawn.health <= 0) )
        return;

    //gLog( "ReceiveWarning" #gPawn(Pawn).BonusMode );
    if( gPawn(Pawn) != None
    &&  gPawn(Pawn).BonusMode == BM_Shield
    && (FRand() < 0.4 + 0.5*(FMin(0,Skill) / 7.0))
    && (Normal((Shooter.Location - Pawn.Location) * vect(1,1,0)) dot Normal(vector(Rotation) * vect(1,1,0)) > 0.7) )
    {
        gPawn(Pawn).ShieldUse();
    }

    if( Enemy == None )
    {
        Squad.SetEnemy(self, shooter);
        return;
    }
    if( (Skill < 4) || (Pawn.Physics == PHYS_Falling) || (Pawn.Physics == PHYS_Swimming )
        || (FRand() > 0.2 * skill - 0.33) )
        return;

    enemyDist = VSize(shooter.Location - Pawn.Location);

    if( (enemyDist > Skill*1000) && Vehicle(shooter) == None && !Stopped() )
        return;

    // only if tight FOV
    GetAxes(Pawn.Rotation,X,Y,Z);
    enemyDir = shooter.Location - Pawn.Location;
    enemyDir.Z = 0;
    X.Z = 0;
    if( (Normal(enemyDir) Dot Normal(X)) < 0.7 )
        return;


    if( projSpeed > 0 && Vehicle(shooter) == None )
    {
        projTime = enemyDist/projSpeed;
        if( projTime < 0.11 + 0.15 * FRand() )
        {
            if( Stopped() && (Pawn.MaxRotation == 0) )
                GotoState('TacticalMove');
            return;
        }
    }

    if( FRand() * (Skill + 4) < 4 )
    {
        if( Stopped() && (Pawn.MaxRotation == 0) )
            GotoState('TacticalMove');
        return;
    }

    if( (FireDir Dot Y) > 0 )
    {
        Y *= -1;
        bResult = TryToDuck(Y, True);
    }
    else
        bResult = TryToDuck(Y, False);

    if( bResult && projspeed > 0 && Vehicle(shooter) != None )
    {
        bNotifyApex = True;
        bPendingDoubleJump = True;
    }

    // FIXME - if duck fails, try back jump if splashdamage landing
}


// ============================================================================
//  Messages
// ============================================================================
function YellAt(Pawn Moron)
{
    if( Invasion(Level.Game) != None )
    {
        if ( (Enemy != None) || (FRand() < 0.7) )
            return;

        SendMessage(None, 'FRIENDLYFIRE', 0, 5, 'TEAM');
    }
    else
    {
        Super(Bot).YellAt(Moron);
    }
}

function bool AllowVoiceMessage(name MessageType)
{
    if( Invasion(Level.Game) != None )
    {
        if ( Level.TimeSeconds - OldMessageTime < 3 )
            return false;
        else
            OldMessageTime = Level.TimeSeconds;

        return true;
    }
    else
    {
        return Super(Bot).AllowVoiceMessage(MessageType);
    }
}

// ============================================================================
//  Senses
// ============================================================================
event SeeMonster(Pawn Seen)
{
    local Pawn CurrentEnemy;

    if( Seen == Turret )
        return;

    if( Invasion(Level.Game) != None )
    {
        CurrentEnemy = Enemy;

        if( !Seen.bAmbientCreature )
            SeePlayer(Seen);

        if( Enemy != None )
        {
            if(  CurrentEnemy == None )
            {
                if( InvasionSquad(Squad).IncomingWave != Invasion(Level.Game).WaveNum )
                {
                    SendMessage(None, 'OTHER', 14, 12, 'TEAM');
                    InvasionSquad(Squad).IncomingWave = Invasion(Level.Game).WaveNum;
                }
            }
            else if( CurrentEnemy != Enemy && Pawn.Health < 80 && LineOfSightTo(CurrentEnemy) )
            {
                if( InvasionSquad(Squad).bHeavyAttack )
                    SendMessage(None, 'OTHER', 21, 12, 'TEAM');
                else
                    SendMessage(None, 'OTHER', 22, 12, 'TEAM');
                InvasionSquad(Squad).bHeavyAttack = !InvasionSquad(Squad).bHeavyAttack;
            }
        }
    }
    else
    {
        Super(Bot).SeeMonster(Seen);
    }
}

// ============================================================================
//  Pathnoding hacks - makes pathnoding use UT sizes instead of Gunreal ones
// ============================================================================

final function HackFakeCollision()
{
    //gLog("FAKE Collision" #Pawn.CollisionRadius #Pawn.CollisionHeight );

    if( Pawn != None )
    {
        Pawn.CrouchHeight = class'xPawn'.default.CrouchHeight;
        Pawn.CrouchRadius = class'xPawn'.default.CrouchRadius;
    }
}

final function HackRealCollision()
{
    //gLog("REAL Collision" #Pawn.CollisionRadius #Pawn.CollisionHeight );

    if( Pawn != None )
    {
        Pawn.CrouchHeight = class'gPawn'.default.CrouchHeight;
        Pawn.CrouchRadius = class'gPawn'.default.CrouchRadius;
    }
}

function bool FindBestPathToward(Actor A, bool bCheckedReach, bool bAllowDetour)
{
    local bool bResult;

    HackFakeCollision();
    //gLog( "FindBestPathToward ?" #bResult #GON(A) #bCheckedReach #bAllowDetour);
    bResult = Super.FindBestPathToward(A, bCheckedReach, bAllowDetour);
    //gLog( "FindBestPathToward !" #bResult #GON(A) #bCheckedReach #bAllowDetour);
    HackRealCollision();
    return bResult;
}

function bool PickRetreatDestination()
{
    local bool bResult;

    HackFakeCollision();
    bResult = Super.PickRetreatDestination();
    //gLog( "PickRetreatDestination" #bResult);
    HackRealCollision();
    return bResult;
}


function bool FindRoamDest()
{
    local bool bResult;

    HackFakeCollision();
    bResult = Super.FindRoamDest();
    //gLog( "FindRoamDest" #bResult);
    HackRealCollision();
    return bResult;
}


state Hunting
{
ignores EnemyNotVisible;

    function PickDestination()
    {
        HackFakeCollision();
        Super.PickDestination();
        //gLog( "PickDestination");
        HackRealCollision();
    }
}

state Scripting
{
    function SetMoveTarget()
    {
        HackFakeCollision();
        Super.SetMoveTarget();
        //gLog( "SetMoveTarget");
        HackRealCollision();
    }
}

event bool NotifyHitWall(vector HitNormal, actor Wall)
{
    local bool bResult;
    local vector Dir, Offset, Extent, HL, HN;

    bResult = Super.NotifyHitWall(HitNormal,Wall);
    //gLog( "NotifyHitWall" #HitNormal #Wall #(HitNormal dot Normal(Pawn.Acceleration)));
    if( bResult )
        return True;

    if( Wall != None
    && !Pawn.bIsCrouched
    &&  Pawn.bCanCrouch
    &&  Pawn.Physics == PHYS_Walking
    /*&& (Normal(HitNormal*vect(1,1,0)) dot Normal(Pawn.Acceleration*vect(1,1,0)) < -0.7)*/ )
    {
        Dir = Normal(Pawn.Acceleration*vect(1,1,0));
        Offset = (Pawn.CrouchHeight - Pawn.CollisionHeight) *  vect(0,0,1);
//        Extent = Pawn.CrouchRadius * vect(1,1,0) + Pawn.CrouchHeight * vect(0,0,1);

        //A = Trace( HL, HN, Pawn.Location + Offset + Pawn.CollisionRadius*Dir, Pawn.Location + Offset, True, Extent );
        //if( A != None )
        if( Wall.TraceThisActor(HL, HN, Pawn.Location + Offset + Pawn.CollisionRadius*Dir, Pawn.Location + Offset, Extent) )
        {
            //gLog( "NotifyHitWall AUTO CROUCH");
            Pawn.bWantsToCrouch = True;
            UncrouchTime = Level.TimeSeconds + 0.33;
            return True;
        }
    }

    return False;
}


// ============================================================================
//  Feat spot avoidance
// ============================================================================

function FearThisSpot(AvoidMarker aSpot)
{
    local int i;

    if( Pawn == None )
        return;

    for( i=0; i<ArrayCount(FearSpots); ++i )
    {
        if( FearSpots[i] == None )
        {
            FearSpots[i] = aSpot;
            return;
        }
    }

    for( i=0; i<ArrayCount(FearSpots); ++i )
    {
        if( VSize(Pawn.Location - FearSpots[i].Location) > VSize(Pawn.Location - aSpot.Location) )
        {
            FearSpots[i] = aSpot;
            return;
        }
    }
}

function AvoidMine( Actor M, bool bStartle )
{
    Mine = M;
    bStartleMine = bStartle;
    GotoState('AvoidingMine');
}

function TryToDodge()
{
}

event MayDodgeToMoveTarget()
{
}

state AvoidingMine
{
    ignores EnemyNotVisible,SeePlayer,HearNoise;

    event Timer()
    {
    }

    function AvoidMine( Actor M, bool bStartle )
    {
    }

    function Startle(Actor Feared)
    {
    }

    event BeginState()
    {
        Pawn.bIsWalking = False;
        Pawn.bWantsToCrouch = False;
        Pawn.Acceleration = vect(0,0,0);

        if( !CanAttack(Mine) )
            SwitchToBestWeapon();
    }

Begin:
    //if( bStartleMine )
    //{
        Pawn.bIsWalking = False;
        Pawn.bWantsToCrouch = False;
        Pawn.Acceleration = Pawn.Location - Mine.Location;
        TryToDodge();
        Sleep(0.5);
    //}

Shoot:
    if( Mine != None )
    {
        Target = Mine;
        Focus = Target;
        if( NeedToTurn(Target.Location) )
        {
            FinishRotation();
        }

        Target = Mine;
        Focus = Target;
        SwitchToBestWeapon();

        if( FireWeaponAt(Target) )
        {
            Sleep(fmax(0.2,Pawn.RefireRate()));
            Goto('Shoot');
        }
    }

End:
    WhatToDoNext(11);
    Goto('Begin');
}


// ============================================================================
//  Pawn
// ============================================================================

function Possess(Pawn P)
{
    Super.Possess(P);

    if( ShopInfo != None )
        ShopInfo.PawnPossessed();
    //ShopInfo.BuyPending();

    //SwitchToBestWeapon();
}

function PawnDied(Pawn P)
{
    local gPRI GPRI;

    GPRI = GetGPRI();
    if( GPRI != None )
        GPRI.TakeGlobalIncome();

    // When pawn is Destroyed()
    //CreateShoppingList();
    if( ShopInfo != None )
        ShopInfo.PawnDied();

    Super.PawnDied(P);
}


function SetPawnClass( string inClass, string inCharacter )
{
    local class<xPawn> pClass;

    if( inClass != "" )
    {
        pClass = class<xPawn>(DynamicLoadObject(inClass, class'class', True));
        if( pClass != None )
            PawnClass = pClass;
    }

    // Replace xPawns with gPawns
    // See also GameInfo.RestartPlayer() and UnrealTeamInfo.AddToTeam()
    if( PawnClass != None && PawnClass.name == 'xPawn' )
        PawnClass = default.PawnClass;

    PawnSetupRecord = class'xUtil'.static.FindPlayerRecord(inCharacter);
    PlayerReplicationInfo.SetCharacterName(inCharacter);
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


// ============================================================================
//  Pickups
// ============================================================================

function bool FindSuperPickup(float MaxDist)
{
    //gLog( "FindSuperPickup" #MaxDist );
    return False;
}


function bool NeedWeapon()
{
    local Inventory Inv;

    if( Vehicle(Pawn) != None )
        return False;

    if( gWeapon(Pawn.Weapon) != None
    &&  gWeapon(Pawn.Weapon).ItemSize > 1
    &&  gWeapon(Pawn.Weapon).NeedAmmo(0) )
        return True;

    for( Inv=Pawn.Inventory; Inv!=None; Inv=Inv.Inventory )
        if( gWeapon(Inv) != None && gWeapon(Inv).ItemSize > 1 && !gWeapon(Inv).NeedAmmo(0) )
            return False;

    return True;
}

event float Desireability(Pickup P)
{
    if( gTerminal(P) != None )
    {
        if( GetGPRI().GetMoney() > 300 )
            return P.BotDesireability(Pawn);
    }
    else
    {
        //gLog( "Desireability" #GON(P) );
        if( class<gWeapon>(P.InventoryType) == None
        ||  gPawn(Pawn) == None
        ||  gPawn(Pawn).PawnInventory.WillWeaponFit(class<gWeapon>(P.InventoryType)) )
            return P.BotDesireability(Pawn);
    }
    return 0;
}

event float SuperDesireability(Pickup P)
{
    //gLog( "SuperDesireability" #GON(P) );
    // Called by Controller.FindBestSuperPickup() ?
    return 0;
}

function TryCombo(string ComboName)
{
    //gLog( "TryCombo" #NeedsAdrenaline()  );
    if( !Pawn.InCurrentCombo() && !NeedsAdrenaline() )
    {
        if( gPawn(Pawn) != None && Pawn.Base != None && Pawn.Base.bWorldGeometry )
        {
            gPawn(Pawn).TurretUse();
        }
    }
}

// ============================================================================
//  Shopping
// ============================================================================

function StartShopping( Actor A )
{
    if( ShopInfo != None )
    {
        StopFiring();
        ShopInfo.Begin(A);
        GotoState('Shopping');
    }
}

state Shopping
{
ignores SeePlayer, HearNoise, KilledBy, NotifyBump, Bump, HitWall, Falling, TakeDamage, ReceiveWarning, EnemyNotVisible;

    function bool Stopped()
    {
        return True;
    }

    event DelayedWarning() {}

    function SwitchToBestWeapon() {}

    function WhatToDoNext(byte CallingByte)
    {
    }

    function Celebrate()
    {
    }

    function SetAttractionState()
    {
    }

    function EnemyChanged(bool bNewEnemyVisible)
    {
    }

    function WanderOrCamp(bool bMayCrouch)
    {
    }

    function StartShopping( Actor A )
    {
    }

    event BeginState()
    {
        //gLog( "BeginState" );
        Super.BeginState();

        // Freeze
        StopStartTime = Level.TimeSeconds;
        Pawn.Acceleration = vect(0,0,0);
        Pawn.bCanJump = False;
        Focus = None;
    }

    event EndState()
    {
        //gLog( "EndState" );
        Super.EndState();
        ShopInfo.End(None);

        if( Pawn != None && Pawn.JumpZ > 0 )
            Pawn.bCanJump = True;
    }

Begin:

    // Pretend we're buying
    Sleep(2.0 + FRand()*3.0);
    ShopInfo.BuyRecommended();
    ShopInfo.End(None);

    // Get off the pad
    if( Pawn != None )
    {
        if( Pawn.JumpZ > 0 )
            Pawn.bCanJump = True;
        Pawn.bIsWalking = False;
        Pawn.bWantsToCrouch = False;
        Pawn.Acceleration = VRand() * vect(1,1,0);
        TryToDodge();
        Sleep(0.5);
    }

    GotoState('Roaming');
}

// ============================================================================
//  STATE Charging
// ============================================================================

state Charging
{
ignores SeePlayer, HearNoise;

Begin:
    if( Pawn.Physics == PHYS_Falling )
    {
        Focus = Enemy;
        Destination = Enemy.Location;
        WaitForLanding();
    }
    if( Enemy == None )
        WhatToDoNext(16);
    if( !FindBestPathToward(Enemy, False,True) )
        DoTacticalMove();
Moving:
    if( Pawn.Weapon.bMeleeWeapon && ShieldGun(Pawn.Weapon) != None ) // FIXME HACK
        FireWeaponAt(Enemy);
    MoveToward(MoveTarget,FaceActor(1),,ShouldStrafeTo(MoveTarget));
    WhatToDoNext(17);
    if( bSoaking )
        SoakStop("STUCK IN CHARGING!");
}


// ============================================================================
//  Spectating
// ============================================================================

// AdjustView() called if Controller's pawn is viewtarget of a player
function AdjustView(float DeltaTime)
{
    Super(Controller).AdjustView(DeltaTime);
    SmoothBotRotation(DeltaTime);
}

final function SmoothBotRotation(float DeltaTime)
{
    local float Alpha;
    local rotator TargetRotation, ViewRotation;
    local vector TargetPoint;

    TargetRotation = Rotation;
    if( Pawn != None )
    {
        if( NavigationPoint(Focus) != None )
            TargetPoint = Focus.Location + FClamp(Pawn.CollisionHeight - Focus.CollisionHeight,-32,32)*vect(0,0,1);
        else if( Focus != None )
            TargetPoint = Focus.Location;
        else
            TargetPoint = FocalPoint;

        TargetRotation.Pitch = rotator(TargetPoint - Pawn.Location).Pitch;
    }

    Alpha = FClamp((SmoothTurnSpeed * DeltaTime) / (acos(vector(TargetRotation) dot vector(LastViewRotation))/PI),0,1);
    if( Alpha == Alpha && Alpha + 1.0 != Alpha ) // NaN & Inf check
    {
        ViewRotation = QuatToRotator(QuatSlerp( QuatFromRotator(LastViewRotation), QuatFromRotator(TargetRotation), Alpha ));
        ViewRotation.Roll = 0;

        //Log("SmoothBotRotation" #DeltaTime #Angle #FAngle #Alpha #GON(Focus) #Rotation.Pitch #TargetRotation.Pitch #ViewRotation.Pitch);
        SetRotation( ViewRotation );
    }
    LastViewRotation = ViewRotation;
}



// ============================================================================
//  MultiKills
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


// ============================================================================
//  Debug
// ============================================================================


function DisplayDebug(Canvas Canvas, out float YL, out float YPos)
{
    local gPRI GPRI;

    GPRI = GetGPRI();

    Super.DisplayDebug(Canvas,YL, YPos);

    Canvas.SetDrawColor(255,255,255);

    if( GPRI != None )
    {
        YPos += YL;
        Canvas.SetPos(4,YPos);
        Canvas.DrawText("Money" @GPRI.GetMoney());
    }

    YPos += YL;
    Canvas.SetPos(4,YPos);
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
    PawnClass = class'GGame.gPawn'
    SmoothTurnSpeed = 1.0
}
