// ============================================================================
//  gHeadShotEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHeadShotEmitter extends gGoreEmitter;

DefaultProperties
{
    bHardAttach     = False

    Begin Object Class=MeshEmitter Name=MeshEmitter15
        StaticMesh=StaticMesh'G_Meshes.Gibs.headshot_k'
        UseCollision=True
        RespawnDeadParticles=False
        SpinParticles=True
        DampRotation=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-900.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=12
        Name="headshot_tiny"
        SpinsPerSecondRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        RotationDampingFactorRange=(X=(Min=0.100000,Max=0.100000),Y=(Min=0.100000,Max=0.100000),Z=(Min=0.100000,Max=0.100000))
        StartSizeRange=(X=(Min=2.000000,Max=2.000000),Y=(Min=2.000000,Max=2.000000),Z=(Min=2.000000,Max=2.000000))
        InitialParticlesPerSecond=111.000000
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=5.000000,Max=5.000000)
        StartVelocityRange=(X=(Min=-555.000000,Max=555.000000),Y=(Min=-555.000000,Max=555.000000),Z=(Min=4.000000,Max=644.000000))
    End Object
    Emitters(0)=MeshEmitter'MeshEmitter15'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        FadeOutStartTime=0.181300
        MaxParticles=1
        Name="blood_spray"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=18.000000,Max=18.000000),Y=(Min=18.000000,Max=18.000000),Z=(Min=18.000000,Max=18.000000))
        Sounds(0)=(Sound=ProceduralSound'G_Proc.gore.gore_gib_explosion',Radius=(Min=40.000000,Max=40.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=3.000000,Max=3.000000),Probability=(Min=1.000000,Max=1.000000))
        SpawningSound=PTSC_LinearLocal
        SpawningSoundProbability=(Min=1.000000,Max=1.000000)
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_splat2b'
        LifetimeRange=(Min=0.370000,Max=0.370000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-988.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=1.160000
        MaxParticles=77
        Name="blood_drops"
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=4.000000,Max=8.000000),Y=(Min=4.000000,Max=8.000000),Z=(Min=4.000000,Max=8.000000))
        InitialParticlesPerSecond=1222.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_dropsfly1'
        TextureUSubdivisions=3
        TextureVSubdivisions=3
        LifetimeRange=(Min=3.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-344.000000,Max=344.000000),Y=(Min=-344.000000,Max=344.000000),Z=(Min=-222.000000,Max=655.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
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
        FadeOutStartTime=0.159600
        MaxParticles=12
        Name="up-spray"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Max=0.500000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=9.000000,Max=15.000000),Y=(Min=9.000000,Max=15.000000),Z=(Min=9.000000,Max=15.000000))
        InitialParticlesPerSecond=15.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_splash1b_sm'
        LifetimeRange=(Min=0.200000,Max=0.400000)
        StartVelocityRange=(Z=(Min=180.000000,Max=188.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-988.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=1.160000
        MaxParticles=90
        Name="up-drops"
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=7.000000,Max=10.000000),Y=(Min=7.000000,Max=10.000000),Z=(Min=7.000000,Max=10.000000))
        InitialParticlesPerSecond=88.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_dropsfly1'
        TextureUSubdivisions=3
        TextureVSubdivisions=3
        LifetimeRange=(Min=3.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-88.000000,Max=88.000000),Y=(Min=-88.000000,Max=88.000000),Z=(Max=405.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter1'
}