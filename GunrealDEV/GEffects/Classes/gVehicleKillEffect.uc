// ============================================================================
//  gVehicleKillEffect.uc ::
// ============================================================================
class gVehicleKillEffect extends gHitEmitterNet;



DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=1
        SpawnAmount=2
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        Opacity=0.000000
        FadeOutStartTime=0.160000
        MaxParticles=555
        Name="Colliders"
        StartLocationRange=(X=(Min=-11.000000,Max=11.000000),Y=(Min=-11.000000,Max=11.000000),Z=(Min=1.000000,Max=11.000000))
        SphereRadiusRange=(Min=300.000000,Max=300.000000)
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=1.500000,Max=4.000000),Y=(Min=1.500000,Max=4.000000),Z=(Min=1.500000,Max=4.000000))
        InitialParticlesPerSecond=4555.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.fireburst2'
        LifetimeRange=(Min=0.600000,Max=1.000000)
        StartVelocityRadialRange=(Min=1800.000000,Max=1800.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
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
        Acceleration=(Z=11.000000)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        Opacity=0.730000
        FadeOutStartTime=0.280000
        FadeInEndTime=0.280000
        MaxParticles=2800
        Name="Smokes"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=20.000000,Max=20.000000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=17.000000,Max=32.000000),Y=(Min=17.000000,Max=32.000000),Z=(Min=17.000000,Max=32.000000))
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=7.000000)
        StartVelocityRange=(X=(Min=-155.000000,Max=155.000000),Y=(Min=-155.000000,Max=155.000000),Z=(Min=-155.000000,Max=155.000000))
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
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
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        Opacity=0.020000
        FadeOutStartTime=0.340000
        FadeInEndTime=0.340000
        MaxParticles=22
        Name="shockwave"
        StartLocationRange=(X=(Min=-11.000000,Max=11.000000),Y=(Min=-11.000000,Max=11.000000),Z=(Min=0.100000,Max=2.000000))
        SphereRadiusRange=(Min=300.000000,Max=300.000000)
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=222.000000,Max=222.000000),Y=(Min=222.000000,Max=222.000000),Z=(Min=222.000000,Max=222.000000))
        InitialParticlesPerSecond=4555.000000
        Texture=Texture'G_FX.Mflashes.plas_flash1'
        LifetimeRange=(Min=0.400000,Max=1.000000)
        InitialDelayRange=(Min=0.100000,Max=0.100000)
        StartVelocityRadialRange=(Min=1100.000000,Max=1100.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter9'

}