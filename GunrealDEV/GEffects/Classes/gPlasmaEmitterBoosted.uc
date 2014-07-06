// ============================================================================
//  gPlasmaEmitterBoosted.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaEmitterBoosted extends gPlasmaEmitterBase;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    DisableOnTrigger(0)         = 1
    DisableOnTrigger(1)         = 2

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.850000,Max=0.850000))
        Opacity=0.040000
        MaxParticles=700
        Name="Vapor"
        DetailMode=DM_SuperHigh
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=30.000000,Max=50.000000),Y=(Min=30.000000,Max=50.000000),Z=(Min=30.000000,Max=50.000000))
        InitialParticlesPerSecond=122.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
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
        Opacity=0.180000
        MaxParticles=155
        Name="GlowBoost"
        DetailMode=DM_SuperHigh
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
        ParticlesPerSecond=111.000000
        InitialParticlesPerSecond=155.000000
        Texture=Texture'G_FX.Plasmafx.PlasmaballA'
        LifetimeRange=(Min=0.100000,Max=0.200000)
        StartVelocityRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Plasmaball"
        SpinCCWorCW=(X=1.000000)
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Plasmafx.PlasmaballA'
        LifetimeRange=(Min=1.000000,Max=1.000000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter3'

}
