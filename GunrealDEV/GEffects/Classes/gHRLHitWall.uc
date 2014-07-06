// ============================================================================
//  gHRLHitWall.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLHitWall extends gHitEmitterNet;

DefaultProperties
{
    ClientSpawnClass    = class'GEffects.gHRLScorch'
    ClientSpawnAxes     = (X=-1,Y=-1,Z=-1)

    LightRadius         = 42
    LightBrightness     = 255
    LightSaturation     = 141
    LightHue            = 35
    LightType           = LT_Steady
    LightEffect         = LE_None
    bDynamicLight       = True

    bFlash              = True
    FlashRadius         = 32
    FlashBrightness     = 192
    FlashTimeIn         = 0.2
    FlashTimeOut        = 0.5
    FlashCurveIn        = 2.0
    FlashCurveOut       = 0.3

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=111.000000)
        ColorScale(0)=(Color=(B=159,G=183,R=204,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=143,G=175,R=205,A=255))
        Opacity=0.800000
        FadeOutStartTime=0.270000
        FadeInEndTime=0.270000
        MaxParticles=8
        Name="Smoke"
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=100.000000,Max=100.000000)
        SpinsPerSecondRange=(X=(Min=0.010000,Max=0.020000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.400000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=75.000000,Max=115.000000),Y=(Min=75.000000,Max=115.000000),Z=(Min=75.000000,Max=115.000000))
        InitialParticlesPerSecond=1111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=3.000000,Max=9.000000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-777.000000,Max=777.000000),Y=(Min=-777.000000,Max=777.000000),Z=(Min=-444.000000,Max=444.000000))
        VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-850.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=2
        SpawnAmount=4
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=1.290000
        MaxParticles=88
        Name="Glass"
        SpinsPerSecondRange=(X=(Min=3.000000,Max=6.000000))
        StartSizeRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
        InitialParticlesPerSecond=1111.000000
        Texture=Texture'G_FX.Glass.glassgrid1'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=3.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-600.000000,Max=600.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-700.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.370000
        MaxParticles=300
        Name="Glass_sub"
        SpinsPerSecondRange=(X=(Min=2.000000,Max=4.000000))
        StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        Texture=Texture'G_FX.Glass.glassgrid1'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        MinSquaredVelocity=2000.000000
        LifetimeRange=(Min=3.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-333.000000,Max=333.000000),Y=(Min=-333.000000,Max=333.000000),Z=(Min=-333.000000,Max=333.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        UseDirectionAs=PTDU_Up
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=151,G=215,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.400000
        FadeOutStartTime=0.050000
        FadeInEndTime=0.010000
        MaxParticles=2
        Name="Spikes"
        SpinsPerSecondRange=(Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=0.200000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=200.000000,Max=300.000000),Y=(Min=200.000000,Max=300.000000),Z=(Min=200.000000,Max=300.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Smokes.Smikes2sm'
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=222.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.180000
        MaxParticles=6
        Name="FireA"
        SpinsPerSecondRange=(X=(Min=0.115000,Max=0.115000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(1)=(RelativeTime=0.620000,RelativeSize=2.300000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.800000)
        StartSizeRange=(X=(Min=60.000000),Y=(Min=60.000000),Z=(Min=60.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.boom2'
        LifetimeRange=(Min=0.600000,Max=0.800000)
        StartVelocityRange=(X=(Min=-22.000000,Max=22.000000),Y=(Min=-22.000000,Max=22.000000),Z=(Min=-22.000000,Max=22.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.460000
        MaxParticles=3
        Name="Shockwave"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.500000)
        StartSizeRange=(X=(Max=200.000000),Y=(Max=200.000000),Z=(Max=200.000000))
        InitialParticlesPerSecond=1000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        InitialDelayRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter24
        UseDirectionAs=PTDU_Up
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=201,G=231,R=245,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=193,G=226,R=244,A=255))
        FadeOutStartTime=0.050000
        FadeInEndTime=0.010000
        MaxParticles=3
        Name="Flare"
        SpinsPerSecondRange=(Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=0.200000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=50.000000,Max=300.000000),Y=(Min=50.000000,Max=300.000000),Z=(Min=50.000000,Max=300.000000))
        InitialParticlesPerSecond=50.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter24'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter25
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=222.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.132000
        MaxParticles=3
        Name="FireB"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.050000,Max=0.100000),Z=(Min=0.050000,Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=50.000000,Max=90.000000),Y=(Min=50.000000,Max=90.000000),Z=(Min=50.000000,Max=90.000000))
        InitialParticlesPerSecond=100.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.boom1'
        LifetimeRange=(Min=0.300000,Max=0.600000)
        StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=-50.000000,Max=50.000000))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter25'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter26
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-1500.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.200000
        MaxParticles=40
        Name="Sparks_thin"
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
        InitialParticlesPerSecond=600.000000
        Texture=Texture'G_FX.Smokes.spark1'
        LifetimeRange=(Min=0.800000,Max=0.800000)
        InitialDelayRange=(Max=0.200000)
        StartVelocityRange=(X=(Min=-1100.000000,Max=1100.000000),Y=(Min=-1100.000000,Max=1100.000000),Z=(Min=-1100.000000,Max=1100.000000))
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter26'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter28
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-800.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=11
        SpawnAmount=5
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=1.600000
        MaxParticles=25
        Name="Sparks"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=5.000000,Max=8.000000),Z=(Min=5.000000,Max=8.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-888.000000,Max=888.000000),Y=(Min=-888.000000,Max=888.000000),Z=(Min=-888.000000,Max=888.000000))
    End Object
    Emitters(9)=SpriteEmitter'SpriteEmitter28'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter29
        UseCollision=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-700.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.880000
        FadeInEndTime=0.880000
        MaxParticles=444
        Name="Tricklers"
        AddLocationFromOtherEmitter=0
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=1.400000,Max=2.200000),Y=(Min=1.400000,Max=2.200000),Z=(Min=1.400000,Max=2.200000))
        InitialParticlesPerSecond=444.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-222.000000,Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=2.000000,Max=250.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000),Z=(Min=1.000000,Max=5.000000))
        AddVelocityFromOtherEmitter=0
    End Object
    Emitters(10)=SpriteEmitter'SpriteEmitter29'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter30
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-700.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        MaxParticles=111
        Name="Sparks_sub"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-222.000000,Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=2.000000,Max=250.000000))
    End Object
    Emitters(11)=SpriteEmitter'SpriteEmitter30'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter31
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-700.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        MaxParticles=777
        Name="Trailers"
        AddLocationFromOtherEmitter=8
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
        InitialParticlesPerSecond=444.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-222.000000,Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=2.000000,Max=250.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000),Z=(Min=1.000000,Max=5.000000))
        AddVelocityFromOtherEmitter=0
    End Object
    Emitters(12)=SpriteEmitter'SpriteEmitter31'


}
