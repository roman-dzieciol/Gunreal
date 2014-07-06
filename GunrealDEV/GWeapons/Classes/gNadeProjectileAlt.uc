// ============================================================================
//  gNadeProjectileAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gNadeProjectileAlt extends gNadeProjectile;


simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    if( Role == ROLE_Authority )
    {
        // Explode on collision
        Hit(Other, HitLocation, HitNormal);
    }
}

simulated singular event HitWall(vector HitNormal, Actor Other)
{
    if( Role == ROLE_Authority )
    {
        // Explode on collision
        Hit(Other, Location, HitNormal);
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ExplosionTimer = 0
}