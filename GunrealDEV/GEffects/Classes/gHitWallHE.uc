// ============================================================================
//  gHitWallHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitWallHE extends gHitEmitterHE;

DefaultProperties
{
    ClientSpawnClass    = class'GEffects.gScorchExplosionHE'
    ClientSpawnAxes     = (X=-1,Y=-1,Z=-1)

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=114.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.850000
        FadeOutStartTime=0.400000
        MaxParticles=5
        Name="Smoke"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.400000,Max=0.600000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=34.000000,Max=44.000000),Y=(Min=34.000000,Max=44.000000),Z=(Min=34.000000,Max=44.000000))
        InitialParticlesPerSecond=222.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000)
        StartVelocityRange=(X=(Max=777.000000),Y=(Min=-777.000000,Max=777.000000),Z=(Min=-777.000000,Max=777.000000))
        VelocityLossRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        UseDirectionAs=PTDU_Up
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=0.500000
        MaxParticles=22
        Name="ThickSparks"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=9.000000,Max=14.000000),Y=(Min=9.000000,Max=14.000000),Z=(Min=9.000000,Max=14.000000))
        InitialParticlesPerSecond=2222.000000
        Texture=Texture'G_FX.Smokes.sparks_4Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.500000)
        StartVelocityRange=(X=(Min=-777.000000,Max=777.000000),Y=(Min=-777.000000,Max=777.000000),Z=(Min=-777.000000,Max=777.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter11'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.660000
        FadeOutStartTime=0.315000
        MaxParticles=3
        Name="Boom_In"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=14.000000,Max=14.000000),Y=(Min=14.000000,Max=14.000000),Z=(Min=14.000000,Max=14.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.200000,Max=0.500000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
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
        Opacity=0.840000
        FadeOutStartTime=0.182000
        MaxParticles=2
        Name="Boom_Out"
        SpinsPerSecondRange=(X=(Min=0.200000,Max=0.200000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=39.000000,Max=49.000000),Y=(Min=39.000000,Max=49.000000),Z=(Min=39.000000,Max=49.000000))
        InitialParticlesPerSecond=33.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.350000,Max=0.350000)
        InitialDelayRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter13'

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
        FadeOutStartTime=0.240000
        MaxParticles=1
        Name="Fireflash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=25.000000,Max=45.000000),Y=(Min=25.000000,Max=45.000000),Z=(Min=25.000000,Max=45.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter14'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseCollision=True
        UseMaxCollisions=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=7
        SpawnAmount=3
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=1.000000
        MaxParticles=11
        Name="Spark_Big"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=4.000000,Max=4.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.300000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=5.000000,Max=7.000000),Y=(Min=5.000000,Max=7.000000),Z=(Min=5.000000,Max=7.000000))
        InitialParticlesPerSecond=400.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Max=1233.000000),Y=(Min=-1277.000000,Max=1277.000000),Z=(Min=-1277.000000,Max=1277.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseCollision=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-600.000000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=4.000000,Max=4.000000)
        SpawnAmount=3
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=2.000000
        MaxParticles=77
        Name="Spark_trailer"
        StartLocationRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=22.000000,Max=22.000000))
        AddLocationFromOtherEmitter=5
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=1.500000,Max=3.000000),Y=(Min=1.500000,Max=3.000000),Z=(Min=1.500000,Max=3.000000))
        InitialParticlesPerSecond=555.000000
        Texture=Texture'G_FX.Mflashes.spark3'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=1.000000,Max=2.000000)
        StartVelocityRange=(X=(Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=-222.000000,Max=222.000000))
        VelocityLossRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000),Z=(Min=1.000000,Max=3.000000))
        AddVelocityFromOtherEmitter=5
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseCollision=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=3
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=2.000000
        FadeInEndTime=0.180000
        MaxParticles=444
        Name="Spark_hit"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=3.000000,Max=4.000000),Y=(Min=3.000000,Max=4.000000),Z=(Min=3.000000,Max=4.000000))
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Mflashes.spark3'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=1.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-333.000000,Max=333.000000),Y=(Min=-333.000000,Max=333.000000),Z=(Min=-444.000000,Max=444.000000))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=1.760000
        MaxParticles=11
        Name="Debris"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=6.000000,Max=11.000000),Y=(Min=6.000000,Max=11.000000),Z=(Min=6.000000,Max=11.000000))
        InitialParticlesPerSecond=444.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Debris.debris_1a'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=3.000000)
        StartVelocityRange=(X=(Min=122.000000,Max=500.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter5'
}
