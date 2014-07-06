// ============================================================================
//  gTracingAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTracingAttachment extends gWeaponAttachment;

// - Hit ----------------------------------------------------------------------

var() class<gHitGroup>  HitGroupClass;
var   vector            OldHitLocation;
var   Material          mHitMaterial;
var   float             HitTimeout;

// - Tracer -------------------------------------------------------------------

var() bool              bTracer;
var() class<Emitter>    TracerClass;
var() float             TracerSpeed;
var() float             TracerPullback;
var() float             TracerMinDistance;
var   Emitter           TracerEffect;
var   float             TracerInterval;
var   float             TracerLastTime;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.HitGroupClass);
    S.PrecacheObject(default.TracerClass);
}


// ============================================================================
// Replication
// ============================================================================

simulated event PostNetReceive()
{
    //gLog("PostNetReceive" #mHitLocation #(mHitLocation != OldHitLocation) );

    if( mHitLocation != OldHitLocation &&  mHitLocation != default.mHitLocation )
    {
        GetHitInfo();
        HitEffects();
        OldHitLocation = mHitLocation;
    }
}


// ============================================================================
// Lifespan
// ============================================================================
simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( Level.Netmode == NM_DedicatedServer )
    {
        bNetNotify = False;
        return;
    }

    if( bRotary )
    {
        // Interval must be less than fire rate
        TracerInterval = RotaryClass.default.FireModeClass[RotaryClass.default.SpinMode].default.FireRate -0.1;
    }
}

simulated event Destroyed()
{
    if( TracerEffect != None )
        TracerEffect.Destroy();

    Super.Destroyed();
}

event Timer()
{
    // stop hit replication
    mHitLocation = default.mHitLocation;
}


// ============================================================================
// Hit Data
// ============================================================================

function SetHitData(Actor HitActor, vector HitLocation, vector HitNormal, optional Material HitMaterial)
{
    local byte HitType;

    mHitLocation = HitLocation;

    if( Role == ROLE_Authority )
    {
        // Hit effects
        if( HitGroupClass != None )
        {
            HitType = HitGroupClass.static.GetSurfaceType(HitActor);
            Spawn(HitGroupClass.static.GetHitEffect(HitType),,, HitLocation, rotator(HitNormal));
        }
    }

    if( Level.NetMode != NM_DedicatedServer )
    {
        mHitActor = HitActor;
        mHitNormal = HitNormal;
        mHitMaterial = HitMaterial;
        HitEffects();
    }

    if( Level.NetMode != NM_Standalone )
    {
        NetUpdateTime = Level.TimeSeconds - 1;
        SetTimer(HitTimeout, False);
    }
}

simulated function GetHitInfo()
{
    local vector HitLocation, Dir;

    Dir = Normal(mHitLocation - GetTipLocation());
    mHitActor = Trace(HitLocation,mHitNormal,mHitLocation+Dir*20,mHitLocation-Dir*20, False,, mHitMaterial);
    if( mHitActor == None )
        mHitNormal = -Dir;
}


// ============================================================================
// Hit Effects
// ============================================================================

simulated function HitEffects()
{
    //gLog( "HitEffects" );

    if( gPawn(Instigator) == None )
        return;

    if( Level.TimeSeconds - LastRenderTime > 0.2 && Instigator.Controller != LocalPlayer )
        return;

    // Tracer
    if( bTracer )
        UpdateTracer();

    // Hit water
    if( bWaterSplash )
        CheckForSplash();
}


// ============================================================================
// Effects
// ============================================================================

simulated function CheckForSplash()
{
    local Actor HA;
    local vector HN, HL;

    if( Level.bDropDetail
        || Level.DetailMode == DM_Low
        || SplashEffect == None
        || Instigator.PhysicsVolume.bWaterVolume )
        return;

    bTraceWater = True;
    HA = Trace(HL, HN, mHitLocation,Instigator.Location + Instigator.EyePosition(),True);
    if( FluidSurfaceInfo(HA) != None || (PhysicsVolume(HA) != None && PhysicsVolume(HA).bWaterVolume) )
        Spawn(SplashEffect,,, HL, rot(16384,0,0));

    bTraceWater = False;
}



// ============================================================================
// Tracer
// ============================================================================

simulated function UpdateTracer()
{
    local vector SpawnLoc, SpawnDir, SpawnVel;
    local float Dist;

    if( TracerEffect == None && TracerClass != None )
        TracerEffect = Spawn(TracerClass);

    if( TracerEffect != None && Level.TimeSeconds > TracerLastTime + TracerInterval )
    {
        SpawnLoc = GetTipLocation();
        TracerEffect.SetLocation(SpawnLoc);
        Dist = VSize(mHitLocation - SpawnLoc) - TracerPullback;
        SpawnDir = Normal(mHitLocation - SpawnLoc);

        if( Dist > TracerMinDistance )
        {
            SpawnVel = SpawnDir * TracerSpeed;

            TracerEffect.Emitters[0].StartVelocityRange.X.Min = SpawnVel.X;
            TracerEffect.Emitters[0].StartVelocityRange.X.Max = SpawnVel.X;
            TracerEffect.Emitters[0].StartVelocityRange.Y.Min = SpawnVel.Y;
            TracerEffect.Emitters[0].StartVelocityRange.Y.Max = SpawnVel.Y;
            TracerEffect.Emitters[0].StartVelocityRange.Z.Min = SpawnVel.Z;
            TracerEffect.Emitters[0].StartVelocityRange.Z.Max = SpawnVel.Z;

            TracerEffect.Emitters[0].LifetimeRange.Min = Dist / TracerSpeed;
            TracerEffect.Emitters[0].LifetimeRange.Max = Dist / TracerSpeed;

            TracerEffect.SpawnParticle(1);
        }

        TracerLastTime = Level.TimeSeconds;
    }
}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    bTracer                         = True
    bWaterSplash                    = True
    bWeaponLight                    = True

    IgnoredMode                     = -1

    bNetNotify                      = True
    HitTimeout                      = 1.0

    TracerInterval                  = 0.1
    TracerClass                     = class'GEffects.gTracerEmitter'
    TracerPullback                  = 50.0
    TracerMinDistance               = 0.0
    TracerSpeed                     = 10000.0
}
