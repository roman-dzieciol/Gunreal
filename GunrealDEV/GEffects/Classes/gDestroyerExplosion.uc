// ============================================================================
//  gDestroyerExplosion.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerExplosion extends gHitEmitterNet;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ClientSpawnClass    = class'GEffects.gDestroyerScorch'
    ClientSpawnAxes     = (X=-1,Y=-1,Z=-1)

    LightRadius         = 32
    LightBrightness     = 222
    LightSaturation     = 80
    LightHue            = 20
    LightType           = LT_Steady
    LightEffect         = LE_None
    bDynamicLight       = True

    bFlash              = True
    FlashRadius         = 22
    FlashBrightness     = 111
    FlashTimeIn         = 0.2
    FlashTimeOut        = 0.1
    FlashCurveIn        = 2.0
    FlashCurveOut       = 0.3

     Begin Object Class=SpriteEmitter Name=SpriteEmitter8
        FadeOut=True
        FadeIn=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        LowDetailFactor=0.350000
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.550000
        FadeOutStartTime=0.071429
        FadeInEndTime=0.071429
        MaxParticles=12
        Name="Destroyer-Smoke"
        StartLocationRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=-88.000000,Max=88.000000),Z=(Min=-88.000000,Max=88.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.014000,Max=0.014000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000))
        SizeScale(0)=(RelativeSize=1.400000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=55.500000,Max=87.900002),Y=(Min=55.500000,Max=87.900002),Z=(Min=55.500000,Max=87.900002))
        Sounds(0)=(Radius=(Min=64.000000,Max=64.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=3.000000,Max=3.000000),Probability=(Min=1.000000,Max=1.000000))
        SpawningSound=PTSC_LinearLocal
        InitialParticlesPerSecond=388.500000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke52Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=3.000000,Max=6.000000)
        StartVelocityRange=(X=(Max=955.000000),Y=(Min=-1155.000000,Max=1155.000000),Z=(Min=-1155.000000,Max=1155.000000))
        VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        FadeOut=True
        FadeIn=True
        UseActorForces=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=38.072998)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.800000
        FadeOutStartTime=0.264286
        FadeInEndTime=0.264286
        MaxParticles=11
        Name="Smoke-thick"
        DetailMode=DM_SuperHigh
        StartLocationRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=-88.000000,Max=88.000000),Z=(Min=-88.000000,Max=88.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.018000,Max=0.018000))
        StartSpinRange=(X=(Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=48.000000,Max=63.000000),Y=(Min=48.000000,Max=63.000000),Z=(Min=48.000000,Max=63.000000))
        InitialParticlesPerSecond=144.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5fireQb'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.428571,Max=2.857143)
        StartVelocityRange=(X=(Max=1143.170044),Y=(Min=-677.000000,Max=677.000000),Z=(Min=-677.000000,Max=677.000000))
        VelocityLossRange=(X=(Min=4.900000,Max=4.900000),Y=(Min=4.900000,Max=4.900000),Z=(Min=4.900000,Max=4.900000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.500000,Max=0.500000))
        Opacity=0.600000
        FadeOutStartTime=0.240000
        FadeInEndTime=0.180000
        MaxParticles=1
        Name="brightener"
        StartLocationOffset=(Z=77.000000)
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=255.000000,Max=255.000000),Y=(Min=255.000000,Max=255.000000),Z=(Min=255.000000,Max=255.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Flares.flare5'
        LifetimeRange=(Min=1.500000,Max=1.500000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=222.000000)
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.930000
        FadeOutStartTime=0.198000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="fire_carpet"
        StartLocationRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=30.250000,Max=42.250000),Y=(Min=30.250000,Max=42.250000),Z=(Min=30.250000,Max=42.250000))
        InitialParticlesPerSecond=140.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_flash_3quad_a'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.700000,Max=0.900000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter13'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.246000
        MaxParticles=1
        Name="Fireflash"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=33.000000,Max=53.000000),Y=(Min=33.000000,Max=53.000000),Z=(Min=33.000000,Max=53.000000))
        InitialParticlesPerSecond=140.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_flash_3quad_a'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.600000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=2
        Name="Spikes"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=32.000000,Max=37.000000),Y=(Min=32.000000,Max=37.000000),Z=(Min=32.000000,Max=37.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Mflashes.mflash4b'
        LifetimeRange=(Min=0.300000,Max=0.400000)
        StartVelocityRange=(X=(Min=-81.584999,Max=81.584999),Y=(Min=-81.584999,Max=81.584999),Z=(Min=-81.584999,Max=81.584999))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-677.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=7
        SpawnAmount=4
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=3.224490
        MaxParticles=50
        Name="Sparks_Main"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-66.000000,Max=66.000000),Y=(Min=-66.000000,Max=66.000000),Z=(Min=-66.000000,Max=66.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.500000)
        SizeScale(2)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=11.000000,Max=22.000000),Y=(Min=11.000000,Max=22.000000),Z=(Min=11.000000,Max=22.000000))
        Sounds(0)=(Sound=ProceduralSound'G_Proc.acid.acd_p_tss',Radius=(Min=6.000000,Max=6.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=2.000000,Max=2.000000),Probability=(Min=0.300000,Max=0.300000))
        CollisionSound=PTSC_LinearGlobal
        CollisionSoundProbability=(Min=1.000000,Max=1.000000)
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRadialRange=(Min=-933.000000,Max=-933.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseCollision=True
        FadeOut=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-378.157501)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=2.871429
        MaxParticles=255
        Name="Sparks_sub"
        DetailMode=DM_High
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=3.307500,Max=4.410000),Y=(Min=3.307500,Max=4.410000),Z=(Min=3.307500,Max=4.410000))
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=2.857143,Max=4.285714)
        StartVelocityRange=(X=(Min=-171.328491,Max=171.328491),Y=(Min=-171.328491,Max=171.328491),Z=(Min=1.543500,Max=192.937500))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.066000
        MaxParticles=4
        Name="Fire_darker"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=22.000000,Max=23.000000),Y=(Min=22.000000,Max=23.000000),Z=(Min=22.000000,Max=23.000000))
        InitialParticlesPerSecond=140.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.boom1'
        LifetimeRange=(Min=0.700000,Max=0.700000)
        StartVelocityRange=(X=(Min=-233.000000,Max=233.000000),Y=(Min=-233.000000,Max=233.000000),Z=(Min=-233.000000,Max=233.000000))
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
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
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.500000,Max=0.500000))
        FadeOutStartTime=0.240000
        FadeInEndTime=0.180000
        MaxParticles=1
        Name="Glow"
        StartLocationOffset=(Z=77.000000)
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=255.000000,Max=255.000000),Y=(Min=255.000000,Max=255.000000),Z=(Min=255.000000,Max=255.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Flares.flare5'
        LifetimeRange=(Min=1.500000,Max=1.500000)
    End Object
    Emitters(9)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        UseCollision=True
        FadeOut=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-360.149994)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=2.800000
        MaxParticles=111
        Name="Spark_trailers"
        DetailMode=DM_SuperHigh
        StartLocationRange=(Z=(Min=11.000000,Max=11.000000))
        AddLocationFromOtherEmitter=6
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=0.140000,RelativeSize=1.000000)
        SizeScale(2)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=4.285714,Max=4.285714)
        StartVelocityRange=(X=(Min=-163.169998,Max=163.169998),Y=(Min=-163.169998,Max=163.169998),Z=(Min=-189.000000,Max=189.000000))
        VelocityLossRange=(X=(Min=0.700000,Max=3.500000),Y=(Min=0.700000,Max=3.500000),Z=(Min=0.700000,Max=3.500000))
        AddVelocityFromOtherEmitter=0
    End Object
    Emitters(10)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=222.000000)
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
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.500000,Max=0.500000))
        FadeOutStartTime=0.240000
        FadeInEndTime=0.180000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="SpriteEmitter7"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=255.000000,Max=255.000000),Y=(Min=255.000000,Max=255.000000),Z=(Min=255.000000,Max=255.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Flares.flare5'
        LifetimeRange=(Min=1.500000,Max=1.500000)
    End Object
    Emitters(11)=SpriteEmitter'SpriteEmitter7'

}