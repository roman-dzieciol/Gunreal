// ============================================================================
//  gDamageType.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamageType extends DamageType
    abstract;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S );


// ============================================================================
//  gDamageType
// ============================================================================

static function class<Effects> GetPawnDamageEffect( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
    return None;
}

static function class<Emitter> GetPawnDamageEmitter( vector HitLocation, float Damage, vector Momentum, Pawn Victim, bool bLowDetail )
{
    return None;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

}