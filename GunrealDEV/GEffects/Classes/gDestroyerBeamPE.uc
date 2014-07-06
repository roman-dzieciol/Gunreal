// ============================================================================
//  gDestroyerBeamPE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerBeamPE extends BeamEmitter;



DefaultProperties
{
    BeamEndPoints(0)=(offset=(X=(Min=0.000000,Max=0.000000)),Weight=1.000000)
    DetermineEndPointBy=PTEP_OffsetAsAbsolute
    BeamTextureUScale=1.000000
    RotatingSheets=1
    ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.000000,Max=0.000000))
    LowFrequencyPoints=2
    HighFrequencyPoints=200
    AutomaticInitialSpawning=False
    CoordinateSystem=PTCS_Absolute
    MaxParticles=1
    StartSizeRange=(X=(Min=20.000000,Max=20.000000))
    InitialParticlesPerSecond=2000.000000
    Texture=Texture'AS_FX_TX.Beams.HotBolt_1'
    //Texture=Texture'AS_FX_TX.Beams.LaserTex'
    SecondsBeforeInactive=0.000000
    LifetimeRange=(Min=1.000000,Max=1.000000)
}
