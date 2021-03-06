// ============================================================================
//  gRoxHitWall.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRoxHitWall extends gHitEmitterNet;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ClientSpawnClass    = class'GEffects.gRoxScorch'
    ClientSpawnAxes     = (X=-1,Y=-1,Z=-1)

    LightRadius         = 42
    LightBrightness     = 255
    LightSaturation     = 40
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

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-816.820129)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=1
        SpawnAmount=5
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=3.224490
        MaxParticles=25
        Name="Sparks_Main"
        DetailMode=DM_High
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=5.000000,Max=8.000000),Y=(Min=5.000000,Max=8.000000),Z=(Min=5.000000,Max=8.000000))
        Sounds(0)=(Sound=ProceduralSound'G_Proc.acid.acd_p_tss',Radius=(Min=10.000000,Max=10.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=2.000000,Max=2.000000),Probability=(Min=1.000000,Max=1.000000))
        CollisionSound=PTSC_LinearGlobal
        CollisionSoundProbability=(Min=1.000000,Max=1.000000)
        InitialParticlesPerSecond=163.169998
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        LifetimeRange=(Min=2.721089,Max=4.081633)
        StartVelocityRange=(X=(Min=222.000000,Max=1233.564941),Y=(Min=-1233.564941,Max=1233.564941),Z=(Min=-1233.000000,Max=1233.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
        Name="Sparks_Sub"
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
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=222.000000)
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.280000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="fire_carpet"
        StartLocationRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=32.250000,Max=42.250000),Y=(Min=32.250000,Max=42.250000),Z=(Min=32.250000,Max=42.250000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.700000,Max=0.900000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
        Opacity=0.800000
        FadeOutStartTime=0.071429
        FadeInEndTime=0.071429
        MaxParticles=12
        Name="Smoke"
        StartLocationRange=(Y=(Min=-88.000000,Max=88.000000),Z=(Min=-88.000000,Max=88.000000))
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
        LifetimeRange=(Min=2.857143,Max=10.000000)
        StartVelocityRange=(X=(Min=-908.950012,Max=1578.780029),Y=(Min=-655.000000,Max=655.000000),Z=(Min=-655.000000,Max=655.000000))
        VelocityLossRange=(X=(Min=4.900000,Max=4.900000),Y=(Min=4.900000,Max=4.900000),Z=(Min=4.900000,Max=4.900000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
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
        Acceleration=(Z=38.072998)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.800000
        FadeOutStartTime=0.264286
        FadeInEndTime=0.264286
        MaxParticles=9
        Name="Smoke_fire"
        DetailMode=DM_SuperHigh
        StartLocationRange=(Y=(Min=-88.000000,Max=88.000000),Z=(Min=-88.000000,Max=88.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.018000,Max=0.018000))
        StartSpinRange=(X=(Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=28.000000,Max=63.000000),Y=(Min=28.000000,Max=63.000000),Z=(Min=28.000000,Max=63.000000))
        InitialParticlesPerSecond=84.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5fireQb'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.428571,Max=2.857143)
        StartVelocityRange=(X=(Min=-457.169983,Max=1143.169922),Y=(Min=-451.779968,Max=451.779968),Z=(Min=-451.779968,Max=451.779968))
        VelocityLossRange=(X=(Min=4.900000,Max=4.900000),Y=(Min=4.900000,Max=4.900000),Z=(Min=4.900000,Max=4.900000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        UseDirectionAs=PTDU_Up
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
        Opacity=0.760000
        FadeOutStartTime=0.130000
        FadeInEndTime=0.130000
        MaxParticles=1
        Name="RL_ExpCore"
        DetailMode=DM_High
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=6.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=55.000000,Max=55.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.429000,Max=0.500000)
        InitialDelayRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-81.584999,Max=81.584999),Y=(Min=-81.584999,Max=81.584999),Z=(Min=-81.584999,Max=81.584999))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.160000
        MaxParticles=1
        Name="Dots"
        DetailMode=DM_High
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
        StartSizeRange=(X=(Min=21.000000,Max=34.649998),Y=(Min=21.000000,Max=34.649998),Z=(Min=21.000000,Max=34.649998))
        InitialParticlesPerSecond=77.699997
        Texture=Texture'G_FX.Mflashes.mini_sparks_1'
        LifetimeRange=(Min=0.285714,Max=0.571429)
        StartVelocityRange=(X=(Min=-81.584999,Max=81.584999),Y=(Min=-81.584999,Max=81.584999),Z=(Min=-81.584999,Max=81.584999))
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
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
        FadeOutStartTime=0.246000
        MaxParticles=2
        Name="Fireflash"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=26.250000,Max=47.250000),Y=(Min=26.250000,Max=47.250000),Z=(Min=26.250000,Max=47.250000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.500000,Max=0.700000)
        StartVelocityRange=(X=(Min=-81.584999,Max=81.584999),Y=(Min=-81.584999,Max=81.584999),Z=(Min=-81.584999,Max=81.584999))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=0.002000
        MaxParticles=2
        Name="Ripple"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=55.000000,Max=55.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
        InitialParticlesPerSecond=140.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.400000,Max=0.400000)
        StartVelocityRange=(X=(Min=-81.584999,Max=81.584999),Y=(Min=-81.584999,Max=81.584999),Z=(Min=-81.584999,Max=81.584999))
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.740000
        FadeOutStartTime=0.167143
        MaxParticles=2
        Name="Firetrail"
        SpinsPerSecondRange=(X=(Min=0.140000,Max=0.140000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=80.849998,Max=108.779991),Y=(Min=80.849998,Max=108.779991),Z=(Min=80.849998,Max=108.779991))
        InitialParticlesPerSecond=23.100000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.428571,Max=0.428571)
        InitialDelayRange=(Min=0.170000,Max=0.170000)
        StartVelocityRange=(X=(Min=-114.218994,Max=114.218994),Y=(Min=-114.218994,Max=114.218994),Z=(Min=-114.218994,Max=114.218994))
    End Object
    Emitters(9)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
        MaxParticles=333
        Name="Sparktrailers"
        DetailMode=DM_SuperHigh
        StartLocationRange=(Z=(Min=11.000000,Max=11.000000))
        AddLocationFromOtherEmitter=0
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
    Emitters(10)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.280000
        MaxParticles=1
        Name="Spikes"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
        StartSizeRange=(X=(Min=31.500000,Max=31.500000),Y=(Min=31.500000,Max=31.500000),Z=(Min=31.500000,Max=31.500000))
        InitialParticlesPerSecond=77.699997
        Texture=Texture'G_FX.Smokes.Smikes2sm'
        LifetimeRange=(Min=0.142857,Max=0.571429)
        StartVelocityRange=(X=(Min=-81.584999,Max=81.584999),Y=(Min=-81.584999,Max=81.584999),Z=(Min=-81.584999,Max=81.584999))
    End Object
    Emitters(11)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=MeshEmitter Name=MeshEmitter0
        StaticMesh=StaticMesh'G_Meshes.Projectiles.hrl_eject_0'
        UseCollision=True
        RespawnDeadParticles=False
        SpinParticles=True
        DampRotation=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-1100.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=7
        Name="Shrapnel"
        DetailMode=DM_SuperHigh
        StartLocationRange=(X=(Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000),Z=(Min=1.000000,Max=3.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        RotationDampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
        RotationNormal=(X=2.000000,Y=2.000000,Z=2.000000)
        StartSizeRange=(X=(Min=0.030000,Max=0.100000),Y=(Min=0.030000,Max=0.100000),Z=(Min=0.030000,Max=0.100000))
        Sounds(0)=(Sound=SoundGroup'G_Proc.impactfx.p_debris_metal_a',Radius=(Min=20.000000,Max=20.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.000000,Max=1.000000),Probability=(Min=1.000000,Max=1.000000))
        CollisionSound=PTSC_LinearLocal
        CollisionSoundProbability=(Min=1.000000,Max=1.000000)
        InitialParticlesPerSecond=311.000000
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Max=8.000000)
        StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
        StartVelocityRadialRange=(Min=-1111.000000,Max=-1111.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(12)=MeshEmitter'MeshEmitter0'

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
        FadeOutStartTime=0.276000
        MaxParticles=1
        Name="Flower"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=26.250000,Max=32.250000),Y=(Min=26.250000,Max=32.250000),Z=(Min=26.250000,Max=32.250000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Mflashes.mflash4b'
        LifetimeRange=(Min=0.600000,Max=0.600000)
        StartVelocityRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
    End Object
    Emitters(13)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
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
        Opacity=0.600000
        FadeOutStartTime=0.240000
        FadeInEndTime=0.180000
        MaxParticles=1
        Name="Fire-linger"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=222.000000,Max=222.000000),Y=(Min=222.000000,Max=222.000000),Z=(Min=222.000000,Max=222.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Flares.flare5'
        LifetimeRange=(Min=1.500000,Max=1.500000)
        InitialDelayRange=(Min=0.300000,Max=0.300000)
    End Object
    Emitters(14)=SpriteEmitter'SpriteEmitter13'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter14
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=222.000000)
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.280000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="fire_carpet"
        StartLocationRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=32.250000,Max=42.250000),Y=(Min=32.250000,Max=42.250000),Z=(Min=32.250000,Max=42.250000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.700000,Max=0.900000)
    End Object
    Emitters(15)=SpriteEmitter'SpriteEmitter14'


}
