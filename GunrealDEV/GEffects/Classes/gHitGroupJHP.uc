// ============================================================================
//  gHitGroupJHP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitGroupJHP extends gHitGroup;

DefaultProperties
{
    HitEffectDefault        = class'gHitWallJHP'
    HitEffectVehicle        = class'gHitVehicleJHP'
    HitEffectPlayer         = None
    HitEffectRock           = class'gHitTerrainJHP'
    HitEffectDirt           = class'gHitTerrainJHP'
    HitEffectMetal          = class'gHitWallJHP'
    HitEffectWood           = class'gHitWallJHP'
    HitEffectPlant          = class'gHitWallJHP'
    HitEffectFlesh          = class'pclRedSmoke'
    HitEffectIce            = class'gHitWallJHP'
    HitEffectSnow           = class'gHitWallJHP'
    HitEffectWater          = class'BulletSplash'
    HitEffectGlass          = class'gHitWallJHP'
}