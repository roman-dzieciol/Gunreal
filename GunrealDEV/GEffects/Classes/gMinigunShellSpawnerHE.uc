// ============================================================================
//  gMinigunShellSpawnerHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunShellSpawnerHE extends gMinigunShellSpawner;

DefaultProperties
{
    Begin Object Class=MeshEmitter Name=Shells_C
        StaticMesh=StaticMesh'G_Meshes.Projectiles.minigun_shell_c'
        UseCollision=True
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        DampRotation=True
        UseSizeScale=True
        UseRegularSizeScale=False
        AutomaticInitialSpawning=False
        Acceleration=(Z=-900.000000)
        DampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=100
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
        RotationDampingFactorRange=(X=(Min=0.500000,Max=0.500000),Y=(Min=0.500000,Max=0.500000),Z=(Min=0.500000,Max=0.500000))
        SizeScale(0)=(RelativeSize=1.300000)
        SizeScale(1)=(RelativeTime=0.070000,RelativeSize=0.800000)
        SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.800000)
        InitialParticlesPerSecond=0.000000
        DrawStyle=PTDS_AlphaBlend
        LifetimeRange=(Min=12.000000,Max=12.000000)
        StartVelocityRange=(X=(Min=240.000000,Max=320.000000),Y=(Min=-350.000000,Max=-80.000000))
    End Object
    Emitters(0)=MeshEmitter'Shells_C'

}
