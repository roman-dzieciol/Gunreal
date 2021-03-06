// ============================================================================
//  gBodyHitEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gBodyHitEmitter extends gGoreEmitter;

DefaultProperties
{

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
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
        FadeOutStartTime=1.050000
        MaxParticles=22
        Name="drops"
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=6.000000,Max=12.000000),Y=(Min=6.000000,Max=12.000000),Z=(Min=6.000000,Max=12.000000))
        InitialParticlesPerSecond=1222.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_dropsfly1'
        TextureUSubdivisions=3
        TextureVSubdivisions=3
        LifetimeRange=(Min=1.500000,Max=3.000000)
        StartVelocityRange=(X=(Min=-422.000000,Max=422.000000),Y=(Min=-422.000000,Max=422.000000),Z=(Min=-222.000000,Max=455.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Up
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-800.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.118000
        FadeInEndTime=0.018000
        MaxParticles=2
        Name="splat_falling"
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=30.000000,Max=34.000000),Y=(Min=30.000000,Max=34.000000),Z=(Min=30.000000,Max=34.000000))
        InitialParticlesPerSecond=11.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_splat1'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-55.000000,Max=55.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-80.000000,Max=-80.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
        FadeOutStartTime=0.153000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="splat_flash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=7.000000)
        StartSizeRange=(X=(Min=18.000000,Max=18.000000),Y=(Min=18.000000,Max=18.000000),Z=(Min=18.000000,Max=18.000000))
        Sounds(0)=(Pitch=(Min=1.000000,Max=1.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_splat2b'
        LifetimeRange=(Min=0.300000,Max=0.300000)
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
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
        Opacity=0.000000
        FadeOutStartTime=0.102000
        MaxParticles=1
        Name="splat_sound"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=18.000000,Max=18.000000),Y=(Min=18.000000,Max=18.000000),Z=(Min=18.000000,Max=18.000000))
        //Sounds(0)=(Sound=SoundGroup'G_Proc.gore.body_hits',Radius=(Min=32.000000,Max=32.000000),Pitch=(Min=0.700000,Max=1.200000),Volume=(Min=2.000000,Max=2.000000),Probability=(Min=1.000000,Max=1.000000))
        SpawningSound=PTSC_LinearLocal
        SpawningSoundProbability=(Min=1.000000,Max=1.000000)
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_splat2b'
        LifetimeRange=(Min=0.200000,Max=0.200000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter2'

    bNetTemporary=True
}