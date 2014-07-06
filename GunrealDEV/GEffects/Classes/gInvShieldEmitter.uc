// ============================================================================
//  gInvShieldEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gInvShieldEmitter extends gNetTemporaryEmitter;

DefaultProperties
{
    ClientSpawnClass            = class'gInvShieldLight';

    SpawnSound                  = Sound'G_Sounds.g_invul_shield_a2'
    SpawnSoundVolume            = 2.0
    SpawnSoundRadius            = 512

    LightRadius                 = 32
    LightBrightness             = 111
    LightSaturation             = 102
    LightHue                    = 189
    LightType                   = LT_Steady
    LightEffect                 = LE_None
    bDynamicLight               = True

    bFlash                      = True
    FlashRadius                 = 22
    FlashBrightness             = 1024
    FlashTimeIn                 = 0.2
    FlashTimeOut                = 0.2
    FlashCurveIn                = 2.0
    FlashCurveOut               = 0.3

    Physics                     = PHYS_Trailer
    bTrailerAllowRotation       = True

    Begin Object Class=SpriteEmitter Name=SpriteEmitter16
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        Opacity=0.630000
        FadeOutStartTime=0.133000
        CoordinateSystem=PTCS_Relative
        MaxParticles=44
        Name="elec"
        StartLocationRange=(X=(Min=-22.000000,Max=22.000000),Y=(Min=-22.000000,Max=22.000000),Z=(Min=-22.000000,Max=22.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
        StartSizeRange=(X=(Min=9.000000,Max=9.000000),Y=(Min=9.000000,Max=9.000000),Z=(Min=9.000000,Max=9.000000))
        InitialParticlesPerSecond=44.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        MaxAbsVelocity=(X=30.000000,Y=30.000000,Z=30.000000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter16'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter17
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        Opacity=0.650000
        FadeOutStartTime=0.250000
        CoordinateSystem=PTCS_Relative
        MaxParticles=6
        Name="embryo"
        SpinsPerSecondRange=(X=(Min=7.000000,Max=7.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=12.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=9.500000,Max=9.500000),Y=(Min=9.500000,Max=9.500000),Z=(Min=9.500000,Max=9.500000))
        InitialParticlesPerSecond=6.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter17'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000))
        Opacity=0.550000
        FadeOutStartTime=0.141000
        FadeInEndTime=0.141000
        CoordinateSystem=PTCS_Relative
        MaxParticles=16
        Name="light"
        StartLocationRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=8.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
        InitialParticlesPerSecond=12.000000
        Texture=Texture'G_FX.Flares.flare5'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.002000
        MaxParticles=2
        Name="initial_flare"
        SpinsPerSecondRange=(X=(Min=-0.400000,Max=0.400000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=33.000000,Max=33.000000),Y=(Min=33.000000,Max=33.000000),Z=(Min=33.000000,Max=33.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.fX.hrl_shield_b1'
        LifetimeRange=(Min=0.300000,Max=0.300000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter11'
}