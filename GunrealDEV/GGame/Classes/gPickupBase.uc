// ============================================================================
//  gPickupBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPickupBase extends xPickUpBase
    abstract;


var   Actor             ReplacedActor;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
}


// ============================================================================
//  Replication
// ============================================================================

replication
{
    reliable if( bNetInitial && Role == ROLE_Authority )
        ReplacedActor;
}

simulated event PostNetReceive()
{
    if( ReplacedActor != None )
    {
        SetReplaced(ReplacedActor);
        bNetNotify = False;
    }
}


// ============================================================================
//  PickupBase
// ============================================================================

simulated event PostBeginPlay()
{
    Super(Actor).PostBeginPlay();

    if( !bHidden && Level.NetMode != NM_DedicatedServer )
    {
        myEmitter = Spawn(SpiralEmitter,,,Location + vect(0,0,40));
        SetDrawScale(Default.DrawScale);
    }
}

simulated function SetReplaced(Actor A)
{
    local xPickUpBase PB;

    //Log("SetReplaced" @A);
    ReplacedActor = A;

    if( ReplacedActor != None )
    {
        Event = ReplacedActor.Event;
        Tag = ReplacedActor.Tag;

        SetLocation(A.Location);
        SetRotation(A.Rotation);

        if( xPickUpBase(A) != None )
        {
            PB = xPickUpBase(A);
            PB.PowerUp = None;
            PB.bHidden = True;
            PB.default.bHidden = True; // don't replicate bHidden

            if( PB.MyMarker != None )
            {
                MyMarker = PB.MyMarker;
                MyMarker.MarkedItem = myPickUp;
                MyMarker.MyPickupBase = self;
                PB.MyMarker = None;
            }

            if( myPickUp != None )
                myPickup.MyMarker = MyMarker;

            if( PB.myEmitter != None )
                PB.myEmitter.Destroy();
        }

        if( Level.NetMode != NM_Client )
        {
            SpawnPickup();
            if( bDelayedSpawn && myPickup != None )
            {
                if( myPickup.IsInState('Pickup') )
                    myPickup.GotoState( 'WaitingForMatch' );

                if( myPickup.myMarker != None )
                    myPickup.myMarker.bSuperPickup = True;
            }
        }
    }
}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    bDelayedSpawn               = True
    SpawnHeight                 = 40.0

    DrawScale                   = 0.5
    DrawType                    = DT_StaticMesh
    StaticMesh                  = StaticMesh'G_Meshes.Pickups.spawner_1'

    RemoteRole                  = ROLE_SimulatedProxy
    bNetNotify                  = True
    bAlwaysRelevant             = True
    bGameRelevant               = True
    bOnlyDirtyReplication       = True
    bStatic                     = False
    bNoDelete                   = False
    bReplicateMovement          = False
    bNetInitialRotation         = True
}