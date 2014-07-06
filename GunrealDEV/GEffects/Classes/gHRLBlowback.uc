// ============================================================================
//  gHRLBlowback.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLBlowback extends gMuzzleSmoke;



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
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        MaxParticles=33
        Name="Fire-Once"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.200000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=22.000000,Max=22.000000),Z=(Min=22.000000,Max=22.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_flash_3quad_a'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.300000)
        StartVelocityRange=(X=(Min=777.000000,Max=777.000000),Y=(Min=-144.000000,Max=144.000000),Z=(Min=-144.000000,Max=144.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=111.000000)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        FadeOutStartTime=0.185000
        FadeInEndTime=0.185000
        MaxParticles=22
        Name="Smoke-Deploy"
        StartLocationRange=(X=(Min=-51.000000,Max=-51.000000),Y=(Min=-22.000000,Max=22.000000),Z=(Min=-22.000000,Max=22.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
        StartSpinRange=(X=(Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=17.000000,Max=37.000000),Y=(Min=17.000000,Max=37.000000),Z=(Min=17.000000,Max=37.000000))
        InitialParticlesPerSecond=120.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5fireQb'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=633.000000,Max=433.000000),Y=(Min=-322.000000,Max=322.000000),Z=(Min=-322.000000,Max=222.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=5.000000),Y=(Min=1.000000,Max=5.000000),Z=(Min=1.000000,Max=5.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=61.000000)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        Opacity=0.740000
        FadeOutStartTime=1.760000
        FadeInEndTime=0.320000
        MaxParticles=8
        Name="Smk-Once-Bot"
        StartLocationRange=(X=(Min=-11.000000,Max=-11.000000),Y=(Min=-11.000000,Max=11.000000),Z=(Min=-11.000000,Max=11.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.020000,Max=0.080000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=9.000000)
        StartSizeRange=(X=(Min=17.000000,Max=37.000000),Y=(Min=17.000000,Max=37.000000),Z=(Min=17.000000,Max=37.000000))
        InitialParticlesPerSecond=180.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke52Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Max=8.000000)
        StartVelocityRange=(X=(Min=1533.000000,Max=333.000000),Y=(Min=-433.000000,Max=433.000000),Z=(Min=-411.000000))
        VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=111.000000)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
        Opacity=0.640000
        FadeOutStartTime=0.320000
        FadeInEndTime=0.320000
        MaxParticles=14
        Name="Smk-Once-Top"
        StartLocationRange=(X=(Min=-11.000000,Max=-11.000000),Y=(Min=-11.000000,Max=11.000000),Z=(Min=-11.000000,Max=11.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.020000,Max=0.080000))
        StartSpinRange=(X=(Min=0.500000,Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=9.000000)
        StartSizeRange=(X=(Min=17.000000,Max=37.000000),Y=(Min=17.000000,Max=37.000000),Z=(Min=17.000000,Max=37.000000))
        InitialParticlesPerSecond=180.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke52Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Max=8.000000)
        StartVelocityRange=(X=(Min=1533.000000,Max=333.000000),Y=(Min=-433.000000,Max=433.000000),Z=(Max=411.000000))
        VelocityLossRange=(X=(Min=4.000000,Max=4.000000),Y=(Min=4.000000,Max=4.000000),Z=(Min=4.000000,Max=4.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=111.000000)
        ColorScale(0)=(Color=(B=199,G=226,R=241,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=172,G=219,R=234,A=255))
        ColorMultiplierRange=(Y=(Min=0.700000,Max=0.700000),Z=(Min=0.400000,Max=0.400000))
        Opacity=0.600000
        MaxParticles=1
        Name="FireLight"
        StartLocationRange=(X=(Min=-51.000000,Max=-51.000000),Y=(Min=-22.000000,Max=22.000000),Z=(Min=-22.000000,Max=22.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
        StartSpinRange=(X=(Max=0.500000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=27.000000,Max=37.000000),Y=(Min=27.000000,Max=37.000000),Z=(Min=27.000000,Max=37.000000))
        InitialParticlesPerSecond=120.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=555.000000,Max=555.000000))
        VelocityLossRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter4'

}
