// ============================================================================
//  gHitVehicleJHP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHitVehicleJHP extends gHitEmitterJHP;

DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        MaxParticles=25
        Name="Sparks"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=2.000000)
        SizeScale(1)=(RelativeTime=1.000000)
        StartSizeRange=(X=(Min=9.000000,Max=22.000000),Y=(Min=9.000000,Max=22.000000),Z=(Min=9.000000,Max=22.000000))
        InitialParticlesPerSecond=2222.000000
        Texture=Texture'G_FX.Smokes.spark1'
        LifetimeRange=(Min=0.220000,Max=0.220000)
        StartVelocityRange=(X=(Min=-777.000000,Max=777.000000),Y=(Min=-777.000000,Max=777.000000),Z=(Min=-777.000000,Max=777.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        DampingFactorRange=(X=(Min=0.300000,Max=0.300000),Y=(Min=0.300000,Max=0.300000),Z=(Min=0.300000,Max=0.300000))
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnAmount=2
        ColorScale(0)=(Color=(B=177,G=215,R=235,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=70,G=70,R=70,A=255))
        MaxParticles=4
        Name="Impact_Flare"
        StartLocationRange=(X=(Min=-3.000000,Max=3.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.300000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=18.000000,Max=29.000000),Y=(Min=18.000000,Max=29.000000),Z=(Min=18.000000,Max=29.000000))
        InitialParticlesPerSecond=888.000000
        Texture=Texture'G_FX.Mflashes.mflash4'
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter2'
}
