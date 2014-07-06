// ============================================================================
//  gHRLBeaconHitGroup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLBeaconHitGroup extends gHitGroup;

DefaultProperties
{
    HitEffectDefault        = None
    HitEffectVehicle        = class'gHRLBeaconHitVehicle'
    HitEffectPlayer         = None
    HitEffectRock           = None
    HitEffectDirt           = None
    HitEffectMetal          = None
    HitEffectWood           = None
    HitEffectPlant          = None
    HitEffectFlesh          = None
    HitEffectIce            = None
    HitEffectSnow           = None
    HitEffectWater          = class'BulletSplash'
    HitEffectGlass          = None
}