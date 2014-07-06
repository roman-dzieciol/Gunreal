// ============================================================================
//  gHitGroupHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitGroupHE extends gHitGroup;

DefaultProperties
{
    HitEffectDefault        = class'gHitWallHE'
    HitEffectVehicle        = class'gHitVehicleHE'
    HitEffectPlayer         = class'gHitWallHE'
    HitEffectRock           = class'gHitTerrainHE'
    HitEffectDirt           = class'gHitTerrainHE'
    HitEffectMetal          = class'gHitWallHE'
    HitEffectWood           = class'gHitWallHE'
    HitEffectPlant          = class'gHitWallHE'
    HitEffectFlesh          = class'gHitWallHE'
    HitEffectIce            = class'gHitWallHE'
    HitEffectSnow           = class'gHitWallHE'
    HitEffectWater          = class'BulletSplash'
    HitEffectGlass          = class'gHitWallHE'
}