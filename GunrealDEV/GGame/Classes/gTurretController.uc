// ============================================================================
//  gTurretController.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurretController extends AIController;


static function PrecacheScan( gPrecacheScan S );

function AnimEnded();

function Possess(Pawn aPawn)
{
    super.Possess( aPawn );

    if( Level.NetMode != NM_Standalone )
    {
        Skill = 6;
        FocusLead = 0.000042;
    }
    else
    {
        Skill = Level.Game.GameDifficulty;

        if( Skill > 3 )
            FocusLead = (0.07 * FMin(Skill,7))/10000;
    }

    // SeeMonster Timer
    SetTimer(1.0,True);
}


simulated function int GetTeamNum()
{
    if( Vehicle(Pawn) != None )
        return Vehicle(Pawn).Team;

    return super.GetTeamNum();
}


event Timer()
{
    PollSeeMonster();
}

// Since SeeMonster apparently works only for bIsPlayer
final function PollSeeMonster()
{
    local Controller C, Best;
    local float BestDist;

    // For each controller
    for( C=Level.ControllerList; C!=None; C=C.NextController )
    {
        // Filter out all but non-friendly non-players
        if( !C.bIsPlayer && C != self && C.Pawn != None && (!Level.Game.bTeamGame || !SameTeamAs(C)) && CanSee(C.Pawn) )
        {
            // Closer is better
            if( Best == None || BestDist > VSize(Pawn.Location - C.Pawn.Location) )
            {
                Best = C;
                BestDist = VSize(Pawn.Location - C.Pawn.Location);
            }

            // Make visible monsters without enemy see us
            if( C.Enemy == None && C.CanSee(Pawn) )
            {
                C.SeePlayer(Pawn);
            }
        }
    }

    // See closest monster
    if( Best != None )
    {
        SeeMonster(Best.Pawn);
        Best.SeePlayer(Pawn);
    }
}

function bool IsTargetRelevant(Pawn Target)
{
    local float TargetDist, EnemyDist;
    //Log(Self @ "IsTargetRelevant" @ Target.GetHumanReadableName() @ Pawn.Owner.GetHumanReadableName());

    // Must be a living, visible pawn
    if( Target == None
    ||  Target.Health < 1
    ||  Target.Controller == gTurret(Pawn).Deployer
    ||  Target.Controller == None
    || !Pawn.LineOfSightTo(Target)
    ||  SameTeamAs(Target.Controller))
        return False;

    // Must be in sight radius
    TargetDist = VSize(Target.Location - Pawn.Location);
    if( TargetDist > Pawn.SightRadius )
        return False;

    // If we already have enemy
    if( Enemy != None && Target != Enemy )
    {
        // Target must be visibly closer than the enemy
        EnemyDist = VSize(Enemy.Location - Pawn.Location);
        if( TargetDist + 512 > EnemyDist )
            return False;

        // Target must not be behind us, unless it's much closer.
        if( TargetDist * (Normal(Target.Location-Pawn.Location) dot -vector(Pawn.Rotation) + 2.0)
        >   EnemyDist  * (Normal(Enemy.Location-Pawn.Location) dot -vector(Pawn.Rotation) + 2.0) )
            return False;
    }

    return True;
}

function rotator AdjustAim(FireProperties FiredAmmunition, vector projStart, int aimerror)
{
    if( FRand() < 0.45 && Enemy != None && Enemy.Controller != None )
        Enemy.Controller.ReceiveWarning(Pawn, -1, vector(Rotation));

    return Rotation;
}

function float GetWaitForTargetTime()
{
    return 0.5 + 1 * FRand();
}

function EngageTarget(Pawn Other)
{
    //gLog("EngageTarget" #GON(Other) #GON(Enemy) #GON(Target) );
    Enemy = Other;
    GotoState('Engaged');
}


// ============================================================================
//  STATE Opening
// ============================================================================
auto state Opening
{
Begin:
    Sleep(2);
    GotoState('Searching');
}


// ============================================================================
//  STATE Active
// ============================================================================
state Active
{
    event SeePlayer(Pawn SeenPlayer)
    {
        //gLog( "SeePlayer" #GON(SeenPlayer) );
        if( SeenPlayer != Enemy && IsTargetRelevant(SeenPlayer) )
        {
            EngageTarget(SeenPlayer);
        }
    }

    event SeeMonster(Pawn SeenMonster)
    {
        //gLog( "SeeMonster" #GON(SeenMonster) );
        if( SeenMonster != Enemy && IsTargetRelevant(SeenMonster) )
        {
            EngageTarget(SeenMonster);
        }
    }

    function DamageAttitudeTo(Pawn Other, float Damage)
    {
        //gLog( "DamageAttitudeTo" #GON(Other) #Damage );
        if( Damage > 0 && Other != Enemy && IsTargetRelevant(Other) && LineOfSightTo(Other) )
        {
            EngageTarget(Other);
        }
    }
}


// ============================================================================
//  STATE Searching
// ============================================================================
auto state Searching extends Active
{
    function BeginState()
    {
        //gLog("BeginState");
        Enemy = None;
        Focus = None;
        StopFiring();
        Enable('SeeMonster');
    }

Begin:
    FocalPoint = Pawn.Location + 1000 * vector(gTurret(Pawn).OriginalRotation);
    FinishRotation();
    Sleep(2);
    Goto('Begin');
}


// ============================================================================
//  STATE Engaged
// ============================================================================
state Engaged extends Active
{
    function EnemyNotVisible()
    {
        //gLog("EnemyNotVisible" #GON(Enemy) #GON(Target) );
        if( IsTargetRelevant( Enemy ) )
        {
            Focus = None;
            FocalPoint = LastSeenPos;
        }
        GotoState('WaitForTarget');
    }

    function BeginState()
    {
        //gLog("BeginState");
        bFire = 1;
        if( Pawn.Weapon != None )
            Pawn.Weapon.BotFire(false);
    }

Begin:
    Focus = Enemy.GetAimTarget();
    Target = Enemy;
    FinishRotation();
    Sleep(1.0);
    if( !IsTargetRelevant(Enemy) || !Pawn.IsFiring() )
        GotoState('WaitForTarget');
    Goto('Begin');
}


// ============================================================================
//  STATE WaitForTarget
// ============================================================================
State WaitForTarget extends Active
{
    function BeginState()
    {
        //gLog("BeginState");
        Target = Enemy;
        bFire = 1;
        if( Pawn.Weapon != None )
            Pawn.Weapon.BotFire(false);
    }

Begin:
    Sleep( GetWaitForTargetTime() );
    GotoState('Searching');
}


// ============================================================================
//  STATE GameEnded
// ============================================================================
state GameEnded
{
ignores SeePlayer, HearNoise, KilledBy, NotifyBump, HitWall, NotifyPhysicsVolumeChange, NotifyHeadVolumeChange, Falling, TakeDamage, ReceiveWarning;

    event BeginState()
    {
        if( Pawn != None )
        {
            if( Pawn.Weapon != None )
                Pawn.Weapon.HolderDied();
            Pawn.SimAnim.AnimRate = 0;
            Pawn.TurnOff();
            Pawn.UnPossessed();
            Pawn = None;
        }

        // Die in next tick
        if( !bIsPlayer )
            Lifespan = 0.001;
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
    RotationRate            = (Pitch=16384,Yaw=16384,Roll=0)
    AcquisitionYawRate      = 16384
    bSlowerZAcquire         = False
}