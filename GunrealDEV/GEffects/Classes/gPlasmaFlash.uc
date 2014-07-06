// ============================================================================
//  gPlasmaFlash.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaFlash extends gMuzzleFlash;


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
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="SpriteEmitter0"
        SpinsPerSecondRange=(X=(Min=-0.004000,Max=0.004000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=1.400000)
        StartSizeRange=(X=(Min=24.000000,Max=32.000000),Y=(Min=24.000000,Max=32.000000),Z=(Min=24.000000,Max=32.000000))
        InitialParticlesPerSecond=15.000000
        Texture=Texture'G_FX.Mflashes.plas_flash1'
        LifetimeRange=(Min=0.100000,Max=0.150000)
        StartVelocityRange=(X=(Min=-0.022000,Max=0.022000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'
}
