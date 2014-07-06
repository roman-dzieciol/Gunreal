//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gHealingWardEmitter extends gNetTemporaryEmitter;

DefaultProperties
{
    Physics                             = PHYS_None

    SpawnSound                          = Sound'G_Sounds.g_regen_c1'
    SpawnSoundVolume					= 8.0
    SpawnSoundRadius                    = 768
    SpawnSoundAttenuate                 = True
    
    LightRadius         = 42
    LightBrightness     = 255
    LightSaturation     = 102
    LightHue            = 189
    LightType           = LT_Steady
    LightEffect         = LE_None
    bDynamicLight       = True

    bFlash              = True
    FlashRadius         = 32
    FlashBrightness     = 192
    FlashTimeIn         = 0.2
    FlashTimeOut        = 1.5
    FlashCurveIn        = 2.0
    FlashCurveOut       = 0.3

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
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
        Opacity=0.560000
        FadeOutStartTime=0.147000
        CoordinateSystem=PTCS_Relative
        MaxParticles=27
        Name="elec"
        StartLocationRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
        StartSizeRange=(X=(Min=35.000000,Max=44.000000),Y=(Min=35.000000,Max=44.000000),Z=(Min=35.000000,Max=44.000000))
        InitialParticlesPerSecond=33.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
        MaxAbsVelocity=(X=30.000000,Y=30.000000,Z=30.000000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
        Opacity=0.560000
        FadeOutStartTime=0.250000
        CoordinateSystem=PTCS_Relative
        MaxParticles=5
        Name="embryo"
        SpinsPerSecondRange=(X=(Min=7.000000,Max=7.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=12.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=22.000000,Max=22.000000),Z=(Min=22.000000,Max=22.000000))
        InitialParticlesPerSecond=6.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        UseDirectionAs=PTDU_Normal
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
        Opacity=0.560000
        FadeOutStartTime=0.250000
        CoordinateSystem=PTCS_Relative
        MaxParticles=5
        Name="embryo_floor"
        StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-75.000000,Max=-75.000000))
        SpinsPerSecondRange=(X=(Min=7.000000,Max=7.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=12.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=19.000000,Max=19.000000),Y=(Min=19.000000,Max=19.000000),Z=(Min=19.000000,Max=19.000000))
        InitialParticlesPerSecond=6.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
        MaxParticles=3
        Name="initial_flare"
        SpinsPerSecondRange=(X=(Min=-0.400000,Max=0.400000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=55.000000,Max=55.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.fX.hrl_shield_b1'
        LifetimeRange=(Min=0.400000,Max=0.400000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter0'

}