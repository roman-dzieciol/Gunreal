// ============================================================================
//  gSpamEmitterBlue.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpamEmitterBlue extends gSpamEmitter;



DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.800000,Max=0.800000))
        MaxParticles=1
        Name="spam_tick_blue"
        StartLocationRange=(X=(Min=4.000000,Max=4.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
        StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
        Sounds(0)=(Sound=ProceduralSound'G_Proc.Spammer.sp_p_tick',Radius=(Min=24.000000,Max=24.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.000000,Max=1.000000),Probability=(Min=1.000000,Max=1.000000))
        SpawningSound=PTSC_LinearLocal
        SpawningSoundProbability=(Min=1.000000,Max=1.000000)
        ParticlesPerSecond=0.650000
        InitialParticlesPerSecond=0.650000
        Texture=Texture'G_FX.Flares.flare5'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.300000,Max=0.300000)
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=222.000000)
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.800000,Max=0.800000))
        Opacity=0.270000
        MaxParticles=1
        Name="fake_lighting"
        StartLocationRange=(X=(Min=0.500000,Max=0.500000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=22.000000,Max=22.000000),Z=(Min=22.000000,Max=22.000000))
        Sounds(0)=(Radius=(Min=32.000000,Max=32.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.000000,Max=1.000000),Probability=(Min=1.000000,Max=1.000000))
        SpawningSoundProbability=(Min=1.000000,Max=1.000000)
        ParticlesPerSecond=0.650000
        InitialParticlesPerSecond=0.650000
        Texture=Texture'G_FX.Flares.flare5'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=0.300000,Max=0.300000)
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter2'

}
