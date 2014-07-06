//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gTurretDamaged extends gNetPersistentEmitter;

DefaultProperties
{
    SoundRadius                 = 256
    SoundVolume                 = 255
    AmbientSound                = Sound'GeneralAmbience.ElectricalFX11'
	
    Begin Object Class=SpriteEmitter Name=SpriteEmitter14
        UseDirectionAs=PTDU_Up
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
        Name="turret_damaged"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
        ParticlesPerSecond=44.000000
        InitialParticlesPerSecond=44.000000
        Texture=Texture'G_FX.Mflashes.spark1Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.400000)
        StartVelocityRange=(X=(Min=-277.000000,Max=277.000000),Y=(Min=-277.000000,Max=277.000000),Z=(Min=-277.000000,Max=277.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter14'
}
