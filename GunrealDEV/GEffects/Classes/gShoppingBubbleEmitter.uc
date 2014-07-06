// ============================================================================
//  gShoppingBubbleEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShoppingBubbleEmitter extends gEmitter;

DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=333.000000)
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
        Opacity=0.250000
        FadeOutStartTime=0.068000
        CoordinateSystem=PTCS_Relative
        MaxParticles=222
        Name="dots"
        DetailMode=DM_High
        StartLocationOffset=(Z=21.000000)
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=20.000000,Max=20.000000)
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=1.700000,Max=3.000000),Y=(Min=1.700000,Max=3.000000),Z=(Min=1.700000,Max=3.000000))
        InitialParticlesPerSecond=1600.000000
        Texture=Texture'G_FX.Plasmafx.P_dots2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.350000,Max=0.350000)
        StartVelocityRadialRange=(Min=670.000000,Max=670.000000)
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
        Opacity=0.760000
        FadeOutStartTime=0.048000
        MaxParticles=1
        Name="ripple"
        StartLocationOffset=(Z=55.000000)
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=33.000000,Max=33.000000),Y=(Min=33.000000,Max=33.000000),Z=(Min=33.000000,Max=33.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.350000,Max=0.350000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
        FadeOutStartTime=0.045500
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="ripple_floor"
        StartLocationOffset=(Z=7.000000)
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        InitialParticlesPerSecond=140.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.350000,Max=0.350000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.306000
        FadeInEndTime=0.306000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="floor_ring_init"
        StartLocationOffset=(Z=1.000000)
        StartLocationRange=(Z=(Min=5.000000,Max=5.000000))
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=114.000000,Max=114.000000),Y=(Min=114.000000,Max=114.000000),Z=(Min=114.000000,Max=114.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Shield.shield_ring_1'
        LifetimeRange=(Min=0.600000,Max=0.600000)
        InitialDelayRange=(Min=0.300000,Max=0.300000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseDirectionAs=PTDU_Normal
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.370000
        FadeOutStartTime=0.100000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="floor_ring_loop"
        StartLocationOffset=(Z=1.000000)
        StartLocationRange=(Z=(Min=5.000000,Max=5.000000))
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=114.000000,Max=114.000000),Y=(Min=114.000000,Max=114.000000),Z=(Min=114.000000,Max=114.000000))
        ParticlesPerSecond=10.000000
        InitialParticlesPerSecond=10.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Shield.shield_ring_1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
        InitialDelayRange=(Min=0.600000,Max=0.600000)
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter1'

}