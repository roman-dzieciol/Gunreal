// ============================================================================
//  gPistonHitWall.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistonHitWall extends gHitEmitterNet;



DefaultProperties
{
    ClientSpawnClass    = class'GEffects.gPistonScorch'
    ClientSpawnAxes     = (X=-1,Y=-1,Z=-1)

    SpawnSound            = Sound'G_Proc.g_bullet_ric'
    SpawnSoundVolume      = 1.4
    SpawnSoundRadius      = 168

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseCollision=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        DampRotation=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=2.000000,Max=2.000000)
        SpawnAmount=3
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=0.180000
        FadeInEndTime=0.180000
        MaxParticles=3
        Name="Debris_Big"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=1.000000,Max=3.000000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        RotationDampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=3.500000,Max=5.500000),Y=(Min=3.500000,Max=5.500000),Z=(Min=3.500000,Max=5.500000))
        InitialParticlesPerSecond=400.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Debris.debris_1a'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=3.000000,Max=5.000000)
        StartVelocityRange=(X=(Min=200.000000,Max=444.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseCollision=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        DampRotation=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=0.180000
        FadeInEndTime=0.180000
        MaxParticles=5
        Name="Debris_Med"
        DetailMode=DM_SuperHigh
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=2.000000,Max=2.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        RotationDampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=1.400000,Max=3.500000),Y=(Min=1.400000,Max=3.500000),Z=(Min=1.400000,Max=3.500000))
        InitialParticlesPerSecond=555.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Debris.debris_1a'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=6.000000,Max=9.000000)
        StartVelocityRange=(X=(Min=177.000000,Max=577.000000),Y=(Min=-577.000000,Max=577.000000),Z=(Min=-577.000000,Max=577.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=55.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.500000
        FadeOutStartTime=0.546000
        MaxParticles=8
        Name="Poof_high"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.400000,Max=0.600000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
        InitialParticlesPerSecond=777.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Qb'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=100.000000,Max=377.000000),Y=(Min=-45.000000,Max=45.000000),Z=(Min=-45.000000,Max=45.000000))
        VelocityLossRange=(X=(Min=2.000000,Max=7.000000),Y=(Min=2.000000,Max=7.000000),Z=(Min=2.000000,Max=7.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.546000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="Poof_low"
        StartSpinRange=(X=(Min=0.400000,Max=0.600000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=10.000000,Max=20.000000),Y=(Min=10.000000,Max=20.000000),Z=(Min=10.000000,Max=20.000000))
        InitialParticlesPerSecond=777.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=100.000000,Max=100.000000),Y=(Min=-45.000000,Max=45.000000),Z=(Min=-45.000000,Max=45.000000))
        VelocityLossRange=(X=(Min=2.000000,Max=7.000000),Y=(Min=2.000000,Max=7.000000),Z=(Min=2.000000,Max=7.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        UseDirectionAs=PTDU_UpAndNormal
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=0.064000
        MaxParticles=6
        Name="Flash_base"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.400000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=12.000000,Max=19.000000),Y=(Min=12.000000,Max=19.000000),Z=(Min=12.000000,Max=19.000000))
        InitialParticlesPerSecond=222.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Mflashes.mflash4'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
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
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="Flash_flare"
        StartLocationRange=(X=(Min=6.000000,Max=6.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.200000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.300000)
        StartSizeRange=(X=(Min=15.000000,Max=20.000000),Y=(Min=15.000000,Max=20.000000),Z=(Min=15.000000,Max=20.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.sparks_hit1cQ'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.150000,Max=0.350000)
        StartVelocityRange=(X=(Min=77.000000,Max=77.000000),Y=(Min=-22.000000,Max=22.000000),Z=(Min=-22.000000,Max=22.000000))
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter13'
}