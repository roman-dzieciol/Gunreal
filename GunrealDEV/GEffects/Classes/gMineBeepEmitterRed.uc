//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gMineBeepEmitterRed extends gMineBeepEmitter;

DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(Y=(Min=0.800000,Max=0.800000),Z=(Min=0.600000,Max=0.600000))
        MaxParticles=1
        Name="mine_blue"
        StartLocationOffset=(Z=3.55)
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=3.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.100000)
        StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
        Sounds(0)=(Sound=Sound'G_Sounds.cglove.cg_mine_beep',Radius=(Min=48.000000,Max=48.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.400000,Max=1.400000),Probability=(Min=1.000000,Max=1.000000))
        SpawningSound=PTSC_LinearLocal
        SpawningSoundProbability=(Min=1.000000,Max=1.000000)
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=1.000000
        Texture=Texture'G_FX.fX.Mine_flash'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=1.000000,Max=1.000000)
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'
}