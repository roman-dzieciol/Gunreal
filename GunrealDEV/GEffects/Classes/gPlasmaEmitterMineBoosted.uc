// ============================================================================
//  gPlasmaEmitterMineBoosted.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaEmitterMineBoosted extends gPlasmaEmitterMineBase;




DefaultProperties
{


    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        CoordinateSystem=PTCS_Relative
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=242,G=208,R=145,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=238,G=190,R=147,A=255))
        Opacity=0.980000
        MaxParticles=111
        Name="P_Core"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=12.000000,Max=28.000000),Y=(Min=12.000000,Max=28.000000),Z=(Min=12.000000,Max=28.000000))
        ParticlesPerSecond=12.000000
        InitialParticlesPerSecond=12.000000
        Texture=Texture'G_FX.Mflashes.mini_blue1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.300000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        CoordinateSystem=PTCS_Relative
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        MaxParticles=33
        Name="Elec"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=27.000000,Max=27.000000),Y=(Min=27.000000,Max=27.000000),Z=(Min=27.000000,Max=27.000000))
        ParticlesPerSecond=12.000000
        InitialParticlesPerSecond=12.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        CoordinateSystem=PTCS_Relative
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=242,G=208,R=145,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=238,G=190,R=147,A=255))
        MaxParticles=111
        Name="P_Grounded"
        StartLocationRange=(Z=(Min=-2.000000,Max=2.000000))
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=12.000000,Max=23.000000),Y=(Min=12.000000,Max=23.000000),Z=(Min=12.000000,Max=23.000000))
        ParticlesPerSecond=12.000000
        InitialParticlesPerSecond=12.000000
        Texture=Texture'G_FX.Mflashes.mini_blue1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.650000,Max=0.650000)
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        CoordinateSystem=PTCS_Relative
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.640000
        FadeOutStartTime=0.260000
        FadeInEndTime=0.096000
        MaxParticles=111
        Name="Membrane"
        SpinsPerSecondRange=(X=(Min=-0.300000,Max=0.300000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.150000)
        StartSizeRange=(X=(Min=50.000000,Max=55.000000),Y=(Min=50.000000,Max=55.000000),Z=(Min=50.000000,Max=55.000000))
        ParticlesPerSecond=8.000000
        InitialParticlesPerSecond=8.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.400000,Max=0.400000)
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        CoordinateSystem=PTCS_Relative
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.540000
        FadeOutStartTime=0.270000
        FadeInEndTime=0.270000
        MaxParticles=33
        Name="Memb_Grounded"
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
        StartSizeRange=(X=(Min=55.000000,Max=55.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
        ParticlesPerSecond=5.000000
        InitialParticlesPerSecond=5.000000
        Texture=Texture'G_FX.Plasmafx.Plasmaball_E'
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        CoordinateSystem=PTCS_Relative
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.830000
        MaxParticles=25
        Name="Elec_Feed"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=55.000000,Max=55.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
        InitialParticlesPerSecond=90.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=Boostminesmoke
        CoordinateSystem=PTCS_Relative
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=15.000000)
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.040000
        FadeOutStartTime=3.120000
        FadeInEndTime=1.800000
        MaxParticles=222
        Name="Boostminesmoke"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
        ParticlesPerSecond=12.000000
        InitialParticlesPerSecond=5.000000
        Texture=Texture'G_FX.Mflashes.mini_blue2_quad_sm'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=6.000000,Max=6.000000)
        StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(6)=SpriteEmitter'Boostminesmoke'

    Begin Object Class=SpriteEmitter Name=SpriteEmitterA
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=15.000000)
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.160000
        FadeOutStartTime=3.120000
        FadeInEndTime=1.800000
        MaxParticles=111
        Name="Boostminesmoke"
        SpinsPerSecondRange=(X=(Min=-0.200000,Max=0.200000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=20.000000,Max=20.000000),Z=(Min=20.000000,Max=20.000000))
        ParticlesPerSecond=6.000000
        InitialParticlesPerSecond=6.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Mflashes.mini_blue2_quad_sm'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=6.000000,Max=6.000000)
        StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitterA'

    Begin Object Class=SpriteEmitter Name=SpriteEmitterB
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.830000
        CoordinateSystem=PTCS_Relative
        MaxParticles=25
        Name="Elec_boost"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=55.000000,Max=85.000000),Y=(Min=55.000000,Max=85.000000),Z=(Min=55.000000,Max=85.000000))
        ParticlesPerSecond=12.000000
        InitialParticlesPerSecond=12.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitterB'


}
