// ============================================================================
//  gShotgunAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotgunAttachment extends gTracingAttachment;

// - Hit ----------------------------------------------------------------------

const SHOTGUN_HIT_MAX = 14;

struct ShotgunHitData
{
    var() vector    Location[14];
};

var ShotgunHitData    ShotgunHit;
var ShotgunHitData    ShotgunHitOld;

var Actor     HitActors[14];
var vector    HitLocations[14];
var vector    HitNormals[14];
var Material  HitMaterials[14];


// ============================================================================
//  Replication
// ============================================================================
replication
{
    // Variables that server should send to clients
    reliable if( bNetDirty && Role == ROLE_Authority )
        ShotgunHit;
}

simulated event PostNetReceive()
{
    //gLog("PostNetReceive" #Hit.Count );

    if( ShotgunHit != ShotgunHitOld
    &&  ShotgunHit != default.ShotgunHit )
    {
        GetHitInfo();
        HitEffects();
        ShotgunHitOld = ShotgunHit;
    }
}


// =============================================================================
//  Lifespan
// =============================================================================

event Timer()
{
    // stop hit replication
    ShotgunHit = default.ShotgunHit;
}


// =============================================================================
//  Hit Data
// =============================================================================

function OpenHitData()
{
    //gLog( "OpenHitData" );
    LocalCount = 0;
}

function SetHitData(Actor HitActor, vector HitLocation, vector HitNormal, optional Material HitMaterial)
{
    local byte HitType;

    //gLog( "SetHitData" #LocalCount #HitLocation );

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

    if( Level.NetMode != NM_Standalone )
    {
        ShotgunHit.Location[LocalCount] = HitLocation;
    }

    if( Level.NetMode != NM_DedicatedServer )
    {
        HitLocations[LocalCount] = HitLocation;
        HitActors[LocalCount] = HitActor;
        HitNormals[LocalCount] = HitNormal;
        HitMaterials[LocalCount] = HitMaterial;
    }

    ++LocalCount;
}

function CloseHitData()
{
    local int i;

    //gLog( "CloseHitData" #LocalCount );

    if( Level.NetMode != NM_Standalone )
    {
        for( i=LocalCount; i<SHOTGUN_HIT_MAX; ++i )
        {
            ShotgunHit.Location[i] = vect(0,0,0);
        }

        NetUpdateTime = Level.TimeSeconds - 1;
        SetTimer(HitTimeout,False);
    }

    if( Level.NetMode != NM_DedicatedServer )
    {
        HitEffects();
    }

}

simulated function GetHitInfo()
{
    local vector HitLocation, Dir, Tip;
    local int i;

    Tip = GetTipLocation();

    for( i=0; i!=SHOTGUN_HIT_MAX; ++i )
    {
        LocalCount = i;

        if( ShotgunHit.Location[i] == vect(0,0,0) )
            break;

        HitLocations[i] = ShotgunHit.Location[i];
        Dir = Normal(HitLocations[i] - Tip);
        HitActors[i] = Trace(HitLocation,HitNormals[i],HitLocations[i]+Dir*20,HitLocations[i]-Dir*20, False,, HitMaterials[i]);
        if( HitActors[i] == None )
            HitNormals[i] = -Dir;
    }
}


// =============================================================================
// Hit Effects
// =============================================================================

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



// =============================================================================
// Effects
// =============================================================================

simulated function ShowMuzzleFlash()
{
    local rotator R;
    local coords C;

    // Muzzle Flash
    if( FlashEffect != None )
    {
        if( LocalCount != SHOTGUN_HIT_MAX )
                FlashEffect.Trigger(None, Instigator);
        else    FlashEffect.Trigger(Self, Instigator);
    }

    if( Level.DetailMode >= ShellDetailMode )
    {
        // Shell spawner
        if( ShellActorClass != None )
        {
            C = GetBoneCoords(ShellBone);
            R = GetBoneRotation(ShellBone,0);
            Spawn(ShellActorClass,Instigator,,C.Origin,R);
            if( LocalCount == SHOTGUN_HIT_MAX )
                Spawn(ShellActorClass,Instigator,,C.Origin+C.XAxis*16,R);
        }

        // Shell spawner
        if( ShellEffect != None )
            ShellEffect.Trigger(self,Instigator);
    }
}

simulated function CheckForSplash()
{
    local Actor HA;
    local vector HN, HL;
    local int i;

    if( Level.bDropDetail
    ||  Level.DetailMode == DM_Low
    ||  SplashEffect == None
    ||  Instigator.PhysicsVolume.bWaterVolume )
        return;

    bTraceWater = True;
    for( i=0; i!=LocalCount; ++i )
    {
        HA = Trace(HL,HN,HitLocations[i],Instigator.Location + Instigator.EyePosition(),True);
        if( FluidSurfaceInfo(HA) != None || (PhysicsVolume(HA) != None && PhysicsVolume(HA).bWaterVolume) )
            Spawn( SplashEffect,,, HL, rot(16384,0,0) );
    }
    bTraceWater = False;
}


// ============================================================================
// Tracer
// ============================================================================
simulated function UpdateTracer()
{
    local vector SpawnLoc, SpawnVel, V;
    local float Dist;
    local int i;

    //gLog( "UpdateTracer" #LocalCount #TracerEffect.Emitters.Length );

    if( TracerEffect == None && TracerClass != None )
        TracerEffect = Spawn(TracerClass);

    if( TracerEffect != None && Level.TimeSeconds > TracerLastTime + TracerInterval )
    {
        SpawnLoc = GetTipLocation();
        TracerEffect.SetLocation(SpawnLoc);

        for( i=0; i!=LocalCount; ++i )
        {
            V = HitLocations[i];
            Dist = VSize(V - SpawnLoc) - TracerPullback;

            if( Dist > TracerMinDistance )
            {
                SpawnVel = Normal(V - SpawnLoc) * TracerSpeed;

                if( TracerEffect.Emitters[i] != None )
                {
                    TracerEffect.Emitters[i].StartVelocityRange.X.Min = SpawnVel.X;
                    TracerEffect.Emitters[i].StartVelocityRange.X.Max = SpawnVel.X;
                    TracerEffect.Emitters[i].StartVelocityRange.Y.Min = SpawnVel.Y;
                    TracerEffect.Emitters[i].StartVelocityRange.Y.Max = SpawnVel.Y;
                    TracerEffect.Emitters[i].StartVelocityRange.Z.Min = SpawnVel.Z;
                    TracerEffect.Emitters[i].StartVelocityRange.Z.Max = SpawnVel.Z;

                    TracerEffect.Emitters[i].LifetimeRange.Min = Dist / TracerSpeed;
                    TracerEffect.Emitters[i].LifetimeRange.Max = Dist / TracerSpeed;
                }
            }
        }

        for( i=0; i!=LocalCount; ++i )
        {
            if( TracerEffect.Emitters[i] != None )
                TracerEffect.Emitters[i].SpawnParticle(1);
        }

        TracerLastTime = Level.TimeSeconds;
    }
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    IgnoredMode                      = 1

    HitGroupClass                   = class'GEffects.gShotgunHitGroup'
    TracerClass                     = class'GEffects.gShotgunTracer'
    TracerSpeed                     = 10000.0

    FlashEffectClass                = class'GEffects.gShotGunFlash'
    FlashBone                       = "Muzzle"
    FlashBoneRotator                = (Pitch=0,Yaw=0,Roll=0)

    ShellActorClass                 = class'gEffects.gShotgunShell'
    ShellBone                       = "Shells"

    bHeavy                          = False
    bRapidFire                      = False
    bAltRapidFire                   = False

    Mesh                            = Mesh'G_Anims3rd.shotgun'

    LightType                       = LT_Steady
    LightEffect                     = LE_NonIncidence
    LightPeriod                     = 3
    LightBrightness                 = 127
    LightHue                        = 30
    LightSaturation                 = 170
    LightRadius                     = 10

    DrawScale                       = 0.15
    RelativeLocation                = (X=10,Y=-10,Z=-15) //X -Forward/+Backward, Y -Left/+Right, Z -Up/+Down
}