// ============================================================================
//  gMinigunTracer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunTracer extends gTracerEmitter;



DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
        UseDirectionAs=PTDU_Right
        UseSizeScale=True
        UseRegularSizeScale=False
        ScaleSizeXByVelocity=True
        FadeIn=True
        FadeInEndTime=0.25
        ExtentMultiplier=(X=0.200000)
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.500000,Max=0.500000))
        MaxParticles=100
        UseRotationFrom=PTRS_None
        UseAbsoluteTimeForSizeScale=True
        SizeScale(1)=(RelativeTime=0.0300000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=20.000000,Max=20.000000),Y=(Min=10.000000,Max=10.000000))
        ScaleSizeByVelocityMultiplier=(X=0.002000)
        InitialParticlesPerSecond=0.000000
        ParticlesPerSecond=0.0
        RespawnDeadParticles=False
        AutomaticInitialSpawning=False
        Texture=AW-2004Particles.Weapons.TracerShot
        LifetimeRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=10000.000000,Max=10000.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        Name="SpriteEmitter13"
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter13'
}