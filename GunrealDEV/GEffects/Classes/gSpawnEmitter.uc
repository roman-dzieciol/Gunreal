// ============================================================================
//  gSpawnEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpawnEmitter extends gNetTemporaryEmitter;

DefaultProperties
{
    SpawnSound              = Sound'G_Sounds.Gameplay.g_respawn_b2'
    SpawnSoundVolume        = 2.0
    SpawnSoundRadius        = 64

    LightRadius             = 22
    LightBrightness         = 111
    LightHue                = 144
    LightSaturation         = 115
    LightType               = LT_Steady
    LightEffect             = LE_None
    bDynamicLight           = True

    bFlash                  = True
    FlashRadius             = 22
    FlashBrightness         = 111
    FlashTimeOut            = 0.5
    FlashCurveOut           = 1

    bSkipActorPropertyReplication = True


    Skins(0)                = Texture'G_FX.Flares.flare2'
    ScaleGlow               = 3.0

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
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
        FadeOutStartTime=0.133000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="spawn_flare"
        StartLocationRange=(X=(Min=-6.000000,Max=6.000000),Y=(Min=-6.000000,Max=6.000000),Z=(Min=-50.000000,Max=50.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
        StartSizeRange=(X=(Min=18.000000,Max=18.000000),Y=(Min=18.000000,Max=18.000000),Z=(Min=18.000000,Max=18.000000))
        InitialParticlesPerSecond=66.000000
        Texture=Texture'G_FX.Flares.flare4'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-300.000000,Max=300.000000))
        MaxAbsVelocity=(X=30.000000,Y=30.000000,Z=30.000000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        RespawnDeadParticles=False
        SpinParticles=True
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
        FadeOutStartTime=0.250000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="pulse_out"
        StartLocationRange=(X=(Min=-15.000000,Max=15.000000),Y=(Min=-15.000000,Max=15.000000),Z=(Min=-50.000000,Max=50.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
        StartSizeRange=(X=(Min=12.000000,Max=22.000000),Y=(Min=12.000000,Max=22.000000),Z=(Min=12.000000,Max=22.000000))
        InitialParticlesPerSecond=66.000000
        Texture=Texture'G_FX.Flares.flare4'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
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
        Opacity=0.590000
        CoordinateSystem=PTCS_Relative
        MaxParticles=4
        Name="pulse_in"
        StartLocationRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-40.000000,Max=40.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=5.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=12.000000,Max=22.000000),Y=(Min=12.000000,Max=22.000000),Z=(Min=12.000000,Max=22.000000))
        InitialParticlesPerSecond=66.000000
        Texture=Texture'G_FX.Flares.flare4'
        LifetimeRange=(Min=0.250000,Max=0.250000)
        InitialDelayRange=(Min=0.150000,Max=0.150000)
        StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
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
        FadeOutStartTime=0.133000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="flash"
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=10.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        InitialParticlesPerSecond=66.000000
        Texture=Texture'G_FX.Flares.flare4'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        MaxAbsVelocity=(X=30.000000,Y=30.000000,Z=30.000000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter3'
}