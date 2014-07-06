//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gTurretTracer extends gProjectileEmitter;

DefaultProperties
{
    bTriggerKills               = True
    
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Up
        ProjectionNormal=(Y=1.000000)
        UseCollision=True
        UseMaxCollisions=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=3
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.700000,Max=0.700000),Y=(Min=0.700000,Max=0.700000))
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="turret_tracer"
        StartLocationRange=(X=(Min=-25.000000,Max=-25.000000))
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=33.000000,Max=33.000000),Z=(Min=22.000000,Max=22.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Smokes.sparks_4Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.010000,Max=0.010000)
        StartVelocityRange=(X=(Min=0.200000,Max=0.200000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        CoordinateSystem=PTCS_Relative
        MaxParticles=4
        Name="blue-filler"
        SpinsPerSecondRange=(X=(Min=0.300000,Max=0.700000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=0.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=5.000000,Max=5.000000),Y=(Min=5.000000,Max=5.000000),Z=(Min=5.000000,Max=5.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_blue1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.060000,Max=0.060000)
        StartVelocityRange=(X=(Min=-644.000000,Max=-644.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

}
