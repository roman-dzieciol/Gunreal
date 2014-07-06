// ============================================================================
//  gShoppingBubbleHitEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShoppingBubbleHitEmitter extends gHitEmitterNet;

DefaultProperties
{
    SpawnSound            = Sound'G_Proc.hrl_shieldhit_grp'
    SpawnSoundVolume      = 1.4
    SpawnSoundRadius      = 168

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Up
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-800.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=2
        SpawnAmount=3
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=3.120000
        MaxParticles=14
        Name="sparks"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=5.000000,Max=5.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.sparks_4Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        MinSquaredVelocity=2222.000000
        StartVelocityRange=(X=(Max=422.000000),Y=(Min=-433.000000,Max=433.000000),Z=(Min=-433.000000,Max=433.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseDirectionAs=PTDU_Up
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-800.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=2
        SpawnAmount=3
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=3.080000
        MaxParticles=14
        Name="sparks2"
        DetailMode=DM_SuperHigh
        StartLocationRange=(X=(Min=5.000000,Max=5.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.sparks_4Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        MinSquaredVelocity=2222.000000
        StartVelocityRange=(X=(Max=273.000000),Y=(Min=-272.000000,Max=272.000000),Z=(Min=-272.000000,Max=272.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter26
        UseCollision=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-800.000000)
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=2.000000
        MaxParticles=1111
        Name="sparks_sub"
        DetailMode=DM_High
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.500000,Max=2.500000),Y=(Min=1.500000,Max=2.500000),Z=(Min=1.500000,Max=2.500000))
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-192.000000,Max=192.000000),Y=(Min=-192.000000,Max=192.000000),Z=(Min=2.000000,Max=180.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter26'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter27
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.102000
        MaxParticles=1
        Name="fire"
        SpinsPerSecondRange=(X=(Min=-0.003000,Max=0.003000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=12.000000)
        StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
        InitialParticlesPerSecond=140.000000
        Texture=Texture'G_FX.Mflashes.mflash4'
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter27'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
        Name="flare_2"
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=28.000000,Max=45.000000),Y=(Min=28.000000,Max=45.000000),Z=(Min=28.000000,Max=45.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Min=0.250000,Max=0.250000)
        StartVelocityRange=(X=(Min=111.000000,Max=111.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
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
        FadeOutStartTime=0.201000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="SpriteEmitter3"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=22.000000,Max=55.000000),Y=(Min=22.000000,Max=55.000000),Z=(Min=22.000000,Max=55.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Plasmafx.elec_1'
        LifetimeRange=(Min=0.300000,Max=0.300000)
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter3'

}