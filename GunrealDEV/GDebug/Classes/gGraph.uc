// ============================================================================
//  gGraph.uc :: Dummy graph class
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGraph extends KVehicle
    cacheexempt;


simulated event Tick( float DeltaSeconds )
{
    //Disable('Tick');
}

simulated event PreBeginPlay()
{
}

simulated event PostBeginPlay()
{
    Log( "Initialized", name );
}

simulated event Destroyed()
{
    Log( "Destroyed", name );
}

simulated event PostNetBeginPlay()
{
}

event FellOutOfWorld( eKillZType KillType )
{
}


// ============================================================================
DefaultProperties
{
    Physics                     = PHYS_Karma
    bCollideActors              = False
    bCollideWorld               = False
    bProjTarget                 = False
    bBlockActors                = False
    bBlockNonZeroExtentTraces   = False
    bBlockZeroExtentTraces      = False
    bBlockPlayers               = False
    bWorldGeometry              = False
    bBlockKarma                 = False
    CollisionHeight             = 0
    CollisionRadius             = 0
    RemoteRole                  = ROLE_Autonomous
    DrawType                    = DT_None
    bTravel                     = False
    bShouldBaseAtStartup        = False
    bAcceptsProjectors          = False
    bLOSHearing                 = False
    bUpdateSimulatedPosition    = False
    bCanBeDamaged               = False
    bAlwaysTick                 = True
    bAlwaysRelevant             = True
    bGameRelevant               = True
    bNotOnDedServer             = True

    Begin Object Class=KarmaParamsCollision Name=KGraphParams
        Name="KGraphParams"
    End Object

    KParams=KarmaParamsCollision'KGraphParams'
}
