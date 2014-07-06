// ============================================================================
//  gTransClawEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTransClawEmitter extends gEmitterBase;



DefaultProperties
{
    bNoDelete           = False
    bStatic             = False
    bHidden             = True
    AutoDestroy         = False
    AutoReset           = False

    AmbientSound        = Sound'G_Sounds.cg_trans_gun_drone'
    SoundRadius         = 192
    SoundVolume         = 255

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Normal
        ProjectionNormal=(X=-0.150000)
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.800000,Max=0.800000))
        FadeOutStartTime=0.440000
        FadeInEndTime=0.220000
        CoordinateSystem=PTCS_Relative
        MaxParticles=23
        Name="CGlove_translocator_light"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.400000)
        StartSizeRange=(X=(Min=0.600000,Max=0.600000),Y=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
        Sounds(0)=(Radius=(Min=32.000000,Max=32.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=1.000000,Max=1.000000))
        SpawningSound=PTSC_LinearLocal
        SpawningSoundProbability=(Min=1.000000,Max=1.000000)
        ParticlesPerSecond=8.000000
        InitialParticlesPerSecond=8.000000
        Texture=Texture'G_FX.Interface.belt_square_a1'
        SecondsBeforeInactive=0.000000
        LifetimeRange=(Min=22.000000,Max=22.000000)
        StartVelocityRange=(X=(Min=5.000000,Max=5.000000),Z=(Min=0.800000,Max=0.800000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        FadeOut=True
        RespawnDeadParticles=False
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.300000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="light_blink"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=0.170000,RelativeSize=2.000000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.400000)
        StartSizeRange=(X=(Min=1.500000,Max=1.500000),Y=(Min=1.500000,Max=1.500000),Z=(Min=1.500000,Max=1.500000))
        ParticlesPerSecond=1.000000
        InitialParticlesPerSecond=1.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Flares.flare3'
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'


}