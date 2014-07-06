// ============================================================================
//  gTeleporterNode.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterNode extends gDynamicTeleporter;

var() float AcceptableDistance;
var() float MaximumDistance;
var() float DistancePenalty;

simulated function bool Accept( actor Incoming, Actor Source )
{
    local rotator newRot;
    local Controller P;

    if( Incoming == None )
        return False;

    // Move the actor here.
    Disable('Touch');
    newRot = Incoming.Rotation;

    if( Pawn(Incoming) != None )
    {
        //tell enemies about teleport
        if( Role == ROLE_Authority )
            for( P=Level.ControllerList; P!=None; P=P.NextController )
                if( P.Enemy == Incoming )
                    P.LineOfSightTo(Incoming);

        if( Role == ROLE_Authority )
        {
            if( Pawn(Incoming).PlayerReplicationInfo.HasFlag != None )
            {
                Pawn(Incoming).PlayerReplicationInfo.HasFlag.Drop(0.5 * Incoming.Velocity);
            }
        }

        if( !Pawn(Incoming).SetLocation(Location) )
        {
            log(self$" Teleport failed for "$Incoming);
            return False;
        }

        if( Role == ROLE_Authority
        ||  Level.TimeSeconds - LastFired > 0.5 )
        {
            newRot.Roll = 0;
            Pawn(Incoming).SetRotation(newRot);
            Pawn(Incoming).SetViewRotation(newRot);
            Pawn(Incoming).ClientSetRotation(newRot);
            LastFired = Level.TimeSeconds;
        }

        if( Pawn(Incoming).Controller != None )
        {
            Pawn(Incoming).Controller.MoveTimer = -1.0;
            Pawn(Incoming).Anchor = self;
            Pawn(Incoming).SetMoveTarget(self);
        }

        Incoming.PlayTeleportEffect(False, True);
    }
    else
    {
        if( !Incoming.SetLocation(Location) )
        {
            Enable('Touch');
            return False;
        }
    }
    Enable('Touch');


    return True;
}

event int SpecialCost( Pawn Other, ReachSpec Path )
{
    local int c;

    c = DebugSpecialCost(Other,Path);
    //Log( "SpecialCost" @Other.name @Path.Start.name @Path.End.name @c, name );
    return c;
}

function int DebugSpecialCost( Pawn Incoming, ReachSpec Path )
{
    local float Dist;

    // is this a teleport path?
    if( Teleporter(Path.Start) != None && Teleporter(Path.End) != None )
    {
        // vehicles can't teleport
        if( Vehicle(Incoming) != None )
            return 10000001;

        // flag carriers shouldn't even try
        if( Incoming.PlayerReplicationInfo.HasFlag != None )
            return 10000002;

        // it's a trap!
        if( !Level.Game.bTeamGame
        || (Instigator != None && Instigator.GetTeamNum() != Incoming.GetTeamNum()) )
            return 10000003;

        // if far away, ignore
        Dist = VSize(Path.Start.Location-Incoming.Location);
        if( Dist > MaximumDistance )
            return 10000004;

        // if not so far away, consider
        if( Dist > AcceptableDistance )
            return Dist * DistancePenalty;
    }

    return 0;
}


DefaultProperties
{
    bHidden                 = True
    AcceptableDistance      = 1024
    MaximumDistance         = 4096
    DistancePenalty         = 2
}
