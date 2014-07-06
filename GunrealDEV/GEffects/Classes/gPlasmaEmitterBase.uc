// ============================================================================
//  gPlasmaEmitterBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaEmitterBase extends gProjectileEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    AmbientGlow                 = 128

    LightPeriod                 = 32
    LightRadius                 = 16
    LightBrightness             = 128
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