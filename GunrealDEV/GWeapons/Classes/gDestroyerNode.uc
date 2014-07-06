// ============================================================================
//  gDestroyerNode.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerNode extends gObject;


enum EBeamCollision
{
    BC_None
,   BC_Actor
,   BC_World
};


var() bool bAnchor;                 // Node is attached to firing weapon

var() gDestroyerNode Next;          // Next node in beam
var() gDestroyerNode Prev;          // Prev node in beam

var() gDestroyerNode NextSpline;    // Next spline node in beam
var() gDestroyerNode PrevSpline;    // Prev spline node in beam

var() vector LocationStart;         // Initial location
var() vector LocationOld;           // Location one movement update ago
var() vector Location;              // Current location
var() vector Dir;                   // Direction of motion
var() float Age;                    // Age of node
var() vector Control;               // Spline control point
var() vector HitLocation;           // Collision location
var() int ID;                       // Unique node ID
var() EBeamCollision Collision;     // Set when node collides with something


final simulated function Init
(   bool nAnchor
,   vector nLocation
,   vector nDir
)
{
    bAnchor = nAnchor;
    LocationStart = nLocation;
    LocationOld = nLocation;
    Location = nLocation;
    Dir = nDir;
}


final simulated function Link
(   gDestroyerNode nNext
,   gDestroyerNode nPrev )
{
    Next = nNext;
    Prev = nPrev;
}

final simulated function Free()
{
    Next = None;
    Prev = None;
    NextSpline = None;
    PrevSpline = None;

    Age = 0;
    HitLocation = vect(0,0,0);
    Collision = BC_None;
}

DefaultProperties
{
}