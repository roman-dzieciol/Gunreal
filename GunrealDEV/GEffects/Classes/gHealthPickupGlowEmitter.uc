// ============================================================================
//  gHealthPickupGlowEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHealthPickupGlowEmitter extends gNetPersistentEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
        MaxParticles=22
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=15.000000,Max=29.000000),Y=(Min=15.000000,Max=29.000000),Z=(Min=15.000000,Max=29.000000))
        ParticlesPerSecond=22.000000
        InitialParticlesPerSecond=22.000000
        Texture=Texture'G_FX.Flares.flare4'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'
}