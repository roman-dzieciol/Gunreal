// ============================================================================
//  gPistonHealFlash.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistonHealFlash extends gHitEmitter;



DefaultProperties
{
    ClientSpawnClass        = class'gPistonHealDots'

    //SpawnSound            = Sound'G_Sounds.cg_melee_heal_proc'
    SpawnSoundVolume      = 1.4
    SpawnSoundRadius      = 168

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        Opacity=0.590000
        FadeOutStartTime=0.260000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="pickup_spawn_flare"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.500000))
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=8.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
        InitialParticlesPerSecond=66.000000
        Texture=Texture'G_FX.Flares.flare3'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-10.000000,Max=10.000000),Y=(Min=-10.000000,Max=10.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=0.029900
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="fire-blue"
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=14.000000,Max=22.000000),Y=(Min=14.000000,Max=22.000000),Z=(Min=14.000000,Max=22.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        LifetimeRange=(Min=0.230000,Max=0.230000)
        StartVelocityRange=(X=(Max=233.000000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        UseDirectionAs=PTDU_Up
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=0.094000
        FadeInEndTime=0.086000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="ZAP"
        StartLocationOffset=(X=22.000000)
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=22.000000,Max=36.000000),Y=(Min=22.000000,Max=36.000000),Z=(Min=22.000000,Max=36.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.spark1Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=3.000000,Max=333.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter6'

}