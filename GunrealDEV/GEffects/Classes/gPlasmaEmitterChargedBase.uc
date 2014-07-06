// ============================================================================
//  gPlasmaEmitterChargedBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaEmitterChargedBase extends gProjectileEmitter;

DefaultProperties
{
    AmbientGlow                 = 192
    LightRadius                 = 24
    LightBrightness             = 192
    LightSaturation             = 102
    LightHue                    = 189
    LightType                   = LT_Steady
    LightEffect                 = LE_QuadraticNonIncidence
    bDynamicLight               = True

    AutoDestroy                 = False

    SoundRadius                 = 256
    SoundVolume                 = 255
    AmbientSound                = None

    bTriggerKills               = True
}
