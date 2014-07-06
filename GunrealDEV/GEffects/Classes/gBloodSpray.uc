// ============================================================================
//  gBloodSpray.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gBloodSpray extends gBloodEmmiter;

DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
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
        FadeOutStartTime=0.078000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="Rear_spray"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Max=0.500000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=22.000000,Max=22.000000),Z=(Min=22.000000,Max=22.000000))
        InitialParticlesPerSecond=222.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_splash1b_sm'
        LifetimeRange=(Min=0.160000,Max=0.250000)
        StartVelocityRange=(X=(Min=222.000000,Max=444.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        Acceleration=(Z=-500.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.140000
        MaxParticles=1
        Name="Rear_drops"
        UseRotationFrom=PTRS_Actor
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=5.000000)
        StartSizeRange=(X=(Min=22.000000,Max=22.000000),Y=(Min=22.000000,Max=22.000000),Z=(Min=22.000000,Max=22.000000))
        InitialParticlesPerSecond=222.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_dots1b_sm'
        LifetimeRange=(Min=0.350000,Max=0.350000)
        StartVelocityRange=(X=(Min=300.000000,Max=790.000000),Y=(Min=-55.000000,Max=55.000000),Z=(Min=-55.000000,Max=55.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter3'
}
