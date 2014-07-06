// ============================================================================
//  gMainMenuEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMainMenuEmitter extends gEmitter;



DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.000000
        FadeOutStartTime=0.285000
        FadeInEndTime=0.285000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="rings_blurry"
        StartLocationRange=(Y=(Min=-6.000000,Max=6.000000),Z=(Min=-6.000000,Max=6.000000))
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=7.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=77.000000,Max=77.000000),Y=(Min=77.000000,Max=77.000000),Z=(Min=77.000000,Max=77.000000))
        ParticlesPerSecond=7.000000
        InitialParticlesPerSecond=7.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Menu.Rings_blurry_2'
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.430000
        FadeOutStartTime=0.285000
        FadeInEndTime=0.285000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="rings_sharp"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.150000)
        StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
        ParticlesPerSecond=1.500000
        InitialParticlesPerSecond=1.500000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Menu.Rings_1_noblur'
        LifetimeRange=(Min=3.000000,Max=3.000000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.330000
        FadeOutStartTime=0.980000
        FadeInEndTime=0.980000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="rings_blur"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.400000)
        StartSizeRange=(X=(Min=77.000000,Max=77.000000),Y=(Min=77.000000,Max=77.000000),Z=(Min=77.000000,Max=77.000000))
        ParticlesPerSecond=1.500000
        InitialParticlesPerSecond=1.500000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Menu.Rings_blurry_b'
        LifetimeRange=(Min=2.000000,Max=2.000000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.240000
        FadeOutStartTime=0.740000
        FadeInEndTime=0.740000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="rings_blur_a"
        StartLocationRange=(Z=(Min=-11.000000,Max=11.000000))
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=7.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=77.000000,Max=77.000000),Y=(Min=77.000000,Max=77.000000),Z=(Min=77.000000,Max=77.000000))
        ParticlesPerSecond=2.000000
        InitialParticlesPerSecond=2.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Menu.Rings_blurry_b'
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(Z=(Min=11.000000,Max=11.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.140000
        FadeOutStartTime=1.600000
        FadeInEndTime=1.600000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="fractal_expand"
        StartLocationOffset=(X=-12.000000)
        StartLocationRange=(Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=66.000000,Max=66.000000),Y=(Min=66.000000,Max=66.000000),Z=(Min=66.000000,Max=66.000000))
        ParticlesPerSecond=2.000000
        InitialParticlesPerSecond=2.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Menu.Rings_blurry_c'
        LifetimeRange=(Min=8.000000,Max=8.000000)
        StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=0.500000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="blue"
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=7.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=90.000000,Max=90.000000),Y=(Min=90.000000,Max=90.000000),Z=(Min=90.000000,Max=90.000000))
        ParticlesPerSecond=11.000000
        InitialParticlesPerSecond=11.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Menu.Blue'
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.560000
        FadeOutStartTime=0.285000
        FadeInEndTime=0.285000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="flare"
        StartLocationOffset=(Y=-1.500000)
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=7.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=75.000000,Max=75.000000),Y=(Min=75.000000,Max=75.000000),Z=(Min=75.000000,Max=75.000000))
        ParticlesPerSecond=4.000000
        InitialParticlesPerSecond=4.000000
        Texture=Texture'G_FX.Menu.Flare'
        LifetimeRange=(Min=1.000000,Max=1.000000)
        InitialDelayRange=(Min=1.000000,Max=1.000000)
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=1.000000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Gunreal"
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=7.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=77.000000,Max=77.000000),Y=(Min=77.000000,Max=77.000000),Z=(Min=77.000000,Max=77.000000))
        ParticlesPerSecond=4.000000
        InitialParticlesPerSecond=4.000000
        Texture=Texture'G_FX.Menu.Gunreal_1'
        LifetimeRange=(Min=1.000000,Max=1.000000)
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.590000
        FadeOutStartTime=2.000000
        CoordinateSystem=PTCS_Relative
        MaxParticles=11
        Name="flare_flash1"
        StartLocationRange=(Y=(Min=-33.000000,Max=33.000000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=0.500000,RelativeSize=1.300000)
        SizeScale(3)=(RelativeTime=0.750000,RelativeSize=0.800000)
        SizeScale(4)=(RelativeTime=1.000000)
        SizeScaleRepeats=2.000000
        StartSizeRange=(X=(Min=88.000000,Max=88.000000),Y=(Min=88.000000,Max=88.000000),Z=(Min=88.000000,Max=88.000000))
        ParticlesPerSecond=0.200000
        InitialParticlesPerSecond=0.200000
        Texture=Texture'G_FX.Flares.flare3'
        LifetimeRange=(Min=0.500000,Max=0.500000)
        InitialDelayRange=(Min=18.000000,Max=18.000000)
        StartVelocityRange=(X=(Min=-40.000000,Max=40.000000))
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.740000
        FadeOutStartTime=2.000000
        CoordinateSystem=PTCS_Relative
        MaxParticles=11
        Name="flare_flash2"
        StartLocationRange=(Y=(Min=-33.000000,Max=33.000000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=0.500000,RelativeSize=1.300000)
        SizeScale(3)=(RelativeTime=0.750000,RelativeSize=0.800000)
        SizeScale(4)=(RelativeTime=1.000000)
        SizeScaleRepeats=3.000000
        StartSizeRange=(X=(Min=66.000000,Max=66.000000),Y=(Min=66.000000,Max=66.000000),Z=(Min=66.000000,Max=66.000000))
        ParticlesPerSecond=0.300000
        InitialParticlesPerSecond=0.300000
        Texture=Texture'G_FX.Flares.flare3'
        LifetimeRange=(Min=0.600000,Max=0.600000)
        InitialDelayRange=(Min=18.000000,Max=18.000000)
        StartVelocityRange=(X=(Min=-40.000000,Max=40.000000))
    End Object
    Emitters(9)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.680000
        FadeOutStartTime=2.000000
        CoordinateSystem=PTCS_Relative
        MaxParticles=11
        Name="flare_flash3"
        StartLocationRange=(Y=(Min=-33.000000,Max=33.000000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(1)=(RelativeTime=0.250000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=0.500000,RelativeSize=1.300000)
        SizeScale(3)=(RelativeTime=0.750000,RelativeSize=0.800000)
        SizeScale(4)=(RelativeTime=1.000000)
        SizeScaleRepeats=2.000000
        StartSizeRange=(X=(Min=77.000000,Max=77.000000),Y=(Min=77.000000,Max=77.000000),Z=(Min=77.000000,Max=77.000000))
        ParticlesPerSecond=0.400000
        InitialParticlesPerSecond=0.400000
        Texture=Texture'G_FX.Flares.flare3'
        LifetimeRange=(Min=0.900000,Max=0.900000)
        InitialDelayRange=(Min=18.000000,Max=18.000000)
        StartVelocityRange=(X=(Min=-40.000000,Max=40.000000))
    End Object
    Emitters(10)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter14
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.050000
        FadeOutStartTime=4.550000
        FadeInEndTime=4.550000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="rings_pan"
        StartLocationOffset=(X=-33.000000,Z=33.000000)
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=6.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=333.000000,Max=333.000000),Y=(Min=333.000000,Max=333.000000),Z=(Min=333.000000,Max=333.000000))
        ParticlesPerSecond=0.600000
        InitialParticlesPerSecond=0.600000
        Texture=Texture'G_FX.Menu.Rings_1'
        LifetimeRange=(Min=7.000000,Max=7.000000)
        InitialDelayRange=(Min=18.000000,Max=18.000000)
        StartVelocityRange=(Y=(Min=11.000000,Max=11.000000))
    End Object
    Emitters(11)=SpriteEmitter'SpriteEmitter14'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        RespawnDeadParticles=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(RelativeTime=0.000000,Color=(B=1))
        ColorScale(1)=(RelativeTime=0.000000,Color=(B=57))
        ColorScale(2)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=1.400000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        name="BLACK"
        StartLocationOffset=(X=-53.000000)
        StartSizeRange=(X=(Min=500.000000,Max=500.000000),Y=(Min=500.000000,Max=500.000000),Z=(Min=500.000000,Max=500.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Menu.Black'
        InitialTimeRange=(Min=1.000000,Max=1.000000)
        LifetimeRange=(Min=7.000000,Max=7.000000)
        WarmupTicksPerSecond=2
        RelativeWarmupTime=0.2
    End Object
    Emitters(12)=SpriteEmitter'SpriteEmitter4'
}