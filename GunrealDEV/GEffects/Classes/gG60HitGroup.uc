// ============================================================================
//  gG60HitGroup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60HitGroup extends gHitGroup;

DefaultProperties
{
    HitEffectDefault        = class'gG60HitWall'
    HitEffectVehicle        = class'gG60HitVehicle'
    HitEffectPlayer         = None
    HitEffectRock           = class'gG60HitWall'
    HitEffectDirt           = class'gG60HitWall'
    HitEffectMetal          = class'gG60HitWall'
    HitEffectWood           = class'gG60HitWall'
    HitEffectPlant          = class'gG60HitWall'
    HitEffectFlesh          = class'pclRedSmoke'
    HitEffectIce            = class'gG60HitWall'
    HitEffectSnow           = class'gG60HitWall'
    HitEffectWater          = class'BulletSplash'
    HitEffectGlass          = class'gG60HitWall'
}