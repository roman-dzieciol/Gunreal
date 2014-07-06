// ============================================================================
//  gMachinegunFlashAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachinegunFlashAlt extends gMuzzleFlash;

DefaultProperties
{
    TriggerSpawnClass       = class'gMachinegunSparksAlt';


    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
        FadeOutStartTime=0.031000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="MG_flash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=7.000000,Max=7.000000),Y=(Min=7.000000,Max=7.000000),Z=(Min=7.000000,Max=7.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.AcidMG_flash_01'
        LifetimeRange=(Min=0.120000,Max=0.120000)
        StartVelocityRange=(X=(Min=-0.022000,Max=0.022000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
        Opacity=0.400000
        FadeOutStartTime=0.115600
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Ripple_flash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=9.000000,Max=9.000000),Y=(Min=9.000000,Max=9.000000),Z=(Min=9.000000,Max=9.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.bullet_ripple_bhi'
        LifetimeRange=(Min=0.170000,Max=0.170000)
        StartVelocityRange=(X=(Min=-0.022000,Max=0.022000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter7'


}
