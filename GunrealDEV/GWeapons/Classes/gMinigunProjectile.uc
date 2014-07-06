// ============================================================================
//  gMinigunProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunProjectile extends gProjectile;


var   Emitter           TracerEffect;
var() class<Emitter>    TracerClass;
var() float             TracerPullback;
var() float             TracerMinDistance;
var   vector            TracerHitLocation;


static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.TracerClass);
}

simulated function DestroyEffects()
{
    Super.DestroyEffects();

    if( TracerEffect != None )
        TracerEffect.Destroy();
}

simulated event PreBeginPlay()
{
    if( Role != ROLE_Authority )
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
        bCollideWorld = False;
    }

    Super.PreBeginPlay();
}

simulated event PostNetBeginPlay()
{
    if( Level.NetMode != NM_DedicatedServer )
        UpdateTracer();

    Super.PostNetBeginPlay();
}

simulated function UpdateTracer()
{
    if( TracerClass != None )
        TracerEffect = Spawn(TracerClass);

    if( TracerEffect != None )
    {
        TracerEffect.Emitters[0].StartVelocityRange.X.Min = Velocity.X;
        TracerEffect.Emitters[0].StartVelocityRange.X.Max = Velocity.X;
        TracerEffect.Emitters[0].StartVelocityRange.Y.Min = Velocity.Y;
        TracerEffect.Emitters[0].StartVelocityRange.Y.Max = Velocity.Y;
        TracerEffect.Emitters[0].StartVelocityRange.Z.Min = Velocity.Z;
        TracerEffect.Emitters[0].StartVelocityRange.Z.Max = Velocity.Z;

        TracerEffect.Emitters[0].LifetimeRange.Min = Lifespan;
        TracerEffect.Emitters[0].LifetimeRange.Max = Lifespan;

        TracerEffect.SpawnParticle(1);
    }
}

DefaultProperties
{
    TracerClass             = class'gMinigunTracer'
    TracerPullback          = 50.0
    TracerMinDistance       = 0.0
}
