// ============================================================================
//  gCreditsEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCreditsEmitter extends gEmitter;


simulated event Destroyed()
{
    Super.Destroyed();
    OnDestroyed();
}

delegate OnDestroyed();

DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter43
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=23.520000
        FadeInEndTime=2.520000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="BACKGROUND"
        StartLocationOffset=(X=11.000000,Z=-44.000000)
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=7.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=222.000000,Max=222.000000),Y=(Min=222.000000,Max=222.000000),Z=(Min=222.000000,Max=222.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Credits.BKGRND_A'
        LifetimeRange=(Min=28.000000,Max=28.000000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter43'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter44
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=3.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=5.840000
        FadeInEndTime=3.040000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Slide 1"
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
        StartSizeRange=(X=(Min=44.000000,Max=44.000000),Y=(Min=44.000000,Max=44.000000),Z=(Min=44.000000,Max=44.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Credits.Text_1_Dario'
        LifetimeRange=(Min=9.000000,Max=9.000000)
        InitialDelayRange=(Min=1.000000,Max=1.000000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter44'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter45
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=3.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=5.400000
        FadeInEndTime=3.060000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Slide 2"
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=44.000000,Max=44.000000),Y=(Min=44.000000,Max=44.000000),Z=(Min=44.000000,Max=44.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Credits.Text_1_Roman'
        LifetimeRange=(Min=9.000000,Max=9.000000)
        InitialDelayRange=(Min=8.000000,Max=8.000000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter45'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter46
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=3.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=5.400000
        FadeInEndTime=3.060000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Slide 3"
        StartSpinRange=(X=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=44.000000,Max=44.000000),Y=(Min=44.000000,Max=44.000000),Z=(Min=44.000000,Max=44.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Credits.Text_1_Eric-Nick'
        LifetimeRange=(Min=9.000000,Max=9.000000)
        InitialDelayRange=(Min=15.000000,Max=15.000000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter46'


}