// ============================================================================
//  gGibTrail.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibTrail extends gGoreEmitter;

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    bStatic             = False
    bCollideWorld       = False
    bCollideActors      = False
    CollisionRadius     = 0.000000
    CollisionHeight     = 0.000000

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Up
        UseCollision=True
        UseMaxCollisions=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-988.000000)
        ExtentMultiplier=(X=7.000000,Y=7.000000,Z=7.000000)
        MaxCollisions=(Min=1.000000,Max=1.000000)
        SpawnFromOtherEmitter=1
        SpawnAmount=1
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=0.660000
        Name="gore_flying_droplets"
        DetailMode=DM_SuperHigh
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=6.000000,Max=12.000000),Y=(Min=6.000000,Max=12.000000),Z=(Min=6.000000,Max=12.000000))
        InitialParticlesPerSecond=22.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_dropsfly1'
        TextureUSubdivisions=3
        TextureVSubdivisions=3
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=1.000000,Max=2.000000)
        StartVelocityRange=(X=(Min=-222.000000,Max=222.000000),Y=(Min=-222.000000,Max=222.000000),Z=(Min=-122.000000,Max=355.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseDirectionAs=PTDU_Normal
        UseCollision=True
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        UseRandomSubdivision=True
        Acceleration=(Z=-42999.000000)
        ExtentMultiplier=(X=0.100000,Y=0.100000,Z=0.100000)
        DampingFactorRange=(X=(Min=0.000000,Max=0.000000),Y=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        FadeOutStartTime=11.250000
        FadeInEndTime=0.150000
        MaxParticles=50
        Name="splats"
        DetailMode=DM_SuperHigh
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=25.000000,Max=45.000000),Y=(Min=25.000000,Max=45.000000),Z=(Min=25.000000,Max=45.000000))
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Gibs.blood_splat_Q1'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        MinSquaredVelocity=2222.000000
        LifetimeRange=(Min=15.000000,Max=15.000000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'
}