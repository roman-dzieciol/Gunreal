// ============================================================================
//  gCoordsEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCoordsEmitter extends gEmitterBase;

DefaultProperties
{
    AutoDestroy     = True
    bNoDelete       = False
    bHardAttach     = True
    LifeSpan        = 30

    Begin Object Class=SpriteEmitter Name=XAxis
        UseDirectionAs=PTDU_Up
        FadeOut=True
        FadeIn=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        FadeOutStartTime=3.000000
        FadeInEndTime=1.000000
        CoordinateSystem=PTCS_Relative
        MaxParticles=8
        StartLocationOffset=(X=-200.000000)
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        InitialParticlesPerSecond=2.000000
        Texture=Texture'EpicParticles.JumpPad.PointArrows'
        StartVelocityRange=(X=(Min=100.000000,Max=100.000000))
        WarmupTicksPerSecond=1.000000
        RelativeWarmupTime=1.000000
    End Object
    Emitters(0)=SpriteEmitter'XAxis'

    Begin Object Class=SpriteEmitter Name=YAxis
        UseDirectionAs=PTDU_Up
        FadeOut=True
        FadeIn=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        FadeOutStartTime=3.000000
        FadeInEndTime=1.000000
        CoordinateSystem=PTCS_Relative
        MaxParticles=8
        StartLocationOffset=(Y=-200.000000)
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        InitialParticlesPerSecond=2.000000
        Texture=Texture'EpicParticles.JumpPad.PointArrows'
        StartVelocityRange=(Y=(Min=100.000000,Max=100.000000))
        WarmupTicksPerSecond=1.000000
        RelativeWarmupTime=1.000000
    End Object
    Emitters(1)=SpriteEmitter'YAxis'

    Begin Object Class=SpriteEmitter Name=ZAxis
        UseDirectionAs=PTDU_Up
        FadeOut=True
        FadeIn=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000))
        FadeOutStartTime=3.000000
        FadeInEndTime=1.000000
        CoordinateSystem=PTCS_Relative
        MaxParticles=8
        StartLocationOffset=(Z=-200.000000)
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        InitialParticlesPerSecond=2.000000
        Texture=Texture'EpicParticles.JumpPad.PointArrows'
        StartVelocityRange=(Z=(Min=100.000000,Max=100.000000))
        WarmupTicksPerSecond=1.000000
        RelativeWarmupTime=1.000000
    End Object
    Emitters(2)=SpriteEmitter'ZAxis'
}