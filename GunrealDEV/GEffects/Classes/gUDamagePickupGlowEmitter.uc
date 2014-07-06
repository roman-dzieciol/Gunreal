// ============================================================================
//  gUDamagePickupGlowEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gUDamagePickupGlowEmitter extends gNetPersistentEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.300000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="double-damage_orb"
        SpinsPerSecondRange=(X=(Max=0.500000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.300000)
        SizeScale(1)=(RelativeTime=0.370000,RelativeSize=1.700000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.300000)
        StartSizeRange=(X=(Min=14.000000,Max=19.000000),Y=(Min=14.000000,Max=19.000000),Z=(Min=14.000000,Max=19.000000))
        ParticlesPerSecond=4.000000
        InitialParticlesPerSecond=4.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.Plasmaball_2'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        Opacity=0.780000
        CoordinateSystem=PTCS_Relative
        MaxParticles=22
        Name="elec_inner"
        SpinsPerSecondRange=(X=(Max=0.500000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=47.000000,Max=47.000000),Y=(Min=47.000000,Max=47.000000),Z=(Min=47.000000,Max=47.000000))
        ParticlesPerSecond=22.000000
        InitialParticlesPerSecond=22.000000
        Texture=Texture'G_FX.fX.hrl_shield_b1'
        LifetimeRange=(Min=0.150000,Max=0.150000)
        StartVelocityRange=(X=(Min=-2.000000,Max=2.000000),Y=(Min=-2.000000,Max=2.000000),Z=(Min=-2.000000,Max=2.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
        Opacity=0.650000
        FadeOutStartTime=0.250000
        CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="membrane"
        SpinsPerSecondRange=(X=(Min=2.000000,Max=4.000000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=12.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
        ParticlesPerSecond=5.000000
        InitialParticlesPerSecond=5.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'
}