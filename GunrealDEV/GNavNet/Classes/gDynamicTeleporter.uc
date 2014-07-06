// ============================================================================
//  gDynamicTeleporter.uc ::
//  Teleporter that can be added/linked/unlinked/removed at realtime
// ============================================================================
//  Compilation requires unconsting variables in NavigationPoint and ReachSpec
//  Always link to network after spawning
//  Calling RemoveLink() before destruction is redundant
//  Links *MUST* be symmetric!
// ============================================================================
class gDynamicTeleporter extends Teleporter;

var() float LinkWebDist;
var() float LinkMaxDist;
var() float LinkMergeAngle;

var name TempName;


// ============================================================================
//  LifeSpan
// ============================================================================
event PostBeginPlay()
{
    local NavigationPoint N;

    // Add to NavPoint linked list
    for( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
    {
        if( N.NextNavigationPoint == None )
        {
            N.NextNavigationPoint = self;
            break;
        }
    }

    AutoLink();

    Super.PostBeginPlay();
}

event Destroyed()
{
    local NavigationPoint N;
    local int i, j;
    local ReachSpec R;
    local array<NavigationPoint> Dirty;

    // Remove from NavPoint linked list
    for( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
    {
        if( N.NextNavigationPoint == self )
        {
            N.NextNavigationPoint = NextNavigationPoint;
            break;
        }
    }
    NextNavigationPoint = None;

    // Clear all reachspecs in this node
    for( i=0; i!=PathList.Length; ++i )
    {
        R = PathList[i];
        if( R != None )
        {
            // Remember which nodes need to be cleared
            if( R.Start != self )
                Dirty[Dirty.Length] = R.Start;
            if( R.End != self )
                Dirty[Dirty.Length] = R.End;

            R.Start = None;
            R.End = None;
        }
    }
    PathList.Length = 0;

    // Clear relevant links in other nodes
    for( j=0; j!=Dirty.Length; ++j )
    {
        N = Dirty[j];
        if( N != None )
        {
            for( i=0; i!=N.PathList.Length; ++i )
            {
                R = N.PathList[i];
                if( R != None && (R.Start == self || R.End == self) )
                {
                    R.Start = None;
                    R.End = None;
                    N.PathList.Remove(i--,1);
                }
            }
        }
    }

    Super.Destroyed();
}


// ============================================================================
//  Linking
// ============================================================================

function AutoLink()
{
    local gScout SC;
    local NavigationPoint N, BestNode;
    local float Dist, BestDist;

    SC = Spawn(class'gScout',,,Location);
    if( SC == None )
        return;

    BestDist = LinkMaxDist;

    // find within distance
    for( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
    {
        if( !N.bNotBased && gDynamicTeleporter(N) == None )
        {
            Dist = VSize(N.Location-Location);
            if( Dist < LinkWebDist )
            {
//                log( "near"
//                @(Dist < BestDist)
//                @(FastTrace(N.Location,Location))
//                @  SC.SetLocation(N.Location)
//                @  SC.MoveSmooth(Location-N.Location)
//                @  VSize(SC.Location-Location) < FMax(SC.CollisionRadius,SC.CollisionHeight) );

                // must be able to move from node to teleporter
                if( Dist < BestDist
                &&  FastTrace(N.Location,Location)
                &&  SC.SetLocation(N.Location)
                &&  SC.MoveSmooth(Location-N.Location)
                &&  VSize(SC.Location-Location) < FMax(SC.CollisionRadius,SC.CollisionHeight) )
                {
                    BestDist = Dist;
                    BestNode = N;
                }
            }
        }
    }

    // alternatively try to find anything
    if( BestNode == None )
    {
        for( N=Level.NavigationPointList; N!=None; N=N.NextNavigationPoint )
        {
            if( !N.bNotBased && gDynamicTeleporter(N) == None )
            {
                Dist = VSize(N.Location-Location);
                if( Dist > LinkWebDist )
                {
                    // must be able to move from node to teleporter
                    if( Dist < BestDist
                    &&  FastTrace(N.Location,Location)
                    &&  SC.SetLocation(N.Location)
                    &&  SC.MoveSmooth(Location-N.Location)
                    &&  VSize(SC.Location-Location) < FMax(SC.CollisionRadius,SC.CollisionHeight) )
                    {
                        BestDist = Dist;
                        BestNode = N;
                    }
                }
            }
        }
    }

    if( BestNode != None )
    {
        AddLink( BestNode, 1, BestDist );
    }

    SC.Destroy();
}

function bool AddLink( NavigationPoint Target, int Flags, float Dist )
{
    local ReachSpec To, From;
    local int i;
    local ReachSpec R;

    //Log( "AddLink" @Target @Flags @Dist );

    if( Target == None )
        return False;

    // Make sure such link doesn't exist already in this node
    for( i=0; i!=PathList.Length; ++i )
    {
        R = PathList[i];
        if( R != None && (R.Start == Target || R.End == Target) )
        {
            Warn( "Link already exists" @Target );
            return False;
        }
    }

    // Make sure such link doesn't exist already in target node
    for( i=0; i!=Target.PathList.Length; ++i )
    {
        R = Target.PathList[i];
        if( R != None && (R.Start == self || R.End == self) )
        {
            Warn( "Link already exists in target" @Target );
            return False;
        }
    }

    // Create ReachSpecs
    To = new(None) class'ReachSpec';
    From = new(None) class'ReachSpec';
    if( To == None || From == None )
    {
        Warn( "Failed to create ReachSpec for" @Target );
        return False;
    }

    // Init ReachSpec pointing to target
    To.Start = self;
    To.End = Target;
    To.Distance = Dist;
    To.reachFlags = Flags;
    To.bForced = True;
    To.CollisionRadius = 120;
    To.CollisionHeight = 120;
    PathList[PathList.Length] = To;

    // Init ReachSpec pointing to us
    From.Start = Target;
    From.End = self;
    From.Distance = Dist;
    From.reachFlags = Flags;
    From.bForced = True;
    From.CollisionRadius = 120;
    From.CollisionHeight = 120;
    Target.PathList[Target.PathList.Length] = From;

    return True;
}

function RemoveLink( NavigationPoint Target )
{
    local int i;
    local ReachSpec R;

    if( Target == None )
        return;

    // Clear relevant reachspecs in this node
    for( i=0; i!=PathList.Length; ++i )
    {
        R = PathList[i];
        if( R != None && (R.Start == Target || R.End == Target) )
        {
            R.Start = None;
            R.End = None;
            PathList.Remove(i--,1);
        }
    }

    // Clear relevant links in other node
    for( i=0; i!=Target.PathList.Length; ++i )
    {
        R = Target.PathList[i];
        if( R != None && (R.Start == self || R.End == self) )
        {
            R.Start = None;
            R.End = None;
            Target.PathList.Remove(i--,1);
        }
    }
}

function LinkTeleporters( string ThisTag, string OtherTag, Teleporter Other )
{
    if( Other == None )
    {
        Warn( "No Teleporter" @ThisTag @OtherTag @Other );
        return;
    }

    if( AddLink(Other, 288, 100 ) )
    {
        Tag = StringToName(ThisTag);
        URL = OtherTag;
        bEnabled = True;

        Other.URL = ThisTag;
        Other.Tag = StringToName(OtherTag);
        Other.bEnabled = True;

        SetCollision(True,False,False);
        Other.SetCollision(True,False,False);
    }
}




// ============================================================================
//  Helpers
// ============================================================================

function name StringToName( string S )
{
    SetPropertyText( "TempName", S );
    return TempName;
}

function Actor SpecialHandling(Pawn Other)
{
    return self;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    LinkMaxDist             = 8192
    LinkWebDist             = 1024
    LinkMergeAngle          = 0.87 // 30

    bStatic                 = False
    bNoDelete               = False
    bPropagatesSound        = False
    bCollideWhenPlacing     = False
    bHidden                 = False
    bCollideActors          = False
    bEnabled                = False
    bNeverUseStrafing       = True
    bForceNoStrafing        = True
}
