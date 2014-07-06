// ============================================================================
//  gHRLShieldEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLShieldEmitter extends gHRLShield;

DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter40
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=1.000000,Z=0.000000)
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.360000
        FadeOutStartTime=0.318000
        FadeInEndTime=0.318000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="hrl_shield"
        StartLocationRange=(Y=(Min=-25.000000,Max=-26.000000))
        UseRotationFrom=PTRS_Offset
        RotationOffset=(Yaw=32767)
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        StartSizeRange=(X=(Min=30.000000,Max=30.000000),Y=(Min=30.000000,Max=30.000000),Z=(Min=30.000000,Max=30.000000))
        ParticlesPerSecond=4.000000
        InitialParticlesPerSecond=4.000000
        Texture=Texture'G_FX.fX.hrl_shield_a1'
        LifetimeRange=(Min=0.600000,Max=0.600000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter40'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter26
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=1.000000,Z=0.000000)
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.410000
        FadeOutStartTime=0.141000
        FadeInEndTime=0.141000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="shield_electric"
        StartLocationRange=(Y=(Min=15.000000,Max=35.000000),Z=(Min=-5.000000,Max=5.000000))
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=1.000000,Max=40.000000),Y=(Min=1.000000,Max=40.000000),Z=(Min=1.000000,Max=40.000000))
        ParticlesPerSecond=8.000000
        InitialParticlesPerSecond=8.000000
        Texture=Texture'G_FX.fX.hrl_shield_b1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter26'
}