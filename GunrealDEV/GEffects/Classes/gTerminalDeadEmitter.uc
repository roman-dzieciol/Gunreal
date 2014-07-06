// ============================================================================
//  gTerminalDeadEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTerminalDeadEmitter extends gNetPersistentEmitter;



DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter20
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        FadeOutStartTime=1.800000
        FadeInEndTime=0.510000
        CoordinateSystem=PTCS_Relative
        MaxParticles=22
        Name="broken_ring"
        StartLocationOffset=(Z=6.000000)
        StartLocationRange=(Z=(Min=11.000000,Max=11.000000))
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=66.000000,Max=66.000000),Y=(Min=66.000000,Max=66.000000),Z=(Min=66.000000,Max=66.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=1.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane1c'
        TextureUSubdivisions=1
        TextureVSubdivisions=1
        LifetimeRange=(Min=3.000000,Max=3.000000)
        InitialDelayRange=(Min=0.700000,Max=0.700000)
        StartVelocityRange=(Z=(Min=11.000000,Max=11.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter20'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter22
        FadeOut=True
        FadeIn=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        Acceleration=(Z=33.000000)
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.660000
        FadeOutStartTime=0.930000
        FadeInEndTime=0.300000
        CoordinateSystem=PTCS_Relative
        MaxParticles=77
        Name="smoke_red"
        StartLocationRange=(Z=(Min=11.000000,Max=11.000000))
        SpinsPerSecondRange=(X=(Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=15.000000,Max=29.000000),Y=(Min=15.000000,Max=29.000000),Z=(Min=15.000000,Max=29.000000))
        ParticlesPerSecond=11.000000
        InitialParticlesPerSecond=11.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Qb_sm'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter22'
}