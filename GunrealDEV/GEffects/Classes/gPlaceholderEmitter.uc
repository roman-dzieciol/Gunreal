// ============================================================================
//  gPlaceholderEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlaceholderEmitter extends gEmitter;

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=0.101200
        CoordinateSystem=PTCS_Relative
        MaxParticles=5
        Name="sparks_lines"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=16.000000,Max=25.000000),Y=(Min=16.000000,Max=25.000000),Z=(Min=16.000000,Max=25.000000))
        InitialParticlesPerSecond=2222.000000
        Texture=Texture'G_FX.Smokes.spark1'
        LifetimeRange=(Min=0.200000,Max=0.300000)
        StartVelocityRange=(X=(Max=777.000000),Y=(Min=-288.000000,Max=288.000000),Z=(Min=-288.000000,Max=288.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        Opacity=0.620000
        FadeOutStartTime=0.100300
        MaxParticles=2
        Name="flash"
        StartLocationRange=(X=(Min=6.000000,Max=6.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.350000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=18.000000,Max=25.000000),Y=(Min=18.000000,Max=25.000000),Z=(Min=18.000000,Max=25.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.sparks_hit1cQ'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.170000,Max=0.170000)
        StartVelocityRange=(X=(Min=111.000000,Max=111.000000),Y=(Min=-22.000000,Max=22.000000),Z=(Min=-22.000000,Max=22.000000))
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.400000,Max=0.400000),Y=(Min=0.400000,Max=0.400000),Z=(Min=0.400000,Max=0.400000))
        MaxCollisions=(Min=2.000000,Max=2.000000)
        SpawnFromOtherEmitter=3
        SpawnAmount=3
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=1.440000
        FadeInEndTime=0.180000
        MaxParticles=2
        Name="sparks"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000),Z=(Min=1.000000,Max=3.000000))
        InitialParticlesPerSecond=444.000000
        Texture=Texture'G_FX.Smokes.spark2'
        MinSquaredVelocity=2000.000000
        LifetimeRange=(Min=1.000000,Max=2.000000)
        StartVelocityRange=(X=(Max=555.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=-222.000000,Max=222.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseCollision=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=0.180000
        FadeInEndTime=0.180000
        MaxParticles=33
        Name="sparks_sub"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
        Texture=Texture'G_FX.Smokes.spark2'
        MinSquaredVelocity=2000.000000
        LifetimeRange=(Min=0.500000,Max=1.000000)
        StartVelocityRange=(X=(Min=-222.000000,Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=-222.000000,Max=222.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter3'
}
