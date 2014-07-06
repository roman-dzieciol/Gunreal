//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gTurretDamagedMore extends gNetPersistentEmitter;

DefaultProperties
{
    SoundRadius                 = 256
    SoundVolume                 = 255
    AmbientSound                = Sound'GeneralAmbience.ElectricalFX12'
	
    Begin Object Class=SpriteEmitter Name=SpriteEmitter16
        FadeOut=True
        FadeIn=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        Acceleration=(Z=13.000000)
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
        Opacity=0.190000
        FadeOutStartTime=1.590000
        FadeInEndTime=1.590000
        MaxParticles=77
        Name="turret_damaged_smoke"
        SpinsPerSecondRange=(X=(Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=15.000000,Max=29.000000),Y=(Min=15.000000,Max=29.000000),Z=(Min=15.000000,Max=29.000000))
        ParticlesPerSecond=15.000000
        InitialParticlesPerSecond=15.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Qb_sm'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Max=7.000000)
        StartVelocityRange=(X=(Min=-9.000000,Max=9.000000),Y=(Min=-9.000000,Max=9.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter16'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter17
        UseDirectionAs=PTDU_Up
        UseCollision=True
        FadeOut=True
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
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.900000,Max=0.900000))
        MaxParticles=22
        Name="SpriteEmitter17"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=6.000000,Max=11.000000),Y=(Min=6.000000,Max=11.000000),Z=(Min=6.000000,Max=11.000000))
        ParticlesPerSecond=44.000000
        InitialParticlesPerSecond=44.000000
        Texture=Texture'G_FX.Mflashes.spark1Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.400000,Max=0.500000)
        StartVelocityRange=(X=(Min=-277.000000,Max=277.000000),Y=(Min=-277.000000,Max=277.000000),Z=(Min=-277.000000,Max=277.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter17'

}
