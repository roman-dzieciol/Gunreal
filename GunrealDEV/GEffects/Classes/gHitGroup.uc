// ============================================================================
//  gHitGroup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitGroup extends Effects;


// - Constants ----------------------------------------------------------------

const GST_Vehicle = 11;
const GST_Player = 12;

var() class<Actor> HitEffectDefault;
var() class<Actor> HitEffectVehicle;
var() class<Actor> HitEffectPlayer;
var() class<Actor> HitEffectRock;
var() class<Actor> HitEffectDirt;
var() class<Actor> HitEffectMetal;
var() class<Actor> HitEffectWood;
var() class<Actor> HitEffectPlant;
var() class<Actor> HitEffectFlesh;
var() class<Actor> HitEffectIce;
var() class<Actor> HitEffectSnow;
var() class<Actor> HitEffectWater;
var() class<Actor> HitEffectGlass;
var() float        TraceDist;



// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    S.PrecacheObject(default.HitEffectDefault);
    S.PrecacheObject(default.HitEffectVehicle);
    S.PrecacheObject(default.HitEffectPlayer);
    S.PrecacheObject(default.HitEffectRock);
    S.PrecacheObject(default.HitEffectDirt);
    S.PrecacheObject(default.HitEffectMetal);
    S.PrecacheObject(default.HitEffectWood);
    S.PrecacheObject(default.HitEffectPlant);
    S.PrecacheObject(default.HitEffectFlesh);
    S.PrecacheObject(default.HitEffectIce);
    S.PrecacheObject(default.HitEffectSnow);
    S.PrecacheObject(default.HitEffectWater);
    S.PrecacheObject(default.HitEffectGlass);
}


// ============================================================================
//  HitGroup
// ============================================================================

final static function byte GetSurfaceType(Actor HitActor, optional Material HitMaterial)
{
    if( xPawn(HitActor) != None )
        return GST_Player;
    else if( Vehicle(HitActor) != None )
        return GST_Vehicle;
    else if( HitMaterial != None && HitMaterial.SurfaceType != EST_Default )
        return HitMaterial.SurfaceType;
    else if( HitActor != None )
        return HitActor.SurfaceType;

    return 0;
}

final static function byte GetHitType(Actor Caller, Actor HitActor, vector HitLocation, vector HitDir, optional float Dist)
{
    local Material HitMaterial;
    local vector Offset, Dummy;

    //Log( "GetHitEffect" #HitActor );

    if( xPawn(HitActor) != None )
        return GST_Player;
    else if( Vehicle(HitActor) != None )
        return GST_Vehicle;
    else
    {
        if( Dist == 0 )
            Offset = default.TraceDist * HitDir;
        else
            Offset = Dist * HitDir;

        Caller.Trace(Dummy, Dummy, HitLocation-Offset, HitLocation+Offset, False,, HitMaterial);

        if( HitMaterial != None && HitMaterial.SurfaceType != EST_Default )
            return HitMaterial.SurfaceType;
        else if( HitActor != None )
            return HitActor.SurfaceType;
    }

    return 0;
}

final static function class<Actor> GetHitEffect(byte HitType)
{
    switch( HitType )
    {
        case GST_Vehicle:           return Default.HitEffectVehicle;
        case GST_Player:            return Default.HitEffectPlayer;
    }

    switch( ESurfaceTypes(HitType) )
    {
        case EST_Default:           return Default.HitEffectDefault;
        case EST_Rock:              return Default.HitEffectRock;
        case EST_Dirt:              return Default.HitEffectDirt;
        case EST_Metal:             return Default.HitEffectMetal;
        case EST_Wood:              return Default.HitEffectWood;
        case EST_Plant:             return Default.HitEffectPlant;
        case EST_Flesh:             return Default.HitEffectFlesh;
        case EST_Ice:               return Default.HitEffectIce;
        case EST_Snow:              return Default.HitEffectSnow;
        case EST_Water:             return Default.HitEffectWater;
        case EST_Glass:             return Default.HitEffectGlass;
        default:                    return Default.HitEffectDefault;
    }
}

final static function class<Actor> GetHitEffectEx( Actor Caller, Actor HitActor, vector HitLocation, vector HitDir, optional float Dist )
{
    return GetHitEffect( GetHitType(Caller,HitActor,HitLocation,HitDir,Dist) );
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
    TraceDist                   = 8

    HitEffectDefault            = class'GEffects.gCoordsEmitter'
    HitEffectVehicle            = class'GEffects.gCoordsEmitter'
    HitEffectPlayer             = class'GEffects.gCoordsEmitter'
    HitEffectRock               = class'GEffects.gCoordsEmitter'
    HitEffectDirt               = class'GEffects.gCoordsEmitter'
    HitEffectMetal              = class'GEffects.gCoordsEmitter'
    HitEffectWood               = class'GEffects.gCoordsEmitter'
    HitEffectPlant              = class'GEffects.gCoordsEmitter'
    HitEffectFlesh              = class'GEffects.gCoordsEmitter'
    HitEffectIce                = class'GEffects.gCoordsEmitter'
    HitEffectSnow               = class'GEffects.gCoordsEmitter'
    HitEffectWater              = class'GEffects.gCoordsEmitter'
    HitEffectGlass              = class'GEffects.gCoordsEmitter'
}