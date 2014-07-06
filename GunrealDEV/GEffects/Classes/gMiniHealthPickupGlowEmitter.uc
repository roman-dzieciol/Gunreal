// ============================================================================
//  gMiniHealthPickupGlowEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMiniHealthPickupGlowEmitter extends gNetPersistentEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{

    Physics                 = PHYS_Trailer
    bTrailerSameRotation    = True

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.099000
        FadeInEndTime=0.099000
        MaxParticles=22
        Name="minihealth_sprite"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=16.000000,Max=16.000000),Y=(Min=16.000000,Max=16.000000),Z=(Min=16.000000,Max=16.000000))
        ParticlesPerSecond=7.000000
        InitialParticlesPerSecond=7.000000
        Texture=Texture'G_FX.Flares.flare4'
        LifetimeRange=(Min=0.400000,Max=0.400000)
        StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseDirectionAs=PTDU_Normal
        UseRotationFrom=PTRS_Actor
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        LowDetailFactor=0.500000
        ColorScale(0)=(Color=(B=243,G=141,R=205,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.600000,Max=0.600000))
        Opacity=0.550000
        FadeOutStartTime=0.440000
        FadeInEndTime=0.140000
        MaxParticles=5
        Name="and_7-up"
        StartLocationRange=(Z=(Min=-22.000000,Max=-22.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        ParticlesPerSecond=5.000000
        InitialParticlesPerSecond=5.000000
        Texture=Texture'G_FX.fX.waterripple_2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=-20.000000,Max=20.000000),Y=(Min=-20.000000,Max=20.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000))
        Opacity=0.370000
        FadeOutStartTime=1.000000
        FadeInEndTime=1.000000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="spawn-in_particles"
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=44.000000,Max=44.000000)
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
        InitialParticlesPerSecond=1622.000000
        Texture=Texture'G_FX.Plasmafx.P_dots2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=1.000000)
        StartVelocityRadialRange=(Min=-110.000000,Max=-110.000000)
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.800000,Max=0.800000))
        Opacity=0.800000
        FadeOutStartTime=0.300000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="orb"
        SpinsPerSecondRange=(X=(Max=0.500000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.300000)
        SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.500000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.300000)
        StartSizeRange=(X=(Min=17.000000,Max=17.000000),Y=(Min=17.000000,Max=17.000000),Z=(Min=17.000000,Max=17.000000))
        ParticlesPerSecond=2.000000
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.Plasmaball_1'
        LifetimeRange=(Min=0.500000,Max=0.500000)
        InitialDelayRange=(Min=0.400000,Max=0.400000)
        StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter3'
}