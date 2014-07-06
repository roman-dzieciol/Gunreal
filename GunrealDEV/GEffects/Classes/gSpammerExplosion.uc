// ============================================================================
//  gSpammerExplosion.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerExplosion extends gHitEmitterNet;

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    LightRadius         = 32
    LightBrightness     = 333
    LightSaturation     = 141
    LightHue            = 35
    LightType           = LT_Steady
    LightEffect         = LE_None
    bDynamicLight       = True

    bFlash              = True
    FlashRadius         = 22
    FlashBrightness     = 111
    FlashTimeIn         = 0.2
    FlashTimeOut        = 0.1
    FlashCurveIn        = 2.0
    FlashCurveOut       = 0.3

    Begin Object Class=SpriteEmitter Name=SpriteEmitter25
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-400.000000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=1
        SpawnAmount=4
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        Opacity=0.000000
        MaxParticles=111
        Name="smoke_spawner"
        DetailMode=DM_High
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=1.500000,Max=4.000000),Y=(Min=1.500000,Max=4.000000),Z=(Min=1.500000,Max=4.000000))
        InitialParticlesPerSecond=900.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.fireburst2'
        LifetimeRange=(Min=0.250000,Max=0.500000)
        StartVelocityRange=(X=(Min=-788.000000,Max=788.000000),Y=(Min=-788.000000,Max=788.000000),Z=(Min=-788.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter25'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter16
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
        FadeOutStartTime=0.400000
        FadeInEndTime=0.400000
        MaxParticles=444
        Name="smokehits"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=9.000000,Max=22.000000),Y=(Min=9.000000,Max=22.000000),Z=(Min=9.000000,Max=22.000000))
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=5.000000)
        StartVelocityRange=(X=(Min=-155.000000,Max=155.000000),Y=(Min=-155.000000,Max=155.000000),Z=(Min=-155.000000,Max=155.000000))
        VelocityLossRange=(X=(Min=6.000000,Max=6.000000),Y=(Min=6.000000,Max=6.000000),Z=(Min=6.000000,Max=6.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter16'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter17
        FadeOut=True
        FadeIn=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=22.000000)
        ColorScale(0)=(Color=(B=173,G=245,R=243,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.120000
        FadeInEndTime=0.120000
        MaxParticles=33
        Name="S_Bot"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartLocationShape=PTLS_Sphere
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
        InitialParticlesPerSecond=599.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=3.000000,Max=8.000000)
        StartVelocityRange=(X=(Min=-655.000000,Max=655.000000),Y=(Min=-655.000000,Max=655.000000),Z=(Min=-555.000000))
        VelocityLossRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter17'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter18
        FadeOut=True
        FadeIn=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=33.000000)
        ColorScale(0)=(Color=(B=173,G=245,R=243,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.120000
        FadeInEndTime=0.120000
        MaxParticles=33
        Name="S_Top"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartLocationShape=PTLS_Sphere
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=15.000000,Max=25.000000),Y=(Min=15.000000,Max=25.000000),Z=(Min=15.000000,Max=25.000000))
        InitialParticlesPerSecond=599.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Qb'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=3.000000,Max=8.000000)
        StartVelocityRange=(X=(Min=-667.000000,Max=667.000000),Y=(Min=-667.000000,Max=667.000000),Z=(Max=555.000000))
        VelocityLossRange=(X=(Min=6.000000,Max=8.000000),Y=(Min=6.000000,Max=8.000000),Z=(Min=6.000000,Max=8.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter18'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter20
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.129000
        MaxParticles=2
        Name="Dots"
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=25.000000,Max=25.000000),Y=(Min=25.000000,Max=25.000000),Z=(Min=25.000000,Max=25.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_sparks_1'
        LifetimeRange=(Min=0.200000,Max=0.350000)
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter20'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter21
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(Y=(Min=0.850000,Max=0.850000),Z=(Min=0.700000,Max=0.700000))
        MaxParticles=1
        Name="Ripple"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=33.000000,Max=33.000000),Y=(Min=33.000000,Max=33.000000),Z=(Min=33.000000,Max=33.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.300000,Max=0.300000)
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter21'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter22
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=2
        Name="Fire_In"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=14.000000,Max=14.000000),Y=(Min=14.000000,Max=14.000000),Z=(Min=14.000000,Max=14.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Smokes.boom1'
        LifetimeRange=(Min=0.350000,Max=0.500000)
    End Object
    Emitters(6)=SpriteEmitter'SpriteEmitter22'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter23
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.250000
        FadeOutStartTime=1.260000
        FadeInEndTime=1.260000
        MaxParticles=15
        Name="Smoke_long"
        StartLocationRange=(X=(Min=-90.000000,Max=90.000000),Y=(Min=-90.000000,Max=90.000000),Z=(Min=-90.000000,Max=90.000000))
        SpinsPerSecondRange=(X=(Min=-0.100000,Max=0.100000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=111.000000,Max=111.000000),Y=(Min=111.000000,Max=111.000000),Z=(Min=111.000000,Max=111.000000))
        InitialParticlesPerSecond=33.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke6'
        LifetimeRange=(Min=6.000000,Max=6.000000)
        InitialDelayRange=(Min=0.500000,Max=0.500000)
        StartVelocityRange=(X=(Min=-30.000000,Max=30.000000),Y=(Min=-30.000000,Max=30.000000),Z=(Min=-30.000000,Max=30.000000))
    End Object
    Emitters(7)=SpriteEmitter'SpriteEmitter23'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter24
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-400.000000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=4
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.166500
        MaxParticles=111
        Name="sparks_dust"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=1.500000,Max=4.000000),Y=(Min=1.500000,Max=4.000000),Z=(Min=1.500000,Max=4.000000))
        InitialParticlesPerSecond=900.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.fireburst2'
        LifetimeRange=(Min=0.250000,Max=0.500000)
        StartVelocityRange=(X=(Min=-788.000000,Max=788.000000),Y=(Min=-788.000000,Max=788.000000),Z=(Min=-788.000000))
    End Object
    Emitters(8)=SpriteEmitter'SpriteEmitter24'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-400.000000)
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.166500
        MaxParticles=70
        Name="sparks_air"
        SpinsPerSecondRange=(X=(Min=0.100000,Max=1.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=1.500000,Max=4.000000),Y=(Min=1.500000,Max=4.000000),Z=(Min=1.500000,Max=4.000000))
        InitialParticlesPerSecond=900.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.fireburst2'
        LifetimeRange=(Min=0.250000,Max=0.500000)
        StartVelocityRange=(X=(Min=-788.000000,Max=788.000000),Y=(Min=-788.000000,Max=788.000000),Z=(Max=788.000000))
    End Object
    Emitters(9)=SpriteEmitter'SpriteEmitter0'
}
