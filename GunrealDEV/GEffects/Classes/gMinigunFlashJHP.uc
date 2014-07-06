// ============================================================================
//  gMinigunFlashJHP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunFlashJHP extends gMuzzleFlash;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
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
        Opacity=0.820000
        FadeOutStartTime=0.055800
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Mini_Fire"
        StartLocationRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.600000)
        StartSizeRange=(X=(Min=17.000000,Max=28.000000),Y=(Min=17.000000,Max=28.000000),Z=(Min=17.000000,Max=28.000000))
        InitialParticlesPerSecond=100.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_flash_3quad_a'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.160000,Max=0.160000)
        StartVelocityRange=(Y=(Min=-4.000000,Max=4.000000),Z=(Min=-4.000000,Max=4.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.670000
        FadeOutStartTime=0.061200
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Mini_Sparks"
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=21.000000,Max=25.000000),Y=(Min=21.000000,Max=25.000000),Z=(Min=21.000000,Max=25.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_sparks_1'
        LifetimeRange=(Min=0.140000,Max=0.140000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.500000
        FadeOutStartTime=0.032200
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Mini_flare"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=40.000000,Max=50.000000),Y=(Min=40.000000,Max=50.000000),Z=(Min=40.000000,Max=50.000000))
        InitialParticlesPerSecond=100.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_flash_3quad_a'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.140000,Max=0.140000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter15
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.600000
        FadeOutStartTime=0.049000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="flare_brightener"
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.600000)
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=23.000000,Max=33.000000),Y=(Min=23.000000,Max=33.000000),Z=(Min=23.000000,Max=33.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter15'
}