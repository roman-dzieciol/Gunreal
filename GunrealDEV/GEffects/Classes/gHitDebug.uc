// ============================================================================
//  gHitDebug.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitDebug extends gHitEmitter;

DefaultProperties
{
    ClientSpawnClass    = class'GEffects.gScorchBullet'
    ClientSpawnAxes     = (X=-1,Y=-1,Z=-1)

    SpawnSound            = Sound'xEffects.Impact1Snd'
    SpawnSoundVolume      = 2
    SpawnSoundRadius      = 512

    AutoDestroy         = False
    LifeSpan            = 1
}
