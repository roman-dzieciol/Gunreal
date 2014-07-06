// ============================================================================
//  gDestroyerProjectileEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerProjectileEmitter extends gProjectileEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    AmbientGlow                 = 192
    LightRadius                 = 24
    LightBrightness             = 192
    LightSaturation             = 102
    LightHue                    = 189
    LightType                   = LT_Steady
    LightEffect                 = LE_QuadraticNonIncidence
    bDynamicLight               = True

    bTriggerKills               = True

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=0.018000
        FadeInEndTime=0.018000
        CoordinateSystem=PTCS_Relative
        MaxParticles=90
        Name="fire2"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.200000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=22.000000,Max=22.000000),Z=(Min=22.000000,Max=22.000000))
        ParticlesPerSecond=31.000000
        InitialParticlesPerSecond=31.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_flash_3quad_a'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.250000)
        StartVelocityRange=(X=(Min=-1044.000000,Max=-1044.000000),Y=(Min=-99.000000,Max=99.000000),Z=(Min=-99.000000,Max=99.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseColorScale=True
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
        Opacity=0.060000
        FadeOutStartTime=0.420000
        FadeInEndTime=0.420000
        MaxParticles=444
        Name="Smoke-behind"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.040000,Max=0.080000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
        StartSizeRange=(X=(Min=25.000000,Max=47.000000),Y=(Min=25.000000,Max=47.000000),Z=(Min=25.000000,Max=47.000000))
        ParticlesPerSecond=35.000000
        InitialParticlesPerSecond=35.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke2_b'
        LifetimeRange=(Min=3.000000,Max=6.000000)
        StartVelocityRange=(X=(Min=-1111.000000,Max=-1111.000000),Y=(Min=-125.000000,Max=125.000000),Z=(Min=-125.000000,Max=125.000000))
        VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
        FadeOutStartTime=0.099000
        FadeInEndTime=0.081000
        CoordinateSystem=PTCS_Relative
        MaxParticles=90
        Name="DestroyerFire"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.200000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=19.000000,Max=19.000000),Y=(Min=19.000000,Max=19.000000),Z=(Min=19.000000,Max=19.000000))
        ParticlesPerSecond=31.000000
        InitialParticlesPerSecond=31.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.Kafire3'
        LifetimeRange=(Min=0.200000,Max=0.300000)
        StartVelocityRange=(X=(Min=-622.000000,Max=-622.000000),Y=(Min=-42.000000,Max=42.000000),Z=(Min=-42.000000,Max=42.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

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
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        Opacity=0.060000
        FadeOutStartTime=0.420000
        FadeInEndTime=0.420000
        MaxParticles=444
        Name="Smoke-front"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.040000,Max=0.080000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
        StartSizeRange=(X=(Min=25.000000,Max=47.000000),Y=(Min=25.000000,Max=47.000000),Z=(Min=25.000000,Max=47.000000))
        ParticlesPerSecond=35.000000
        InitialParticlesPerSecond=35.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke2_b'
        LifetimeRange=(Min=3.000000,Max=6.000000)
        StartVelocityRange=(X=(Min=-1111.000000,Max=-1111.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
        VelocityLossRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Brightener"
        SpinCCWorCW=(X=1.000000)
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=66.000000,Max=66.000000),Y=(Min=66.000000,Max=66.000000),Z=(Min=66.000000,Max=66.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter4'
}