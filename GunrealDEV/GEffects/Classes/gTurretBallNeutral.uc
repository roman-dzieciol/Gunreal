//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gTurretBallNeutral extends gTurretBall;

DefaultProperties
{
    LightRadius                 = 24
    LightBrightness             = 128
    LightSaturation             = 102
    LightHue                    = 189
    LightType                   = LT_Steady
    LightEffect                 = LE_NonIncidence
    bDynamicLight               = True
    
    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Y=(Min=0.800000,Max=0.800000))
        FadeOutStartTime=0.072000
        FadeInEndTime=0.072000
        CoordinateSystem=PTCS_Relative
        MaxParticles=9
        Name="membrane"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.400000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
        ParticlesPerSecond=9.000000
        InitialParticlesPerSecond=9.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane1c'
        LifetimeRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.500000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="core"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.200000)
        StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.Plasmaball_1'
        LifetimeRange=(Min=1.000000,Max=1.000000)
        InitialDelayRange=(Min=2.000000,Max=2.000000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.500000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="core_in"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=12.000000,Max=12.000000),Y=(Min=12.000000,Max=12.000000),Z=(Min=12.000000,Max=12.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Plasmafx.Plasmaball_1'
        LifetimeRange=(Min=2.000000,Max=2.000000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter0'
}