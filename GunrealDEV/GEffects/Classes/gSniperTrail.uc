// ============================================================================
//  gSniperTrail.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
// StartLoc is replicated instead of Location, because Location can change on
// listen server and that change must not be replicated.
// ============================================================================
class gSniperTrail extends gProjectileEmitter;


var() float         Spacing;
var   vector        StartLoc;
var   vector        HitLoc;
var   int           TickCount;
var   bool          bSpawn;


replication
{
    reliable if( Role == ROLE_Authority )
        StartLoc, HitLoc;
}


// ============================================================================
//  Emitter
// ============================================================================

simulated event PostNetReceive()
{
    //gLog( "PostNetReceive" );

    if( StartLoc != default.StartLoc && HitLoc != default.HitLoc && Level.NetMode == NM_Client )
    {
        SetLocation(HitLoc);
        SetRotation(rotator(HitLoc - StartLoc));
        bSpawn = True;
        bNetNotify = False;
    }
}

final function SetHit(vector Loc)
{
    //glog( "SetHit" #bJustTeleported );

    StartLoc = Loc;
    HitLoc = Location;
    SetRotation(rotator(HitLoc - StartLoc));

    if( Level.NetMode != NM_DedicatedServer )
        bSpawn = True;
}

simulated event Tick(float DeltaTime)
{
    //gLog( "Tick" #bJustTeleported );

    if( Level.NetMode == NM_DedicatedServer )
    {
        Emitters[0].InitialParticlesPerSecond = 0;
        Disable('Tick');
        return;
    }

    if( bSpawn )
    {
        if( TickCount == 1 )
        {
            Emitters[0].InitialParticlesPerSecond = VSize(StartLoc - HitLoc)/Spacing/DeltaTime;
            Emitters[0].AllParticlesDead = False;
            Emitters[0].Reset();

            SetLocation(StartLoc);
        }
        else if( TickCount == 2 )
        {
            Emitters[0].InitialParticlesPerSecond = 0;
            bSpawn = False;
            Disable('Tick');
        }

        ++TickCount;
    }
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    Spacing                             = 4
    bOwnerNoSee                         = False

    bUpdateSimulatedPosition            = False
    bReplicateMovement                  = False
    bSkipActorPropertyReplication       = True
    bNetInitialRotation                 = False
    bNetTemporary                       = True
    bNetNotify                          = True
    RemoteRole                          = ROLE_SimulatedProxy

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        Opacity=0.150000
        MaxParticles=19000
        Name="sniper_trail"
        StartLocationRange=(X=(Min=-0.500000,Max=0.500000),Y=(Min=-0.500000,Max=0.500000),Z=(Min=-0.500000,Max=0.500000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=0.700000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.200000)
        StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=3.000000,Max=5.000000),Z=(Min=3.000000,Max=5.000000))
        ParticlesPerSecond=3000.000000
        InitialParticlesPerSecond=3000.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.sniper_ripple'
        LifetimeRange=(Min=0.500000,Max=1.300000)
        InitialDelayRange=(Min=0.004000,Max=0.004000)
        StartVelocityRange=(X=(Min=-1.000000,Max=1.000000),Y=(Min=-1.000000,Max=1.000000),Z=(Min=-1.000000,Max=1.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'
}