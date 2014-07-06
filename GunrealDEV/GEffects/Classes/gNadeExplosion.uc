// ============================================================================
//  gNadeExplosion.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gNadeExplosion extends gHitEmitterNet;



DefaultProperties
{
    ClientSpawnClass    = class'GEffects.gNadeScorch'
    ClientSpawnAxes     = (X=-1,Y=-1,Z=-1)
    
    Begin Object Class=SpriteEmitter Name=SpriteEmitter23
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-800.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=1
        SpawnAmount=5
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=1.590000
        MaxParticles=25
        Name="sparks_main"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-888.000000,Max=888.000000),Y=(Min=-888.000000,Max=888.000000),Z=(Min=-888.000000,Max=888.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter23'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
        UseCollision=True
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
        FadeOutStartTime=3.000000
        MaxParticles=155
        Name="sparks_sub"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
        InitialParticlesPerSecond=777.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-222.000000,Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=2.000000,Max=250.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter13'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter41
        FadeOut=True
        FadeIn=True
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
        FadeOutStartTime=0.050000
        FadeInEndTime=0.050000
        MaxParticles=11
        Name="smoke"
        StartLocationRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.020000,Max=0.020000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000))
        SizeScale(0)=(RelativeSize=1.400000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=55.000000,Max=77.000000),Y=(Min=55.000000,Max=77.000000),Z=(Min=55.000000,Max=77.000000))
        InitialParticlesPerSecond=555.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Qb'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=7.000000)
        StartVelocityRange=(X=(Min=-555.000000,Max=2222.000000),Y=(Min=-888.000000,Max=888.000000),Z=(Min=-888.000000,Max=888.000000))
        VelocityLossRange=(X=(Min=7.000000,Max=7.000000),Y=(Min=7.000000,Max=7.000000),Z=(Min=7.000000,Max=7.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter41'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter33
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
        Opacity=0.590000
        MaxParticles=5
        Name="fire_in"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=14.000000,Max=14.000000),Y=(Min=14.000000,Max=14.000000),Z=(Min=14.000000,Max=14.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.300000,Max=0.500000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter33'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter17
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
        Name="dots"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=20.000000,Max=33.000000),Y=(Min=20.000000,Max=33.000000),Z=(Min=20.000000,Max=33.000000))
        InitialParticlesPerSecond=111.000000
        Texture=Texture'G_FX.Mflashes.mini_sparks_1'
        LifetimeRange=(Min=0.200000,Max=0.400000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter17'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter18
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
        MaxParticles=2
        Name="fireflash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=9.000000)
        StartSizeRange=(X=(Min=25.000000,Max=45.000000),Y=(Min=25.000000,Max=45.000000),Z=(Min=25.000000,Max=45.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.300000,Max=0.500000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter18'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter24
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
        Opacity=0.800000
        FadeOutStartTime=0.048000
        MaxParticles=1
        Name="ripple"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=9.000000)
        StartSizeRange=(X=(Min=47.000000,Max=47.000000),Y=(Min=47.000000,Max=47.000000),Z=(Min=47.000000,Max=47.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter24'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
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
        FadeOutStartTime=0.117000
        MaxParticles=2
        Name="fire_out"
        SpinsPerSecondRange=(X=(Min=0.200000,Max=0.200000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=55.000000,Max=74.000000),Y=(Min=55.000000,Max=74.000000),Z=(Min=55.000000,Max=74.000000))
        InitialParticlesPerSecond=33.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.300000)
        InitialDelayRange=(Min=0.170000,Max=0.170000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter15
        UseCollision=True
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
        FadeOutStartTime=3.000000
        MaxParticles=444
        Name="spark_trailers"
        AddLocationFromOtherEmitter=0
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.400000,Max=2.200000),Y=(Min=1.400000,Max=2.200000),Z=(Min=1.400000,Max=2.200000))
        InitialParticlesPerSecond=444.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=3.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-222.000000,Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=2.000000,Max=250.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000),Z=(Min=1.000000,Max=5.000000))
        AddVelocityFromOtherEmitter=0
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter15'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter16
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.230000
        MaxParticles=1
        Name="spikes"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=10.000000)
        StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
        InitialParticlesPerSecond=111.000000
        Texture=Texture'G_FX.Smokes.Smikes2sm'
        LifetimeRange=(Min=0.100000,Max=0.400000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(9)=SpriteEmitter'SpriteEmitter16'

}