// ============================================================================
//  gHRLSmokeTrail.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLSmokeTrail extends gProjectileEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    bTriggerKills               = True
    DisableOnTrigger(0)         = 3

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseColorScale=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=189,G=209,R=223,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=82,G=82,R=82,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        Opacity=0.730000
        FadeOutStartTime=0.120000
        FadeInEndTime=0.090000
        MaxParticles=850
        Name="Smoke"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.080000,Max=0.140000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=17.000000,Max=37.000000),Y=(Min=17.000000,Max=37.000000),Z=(Min=17.000000,Max=37.000000))
        ParticlesPerSecond=180.000000
        InitialParticlesPerSecond=180.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Qb'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=3.000000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-2333.000000,Max=-2333.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-51.000000,Max=111.000000))
        VelocityLossRange=(X=(Min=6.500000,Max=6.500000),Y=(Min=6.500000,Max=6.500000),Z=(Min=6.500000,Max=6.500000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
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
        Opacity=0.150000
        MaxParticles=222
        Name="Ripple_Alt"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
        ParticlesPerSecond=111.000000
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.260000,Max=0.260000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(Y=(Min=0.950000,Max=0.950000),Z=(Min=0.880000,Max=0.880000))
        Opacity=0.200000
        FadeOutStartTime=0.450000
        FadeInEndTime=0.450000
        MaxParticles=850
        Name="Smoke_mid"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.200000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=12.000000,Max=19.000000),Y=(Min=12.000000,Max=19.000000),Z=(Min=12.000000,Max=19.000000))
        ParticlesPerSecond=180.000000
        InitialParticlesPerSecond=180.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke6'
        LifetimeRange=(Min=2.000000,Max=3.000000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-2333.000000,Max=-2333.000000),Y=(Min=-152.000000,Max=152.000000),Z=(Min=-111.000000,Max=51.000000))
        VelocityLossRange=(X=(Min=6.500000,Max=6.500000),Y=(Min=6.500000,Max=6.500000),Z=(Min=6.500000,Max=6.500000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter15
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        Opacity=0.330000
        CoordinateSystem=PTCS_Relative
        MaxParticles=90
        Name="Fire"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.200000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
        ParticlesPerSecond=111.000000
        InitialParticlesPerSecond=111.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.150000,Max=0.350000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-633.000000,Max=-633.000000),Y=(Min=-100.000000,Max=100.000000),Z=(Min=-100.000000,Max=100.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter15'

}
