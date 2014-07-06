// ============================================================================
//  gTurretFlash.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurretFlash extends gMuzzleFlash;

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
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.088200
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="blue-fire"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=11.000000,Max=11.000000),Y=(Min=11.000000,Max=11.000000),Z=(Min=11.000000,Max=11.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.turret_flash1'
        LifetimeRange=(Min=0.180000,Max=0.180000)
        StartVelocityRange=(X=(Min=-0.022000,Max=0.022000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
        FadeOutStartTime=0.032000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="orange-fire"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.180000,Max=0.180000)
        StartVelocityRange=(X=(Min=-0.022000,Max=0.022000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
        Opacity=0.600000
        FadeOutStartTime=0.030600
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="flare"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.500000)
        StartSizeRange=(X=(Min=33.000000,Max=33.000000),Y=(Min=33.000000,Max=33.000000),Z=(Min=33.000000,Max=33.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Flares.flare3'
        LifetimeRange=(Min=0.180000,Max=0.180000)
        StartVelocityRange=(X=(Min=-0.022000,Max=0.022000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

}