// ============================================================================
//  gPrecacheScan.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPrecacheScan extends Actor;


function PrecacheStaticMesh( StaticMesh Obj );
function PrecacheMaterial( Material Obj );
function PrecacheSound( Sound Obj );
function PrecacheClass( class C );
function PrecacheSkelMesh( Mesh Obj );

function PrecacheObject( Object Obj )
{
    if( StaticMesh(Obj) != None )
        PrecacheStaticMesh( StaticMesh(Obj) );
    else if( Material(Obj) != None )
        PrecacheMaterial( Material(Obj) );
    else if( Sound(Obj) != None )
        PrecacheSound( Sound(Obj) );
    else if( Mesh(Obj) != None )
        PrecacheSkelMesh( Mesh(Obj) );
    else if( class<Object>(Obj) != None )
        PrecacheClass( class<Object>(Obj) );
    else if( Obj != None )
        gLog( "PrecacheObject UNKNOWN" #Obj );
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

}
