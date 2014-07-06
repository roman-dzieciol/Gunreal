// ============================================================================
//  gDestroyerBeamInfo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerBeamInfo extends gActor
    dependson(gDestroyerNode);


// - Beam behavior ------------------------------------------------------------

var() float Speed;
var() float LifeDist;
var() byte Tesselation;
var() float ControlDistNode;
var() vector CollisionExtent;
var() float FixedTickDelta;
var() bool bDebugVerifyNodes;

var   bool bReleased;
var   float NodeLifespan;
var   float TesselationDelta;
var   float FixedTickAccum;
var   float TimeElapsed;
var   vector OldFireLoc;
var   rotator OldFireRot;
var   int NodeID;

var   gDestroyerScout Scout;

var   gDestroyerNode NodeFirst;       // First node
var   gDestroyerNode NodeLast;        // Last node
var   gDestroyerNode NodeFirstFree;   // First non-anchor node
var   gDestroyerNode SplineFirst;     // First spline node
var   gDestroyerNode SplineLast;      // Last spline node


// - Beam drawing -------------------------------------------------------------

var() bool bDrawBeam;

var() bool bDebugDraw;
var() bool bDebugDrawBeam;
var() bool bDebugDrawBeamNodes;
var() bool bDebugDrawSpline;
var() bool bDebugDrawSplineControls;

var() float DebugCrossSize;

var() color ColorNode;
var() color ColorNode2;
var() color ColorSpline;
var() color ColorSpline2;
var() color ColorSplineControl;
var() color ColorSegment;
var() color ColorSegment2;


// - Effects ------------------------------------------------------------------

var() class<Projector> ScorchClass;
var() float MinScorchDist;
var   vector OldScorchLoc;

var() class<Emitter> HitEffectClass;
var() float MinHitDist;
var   vector HitEffectLocation;

var() class<gDestroyerBeamEmitter> BeamEmitterClass;
var   array<gDestroyerBeamEmitter> BeamEmitters;

var() class<gDestroyerDispEmitter> DispEmitterClass;
var   array<gDestroyerDispEmitter> DispEmitters;

var() class<Emitter> FlashEffectClass;
var   Emitter FlashEffect;


// - Beam damage --------------------------------------------------------------

var() class<DamageType> BeamDamageType;
var() float BeamDamageSeconds;
var() float BeamDamageTimer;
var() float BeamDamagePerSecond;

var   Actor CachedHitActor;
var   gDestroyerDOT CachedDestroyerTimer;



/*  TODO
    - beam emitter bounding box?
*/


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.ScorchClass);
    S.PrecacheObject(default.HitEffectClass);
    S.PrecacheObject(default.BeamEmitterClass);
    S.PrecacheObject(default.DispEmitterClass);
}


// ============================================================================
//  Replication
// ============================================================================
replication
{
    reliable if( Role == ROLE_Authority )
        bReleased;
}


// ============================================================================
//  Lifespan
// ============================================================================
simulated event PreBeginPlay()
{
}

simulated event PostBeginPlay()
{
    //gLog( "PostBeginPlay" );

    Super.PostBeginPlay();

    if( Role == ROLE_Authority )
    {
        // Init coords cache on server
        if( Instigator != None && gDestroyer(Instigator.Weapon) != None )
        {
            gDestroyerFireAlt(gDestroyer(Instigator.Weapon).GetFireMode(1)).GetFireCoords(OldFireLoc, OldFireRot);
            SetLocation(OldFireLoc);
            SetRotation(OldFireRot);
        }
    }
    else
    {
        // Init coords cache on clients
        OldFireLoc = Location;
        OldFireRot = Rotation;
    }

    // Init constants
    NodeLifespan = LifeDist / Speed;
    FixedTickAccum = FixedTickDelta;
    TesselationDelta = 1.0 / float(Tesselation);

    // Create first node
    AddAnchorNode();

    // Spawn collision scout
    Scout = Spawn(class'gDestroyerScout');
}

simulated event PostNetBeginPlay()
{
    // Init coords cache on clients
    if( Role != ROLE_Authority )
    {
        OldFireLoc = Location;
        OldFireRot = Rotation;
    }
}

simulated event Destroyed()
{
    local int i;

    //gLog( "Destroyed" );

    Super.Destroyed();

    // Clear debug lines
    ClearStayingDebugLines();

    // Free nodes
    class'gDestroyerNodePool'.static.ReleaseNodeRange(NodeFirst, NodeLast);
    NodeFirst = None;
    NodeLast = None;
    NodeFirstFree = None;
    SplineFirst = None;
    SplineLast = None;

    // Remove Beam emitters
    for( i=0; i<BeamEmitters.Length; ++i )
        BeamEmitters[i].Destroy();
    BeamEmitters.Length = 0;

    // Remove Dispersion emitters
    for( i=0; i<DispEmitters.Length; ++i )
        DispEmitters[i].Trigger(self,instigator);
    DispEmitters.Length = 0;

    // Remove Flash
    if( FlashEffect != None )
    {
        FlashEffect.Kill();
        FlashEffect = None;
    }

    // Remove Scout actor
    if( Scout != None )
        Scout.Destroy();
}


// ============================================================================
//  Construction
// ============================================================================

final simulated function Release()
{
    local int i;

    //gLog( "Release" );

    if( bDebugVerifyNodes )
    {
        assert(NodeFirst != None);
        assert(NodeFirst.bAnchor);
        assert(!bReleased);
    }

    // If there are at least two nodes, release the beam
    if( NodeFirst.Next != None )
    {
        // Remove Flash
        if( FlashEffect != None )
        {
            FlashEffect.Kill();
            FlashEffect = None;
        }

        // Make anchor node normal
        NodeFirstFree = NodeFirst;
        NodeFirst.bAnchor = False;
        NodeFirst.Age = NodeFirst.Next.Age - FixedTickDelta;
        NodeFirst.Dir = NodeFirst.Next.Dir;
        NodeFirst.LocationStart = NodeFirst.Next.LocationStart;

        // Release
        bReleased = True;
        NetUpdateTime = Level.TimeSeconds - 1;

        // Reset the anchor disp emitter
        for( i=0; i<DispEmitters.Length; ++i )
        {
            if( DispEmitters[i].bHidden )
            {
                DispEmitters[i].bHidden = False;
                DispEmitters[i].SoundVolume = DispEmitters[i].default.SoundVolume;
                DispEmitters[i].Reset();
            }
        }

        if( bDebugVerifyNodes )
            DebugVerifyNodes("Release");
    }
    // otherwise destroy
    else
    {
        Destroy();
    }
}

final simulated function AddAnchorNode()
{
    if( bDebugVerifyNodes )
    {
        assert(NodeFirst == None);
        assert(NodeLast == None);
    }

    // Create first node
    NodeFirst = class'gDestroyerNodePool'.static.GetNode();
    NodeFirst.Init( True, Location, vector(Rotation) );
    NodeFirst.Next = None;
    NodeFirst.Prev = None;
    NodeFirst.ID = -1;
    NodeLast = NodeFirst;

    if( bDebugVerifyNodes )
        DebugVerifyNodes("AddAnchorNode");
}


final simulated function gDestroyerNode AddNode( vector nLocation, vector nDir )
{
    local gDestroyerNode Node;

    //gLog( "AddNode" );

    // Create node
    Node = class'gDestroyerNodePool'.static.GetNode();
    Node.Init( False, nLocation, nDir );
    Node.ID = NodeID++;
    NodeFirstFree = Node;

    // Mark every Tesselation'th node as spline node
    if( Node.ID++ % Tesselation == 0 )
    {
        if( SplineLast == None )
            SplineLast = Node;

        if( SplineFirst != None )
            SplineFirst.PrevSpline = Node;

        Node.NextSpline = SplineFirst;
        SplineFirst = Node;
    }

    // If nodes found, prepend node
    if( NodeFirst != None )
    {
        // If anchor present, add as second
        if( NodeFirst.bAnchor )
        {
            // If at least two nodes present
            if( NodeFirst.Next != None )
            {
                Node.Next = NodeFirst.Next;
                Node.Prev = NodeFirst;
                NodeFirst.Next.Prev = Node;
                NodeFirst.Next = Node;
            }
            // If only anchor node present
            else
            {
                assert(NodeLast == NodeFirst);
                Node.Next = NodeFirst.Next;
                Node.Prev = NodeFirst;
                NodeFirst.Next = Node;
                NodeLast = Node;
            }
        }
        // If anchor not present, add as first
        else
        {
            Node.Next = NodeFirst;
            Node.Prev = None;
            NodeFirst.Prev = Node;
            NodeFirst = Node;
        }
    }
    // If nodes not found, assert
    // Beam should have been destroyed when last node was released
    else if( bDebugVerifyNodes )
    {
        gLog( "AddNode NO BEAM" );
        DumpBeam(Node);
        assert(False);
    }

    if( bDebugVerifyNodes )
        DebugVerifyNodes("AddNode");

    return Node;
}


// ============================================================================
//  Simulatiom
// ============================================================================

simulated event Tick( float DeltaTime )
{
    local gDestroyerNode Node;
    local Quat NewQuat, OldQuat;
    local vector FireLoc, V,X,Y,Z;
    local rotator FireRot, R, SR;
    local float Alpha, OldFixedTickAccum;

    if( bDebugVerifyNodes )
        DebugVerifyNodes("Tick");

    // Reset hit effect limiter
    HitEffectLocation = vect(0,0,0);

    if( Role == ROLE_Authority )
    {
        // On server update location and rotation from weapon
        if( !bReleased && Instigator != None && gDestroyer(Instigator.Weapon) != None )
        {
            gDestroyerFireAlt(gDestroyer(Instigator.Weapon).GetFireMode(1)).GetFireCoords(FireLoc, FireRot);
            SetRotation(FireRot);
            SetLocation(FireLoc);
        }
    }
    else
    {
        // On client release when server says so
        if( bReleased && NodeFirst != None && NodeFirst.bAnchor )
        {
            Release();
        }
    }

    // Do fixed time tick
    FixedTickAccum += DeltaTime;
    if( FixedTickAccum >= FixedTickDelta )
    {
        // If firing grab old rotation
        if( !bReleased )
        {
            OldQuat = QuatFromRotator(OldFireRot);
            NewQuat = QuatFromRotator(Rotation);
            AlignQuatWith(OldQuat,NewQuat);
        }

        // Subdivide tick into as many as neccesary
        OldFixedTickAccum = FixedTickAccum;
        while( FixedTickAccum >= FixedTickDelta )
        {
            FixedTickAccum -= FixedTickDelta;

            if( !bReleased )
            {
                // Interpolate smoothly target location and rotation
                Alpha = 1.0 - (FixedTickAccum / OldFixedTickAccum);
                V = OldFireLoc + Normal(Location-OldFireLoc) * VSize(Location-OldFireLoc) * Alpha;
                R = QuatToRotator( QuatSlerp( OldQuat, NewQuat, Alpha ) );
                GetAxes(R,X,Y,Z);

                // Apply slight wavey rotation pattern
                TimeElapsed += FixedTickDelta;
                SR.Yaw = float(192) * (sin(TimeElapsed*10.0));
                SR.Pitch = float(160) * (cos((TimeElapsed+pi*0.5)*15));
                SR.Roll = 0;
                GetAxes(SR,X,Y,Z);
                R = OrthoRotation(X>>R, Y>>R, Z>>R);

                // Create node
                Node = AddNode(V,vector(R));
            }

            // Update node age
            DoAging(FixedTickDelta);
            if( bDeleteMe )
                return;

            // Move nodes
            DoMovement(FixedTickDelta);

            // Calc spline points and move around non-spline nodes
            DoSpline();

            // Check collision
            DoCollision(FixedTickDelta);
        }

        // Coords cache
        if( !bReleased )
        {
            OldFireLoc = V;
            OldFireRot = R;
        }
    }

    // Don't draw the beam on server
    if( Level.NetMode != NM_DedicatedServer )
    {
        if( bDebugDraw )
            DrawDebugBeam();

        if( bDrawBeam )
            DrawBeam();
    }
}

final simulated function DoAging(float DeltaTime)
{
    local gDestroyerNode Node, PrevNode;

    // Age nodes starting from first non-anchor node
    Node = NodeFirstFree;
    while( Node != None )
    {
        // Age node
        Node.Age += DeltaTime;

        // Remove if age exceeded
        if( Node.Age > NodeLifespan )
        {
            PrevNode = Node.Prev;

            // Remove only if there will be at least two nodes left, otherwise destroy the beam
            if( PrevNode != None && PrevNode != NodeFirst )
            {
                // Update spline list
                while( SplineLast != None && SplineLast.ID <= Node.ID )
                {
                    SplineLast = SplineLast.PrevSpline;
                    if( SplineLast != None )
                    {
                        SplineLast.NextSpline = None;
                    }
                    else
                    {
                        SplineFirst = None;
                    }
                }

                // Remove old nodes
                class'gDestroyerNodePool'.static.ReleaseNodeRange(Node, NodeLast);
                NodeLast = PrevNode;
                NodeLast.Next = None;

                if( bDebugVerifyNodes )
                    DebugVerifyNodes("Aging");
            }
            else
            {
                Destroy();
            }

            return;
        }

        Node = Node.Next;
    }
}

final simulated function DoMovement(float DeltaTime)
{
    local gDestroyerNode Node;

    // Update nodes starting from first non-anchor node
    Node = NodeFirstFree;
    while( Node != None )
    {
        // Update location
        Node.LocationOld = Node.Location;
        Node.Location += Node.Dir * Speed * DeltaTime;
        //Node.Location = Node.LocationStart + Node.Dir * Speed * Node.Age;

        Node = Node.Next;
    }

    // Update anchor node location
    if( NodeFirst.bAnchor )
    {
        NodeFirst.Dir = vector(Rotation);
        NodeFirst.Location = Location;

        if( Pawn(Owner) != None && Level.NetMode != NM_DedicatedServer )
        {
            if( Pawn(Owner).IsFirstPerson() && Pawn(Owner).Weapon != None )
            {
                NodeFirst.Location = Pawn(Owner).Weapon.GetBoneCoords('Muzzle').Origin;
            }
            else if( gPawn(Owner).WeaponAttachment != None && Level.TimeSeconds - gPawn(Owner).WeaponAttachment.LastRenderTime < 0.1 )
            {
                NodeFirst.Location = gPawn(Owner).WeaponAttachment.GetBoneCoords('Muzzle').Origin;
            }
        }

        NodeFirst.LocationOld = Location;
    }
}

final simulated function DoCollision( float DeltaTime )
{
    local gDestroyerNode Node, NextNode, PrevNode;
    local vector TL, HL, HN;
    local Actor A;

    // TODO: make sure all beam fragments are at least two nodes big

    Scout.SetLocation(NodeFirst.Location);
    Scout.SetCollision(True,False);

    // Anchor remains attached so check its collision every time
    if( NodeFirst != None && NodeFirst.bAnchor )
    {
        NodeFirst.Collision = BC_None;
    }

    Node = NodeFirst;
    while( Node != None )
    {
        NextNode = Node.Next;
        PrevNode = Node.Prev;

        // Check collision for nodes that didn't collided yet
        if( Node.Collision == BC_None )
        {
            // Teleport the scout
            Scout.SetLocation(Node.Location);

            // Get previous location
            TL = Node.LocationOld;

            // Debug collision
            //DrawStayingDebugLine(TL, Node.Location, 255, 0, 0);
            //if( Role == ROLE_Authority )
            //{
            //    Spawn(class'gCoordsEmitterNet',,,TL, rotator(Node.Location-TL));
            //}

            // See if it went through something
            A = Scout.Trace(HL, HN, Node.Location, TL, True, CollisionExtent);
            if( A != None )
            {
                if( A.bWorldGeometry )
                {
                    HitWorld(Node, HL,HN);
                }
                else if( A != Instigator )
                {
                    HitActor(A, Node, HL, HN);
                }
            }

            // If didn't collided, try touching actors
            if( Node.Collision == BC_None )
            {
                // See if node is touching something
                foreach Scout.TouchingActors(class'Actor',A)
                {
                    if( A.bWorldGeometry )
                    {
                        HitWorld(Node, Node.Location, -Node.Dir);
                    }
                    else if( A != Instigator )
                    {
                        HitActor(A, Node, Node.Location, -Node.Dir);
                    }
                }
            }
        }

        Node = NextNode;
    }

    Scout.SetCollision(False,False);
}

final simulated function HitActor(Actor A, gDestroyerNode Node, vector HL, vector HN)
{
    // If potentially damageable actor
    if( A.bCanBeDamaged || A.bProjTarget || A.bWorldGeometry || A.bBlockActors )
    {
        // Mark collision
        Node.Collision = BC_Actor;
        Node.HitLocation = HL;

        // Spawn hit effect
        if( VSize(HitEffectLocation-HL) > MinHitDist )
        {
            // Reverse normal when striking players
            if( gPawn(A) != None )
                HN *= -1;

            Spawn(HitEffectClass,,,HL,rotator(HN));
            HitEffectLocation = HL;
        }

        // Do damage
        if( Role == ROLE_Authority )
        {
            DoFireDamage(A);
        }
    }
}

final simulated function HitWorld(gDestroyerNode Node, vector HL, vector HN)
{
    local gDestroyerNode  NextNode, PrevNode;
    local vector ScorchLoc;

    NextNode = Node.Next;
    PrevNode = Node.Prev;

    // Mark collision
    Node.Collision = BC_World;
    Node.HitLocation = HL;

    // Spawn hit effect
    if( VSize(HitEffectLocation-HL) > MinHitDist )
    {
        Spawn(HitEffectClass,,,HL,rotator(HN));
        HitEffectLocation = HL;
    }

    // Get nearest linked scorch location
    if( NextNode != None && NextNode.HitLocation != vect(0,0,0) )
    {
        if( PrevNode != None && PrevNode.HitLocation != vect(0,0,0) && VSize(PrevNode.HitLocation-HL) < VSize(NextNode.HitLocation-HL))
            ScorchLoc = PrevNode.HitLocation;
        else
            ScorchLoc = NextNode.HitLocation;
    }
    else if( PrevNode != None && PrevNode.HitLocation != vect(0,0,0) )
    {
        ScorchLoc = PrevNode.HitLocation;
    }
    else
    {
        ScorchLoc = OldScorchLoc;
    }

    // Spawn scorch
    if( ScorchLoc == vect(0,0,0) )
    {
        // If no location do a point scorch
        Spawn(ScorchClass,,,HL+HN*8.0,rotator(Node.Dir));
        OldScorchLoc = HL;
    }
    else if( VSize(HL-ScorchLoc) > MinScorchDist )
    {
        // If old hit location not too close, spawn a point smeared in both directions
        //DrawStayingDebugLine(HL+HN*8.0, ScorchLoc+HN*8.0, 255,0,0);
        Spawn(ScorchClass,,,HL+HN*8.0 + Normal(HL-ScorchLoc),rotator(Node.Dir*0.3 + Normal(HL-ScorchLoc)*0.7));
        Spawn(ScorchClass,,,HL+HN*8.0 + Normal(ScorchLoc-HL),rotator(Node.Dir*0.3 + Normal(ScorchLoc-HL)*0.7));
        OldScorchLoc = HL;
    }
}


final simulated function DoFireDamage(Actor A)
{
    local gDestroyerDOT T;

    // Get DOT actor from cache or find it manually, then update it
    if( CachedHitActor == A && CachedDestroyerTimer != None )
    {
        CachedDestroyerTimer.Update( BeamDamageSeconds, BeamDamageType, BeamDamagePerSecond, BeamDamageTimer, Instigator );
    }
    else
    {
        T = class'gDestroyerDOT'.static.GetDestroyerTimer(A, True);
        if( T != None )
        {
            CachedHitActor = A;
            CachedDestroyerTimer = T;
            T.Update( BeamDamageSeconds, BeamDamageType, BeamDamagePerSecond, BeamDamageTimer, Instigator );
        }
    }
}


// ============================================================================
//  Splines
// ============================================================================

final simulated function DoSpline()
{
    local gDestroyerNode Node;
    local float Dist, BezierAlpha;
    local gDestroyerNode SplineNode, SplineNext, SplinePrev;

    if( SplineFirst == None || SplineFirst == SplineLast )
        return;

    // Spline control points for outer nodes
    SplineFirst.Control = vect(0,0,0);
    SplineLast.Control = vect(0,0,0);

    // Adjust non-spline nodes to spline
    SplineNode = SplineFirst.NextSpline;
    while( SplineNode != None )
    {
        SplineNext = SplineNode.NextSpline;
        SplinePrev = SplineNode.PrevSpline;

        // Calc spline control point as direction from next to previous with length equal a fraction of distance to closest neighbour
        if( SplineNext != None )
        {
            Dist = FMin( VSize(SplinePrev.Location - SplineNode.Location), VSize(SplineNode.Location - SplineNext.Location) );
            SplineNode.Control = Normal(SplinePrev.Location - SplineNext.Location) * Dist * ControlDistNode;
        }

        // Init variables for spline calculation
        BezierAlpha = TesselationDelta;

        // Calc spline points
        Node = SplinePrev.Next;
        while( Node != SplineNode )
        {
            Node.Location = Bezier( BezierAlpha, SplinePrev.Location, SplinePrev.Location - SplinePrev.Control, SplineNode.Location, SplineNode.Location + SplineNode.Control );
            //Node.Dir = Normal(Node.Location - Node.LocationStart);
            BezierAlpha += TesselationDelta;
            Node = Node.Next;
        }

        SplineNode = SplineNext;
    }
}

final simulated function vector Bezier( float Alpha, vector StartLoc, vector StartControl, vector EndLoc, vector EndControl )
{
    local vector ab,bc,cd,abbc,bccd,dest;

    ab = StartLoc+(StartControl-StartLoc)*Alpha;
    bc = StartControl+(EndControl-StartControl)*Alpha;
    cd = EndControl+(EndLoc-EndControl)*Alpha;

    abbc = ab+(bc-ab)*Alpha;
    bccd = bc+(cd-bc)*Alpha;
    dest = abbc+(bccd-abbc)*Alpha;

    return dest;
}


// ============================================================================
//  Draw
// ============================================================================

final simulated function DrawBeam()
{
    local gDestroyerNode Node;
    local vector BeamPoint;
    local int i, BeamIdx, FragmentIdx;
    local float FragmentLength;
    local BeamEmitter BeamEmitter;
    local RangeVector EndPoint;

    // Iterate from first to last
    Node = NodeFirst;
    while( Node != None )
    {
        // Create new fragment only if there will be at least two nodes
        if( Node.Collision == BC_None
        && (Node.Prev == None || Node.Prev.Collision != BC_None)
        && (Node.Next != None && Node.Next.Collision == BC_None) )
        {
            // Spawn beam emitter if neccesary
            if( BeamEmitters.Length <= BeamIdx )
            {
                BeamEmitters[BeamEmitters.Length] = Spawn(BeamEmitterClass,,, Node.Location, rotator(Node.Dir));
            }

            // Spawn dispersion emitters if neccesary, one for beginning and another for end
            if( DispEmitters.Length < (BeamIdx*2)+1 )
            {
                DispEmitters[DispEmitters.Length] = Spawn(DispEmitterClass,,, Node.Location, rotator(Node.Dir));
                DispEmitters[DispEmitters.Length] = Spawn(DispEmitterClass,,, Node.Location, rotator(Node.Dir));
            }

            // Init fragment variables
            FragmentIdx = 0;
            FragmentLength = 0;
            BeamEmitter = BeamEmitter(BeamEmitters[BeamIdx].Emitters[0]);

            // Add first point to beam emitter
            BeamPoint = Node.Location;
            BeamEmitter.HFPoints[FragmentIdx++].Location = BeamPoint;

            // Place dispersion start emitter
            DispEmitters[BeamIdx*2].SetLocation(BeamPoint);
            if( Node.bAnchor )
            {
                DispEmitters[BeamIdx*2].bHidden = true;
                DispEmitters[BeamIdx*2].SoundVolume = 0;
            }
            else
            {
                DispEmitters[BeamIdx*2].bHidden = false;
                DispEmitters[BeamIdx*2].SoundVolume = DispEmitters[BeamIdx*2].default.SoundVolume;
            }

            // Get beam points
            Node = Node.Next;
            while( Node != None && Node.Collision == BC_None )
            {
                // Extend fragment
                FragmentLength += VSize(BeamPoint-Node.Location);
                BeamPoint = Node.Location;
                BeamEmitter.HFPoints[FragmentIdx++].Location = BeamPoint;

                Node = Node.Next;
            }

            // Update Beam UV's
            BeamEmitter.BeamTextureUScale = (FragmentLength/(float(FragmentIdx)/float(BeamEmitter.HFPoints.Length))) / 256.0;

            // Place dispersion end emitter
            DispEmitters[(BeamIdx*2)+1].SetLocation(BeamPoint);

            // Move excess points to last beam point
            for( i=FragmentIdx; i<BeamEmitter.HFPoints.Length; ++i )
            {
                BeamEmitter.HFPoints[i].Location = BeamPoint;
            }

            // Update EndPoint
            EndPoint.X.Min = BeamPoint.X;
            EndPoint.X.Max = BeamPoint.X;
            EndPoint.Y.Min = BeamPoint.Y;
            EndPoint.Y.Max = BeamPoint.Y;
            EndPoint.Z.Min = BeamPoint.Z;
            EndPoint.Z.Max = BeamPoint.Z;
            BeamEmitter.BeamEndPoints[0].Offset = EndPoint;

            // Finish Beam
            ++BeamIdx;
            BeamEmitter = None;

            if( Node == None )
                break;
        }

        Node = Node.Next;
    }

    // Remove excess beam emitters
    for( i=BeamIdx; i<BeamEmitters.Length; ++i )
    {
        //gLog("Destroy beam" #i );
        if( BeamEmitters[i] != None )
            BeamEmitters[i].Destroy();
    }
    BeamEmitters.Length = BeamIdx;


    // Remove excess dispersion emitters
    for( i=BeamIdx*2; i<DispEmitters.Length; ++i )
    {
        DispEmitters[i].Trigger(self,instigator);
    }
    DispEmitters.Length = BeamIdx*2;


    // Display Flash effect
    if( NodeFirst != None && NodeFirst.bAnchor )
    {
        if( FlashEffect == None )
        {
            FlashEffect = Spawn(FlashEffectClass);
        }

        if( FlashEffect != None )
        {
            FlashEffect.SetLocation(NodeFirst.Location);
            FlashEffect.SetRotation(rotator(NodeFirst.Dir));
        }
    }
}


// ============================================================================
//  Util
// ============================================================================

// So the angle between them is <= 180 degrees
final simulated function AlignQuatWith( Quat BaseQuat, out Quat OutQuat )
{
    local float Minus, Plus;

    Minus = Square(OutQuat.X-BaseQuat.X) + Square(OutQuat.Y-BaseQuat.Y) + Square(OutQuat.Z-BaseQuat.Z) + Square(OutQuat.W-BaseQuat.W);
    Plus  = Square(OutQuat.X+BaseQuat.X) + Square(OutQuat.Y+BaseQuat.Y) + Square(OutQuat.Z+BaseQuat.Z) + Square(OutQuat.W+BaseQuat.W);

    if( Minus > Plus )
    {
        OutQuat.X = -OutQuat.X;
        OutQuat.Y = -OutQuat.Y;
        OutQuat.Z = -OutQuat.Z;
        OutQuat.W = -OutQuat.W;
    }
}


// ============================================================================
//  Debug - draw
// ============================================================================

final simulated function DrawDebugBeam()
{
    local gDestroyerNode Node, NodeSpline;
    local vector Loc, Control;
    local color C;

    ClearStayingDebugLines();

    // Draw beam points
    if( bDebugDrawBeam )
    {
        Node = NodeFirst;
        while( Node != None )
        {
            // Draw beam nodes
            if( bDebugDrawBeamNodes )
            {
                if( Node.ID % 2 == 0 )
                    C = ColorNode;
                else
                    C = ColorNode2;

                Loc = Node.Location;
                DrawStayingDebugLine( Loc+vect(0,0,1)*DebugCrossSize, Loc-vect(0,0,1)*DebugCrossSize, C.R,C.G,C.B );
                DrawStayingDebugLine( Loc+vect(0,1,0)*DebugCrossSize, Loc-vect(0,1,0)*DebugCrossSize, C.R,C.G,C.B );
                DrawStayingDebugLine( Loc+vect(1,0,0)*DebugCrossSize, Loc-vect(1,0,0)*DebugCrossSize, C.R,C.G,C.B );
            }

            // Draw beam
            if( Node.Next != None )
            {
                if( Node.ID % 2 == 0 )
                    C = ColorNode;
                else
                    C = ColorNode2;

                DrawStayingDebugLine( Node.Location, Node.Next.Location, C.R,C.G,C.B );
            }

            Node = Node.Next;
        }
    }

    // Draw spline
    if( bDebugDrawSpline )
    {
        NodeSpline = SplineFirst;
        while( NodeSpline != None )
        {
            // Draw spline control points
            if( bDebugDrawSplineControls )
            {
                Loc = NodeSpline.Location;
                Control = NodeSpline.Control;
                C = ColorSplineControl;
                DrawStayingDebugLine( Loc, Loc+vect(0,0,1)*DebugCrossSize, C.R,C.G,C.B );
                DrawStayingDebugLine( Loc+vect(0,0,1)*DebugCrossSize, Loc+vect(0,0,1)*DebugCrossSize-Control, C.R,C.G,C.B );
                DrawStayingDebugLine( Loc, Loc-vect(0,0,1)*DebugCrossSize, C.R,C.G,C.B );
                DrawStayingDebugLine( Loc-vect(0,0,1)*DebugCrossSize, Loc-vect(0,0,1)*DebugCrossSize+Control, C.R,C.G,C.B );
            }

            // Draw spline
            if( NodeSpline.PrevSpline != None )
            {
                Node = NodeSpline.PrevSpline;
                while( Node != NodeSpline )
                {
                    if( Node.ID % 2 == 0 )
                        C = ColorSpline;
                    else
                        C = ColorSpline2;

                    DrawStayingDebugLine( Node.Location, Node.Next.Location, C.R,C.G,C.B );
                    Node = Node.Next;
                }
            }

            NodeSpline = NodeSpline.NextSpline;
        }
    }
}


// ============================================================================
//  Debug - verify
// ============================================================================

final simulated function DebugVerifyNodes( optional string Msg )
{
    local gDestroyerNode Node;
    local array<gDestroyerNode> Uniques;
    local int i, counter;


    // Verify that list ends on both sides
    if( NodeFirst != None && NodeFirst.Prev != None ) { DumpBeam(NodeFirst,Msg); assert(False); }
    if( NodeLast != None && NodeLast.Next != None ) { DumpBeam(NodeLast,Msg); assert(False); }

    counter = 0;
    Uniques.Length = 0;
    for( Node=NodeFirst; Node!=None; Node=Node.Next )
    {
        // Catch infinite loop
        if( ++counter > 200 ) { DumpBeam(Node,Msg); assert(False); }

        if( Node.Next != None )
        {
            // Verify links
            if( Node.Next.Prev != Node ) { DumpBeam(Node,Msg); assert(False); }
        }
        else
        {
            if( Node != NodeLast ) { DumpBeam(Node,Msg); assert(False); }
        }

        if( Node.Prev != None )
        {
            // Verify links
            if( Node.Prev.Next != Node ) { DumpBeam(Node,Msg); assert(False); }
        }
        else
        {
            if( Node != NodeFirst ) { DumpBeam(Node,Msg); assert(False); }
        }

        // Must be unique in list
        for( i=0; i!=Uniques.Length; ++i )
        {
            if( Uniques[i] == Node ) { DumpBeam(Node,Msg); assert(False); }
        }
        Uniques[Uniques.Length] = Node;
    }


    // Verify that list ends on both sides
    if( SplineFirst != None && SplineFirst.PrevSpline != None ) { DumpBeam(SplineFirst,Msg); assert(False); }
    if( SplineLast != None && SplineLast.NextSpline != None ) { DumpBeam(SplineLast,Msg); assert(False); }

    counter = 0;
    Uniques.Length = 0;
    for( Node=SplineFirst; Node!=None; Node=Node.NextSpline )
    {
        // Catch infinite loop
        if( ++counter > 200 ) { DumpBeam(Node,Msg); assert(False); }

        if( Node.NextSpline != None )
        {
            // Verify links
            if( Node.NextSpline.PrevSpline != Node ) { DumpBeam(Node,Msg); assert(False); }
        }
        else
        {
            if( Node != SplineLast) { DumpBeam(Node,Msg); assert(False); }
        }

        if( Node.PrevSpline != None )
        {
            // Verify links
            if( Node.PrevSpline.NextSpline != Node ) { DumpBeam(Node,Msg); assert(False); }
        }
        else
        {
            if( Node != SplineFirst ) { DumpBeam(Node,Msg); assert(False); }
        }

        // Must be unique in list
        for( i=0; i!=Uniques.Length; ++i )
        {
            if( Uniques[i] == Node ) { DumpBeam(Node,Msg); assert(False); }
        }
        Uniques[Uniques.Length] = Node;
    }
}


// ============================================================================
//  Debug - log
// ============================================================================

final simulated function DumpBeam( optional gDestroyerNode Node, optional string Msg )
{
    gLog( "DumpBeam" #Msg #GON(Node) );
    DumpNodes(Node);
}

final simulated function DumpNodes( optional gDestroyerNode Node )
{
    gLog( "DumpNodes" #GON(Node) );

    gLog( "First" #(NodeFirst.Age #NodeFirst.ID @GON(NodeFirst)) );
    gLog( "Last" #(NodeLast.Age #NodeLast.ID @GON(NodeLast)) );

    for( Node=NodeFirst; Node!=None; Node=Node.Next )
    {
        gLog( "" #byte(Node.bAnchor) #int(Node.Collision) #GON(Node.Prev) #(Node.Age @Node.ID @GON(Node)) #GON(Node.Next) #(Node.Location)
        );
    }

    gLog( "SplineFirst" #(SplineFirst.Age @SplineFirst.ID @GON(SplineFirst)) );
    gLog( "SplineLast" #(SplineLast.Age @SplineLast.ID @GON(SplineLast)) );
    for( Node=SplineFirst; Node!=None; Node=Node.NextSpline )
    {
        gLog( "" #GON(Node.PrevSpline) #(Node.Age @Node.ID @GON(Node)) #GON(Node.NextSpline)
        );
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{


    BeamDamageType                  = class'GDamTypeDestroyerBeam'
    BeamDamageSeconds               = 0.2
    BeamDamageTimer                 = 0.1
    BeamDamagePerSecond             = 150

    FlashEffectClass                = class'GEffects.gDestroyerAltMuzzle'

    BeamEmitterClass                = class'gDestroyerBeamEmitter'
    DispEmitterClass                = class'gDestroyerDispEmitter'
    HitEffectClass                  = class'gDestroyerBeamHit'
    ScorchClass                     = class'gDestroyerBeamScorch'
    MinScorchDist                   = 12
    MinHitDist                      = 256

    Speed                           = 4200 // 28uu per tick
    LifeDist                        = 3200 // 0.76s lifespan
    Tesselation                     = 10
    CollisionExtent                 = (x=0,Y=0,Z=0)
    ControlDistNode                 = 0.4
    FixedTickDelta                  = 0.0067 // 120fps and up to 114 nodes
    DebugCrossSize                  = 32

    ColorNode                       = (R=0,G=0,B=255)
    ColorNode2                      = (R=0,G=255,B=0)
    ColorSpline                     = (R=255,G=0,B=0)
    ColorSpline2                    = (R=255,G=255,B=0)
    ColorSplineControl              = (R=255,G=0,B=255)

    bDrawBeam                       = True

    bDebugDraw                      = False
    bDebugDrawBeam                  = True
    bDebugDrawBeamNodes             = True
    bDebugDrawSpline                = True
    bDebugDrawSplineControls        = True

    bDebugVerifyNodes               = False

    DrawType                        = DT_StaticMesh // so rotation replicates
    bAcceptsProjectors              = False

    RemoteRole                      = ROLE_SimulatedProxy
    bAlwaysRelevant                 = True
    bReplicateInstigator            = True
    bUpdateSimulatedPosition        = True
    bNetInitialRotation             = False // so rotation replicates continuously
    NetPriority                     = 4.0
}
