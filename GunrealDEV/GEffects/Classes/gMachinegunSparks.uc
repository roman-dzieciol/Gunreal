// ============================================================================
//  gMachinegunSparks.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachinegunSparks extends gMuzzleSmoke;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter18
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
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
        Opacity=0.170000
        FadeOutStartTime=0.440000
        FadeInEndTime=0.440000
        MaxParticles=2
        Name="smoke"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=-0.085000,Max=0.085000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        InitialParticlesPerSecond=12.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.Smoke2'
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=3.000000,Max=12.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter18'
}