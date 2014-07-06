// ============================================================================
//  gDestroyerDispEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerDispEmitter extends gEmitter;

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
    bHardAttach             = True
    bAcceptsProjectors      = False

    bTriggerKills           = True
    DisableOnTrigger(0)     = 0

    AmbientSound            = sound'G_Sounds.de_ball-fly'
    SoundRadius             = 512
    SoundVolume             = 128

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Destroyer_tips"
        SpinCCWorCW=(X=1.000000)
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=222.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Smokes.boom1'
        LifetimeRange=(Min=1.000000,Max=1.000000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseColorScale=True
        FadeOut=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=149,G=187,R=206,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=30,G=47,R=64,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        Opacity=0.100000
        MaxParticles=700
        Name="smoke"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=30.000000,Max=50.000000),Y=(Min=30.000000,Max=50.000000),Z=(Min=30.000000,Max=50.000000))
        InitialParticlesPerSecond=122.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke2_b'
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="SpriteEmitter11"
        SpinCCWorCW=(X=1.000000)
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=44.000000,Max=44.000000),Y=(Min=44.000000,Max=44.000000),Z=(Min=44.000000,Max=44.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter11'
}
