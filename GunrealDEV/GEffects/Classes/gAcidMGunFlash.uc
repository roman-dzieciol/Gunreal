// ============================================================================
//  gAcidMGunFlash.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gAcidMGunFlash extends gMuzzleFlash;

DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
        FadeOutStartTime=0.031000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="MG_flash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=9.000000,Max=9.000000),Y=(Min=9.000000,Max=9.000000),Z=(Min=9.000000,Max=9.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.AcidMG_flash_01'
        LifetimeRange=(Min=0.120000,Max=0.120000)
        StartVelocityRange=(X=(Min=-0.022000,Max=0.022000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
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
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Z=(Min=0.900000,Max=0.900000))
        Opacity=0.170000
        FadeOutStartTime=0.440000
        FadeInEndTime=0.440000
        MaxParticles=2
        Name="mg_smoke"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=-0.085000,Max=0.085000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        InitialParticlesPerSecond=12.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.Smoke2'
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=3.000000,Max=12.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.800000,Max=0.800000),Z=(Min=0.800000,Max=0.800000))
        Opacity=0.400000
        FadeOutStartTime=0.115600
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Ripple_flash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=9.000000,Max=9.000000),Y=(Min=9.000000,Max=9.000000),Z=(Min=9.000000,Max=9.000000))
        InitialParticlesPerSecond=200.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.bullet_ripple_bhi'
        LifetimeRange=(Min=0.170000,Max=0.170000)
        StartVelocityRange=(X=(Min=-0.022000,Max=0.022000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseCollision=True
        UseMaxCollisions=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-999.000000)
        DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=4
        SpawnAmount=1
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
        MaxParticles=4
        Name="acid_spray"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.500000)
        StartSizeRange=(X=(Min=1.000000,Max=2.000000),Y=(Min=1.000000,Max=2.000000),Z=(Min=1.000000,Max=2.000000))
        InitialParticlesPerSecond=111.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Mflashes.spark3'
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=2.000000,Max=2.000000)
        StartVelocityRange=(X=(Max=522.000000),Y=(Min=-92.000000,Max=92.000000),Z=(Min=-72.000000,Max=152.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=50
        Name="acid_splats"
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=3.000000,Max=10.000000),Y=(Min=3.000000,Max=10.000000),Z=(Min=3.000000,Max=10.000000))
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Decals.Acidsplash2'
        LifetimeRange=(Min=2.000000,Max=3.000000)
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter3'
}