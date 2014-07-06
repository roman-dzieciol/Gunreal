// ============================================================================
//  gHitGroupAP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitGroupAP extends gHitGroup;

DefaultProperties
{
    HitEffectDefault        = class'gHitWallAP'
    HitEffectVehicle        = class'gHitVehicleAP'
    HitEffectPlayer         = None
    HitEffectRock           = class'gHitTerrainAP'
    HitEffectDirt           = class'gHitTerrainAP'
    HitEffectMetal          = class'gHitWallAP'
    HitEffectWood           = class'gHitWallAP'
    HitEffectPlant          = class'gHitWallAP'
    HitEffectFlesh          = class'pclRedSmoke'
    HitEffectIce            = class'gHitWallAP'
    HitEffectSnow           = class'gHitWallAP'
    HitEffectWater          = class'BulletSplash'
    HitEffectGlass          = class'gHitWallAP'
}