// ============================================================================
//  gPlasmaEmitterMineBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaEmitterMineBase extends gProjectileEmitter;

simulated event Trigger( Actor Other, Pawn EventInstigator )
{
    local int i;

    //Log("Trigger");

    bFlash = True;
    Enable('Tick');

    for( i=0; i!=Emitters.Length; ++i )
    {
        Emitters[i].Disabled = True;
    }

    AmbientSound = None;
    LifeSpan = FlashTimeIn + FlashTimeOut;
}

DefaultProperties
{
    AmbientGlow         = 0
    LightRadius         = 24
    LightBrightness     = 255
    LightSaturation     = 102
    LightHue            = 189
    LightType           = LT_Steady
    LightEffect         = LE_QuadraticNonIncidence
    bDynamicLight       = True

//    bFlash              = False
//    FlashBrightness     = 768
//    FlashRadius         = 32
//    FlashTimeIn         = 0.25
//    FlashTimeOut        = 5
//    FlashCurveIn        = 0.3
//    FlashCurveOut       = 2

    AutoDestroy         = False

    bTriggerKills       = True

}
