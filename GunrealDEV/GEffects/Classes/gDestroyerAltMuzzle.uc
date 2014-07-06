// ============================================================================
//  gDestroyerAltMuzzle.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerAltMuzzle extends gMuzzleSmoke;



DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseDirectionAs=PTDU_Up
        UseMaxCollisions=True
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
        SpawnFromOtherEmitter=1
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.800000,Max=0.800000))
        FadeOutStartTime=0.088000
        MaxParticles=777
        Name="dots_spew"
        StartLocationRange=(X=(Min=-9.000000,Max=-9.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=5.000000,Max=48.000000),Y=(Min=5.000000,Max=48.000000),Z=(Min=5.000000,Max=48.000000))
        ParticlesPerSecond=333.000000
        InitialParticlesPerSecond=666.000000
        Texture=Texture'G_FX.Smokes.sparks_4Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        MinSquaredVelocity=4444.000000
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=777.000000,Max=777.000000),Y=(Min=-655.000000,Max=655.000000),Z=(Min=-555.000000,Max=555.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(Y=(Min=0.700000,Max=0.700000),Z=(Min=0.500000,Max=0.500000))
        FadeOutStartTime=0.200000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="brightener"
        StartLocationRange=(X=(Min=22.000000,Max=22.000000))
        SpinCCWorCW=(X=1.000000)
        SpinsPerSecondRange=(X=(Min=3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=1.300000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        SizeScaleRepeats=2.000000
        StartSizeRange=(X=(Min=33.000000,Max=33.000000),Y=(Min=33.000000,Max=33.000000),Z=(Min=33.000000,Max=33.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.100000,Max=0.100000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter9'

}