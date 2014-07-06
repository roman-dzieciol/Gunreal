// ============================================================================
//  gRoxSmokeTrail.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRoxSmokeTrail extends gProjectileEmitter;

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    bTriggerKills               = True
    DisableOnTrigger(0)         = 2

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
        Opacity=0.770000
        FadeOutStartTime=0.150000
        FadeInEndTime=0.100000
        MaxParticles=16
        Name="intro-smoke"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=26.000000,Max=26.000000),Y=(Min=26.000000,Max=26.000000),Z=(Min=26.000000,Max=26.000000))
        InitialParticlesPerSecond=70.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke52Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.000000,Max=5.000000)
        StartVelocityRange=(X=(Min=-77.000000,Max=77.000000),Y=(Min=-77.000000,Max=77.000000),Z=(Min=-77.000000,Max=77.000000))
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
        Opacity=0.500000
        MaxParticles=3222
        Name="Smoke"
        DetailMode=DM_SuperHigh
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
        ParticlesPerSecond=33.000000
        InitialParticlesPerSecond=33.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke52Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=3.500000)
        StartVelocityRange=(X=(Min=611.000000,Max=611.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        Opacity=0.580000
        CoordinateSystem=PTCS_Relative
        MaxParticles=90
        Name="Fire1"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.200000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
        ParticlesPerSecond=44.000000
        InitialParticlesPerSecond=44.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.400000)
        StartVelocityRange=(X=(Min=-511.000000,Max=-511.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.280000
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Brightener"
        StartLocationRange=(X=(Min=-22.000000,Max=-22.000000))
        SpinCCWorCW=(X=1.000000)
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=66.000000,Max=66.000000),Y=(Min=66.000000,Max=66.000000),Z=(Min=66.000000,Max=66.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
        Opacity=0.390000
        FadeOutStartTime=0.490000
        FadeInEndTime=0.210000
        MaxParticles=800
        Name="Smoke_mid"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=13.000000,Max=22.000000),Y=(Min=13.000000,Max=22.000000),Z=(Min=13.000000,Max=22.000000))
        ParticlesPerSecond=55.000000
        InitialParticlesPerSecond=55.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke52Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=3.500000)
        StartVelocityRange=(X=(Min=600.000000,Max=600.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter11'
}