// ============================================================================
//  gDestroyerBeamEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerBeamEmitter extends gEmitterBase;

simulated event PreBeginPlay()
{
}

DefaultProperties
{
    AutoDestroy             = True
    bUnlit                  = True
    AutoReset               = False
    bNoDelete               = False
    RemoteRole              = ROLE_None
    bHardAttach             = False
    bAcceptsProjectors      = False

    Begin Object Class=BeamEmitter Name=BeamEmitter2
        BeamEndPoints(0)=(offset=(X=(Min=512.000000,Max=512.000000)),Weight=1.000000)
        DetermineEndPointBy=PTEP_OffsetAsAbsolute
        RotatingSheets=3
        LowFrequencyPoints=1
        HighFrequencyPoints=300
        AlphaTest=False
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.900000
        CoordinateSystem=PTCS_Absolute
        MaxParticles=1
        Name="Destroyer-beam"
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=22.000000,Max=22.000000),Z=(Min=22.000000,Max=22.000000))
        InitialParticlesPerSecond=2000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.fX.destroyer_1a'
        LifetimeRange=(Min=1000.000000,Max=1000.000000)
    End Object
    Emitters(0)=BeamEmitter'BeamEmitter2'
}
