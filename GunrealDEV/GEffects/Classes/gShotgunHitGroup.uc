// ============================================================================
//  gShotgunHitGroup.uc ::
// ============================================================================
class gShotgunHitGroup extends gHitGroup;

DefaultProperties
{
    HitEffectDefault        = class'gShotgunHitWall'
    HitEffectVehicle        = class'gShotgunHitVehicle'
    HitEffectPlayer         = None
    HitEffectRock           = class'gShotgunHitWall'
    HitEffectDirt           = class'gShotgunHitWall'
    HitEffectMetal          = class'gShotgunHitWall'
    HitEffectWood           = class'gShotgunHitWall'
    HitEffectPlant          = class'gShotgunHitWall'
    HitEffectFlesh          = class'pclRedSmoke'
    HitEffectIce            = class'gShotgunHitWall'
    HitEffectSnow           = class'gShotgunHitWall'
    HitEffectWater          = class'BulletSplash'
    HitEffectGlass          = class'gShotgunHitWall'
}