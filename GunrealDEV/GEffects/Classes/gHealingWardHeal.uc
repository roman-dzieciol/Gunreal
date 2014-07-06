//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gHealingWardHeal extends gHitEmitterNet;

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


    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        LowDetailFactor=0.500000
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.600000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="Core_Both"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=25.000000,Max=55.000000),Y=(Min=25.000000,Max=55.000000),Z=(Min=25.000000,Max=55.000000))
        InitialParticlesPerSecond=50.000000
        Texture=Texture'G_FX.Mflashes.plas_flash1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        LowDetailFactor=0.500000
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        CoordinateSystem=PTCS_Relative
        MaxParticles=11
        Name="Elec_Alt"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=68.000000,Max=68.000000),Y=(Min=68.000000,Max=68.000000),Z=(Min=68.000000,Max=68.000000))
        InitialParticlesPerSecond=50.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        LowDetailFactor=0.500000
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(X=(Min=0.750000,Max=0.750000),Y=(Min=0.750000,Max=0.750000))
        FadeOutStartTime=0.096000
        CoordinateSystem=PTCS_Relative
        MaxParticles=75
        Name="Sparks_Alt"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=12.000000,Max=12.000000)
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=9.000000,Max=14.000000),Y=(Min=9.000000,Max=14.000000),Z=(Min=9.000000,Max=14.000000))
        InitialParticlesPerSecond=444.000000
        Texture=Texture'G_FX.Mflashes.spark1Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRadialRange=(Min=555.000000,Max=555.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.850000,Max=0.850000),Y=(Min=0.850000,Max=0.850000))
        FadeOutStartTime=0.048000
        MaxParticles=1
        Name="ripple"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=47.000000,Max=47.000000),Y=(Min=47.000000,Max=47.000000),Z=(Min=47.000000,Max=47.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.350000,Max=0.350000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter6'

}