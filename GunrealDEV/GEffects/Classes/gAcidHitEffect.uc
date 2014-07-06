// ============================================================================
//  gAcidHitEffect.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gAcidHitEffect extends gHitEmitterNet;

DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=3.000000,Z=0.000000)
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.800000
        FadeOutStartTime=0.068000
        MaxParticles=1
        Name="Acid_splash"
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=15.000000,Max=15.000000),Y=(Min=15.000000,Max=15.000000),Z=(Min=15.000000,Max=15.000000))
        InitialParticlesPerSecond=1.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Decals.Acidsplash2'
        LifetimeRange=(Min=0.100000,Max=0.100000)
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        ProjectionNormal=(X=3.000000,Z=0.000000)
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-900.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=2
        SpawnAmount=1
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.730000
        MaxParticles=16
        Name="Drops"
        DetailMode=DM_High
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=1.500000,Max=3.000000),Y=(Min=1.500000,Max=3.000000),Z=(Min=1.500000,Max=3.000000))
        InitialParticlesPerSecond=900.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Decals.Acid_drop1'
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Max=333.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=-333.000000,Max=333.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.600000
        FadeOutStartTime=2.450000
        MaxParticles=50
        Name="Splats"
        DetailMode=DM_High
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=3.000000,Max=10.000000),Y=(Min=3.000000,Max=10.000000),Z=(Min=3.000000,Max=10.000000))
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Decals.Acidsplash2'
        LifetimeRange=(Min=10.000000,Max=10.000000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        ProjectionNormal=(X=3.000000,Z=0.000000)
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        DampRotation=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.350000,Max=0.350000),Y=(Min=0.350000,Max=0.350000),Z=(Min=0.350000,Max=0.350000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=3
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=2.000000
        MaxParticles=11
        Name="Glass_A"
        DetailMode=DM_SuperHigh
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=3.000000,Max=4.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        RotationDampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=2.000000,Max=3.000000),Y=(Min=2.000000,Max=3.000000),Z=(Min=2.000000,Max=3.000000))
        InitialParticlesPerSecond=900.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Glass.glassgrid1'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=3.000000,Max=5.000000)
        StartVelocityRange=(X=(Max=333.000000),Y=(Min=-333.000000,Max=333.000000),Z=(Min=-333.000000,Max=333.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=11.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.420000
        FadeOutStartTime=0.540000
        FadeInEndTime=0.120000
        MaxParticles=2
        Name="Smoke_puff"
        StartSpinRange=(X=(Min=0.400000,Max=0.600000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=11.000000,Max=15.000000),Y=(Min=11.000000,Max=15.000000),Z=(Min=11.000000,Max=15.000000))
        InitialParticlesPerSecond=5.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_blue1_quad_smalpha'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(Z=(Max=3.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter0'
}
