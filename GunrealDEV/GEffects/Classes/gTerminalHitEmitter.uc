// ============================================================================
//  gTerminalHitEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTerminalHitEmitter extends gNetTemporaryEmitter;



DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter24
        UseDirectionAs=PTDU_Forward
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        ColorScale(0)=(Color=(B=158,G=129,R=153,A=255))
        ColorScale(1)=(RelativeTime=0.317857,Color=(B=240,G=162,R=208,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(3)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=128,G=128,R=128,A=255))
        ColorScale(5)=(RelativeTime=1.000000,Color=(B=204,G=118,R=222,A=255))
        ColorScale(6)=(RelativeTime=1.000000,Color=(B=232,G=134,R=198,A=255))
        ColorScale(7)=(RelativeTime=1.000000,Color=(B=245,G=186,R=239,A=255))
        ColorMultiplierRange=(Y=(Min=0.900000,Max=0.900000),Z=(Min=0.700000,Max=0.700000))
        Opacity=0.290000
        MaxParticles=44
        Name="bubble_hit"
        StartLocationOffset=(Z=80.000000)
        StartLocationShape=PTLS_Sphere
        SphereRadiusRange=(Min=122.000000,Max=122.000000)
        UseRotationFrom=PTRS_Actor
        StartSpinRange=(X=(Max=1.000000))
        SizeScale(0)=(RelativeSize=7.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=22.000000,Max=22.000000),Z=(Min=22.000000,Max=22.000000))
        InitialParticlesPerSecond=444.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.250000,Max=0.250000)
        StartVelocityRadialRange=(Min=1.000000,Max=1.000000)
        VelocityLossRange=(X=(Min=3.000000,Max=3.000000),Y=(Min=3.000000,Max=3.000000),Z=(Min=3.000000,Max=3.000000))
        GetVelocityDirectionFrom=PTVD_AddRadial
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter24'

}