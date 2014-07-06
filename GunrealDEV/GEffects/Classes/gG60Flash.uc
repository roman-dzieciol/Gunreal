// ============================================================================
//  gG60Flash.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60Flash extends gMuzzleFlash;

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="g60_big"
        StartLocationOffset=(X=8.000000)
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=15.000000,Max=20.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=0.100000,Max=0.150000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="med"
        StartLocationOffset=(X=22.000000)
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=13.000000,Max=20.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=0.100000,Max=0.140000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="small"
        StartLocationOffset=(X=30.000000)
        StartLocationRange=(X=(Max=8.000000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=7.000000,Max=12.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=0.100000,Max=0.130000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        RespawnDeadParticles=False
        SpinParticles=True
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        CoordinateSystem=PTCS_Relative
        MaxParticles=4
        Name="smallest"
        StartLocationOffset=(X=35.000000)
        StartLocationRange=(X=(Max=8.000000))
        StartSpinRange=(X=(Max=1.000000))
        StartSizeRange=(X=(Min=3.000000,Max=6.000000))
        InitialParticlesPerSecond=5000.000000
        Texture=Texture'AW-2004Explosions.Fire.Part_explode2s'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=0.100000,Max=0.120000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
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
        FadeOutStartTime=0.049000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="fire"
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.300000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.600000)
        StartSizeRange=(X=(Min=21.000000,Max=28.000000),Y=(Min=21.000000,Max=28.000000),Z=(Min=21.000000,Max=28.000000))
        InitialParticlesPerSecond=100.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_flash_3quad_a'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.140000,Max=0.140000)
        StartVelocityRange=(X=(Min=205.000000,Max=205.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter14
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
        FadeOutStartTime=0.049000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="flare"
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.400000)
        StartSizeRange=(X=(Min=28.000000,Max=45.000000),Y=(Min=28.000000,Max=45.000000),Z=(Min=28.000000,Max=45.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.140000,Max=0.140000)
        StartVelocityRange=(X=(Min=155.000000,Max=155.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter14'
}