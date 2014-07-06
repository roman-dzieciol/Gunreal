// ============================================================================
//  gSniperFlash.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSniperFlash extends gMuzzleFlash;



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
        Opacity=0.220000
        FadeOutStartTime=0.032000
        CoordinateSystem=PTCS_Relative
        MaxParticles=7
        Name="Fire"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=0.500000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.350000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=20.000000,Max=28.000000),Y=(Min=20.000000,Max=28.000000),Z=(Min=20.000000,Max=28.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_blue1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.300000)
        StartVelocityRange=(X=(Max=733.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
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
        Opacity=0.210000
        FadeOutStartTime=0.032000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="Flash"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.200000)
        StartSizeRange=(X=(Min=40.000000,Max=60.000000),Y=(Min=40.000000,Max=60.000000),Z=(Min=40.000000,Max=60.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_blue1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Max=333.000000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
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
        Opacity=0.340000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="Sparks"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=0.100000)
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=27.000000,Max=37.000000),Y=(Min=27.000000,Max=37.000000),Z=(Min=27.000000,Max=37.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_sparks_1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Max=433.000000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'
}
