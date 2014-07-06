// ============================================================================
//  gMineExplosion.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineExplosion extends gHitEmitterNet;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ClientSpawnClass    = class'GEffects.gMineScorch'
    ClientSpawnAxes     = (X=-1,Y=-1,Z=-1)
    
    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=1
        SpawnAmount=2
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        Opacity=0.000000
        FadeOutStartTime=0.160000
        MaxParticles=555
        Name="Colliders"
        DetailMode=DM_SuperHigh
        StartLocationOffset=(X=300.000000)
        SphereRadiusRange=(Min=300.000000,Max=300.000000)
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
        InitialParticlesPerSecond=4555.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.fireburst2'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-3333.000000,Max=3333.000000),Y=(Min=-3333.000000,Max=3333.000000),Z=(Min=-3333.000000,Max=3333.000000))
        StartVelocityRadialRange=(Min=1800.000000,Max=1800.000000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
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
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.340000
        FadeOutStartTime=0.280000
        FadeInEndTime=0.280000
        MaxParticles=2800
        Name="Coll_smokes"
        DetailMode=DM_SuperHigh
        StartLocationRange=(X=(Min=-6.000000,Max=6.000000),Y=(Min=-6.000000,Max=6.000000),Z=(Min=20.000000,Max=20.000000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=17.000000,Max=32.000000),Y=(Min=17.000000,Max=32.000000),Z=(Min=17.000000,Max=32.000000))
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke52Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=6.000000)
        StartVelocityRange=(X=(Min=-155.000000,Max=155.000000),Y=(Min=-155.000000,Max=155.000000),Z=(Min=-155.000000,Max=155.000000))
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter13'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseCollision=True
        UseMaxCollisions=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-400.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=3
        SpawnAmount=10
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.600000,Max=0.600000),Z=(Min=0.500000,Max=0.500000))
        FadeOutStartTime=5.000000
        MaxParticles=22
        Name="sparks_main"
        StartLocationOffset=(Z=11.000000)
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        LifetimeRange=(Min=0.300000,Max=0.600000)
        StartVelocityRange=(X=(Max=1188.000000),Y=(Min=-1088.000000,Max=1088.000000),Z=(Min=-1088.000000,Max=1088.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-220.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.600000,Max=0.600000),Z=(Min=0.500000,Max=0.500000))
        FadeOutStartTime=2.010000
        MaxParticles=155
        Name="sparks_sub"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=0.700000,Max=1.200000)
        StartVelocityRange=(X=(Min=-222.000000,Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=2.000000,Max=250.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-220.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
        FadeOutStartTime=7.000000
        MaxParticles=222
        Name="sparks_trailers"
        DetailMode=DM_High
        AddLocationFromOtherEmitter=2
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.400000,Max=2.200000),Y=(Min=1.400000,Max=2.200000),Z=(Min=1.400000,Max=2.200000))
        InitialParticlesPerSecond=1111.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=3.000000,Max=6.000000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-333.000000,Max=333.000000),Y=(Min=-333.000000,Max=333.000000),Z=(Min=2.000000,Max=250.000000))
        VelocityLossRange=(X=(Min=2.500000,Max=3.500000),Y=(Min=2.500000,Max=3.500000),Z=(Min=2.500000,Max=3.500000))
        AddVelocityFromOtherEmitter=2
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=44.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.550000
        MaxParticles=222
        Name="smoke_trailers"
        DetailMode=DM_High
        AddLocationFromOtherEmitter=2
        StartSpinRange=(X=(Min=0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=22.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=11.000000)
        StartSizeRange=(X=(Min=1.200000,Max=2.800000),Y=(Min=1.200000,Max=2.800000),Z=(Min=1.200000,Max=2.800000))
        InitialParticlesPerSecond=1177.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Qb'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=3.000000,Max=7.000000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=2.000000,Max=250.000000))
        VelocityLossRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
        AddVelocityFromOtherEmitter=2
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter4'

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
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.500000,Max=0.500000))
        Opacity=0.830000
        MaxParticles=2
        Name="Brightener"
        DetailMode=DM_High
        StartLocationOffset=(Z=111.000000)
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=205.000000,Max=205.000000),Y=(Min=205.000000,Max=205.000000),Z=(Min=205.000000,Max=205.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Flares.flare5'
        LifetimeRange=(Min=0.400000,Max=0.400000)
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.300000
        MaxParticles=1
        Name="Fire-flash"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=25.000000,Max=50.000000),Y=(Min=25.000000,Max=50.000000),Z=(Min=25.000000,Max=50.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Smokes.boom1'
        LifetimeRange=(Min=0.500000,Max=0.600000)
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
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
        Opacity=0.600000
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="Fire_carpet"
        StartLocationOffset=(X=5.000000)
        StartLocationRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=8.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=33.000000,Max=58.000000),Y=(Min=33.000000,Max=58.000000),Z=(Min=33.000000,Max=58.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Smokes.boom1'
        LifetimeRange=(Min=0.300000,Max=0.500000)
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.730000
        FadeOutStartTime=0.224000
        FadeInEndTime=0.224000
        MaxParticles=2
        Name="Ripple"
        DetailMode=DM_High
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
    Emitters(9)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter14
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
        MaxParticles=1
        Name="Fire_out"
        SpinsPerSecondRange=(X=(Min=0.140000,Max=0.140000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=80.849998,Max=108.779991),Y=(Min=80.849998,Max=108.779991),Z=(Min=80.849998,Max=108.779991))
        InitialParticlesPerSecond=23.100000
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.500000)
        InitialDelayRange=(Min=0.170000,Max=0.170000)
    End Object
    Emitters(10)=SpriteEmitter'SpriteEmitter14'
}