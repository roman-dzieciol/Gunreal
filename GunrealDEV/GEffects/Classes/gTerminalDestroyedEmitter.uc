// ============================================================================
//  gTerminalDestroyedEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTerminalDestroyedEmitter extends gNetTemporaryEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter25
        UseDirectionAs=PTDU_Forward
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        FadeOutStartTime=0.068000
        MaxParticles=77
        Name="bubble_destroyed"
        StartLocationOffset=(Z=80.000000)
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=122.000000,Max=122.000000)
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
        StartSizeRange=(X=(Min=33.000000,Max=33.000000),Y=(Min=33.000000,Max=33.000000),Z=(Min=33.000000,Max=33.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Qe'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.400000,Max=0.400000)
        StartVelocityRadialRange=(Min=1.000000,Max=1.000000)
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter25'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter26
        UseDirectionAs=PTDU_Normal
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
        FadeOutStartTime=0.170000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="floor_shockwave"
        StartLocationOffset=(Z=5.000000)
        StartLocationRange=(Z=(Min=1.000000,Max=5.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=133.000000,Max=155.000000),Y=(Min=133.000000,Max=155.000000),Z=(Min=133.000000,Max=155.000000))
        InitialParticlesPerSecond=70.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Qe'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.400000,Max=0.800000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter26'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.500000
        MaxParticles=1
        Name="flash_spots"
        StartLocationOffset=(Z=99.000000)
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=44.000000,Max=44.000000)
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=4.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=222.000000,Max=222.000000),Y=(Min=222.000000,Max=222.000000),Z=(Min=222.000000,Max=222.000000))
        InitialParticlesPerSecond=7222.000000
        Texture=Texture'G_FX.Mflashes.spot1'
        LifetimeRange=(Min=0.300000,Max=2.000000)
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
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
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        FadeOutStartTime=0.105000
        MaxParticles=4
        Name="burst-off"
        StartLocationOffset=(Z=99.000000)
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=33.000000,Max=33.000000)
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
        StartSizeRange=(X=(Min=66.000000,Max=66.000000),Y=(Min=66.000000,Max=66.000000),Z=(Min=66.000000,Max=66.000000))
        InitialParticlesPerSecond=555.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Qe'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.700000,Max=0.700000)
        StartVelocityRadialRange=(Min=1.000000,Max=1.000000)
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter1'

}