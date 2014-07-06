// ============================================================================
//  gPlasmaExplosionMine.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaExplosionMine extends gHitEmitterNet;


DefaultProperties
{

    AmbientGlow             = 192
    LightRadius             = 24
    LightBrightness         = 128
    LightSaturation         = 60
    LightHue                = 189
    LightType               = LT_Steady
    LightEffect             = LE_QuadraticNonIncidence
    bDynamicLight           = True

    bFlash                  = True
    FlashBrightness         = 512
    FlashRadius             = 32
    FlashTimeIn             = 0.15
    FlashTimeOut            = 5
    FlashCurveIn            = 0.3
    FlashCurveOut           = 2

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.720000
        MaxParticles=15
        Name="Elec_Core"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=161.000000,Max=161.000000),Y=(Min=161.000000,Max=161.000000),Z=(Min=161.000000,Max=161.000000))
        InitialParticlesPerSecond=55.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.760000
        MaxParticles=15
        Name="Elec_Static"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.800000)
        StartSizeRange=(X=(Min=111.000000,Max=233.000000),Y=(Min=111.000000,Max=233.000000),Z=(Min=111.000000,Max=233.000000))
        InitialParticlesPerSecond=55.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.170000
        FadeOutStartTime=0.200000
        FadeInEndTime=0.200000
        MaxParticles=5
        Name="Shrink"
        StartLocationRange=(X=(Min=-66.000000,Max=66.000000),Y=(Min=-66.000000,Max=66.000000),Z=(Min=-66.000000,Max=33.000000))
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=5.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=20.000000,Max=80.000000),Y=(Min=20.000000,Max=80.000000),Z=(Min=20.000000,Max=80.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.Plasmaball_1'
        LifetimeRange=(Min=0.400000,Max=0.400000)
        InitialDelayRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.410000
        MaxParticles=3
        Name="Flash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=222.000000,Max=322.000000),Y=(Min=222.000000,Max=322.000000),Z=(Min=222.000000,Max=322.000000))
        InitialParticlesPerSecond=55.000000
        Texture=Texture'G_FX.Plasmafx.Plasmaball_E'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=11.000000)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.700000,Max=0.700000),Z=(Min=0.900000,Max=0.900000))
        Opacity=0.100000
        FadeOutStartTime=0.210000
        FadeInEndTime=0.210000
        MaxParticles=15
        Name="Steam"
        StartLocationRange=(X=(Min=-77.000000,Max=77.000000),Y=(Min=-77.000000,Max=77.000000),Z=(Min=-77.000000,Max=77.000000))
        SpinsPerSecondRange=(X=(Min=0.020000,Max=0.050000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=55.000000,Max=95.000000),Y=(Min=55.000000,Max=95.000000),Z=(Min=55.000000,Max=95.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.mini_blue1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=7.000000,Max=7.000000)
        StartVelocityRange=(X=(Min=-411.000000,Max=411.000000),Y=(Min=-411.000000,Max=411.000000),Z=(Min=-111.000000,Max=111.000000))
        VelocityLossRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        Acceleration=(Z=111.000000)
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.390000
        MaxParticles=22
        Name="Aftershocks"
        StartLocationRange=(X=(Min=-133.000000,Max=133.000000),Y=(Min=-133.000000,Max=133.000000),Z=(Min=-133.000000,Max=133.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.300000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.200000)
        StartSizeRange=(X=(Min=51.000000,Max=111.000000),Y=(Min=51.000000,Max=111.000000),Z=(Min=51.000000,Max=111.000000))
        InitialParticlesPerSecond=33.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.100000,Max=0.100000)
        InitialDelayRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=111.000000)
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.270000
        MaxParticles=11
        Name="Afterdots"
        StartLocationRange=(X=(Min=-155.000000,Max=155.000000),Y=(Min=-155.000000,Max=155.000000),Z=(Min=-155.000000,Max=155.000000))
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=111.000000,Max=222.000000),Y=(Min=111.000000,Max=222.000000),Z=(Min=111.000000,Max=222.000000))
        InitialParticlesPerSecond=33.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
        InitialDelayRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.110000
        MaxParticles=3
        Name="Flare_Env"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=333.000000,Max=600.000000),Y=(Min=333.000000,Max=600.000000),Z=(Min=333.000000,Max=600.000000))
        InitialParticlesPerSecond=33.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.Plasmaball_1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        MaxParticles=222
        Name="Splatter"
        StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        SpinsPerSecondRange=(X=(Min=0.050000,Max=0.150000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=3.000000,Max=7.000000),Y=(Min=3.000000,Max=7.000000),Z=(Min=3.000000,Max=7.000000))
        InitialParticlesPerSecond=1000.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.Plasmaball_Alpha'
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRadialRange=(Min=2111.000000,Max=2111.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.600000
        MaxParticles=8
        Name="PlasCore"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.200000)
        StartSizeRange=(X=(Min=55.000000,Max=55.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
        InitialParticlesPerSecond=15.000000
        Texture=Texture'G_FX.Mflashes.plas_flash1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(9)=SpriteEmitter'SpriteEmitter4'

}
