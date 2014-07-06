// ============================================================================
//  gPlasmaExplosion.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaExplosion extends gHitEmitterNet;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
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

    Begin Object Class=SpriteEmitter Name=SpriteEmitter5
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        FadeOutStartTime=0.120000
        CoordinateSystem=PTCS_Relative
        MaxParticles=8
        Name="ElecCore"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=17.000000,Max=37.000000),Y=(Min=17.000000,Max=37.000000),Z=(Min=17.000000,Max=37.000000))
        InitialParticlesPerSecond=55.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.100000,Max=0.190000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter5'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter6
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        CoordinateSystem=PTCS_Relative
        MaxParticles=3
        Name="Round"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=27.000000,Max=27.000000),Y=(Min=27.000000,Max=27.000000),Z=(Min=27.000000,Max=27.000000))
        InitialParticlesPerSecond=55.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane1'
        LifetimeRange=(Min=0.300000,Max=0.300000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter6'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter8
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        Opacity=0.450000
        FadeOutStartTime=0.120000
        CoordinateSystem=PTCS_Relative
        MaxParticles=4
        Name="Elec_Big"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.500000)
        StartSizeRange=(X=(Min=27.000000,Max=47.000000),Y=(Min=27.000000,Max=47.000000),Z=(Min=27.000000,Max=47.000000))
        InitialParticlesPerSecond=111.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.100000,Max=0.100000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter8'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-1000.000000)
        DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=4
        SpawnAmount=3
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        FadeOutStartTime=0.280000
        //CoordinateSystem=PTCS_Relative
        MaxParticles=25
        Name="Splats_main"
        StartLocationRange=(X=(Min=-11.000000,Max=11.000000),Y=(Min=-11.000000,Max=11.000000),Z=(Min=-11.000000,Max=11.000000))
        SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=3.500000,Max=6.000000),Y=(Min=3.500000,Max=6.000000),Z=(Min=3.500000,Max=6.000000))
        InitialParticlesPerSecond=900.000000
        Texture=Texture'G_FX.Plasmafx.P_dots1'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=1.000000,Max=1.000000)
        StartVelocityRange=(X=(Min=-300.000000,Max=300.000000),Y=(Min=-300.000000,Max=300.000000),Z=(Min=-222.000000,Max=460.000000))
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter10'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter11
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-900.000000)
        DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        //CoordinateSystem=PTCS_Relative
        MaxParticles=111
        Name="Splats_sub"
        StartLocationRange=(X=(Min=-11.000000,Max=11.000000),Y=(Min=-11.000000,Max=11.000000),Z=(Min=-11.000000,Max=11.000000))
        SpinsPerSecondRange=(X=(Min=0.100000,Max=0.100000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=1.500000,Max=3.000000),Y=(Min=1.500000,Max=3.000000),Z=(Min=1.500000,Max=3.000000))
        Texture=Texture'G_FX.Plasmafx.P_dots1'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.500000,Max=0.900000)
        StartVelocityRange=(X=(Min=-190.000000,Max=190.000000),Y=(Min=-190.000000,Max=190.000000),Z=(Min=-190.000000,Max=190.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter11'

}
