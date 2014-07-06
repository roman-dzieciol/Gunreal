// ============================================================================
//  gShieldHitProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShieldHitProjectile extends gShieldEmitter;

DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=22.000000)
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        FadeOutStartTime=0.141000
        FadeInEndTime=0.141000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="Red_big"
        StartLocationRange=(Y=(Min=-19.000000,Max=-7.000000))
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=22.000000,Max=75.000000),Y=(Min=22.000000,Max=75.000000),Z=(Min=22.000000,Max=75.000000))
        InitialParticlesPerSecond=44.000000
        Texture=Texture'G_FX.fX.hrl_shield_b1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter6'


}
