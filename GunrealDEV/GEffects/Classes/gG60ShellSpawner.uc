// ============================================================================
//  gG60ShellSpawner.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60ShellSpawner extends gShellSpawner;

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    Begin Object Class=MeshEmitter Name=MeshEmitter0
        StaticMesh=StaticMesh'XEffects.ShellCasing'
        UseCollision=True
        UseMaxCollisions=True
        RespawnDeadParticles=False
        AutomaticInitialSpawning=False
        SpinParticles=True
        Acceleration=(Z=-950.000000)
        DampingFactorRange=(X=(Min=0.400000,Max=0.750000),Y=(Min=0.400000,Max=0.750000),Z=(Min=0.400000,Max=0.750000))
        MaxCollisions=(Min=3.000000,Max=3.000000)
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        MaxParticles=100
        Name="MeshEmitter0"
        UseRotationFrom=PTRS_Actor
        SpinsPerSecondRange=(X=(Max=1.000000),Y=(Min=2.000000,Max=5.000000))
        StartSpinRange=(X=(Max=1.000000))
        Sounds(0)=(Sound=ProceduralSound'WeaponSounds.PShell1.P1Shell1',Radius=(Min=255.000000,Max=255.000000),Pitch=(Min=1.000000,Max=1.000000),Volume=(Min=10.000000,Max=10.000000),Probability=(Min=1.000000,Max=1.000000))
        CollisionSound=PTSC_LinearGlobal
        CollisionSoundProbability=(Min=1.000000,Max=1.000000)
        InitialParticlesPerSecond=0.000000
        LifetimeRange=(Min=10.000000,Max=10.000000)
        StartVelocityRange=(X=(Min=-50.000000,Max=50.000000),Y=(Min=-50.000000,Max=50.000000),Z=(Min=500.000000,Max=500.000000))
    End Object
    Emitters(0)=MeshEmitter'MeshEmitter0'
}