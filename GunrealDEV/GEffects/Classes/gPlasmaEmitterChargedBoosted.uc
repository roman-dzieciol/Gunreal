// ============================================================================
//  gPlasmaEmitterChargedBoosted.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaEmitterChargedBoosted extends gPlasmaEmitterChargedBase;


DefaultProperties
{
    DisableOnTrigger(0)         = 0
    DisableOnTrigger(1)         = 2
    DisableOnTrigger(2)         = 3


    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
        FadeOutStartTime=0.064500
        CoordinateSystem=PTCS_Relative
        MaxParticles=33
        Name="Arcs"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=25.000000,Max=35.000000),Y=(Min=25.000000,Max=35.000000),Z=(Min=25.000000,Max=35.000000))
        ParticlesPerSecond=12.000000
        InitialParticlesPerSecond=12.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.100000,Max=0.150000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-70.000000)
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.850000,Max=0.850000))
        Opacity=0.360000
        FadeOutStartTime=0.100000
        FadeInEndTime=0.100000
        MaxParticles=500
        Name="Vapor-Boost"
        DetailMode=DM_SuperHigh
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=30.000000,Max=50.000000),Y=(Min=30.000000,Max=50.000000),Z=(Min=30.000000,Max=50.000000))
        ParticlesPerSecond=122.000000
        InitialParticlesPerSecond=122.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.p_smoke1'
        LifetimeRange=(Min=1.000000,Max=2.000000)
        InitialDelayRange=(Min=0.150000,Max=0.150000)
        StartVelocityRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.100000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Ball"
        SpinCCWorCW=(X=1.000000)
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.800000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=35.000000,Max=35.000000),Y=(Min=35.000000,Max=35.000000),Z=(Min=35.000000,Max=35.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=1111.000000
        Texture=Texture'G_FX.Plasmafx.PlasmaballA'
        LifetimeRange=(Min=1.000000,Max=1.000000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
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
        Opacity=0.240000
        MaxParticles=111
        Name="Glow"
        DetailMode=DM_SuperHigh
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=12.000000,Max=20.000000),Y=(Min=12.000000,Max=20.000000),Z=(Min=12.000000,Max=20.000000))
        ParticlesPerSecond=111.000000
        InitialParticlesPerSecond=111.000000
        Texture=Texture'G_FX.Plasmafx.PlasmaballA'
        LifetimeRange=(Min=0.100000,Max=0.200000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter7'

}
