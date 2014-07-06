// ============================================================================
//  gHitGroupPiston.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitGroupPiston extends gHitGroup;

DefaultProperties
{
    HitEffectDefault        = class'gPistonHitWall'
    HitEffectVehicle        = class'gPistonHitWall'
    HitEffectPlayer         = None
    HitEffectRock           = class'gPistonHitWall'
    HitEffectDirt           = class'gPistonHitWall'
    HitEffectMetal          = class'gPistonHitWall'
    HitEffectWood           = class'gPistonHitWall'
    HitEffectPlant          = class'gPistonHitWall'
    HitEffectFlesh          = class'pclRedSmoke'
    HitEffectIce            = class'gPistonHitWall'
    HitEffectSnow           = class'gPistonHitWall'
    HitEffectWater          = class'BulletSplash'
    HitEffectGlass          = class'gPistonHitWall'
}