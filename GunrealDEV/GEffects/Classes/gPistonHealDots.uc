// ============================================================================
//  gPistonHealDots.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistonHealDots extends gHitEmitter;

DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseCollision=True
        UseMaxCollisions=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-500.000000)
        ExtentMultiplier=(X=0.300000,Y=0.300000,Z=0.300000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=1
        SpawnAmount=4
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000))
        FadeOutStartTime=5.000000
        MaxParticles=11
        Name="collision-o-rama"
        StartLocationShape=PTLS_Sphere
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
        InitialParticlesPerSecond=111.000000
        Texture=Texture'G_FX.Plasmafx.P_dots2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=2.000000,Max=5.000000)
        StartVelocityRange=(X=(Max=77.000000),Y=(Min=-77.000000,Max=77.000000),Z=(Min=-97.000000,Max=97.000000))
        StartVelocityRadialRange=(Min=111.000000,Max=111.000000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseCollision=True
        FadeOut=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-378.157990)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000))
        FadeOutStartTime=2.871429
        MaxParticles=255
        Name="Sparks_Sub"
        DetailMode=DM_High
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=0.500000,Max=1.500000),Y=(Min=0.500000,Max=1.500000),Z=(Min=0.500000,Max=1.500000))
        Texture=Texture'G_FX.Plasmafx.P_dots2'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=1.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-77.000000,Max=77.000000),Y=(Min=-77.000000,Max=77.000000),Z=(Min=24.000000,Max=74.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter4'
}