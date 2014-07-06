// ============================================================================
//  gHRLTransform.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLTransform extends gHitEmitterNet;

DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseColorScale=True
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
        DampingFactorRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
        ColorScale(0)=(Color=(B=184,G=208,R=220,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=43,G=65,R=96,A=255))
        FadeOutStartTime=0.180000
        FadeInEndTime=0.180000
        MaxParticles=5
        Name="smoke"
        StartLocationRange=(X=(Min=-33.000000,Max=33.000000),Y=(Min=-33.000000,Max=33.000000),Z=(Min=-33.000000,Max=33.000000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=34.000000,Max=60.000000),Y=(Min=34.000000,Max=60.000000),Z=(Min=34.000000,Max=60.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke52Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=3.000000,Max=6.000000)
        StartVelocityRadialRange=(Min=-750.000000,Max=-750.000000)
        VelocityLossRange=(X=(Min=7.000000,Max=7.000000),Y=(Min=7.000000,Max=7.000000),Z=(Min=7.000000,Max=7.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.119000
        MaxParticles=1
        Name="burst-fire"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=3.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=35.000000,Max=55.000000),Y=(Min=35.000000,Max=55.000000),Z=(Min=35.000000,Max=55.000000))
        InitialParticlesPerSecond=222.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Mflashes.mini_flash_3quad_a'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.350000,Max=0.350000)
        StartVelocityRange=(X=(Min=-55.000000,Max=55.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.030000
        MaxParticles=1
        Name="Burst"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=35.000000,Max=65.000000),Y=(Min=35.000000,Max=65.000000),Z=(Min=35.000000,Max=65.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.mini_sparks_1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-55.000000,Max=55.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=MeshEmitter Name=MeshEmitter3
        StaticMesh=StaticMesh'G_Meshes.Projectiles.hrl_eject_0'
        UseCollision=True
        RespawnDeadParticles=False
        SpinParticles=True
        DampRotation=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-1100.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=4
        Name="Shrapnel"
        DetailMode=DM_High
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=1.000000,Max=3.000000),Y=(Min=1.000000,Max=3.000000),Z=(Min=1.000000,Max=3.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
        RotationDampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
        RotationNormal=(X=2.000000,Y=2.000000,Z=2.000000)
        StartSizeRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
        Sounds(0)=(Sound=SoundGroup'G_Proc.impactfx.p_debris_metal_a',Radius=(Min=22.000000,Max=22.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.000000,Max=1.000000),Probability=(Min=1.000000,Max=1.000000))
        CollisionSound=PTSC_LinearLocal
        CollisionSoundProbability=(Min=1.000000,Max=1.000000)
        InitialParticlesPerSecond=77.000000
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=5.000000,Max=5.000000)
        StartVelocityRange=(X=(Min=-822.000000,Max=822.000000),Y=(Min=-822.000000,Max=822.000000),Z=(Min=-822.000000,Max=822.000000))
    End Object
    Emitters(3)=MeshEmitter'MeshEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.070000
        MaxParticles=1
        Name="Burst2"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=6.000000)
        StartSizeRange=(X=(Min=35.000000,Max=55.000000),Y=(Min=35.000000,Max=55.000000),Z=(Min=35.000000,Max=55.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Mflashes.mflash4b'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-55.000000,Max=55.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
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
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.030000
        MaxParticles=2
        Name="Burst-New1"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.500000,RelativeSize=2.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=35.000000,Max=65.000000),Y=(Min=35.000000,Max=65.000000),Z=(Min=35.000000,Max=65.000000))
        InitialParticlesPerSecond=222.000000
        Texture=Texture'G_FX.Smokes.boom1'
        LifetimeRange=(Min=0.200000,Max=0.300000)
        StartVelocityRange=(X=(Min=-55.000000,Max=55.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-700.000000)
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.188000
        MaxParticles=11
        Name="Sparks-Big"
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=5.000000,Max=5.000000)
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=12.000000,Max=22.000000),Y=(Min=12.000000,Max=22.000000),Z=(Min=12.000000,Max=22.000000))
        InitialParticlesPerSecond=422.000000
        Texture=Texture'G_FX.Smokes.sparks_4Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.400000,Max=0.400000)
        StartVelocityRadialRange=(Min=1111.000000,Max=1111.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-700.000000)
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.030000
        MaxParticles=22
        Name="Sparks-Sm"
        DetailMode=DM_High
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=2.000000,Max=4.000000),Y=(Min=2.000000,Max=4.000000),Z=(Min=2.000000,Max=4.000000))
        InitialParticlesPerSecond=422.000000
        Texture=Texture'G_FX.Smokes.spark2'
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=-955.000000,Max=955.000000),Y=(Min=-955.000000,Max=955.000000),Z=(Min=-955.000000,Max=955.000000))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
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
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=8
        SpawnAmount=3
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        Opacity=0.000000
        FadeOutStartTime=0.300000
        FadeInEndTime=0.300000
        MaxParticles=22
        Name="colliders"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-11.000000,Max=11.000000),Y=(Min=-11.000000,Max=11.000000),Z=(Min=8.000000,Max=11.000000))
        SphereRadiusRange=(Min=300.000000,Max=300.000000)
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=1.500000,Max=4.000000),Y=(Min=1.500000,Max=4.000000),Z=(Min=1.500000,Max=4.000000))
        InitialParticlesPerSecond=4555.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.fireburst2'
        LifetimeRange=(Min=0.200000,Max=0.350000)
        StartVelocityRadialRange=(Min=1100.000000,Max=1100.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        UseCollision=True
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
        DampingFactorRange=(X=(Min=0.200000,Max=0.200000),Y=(Min=0.200000,Max=0.200000),Z=(Min=0.200000,Max=0.200000))
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        Opacity=0.530000
        FadeOutStartTime=0.400000
        FadeInEndTime=0.400000
        MaxParticles=2800
        Name="col-smokes"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=20.000000,Max=20.000000))
        SpinsPerSecondRange=(X=(Min=0.030000,Max=0.100000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=17.000000,Max=32.000000),Y=(Min=17.000000,Max=32.000000),Z=(Min=17.000000,Max=32.000000))
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=3.000000,Max=5.000000)
        StartVelocityRange=(X=(Min=-155.000000,Max=155.000000),Y=(Min=-155.000000,Max=155.000000),Z=(Min=-155.000000,Max=155.000000))
        StartVelocityRadialRange=(Min=-1133.000000,Max=-1133.000000)
        VelocityLossRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(9)=SpriteEmitter'SpriteEmitter9'

}

