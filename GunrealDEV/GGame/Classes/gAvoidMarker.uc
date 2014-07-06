// ============================================================================
//  gAvoidMarker.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gAvoidMarker extends AvoidMarker;


struct SAvoidInfo
{
    var gPawn   Pawn;
    var gBot    Bot;
    var bool    bAware;
    var float   LastTime;
    var float   LOSTime;
};

var() array<SAvoidInfo> AvoidInfo;
var() float FieldRadius;
var   int FieldSize;
var() float LOSTimeout;
var() float LOSCurve;
var() float LOSSkillModifier;

var() float RelevantDist;
var() float WarnDist;
var() float StartleDist;

var() float PollRate;


// ============================================================================
//  AvoidMarker
// ============================================================================

event PostBeginPlay()
{
    local gAvoidMarker A;

    Super.PostBeginPlay();

    // Attach to owner
    if( Owner != None )
    {
        SetBase(Owner);
        SetTimer(PollRate,True);
        Disable('Touch');

        if( gProjectile(Owner) != None && gProjectile(Owner).InstigatorTeam != None )
            TeamNum = gProjectile(Owner).InstigatorTeam.TeamIndex;

        // Do not remove the brackets or the script will crash, lol.
        foreach CollidingActors(class'gAvoidMarker',A,FieldRadius)
        {
            ++FieldSize;
        }

        //gLog("FieldSize" #FieldSize);
    }
    else
        Destroy();
}

simulated event SetInitialState()
{
    //gLog("SetInitialState" );

    Super.SetInitialState();

    if( Owner != None )
        Disable('Touch');
}

event BaseChange()
{
    if( Base == None && !bDeleteMe )
        Destroy();
}

event Touch( Actor Other )
{
}

function bool RelevantTo(Pawn P)
{
    return( gBot(P.Controller) != None
        &&(!Level.Game.bTeamGame
        ||  P.Controller.PlayerReplicationInfo == None
        ||  P.Controller.PlayerReplicationInfo.Team == None
        ||  P.Controller.PlayerReplicationInfo.Team.TeamIndex != TeamNum) );
}

function WarnBot( gBot B )
{
    local gPawn P;
    local bool bStartle;

    if( gProjectile(Owner) == None )
    {
        Destroy();
        return;
    }

    P = gPawn(B.Pawn);
    bStartle = VSize(P.Location-Location) < StartleDist;

    //gLog("WarnBot" #bStartle #B.EnemyVisible() );

    B.AvoidMine(owner,bStartle);
}

event Timer()
{
    local gPawn P;
    local gBot B;
    local int i;
    local float TimeSeconds, Dist, TimeDelta, BotStupidity;//,Alpha;
    local SAvoidInfo AI;
    local vector Delta;

    TimeSeconds = Level.TimeSeconds;

    for( i=0; i<AvoidInfo.Length; ++i )
    {
        P = AvoidInfo[i].Pawn;
        B = AvoidInfo[i].Bot;
        TimeDelta = TimeSeconds - AvoidInfo[i].LastTime;

        // if invalid, remove
        if( B == None || P == None || B.Pawn != P || TimeDelta > LOSTimeout )
        {
            //gLog("remove" #P #TimeDelta );
            if( P != None )
                P.LastMarker = None;
            AvoidInfo.Remove(i--,1);
            continue;
        }

        P.LastMarker = self;
        Delta = Location-P.Location;
        Dist = VSize(Delta);

        if( Dist < RelevantDist )
        {
            if( AvoidInfo[i].bAware )
            {
                if( Dist < WarnDist
                &&  FastTrace(Location,P.Location)
                && (Delta dot vector(P.Rotation)) > 0.7 )
                    WarnBot(B);
            }
            else
            {
                if( FastTrace(Location,P.Location) && (Delta dot vector(P.Rotation)) > 0.7 )
                {
                    //gLog("tick" #AvoidInfo[i].LOSTime #TimeDelta );
                    if( Dist < WarnDist )
                    {
                        AvoidInfo[i].LOSTime -= TimeDelta;
                    }
                    else
                    {
                        AvoidInfo[i].LOSTime -= TimeDelta*0.5;
                    }

                    if( AvoidInfo[i].LOSTime <= 0 )
                    {
                        AvoidInfo[i].bAware = True;
                        //gLog("aware" #AI.LOSTime );
                        if( Dist < WarnDist )
                            WarnBot(B);
                    }
                }
                else
                {
                    //gLog("no los" #AvoidInfo[i].LOSTime #TimeDelta );
                }
            }
            AvoidInfo[i].LastTime = TimeSeconds;
        }
    }

    ForEach CollidingActors(class'gPawn', P, RelevantDist)
    {
        if( P.LastMarker != self && RelevantTo(P) )
        {
            AI.bAware = False;
            AI.LastTime = TimeSeconds;
            AI.Pawn = P;
            AI.Bot = gBot(P.Controller);

            BotStupidity = 1.0-(FClamp(AI.Bot.Skill,0,7)/7.0);
            AI.LOSTime = FRand() + BotStupidity*LOSSkillModifier;

            //gLog("add" #AI.LOSTime );

            AvoidInfo[AvoidInfo.Length] = AI;
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
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    PollRate                        = 0.33
    FieldRadius                     = 192

    LOSTimeout                      = 5
    LOSCurve                        = 2
    LOSSkillModifier                = 3.0

    RelevantDist                    = 1024
    WarnDist                        = 256
    StartleDist                     = 256

    CollisionRadius                 = 0
    CollisionHeight                 = 0
    bProjTarget                     = False
    bCollideActors                  = True
    bCollideWorld                   = False
    bBlockActors                    = False
    bBlockZeroExtentTraces          = True
    bBlockNonZeroExtentTraces       = True
    bUseCylinderCollision           = True
    bUseCollisionStaticMesh         = False
    bHardAttach                     = True
    bOnlyAffectPawns                = True
}
