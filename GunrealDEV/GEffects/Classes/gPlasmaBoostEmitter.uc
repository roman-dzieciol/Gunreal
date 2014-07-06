// ============================================================================
//  gPlasmaBoostEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaBoostEmitter extends gHitEmitterNet;


defaultproperties
{
    AmbientGlow             = 128
    LightRadius             = 16
    LightBrightness         = 128
    LightSaturation         = 102
    LightHue                = 189
    LightType               = LT_Steady
    LightEffect             = LE_QuadraticNonIncidence
    bDynamicLight           = True

    bFlash                  = True
    FlashBrightness         = 255
    FlashRadius             = 20
    FlashTimeIn             = 0.1
    FlashTimeOut            = 0.8
    FlashCurveIn            = 0.3
    FlashCurveOut           = 2

    //Physics               = PHYS_Trailer



    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        Disabled=True
        Backup_Disabled=True
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        LowDetailFactor=0.500000
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.600000
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="Core_both"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=25.000000,Max=55.000000),Y=(Min=25.000000,Max=55.000000),Z=(Min=25.000000,Max=55.000000))
        InitialParticlesPerSecond=50.000000
        Texture=Texture'G_FX.Mflashes.plas_flash1'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        LowDetailFactor=0.500000
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.720000
        CoordinateSystem=PTCS_Relative
        MaxParticles=15
        Name="Elec_prim"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=55.000000,Max=55.000000),Y=(Min=55.000000,Max=55.000000),Z=(Min=55.000000,Max=55.000000))
        InitialParticlesPerSecond=50.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter4'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        LowDetailFactor=0.500000
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        ColorMultiplierRange=(X=(Min=0.850000,Max=0.850000),Y=(Min=0.850000,Max=0.850000))
        FadeOutStartTime=0.096000
        CoordinateSystem=PTCS_Relative
        MaxParticles=33
        Name="Sparks_prim"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=2.000000,Max=2.000000)
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=9.000000,Max=14.000000),Y=(Min=9.000000,Max=14.000000),Z=(Min=9.000000,Max=14.000000))
        InitialParticlesPerSecond=444.000000
        Texture=Texture'G_FX.Mflashes.spark1Q'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRadialRange=(Min=-400.000000,Max=-400.000000)
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter5'
}
