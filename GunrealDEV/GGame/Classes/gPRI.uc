// ============================================================================
//  gPRI.uc :: Gunreal data attached to each PRI
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPRI extends LinkedReplicationInfo;


var   PlayerReplicationInfo     OwnerPRI;

var   protected int             Money;
var() int                       MoneyLimit;

var   float                     GlobalIncome;
var() float                     GlobalIncomeLimit;
var() float                     GlobalIncomePercent;

var() class<LocalMessage>       DonateMsgClass;

var   int                       OldTeam;
var   int                       NewTeam;

var() float                     SurvivalTimeBase;
var   gTimer					SurvivalTimer;
var   bool						bSurvivalBonus;
var() float						SurvivalBonus;

var   float                     NoKillTime;
var() float                     NoKillTimeBase;
var() float                     NoKillTimeLevel;
var() float                     NoKillLevelMax;


// ============================================================================
//  Replication
// ============================================================================

replication
{
    // Things the server should send to the clients.
    reliable if( bNetDirty && Role == Role_Authority )
        Money, bSurvivalBonus;

    // Functions the server can call on client.
    reliable if( Role == Role_Authority )
        ClientSetNoKillTime;

    // Functions the client can call on server.
    reliable if( Role < Role_Authority )
        DonateMoney;
}

simulated event PostNetReceive()
{
    if( Owner != None )
    {
        LinkGPRI();
        bNetNotify = False;
    }
}


// ============================================================================
//  Lifespan
// ============================================================================

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( Level.Game != None && Level.Game.IsA('xLastManStandingGame') )
        Money = default.Money + 1000;

    if( Owner != None )
    {
        LinkGPRI();
        bNetNotify = False;
    }
    
    if( Role == ROLE_Authority )
    {
    	SurvivalTimer = Spawn(class'gTimer');
    	SurvivalTimer.OnTimer = OnSurvivalBonus;
    }
}

simulated function LinkGPRI()
{
    if( gPlayer(Owner) != None )
        gPlayer(Owner).CachedGPRI = Self;
    else if( gBot(Owner) != None )
        gBot(Owner).CachedGPRI = Self;
}

function PawnPossessed(Pawn P)
{
    ResetSurvivalBonus();
    ResetNoKillMultiplier();
}

function PawnDied(Pawn P)
{
    TakeGlobalIncome();
    HaltSurvivalBonus();
    HaltNoKillMultiplier();
}


// ============================================================================
//  Survival Bonus
// ============================================================================

final simulated function ResetSurvivalBonus()
{
	bSurvivalBonus = False;
	SurvivalTimer.SetTimer(SurvivalTimeBase, False);
}

final simulated function HaltSurvivalBonus()
{
	bSurvivalBonus = False;
	SurvivalTimer.SetTimer(0, False);
}

final simulated function OnSurvivalBonus()
{
	bSurvivalBonus = True;
}

final simulated function float GetSurvivalBonus()
{
	return SurvivalBonus;
}



// ============================================================================
//  NoKill Multiplier
// ============================================================================

final simulated function DeductNoKillMultiplier()
{
    local float Multiplier;

    //gLog( "DeductNoKillMultiplier" );

    // Get deducted by 1 and 0-based multiplier
    Multiplier = GetNoKillMultiplier() - 2.0;

    // update only if it won't fall below lvl 1 bounds, otherwise reset
    if( Multiplier >= 0.0 )
    {
        // Update timer
        NoKillTime = Level.TimeSeconds - NoKillTimeBase - NoKillTimeLevel * int(Multiplier);
        ClientSetNoKillTime(NoKillTime - Level.TimeSeconds);
    }
    else
    {
        // Reset multiplier
        NoKillTime = Level.TimeSeconds;
        ClientSetNoKillTime();
    }
}

final simulated function ResetNoKillMultiplier()
{
    //gLog( "ResetNoKillMultiplier" );
    NoKillTime = Level.TimeSeconds;
    ClientSetNoKillTime();
}

final simulated function HaltNoKillMultiplier()
{
    //gLog( "HaltNoKillMultiplier" );
    NoKillTime = -1;
    ClientSetNoKillTime(,True);
}

final simulated function ClientSetNoKillTime( optional float DeltaTime, optional bool bHalt )
{
    //gLog( "ClientSetNoKillTime" #DeltaTime #bHalt );

    if( bHalt )
        NoKillTime = -1;
    else
        NoKillTime = Level.TimeSeconds + DeltaTime;
}

final simulated function float GetNoKillMultiplier()
{
    if( NoKillTime >= 0 && Level.TimeSeconds - NoKillTime > NoKillTimeBase )
        return 1.0 + FMin((Level.TimeSeconds - NoKillTime - NoKillTimeBase) / NoKillTimeLevel, NoKillLevelMax - 1.0);
    return 1.0;
}

final simulated function float GetNoKillMultiplierTime()
{
    if( NoKillTime >= 0 )
        return Level.TimeSeconds - NoKillTime;
    return -1.0;
}


// ============================================================================
//  Money
// ============================================================================

protected function AddMoney(float M, optional class<LocalMessage> MessageClass, optional PlayerReplicationInfo OtherPRI, optional Object O, optional bool bNoIncome, optional bool bQuiet)
{
    //gLog("AddMoney" #M);

    if( Messageclass == class'gMessageMoneyKill' )
    {
        M *= GetNoKillMultiplier();
        M += GetSurvivalBonus();
    }

    if( MessageClass != class'gMessageMoneyBonus'
    &&  MessageClass != class'gMessageMoneyGive'
    &&  MessageClass != class'gMessageMoneyShop'
    &&  MessageClass != class'gMessageShopWarranty' )
    {
        if( PlayerController(Owner) != None && gPawn(PlayerController(Owner).Pawn) != None )
        {
            if( gPawn(PlayerController(Owner).Pawn).BonusMode == BM_Money )
                M *= 1.3;
        }
    }

    Money += M;

    /*if( !bNoIncome )
        ShareGlobalIncome(M, MessageClass);*/

	if( Money > MoneyLimit )
	{
		if( Messageclass != class'gMessageMoneyExcess' )
			DistributeExcessMoney(Money-MoneyLimit);
    	Money = MoneyLimit;
	}

    if( PlayerController(Owner) != None && MessageClass != None && !bQuiet )
        PlayerController(Owner).ReceiveLocalizedMessage(MessageClass, M, OwnerPRI, OtherPRI, O);

    NetUpdateTime = Level.TimeSeconds - 1;
}

protected function DistributeExcessMoney(float Amount)
{
	local Controller C;
	local array<Controller> Players;
	local gPRI GPRI;
	local int i, Share;

	// see if allowed
	if( !Level.Game.bTeamGame )
		return;

	For( C=Level.ControllerList; C!=None; C=C.NextController )
	{
		if( C != Owner && C.PlayerReplicationInfo != None && C.PlayerReplicationInfo.Team == Controller(Owner).PlayerReplicationInfo.Team )
		{
			Players[Players.Length] = C;
		}
	}

	if( Players.Length == 0 )
		return;
	
	Share = int(Amount) / Players.Length;
	if( Share == 0 )
		return;
		
	for( i=0; i<Players.Length; ++i )
	{
		GPRI = GetGPRI(Players[i].PlayerReplicationInfo);
		if( GPRI != None )
		{
			GPRI.AddMoney(Share, class'gMessageMoneyExcess', Controller(Owner).PlayerReplicationInfo );
		}
	}
}

protected function RemoveMoney(float M, optional class<LocalMessage> MessageClass, optional PlayerReplicationInfo OtherPRI, optional Object O, optional bool bNoIncome, optional bool bQuiet)
{
    Money -= Abs(M);

    if( PlayerController(Owner) != None && MessageClass != None && !bQuiet )
        PlayerController(Owner).ReceiveLocalizedMessage(MessageClass, M, OwnerPRI, OtherPRI, O);

    NetUpdateTime = Level.TimeSeconds - 1;
}

function UpdateMoney(float M, optional class<LocalMessage> MessageClass, optional PlayerReplicationInfo OtherPRI, optional Object O, optional bool bNoIncome, optional bool bQuiet)
{
    if( M >= 0 )
        AddMoney(M, MessageClass, OtherPRI, O, bNoIncome, bQuiet);
    else
        RemoveMoney(M, MessageClass, OtherPRI, O, bNoIncome, bQuiet);
}

simulated final function int GetMoney()
{
    return Money;
}

function DonateMoney(int PlayerID, int Amount)
{
    local PlayerReplicationInfo PRI;
    local gPRI OtherGPRI;

    if( Money <= 0 )
        return;

    if( Amount == 0 )
        Amount = MoneyLimit;
        
    if( !AllowDonate(Level.GRI) )
    	return;

    PRI = Level.GRI.FindPlayerByID(PlayerID);
    if( PRI != None )
    {
        if( Level.GRI.bTeamGame && PRI.Team != OwnerPRI.Team )
            return;

        OtherGPRI = GetGPRI(PRI);
        if( OtherGPRI != None )
        {
            Amount = Min(Amount, Money-1);
            UpdateMoney(-Amount, DonateMsgClass, PRI);
            OtherGPRI.UpdateMoney(Amount, DonateMsgClass, OwnerPRI);
        }
    }
}

static simulated function bool AllowDonate(GameReplicationInfo G)
{
    if( G != None )
    {
    	if( G.bTeamGame )
    		return true;
    		
    	if( InStr(Caps(G.GameClass), "INVASION") != -1 )
    		return true;
    }
	return false;
}


// ============================================================================
//  LinkedReplicationInfo
// ============================================================================

static final function gPRI GetGPRI(PlayerReplicationInfo PRI)
{
    local LinkedReplicationInfo L;

    if( PRI != None )
    {
        for( L=PRI.CustomReplicationInfo; L!=None; L=L.NextReplicationInfo )
        {
            if( gPRI(L) != None )
                return gPRI(L);
        }
    }

    return None;
}

static function gPRI SpawnGPRI(PlayerReplicationInfo PRI)
{
    //local LinkedReplicationInfo L;
    local gPRI GPRI;

    //log("SpawnGPRI" @PRI);

    // Spawn then add to LRI list
    if( PRI != None )
    {
        /*for( L=PRI.CustomReplicationInfo; L!=None; L=L.NextReplicationInfo )
            if( gPRI(L) != None )
                return gPRI(L);*/

        GPRI = GetGPRI(PRI);
        if( GPRI != None )
            return GPRI;

        GPRI = PRI.Spawn(default.class, PRI.Owner);
        GPRI.NextReplicationInfo = PRI.CustomReplicationInfo;
        GPRI.OwnerPRI = PRI;
        PRI.CustomReplicationInfo = GPRI;
    }

    return GPRI;
}

static function DestroyGPRI(PlayerReplicationInfo PRI)
{
    local LinkedReplicationInfo L;
    local gPRI GPRI;

    //log("DestroyGPRI" @PRI);

    // Remove from LRI list and destroy
    if( PRI != None )
    {
        GPRI = gPRI(PRI.CustomReplicationInfo);
        if( GPRI != None )
        {
            PRI.CustomReplicationInfo = GPRI.NextReplicationInfo;
            GPRI.Destroy();
        }
        else
        {
            for( L=PRI.CustomReplicationInfo; L!=None; L=L.NextReplicationInfo )
            {
                GPRI = gPRI(L.NextReplicationInfo);
                if( GPRI != None )
                {
                    L.NextReplicationInfo = GPRI.NextReplicationInfo;
                    GPRI.Destroy();
                    return;
                }
            }
        }
    }
}


// ============================================================================
//  Global Income
// ============================================================================

function TakeGlobalIncome()
{
    UpdateMoney(FMin(GlobalIncome, GlobalIncomeLimit), class'gMessageMoneyGlobal', OwnerPRI,, True);
    GlobalIncome = 0;
}

function ShareGlobalIncome( float Income, optional class<LocalMessage> MessageClass )
{
    local Controller P;
    local int NumPlayers, Count;
    local gPRI GPRI;
    local float PercentIncome, OverflowIncome;
    local float PercentReceived, OverflowReceived, TotalReceived;

    if( Money > MoneyLimit )
    {
        NumPlayers = Level.Game.NumPlayers + Level.Game.NumBots;

        OverflowIncome = Money - MoneyLimit;
        PercentIncome = Income - OverflowIncome;

        PercentReceived = PercentIncome * GlobalIncomePercent;
        OverflowReceived = OverflowIncome  / float(NumPlayers);

        TotalReceived = PercentReceived + OverflowReceived;
    }
    else
    {
        NumPlayers = 1;

        OverflowIncome = 0;
        PercentIncome = Income;

        PercentReceived = PercentIncome * GlobalIncomePercent;
        OverflowReceived = 0;

        TotalReceived = PercentReceived;
    }

    gLog( "ShareGlobalIncome"
        #OwnerPRI.PlayerName #GON(MessageClass)
        #GlobalIncome
        #(PercentIncome @OverflowIncome)
        #(PercentReceived @OverflowReceived)
        #TotalReceived
        #NumPlayers #Money);

    // TODO: perform this in batch only when TakeGlobalIncome() is called?
    for( P=Level.ControllerList; P!=None; P=P.nextController )
    {
        if( P.bIsPlayer && P.PlayerReplicationInfo != None && !P.PlayerReplicationInfo.bOnlySpectator )
        {
            ++Count;
            GPRI = GetGPRI(P.PlayerReplicationInfo);
            if( GPRI != None )
            {
                GPRI.GlobalIncome += TotalReceived;
            }
        }
    }

    if( OverflowReceived > 0 && Count != NumPlayers )
        gLog( "ShareGlobalIncome :: Count != NumPlayers" #Count #NumPlayers );
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
    SurvivalTimeBase            = 180
    SurvivalBonus				= 200

    NoKillTimeBase              = 120
    NoKillTimeLevel             = 30
    NoKillLevelMax              = 5

    RemoteRole                  = ROLE_SimulatedProxy
    bAlwaysRelevant             = True
    bNetNotify                  = True

    Money                       = 1600
    MoneyLimit                  = 10000
    GlobalIncomeLimit           = 500
    GlobalIncomePercent         = 0.05

    DonateMsgClass              = class'gMessageMoneyGive'

    OldTeam                     = -1
}
