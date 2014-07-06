// ============================================================================
//  gPlasmaProjectileChargedBoosted.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaProjectileChargedBoosted extends gPlasmaProjectileCharged;

DefaultProperties
{
    AttachmentClass         = Class'GEffects.gPlasmaEmitterChargedBoosted'
    BoostEffectClass        = Class'GEffects.gPlasmaBoostEmitterBigBoosted'
    HealEffectClass         = Class'GEffects.gPlasmaBoostEmitterBigBoosted'
    MineClass               = class'gPlasmaProjectileMineBoosted'
}
