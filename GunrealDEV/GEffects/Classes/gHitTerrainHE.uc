// ============================================================================
//  gHitTerrainHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitTerrainHE extends gHitEmitterHE;

DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=114.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.850000
        FadeOutStartTime=0.400000
        MaxParticles=15
        Name="Smoke"
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Min=0.400000,Max=0.600000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=34.000000,Max=44.000000),Y=(Min=34.000000,Max=44.000000),Z=(Min=34.000000,Max=44.000000))
        InitialParticlesPerSecond=222.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Smokes.smoke5Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000)
        StartVelocityRange=(X=(Max=777.000000),Y=(Min=-777.000000,Max=777.000000),Z=(Min=-777.000000,Max=777.000000))
        VelocityLossRange=(X=(Min=8.000000,Max=8.000000),Y=(Min=8.000000,Max=8.000000),Z=(Min=8.000000,Max=8.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter12
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.660000
        MaxParticles=3
        Name="Boom_In"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=8.000000)
        StartSizeRange=(X=(Min=14.000000,Max=14.000000),Y=(Min=14.000000,Max=14.000000),Z=(Min=14.000000,Max=14.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.100000,Max=0.400000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter12'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter13
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.840000
        MaxParticles=2
        Name="Boom_Out"
        SpinsPerSecondRange=(X=(Min=0.200000,Max=0.200000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=39.000000,Max=49.000000),Y=(Min=39.000000,Max=49.000000),Z=(Min=39.000000,Max=49.000000))
        InitialParticlesPerSecond=33.000000
        DrawStyle=PTDS_Brighten
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.250000,Max=0.250000)
        InitialDelayRange=(Min=0.120000,Max=0.120000)
        StartVelocityRange=(X=(Min=-111.000000,Max=111.000000),Y=(Min=-111.000000,Max=111.000000),Z=(Min=-111.000000,Max=111.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter13'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter14
        UseDirectionAs=PTDU_Up
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
        Name="Fireflash"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=25.000000,Max=45.000000),Y=(Min=25.000000,Max=45.000000),Z=(Min=25.000000,Max=45.000000))
        InitialParticlesPerSecond=200.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2'
        LifetimeRange=(Min=0.200000,Max=0.400000)
        StartVelocityRange=(X=(Min=-88.000000,Max=88.000000),Y=(Min=-88.000000,Max=88.000000),Z=(Min=-88.000000,Max=88.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter14'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=1.760000
        MaxParticles=22
        Name="Debris"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=3.000000,Max=7.000000),Y=(Min=3.000000,Max=7.000000),Z=(Min=3.000000,Max=7.000000))
        InitialParticlesPerSecond=444.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Debris.debris_1a'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=3.000000)
        StartVelocityRange=(X=(Min=122.000000,Max=500.000000),Y=(Min=-600.000000,Max=600.000000),Z=(Min=-600.000000,Max=600.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        DampRotation=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        FadeOutStartTime=1.720000
        MaxParticles=40
        Name="Explosion_Debris"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=1.000000,Max=3.000000))
        StartSpinRange=(X=(Min=0.400000,Max=0.600000),Y=(Max=1.000000),Z=(Max=1.000000))
        RotationDampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=4.000000)
        StartSizeRange=(X=(Min=4.000000,Max=10.000000),Y=(Min=4.000000,Max=10.000000),Z=(Min=4.000000,Max=10.000000))
        InitialParticlesPerSecond=777.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Debris.debris_1a'
        TextureUSubdivisions=4
        TextureVSubdivisions=4
        LifetimeRange=(Min=2.000000)
        StartVelocityRange=(X=(Min=120.000000,Max=800.000000),Y=(Min=-800.000000,Max=800.000000),Z=(Min=-800.000000,Max=800.000000))
    End Object
    Emitters(5)=SpriteEmitter'SpriteEmitter0'

}
