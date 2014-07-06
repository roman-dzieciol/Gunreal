// ============================================================================
//  gHRLBeacon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLBeacon extends gProjectile;


// Static linked list
//  - First item is default.BeaconList
//  - Next item is self.BeaconList
var   gHRLBeacon    BeaconList;

var   Actor         Target;

var() float         PhysicsRate;
var() float         AngularSpeed;

var() Sound         DeathSound;
var() float         DeathSoundVolume;
var() float         DeathSoundRadius;
var() ESoundSlot    DeathSoundSlot;

var() Sound         StickAmbientSound;


replication
{
    reliable if( bNetInitial && Role == ROLE_Authority )
        Target;
}


static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.StickAmbientSound);
    S.PrecacheObject(default.DeathSound);
}

simulated event PreBeginPlay()
{
    // Add to linked list
    default.BeaconList = self;

    // Scripted physics
    SetTimer(PhysicsRate, True);

    if( Role != ROLE_Authority )
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
    }

    Super.PreBeginPlay();
}

simulated event Destroyed()
{
    local gHRLBeacon B;

    // Remove from linked list
    if( default.BeaconList == Self )
    {
        default.BeaconList = BeaconList;
    }
    else
    {
        for( B=default.BeaconList; B!=None; B=B.BeaconList )
        {
            if( B.BeaconList == Self )
            {
                B.BeaconList = BeaconList;
                return;
            }
        }
    }

    Super.Destroyed();
}

event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    if( Role == ROLE_Authority && !bDeleteMe )
    {
        PlaySound(DeathSound, DeathSoundSlot, DeathSoundVolume,, DeathSoundRadius);
        Destroy();
    }
}

simulated event Timer()
{
    local vector TargetLoc,Dir;
    local float Angle,F;
    local quat Q;

    //gLog( "Timer" );

    // Homing physics
    if( Target != None )
    {
        TargetLoc = Target.Location;
        Dir = Normal(TargetLoc - Location);
        Angle = Dir dot vector(Rotation);
        if( Angle > 0 )
        {
            F = 2 * acos(Angle)/pi;
            F = ((AngularSpeed/90) * PhysicsRate) / F;
            F = FClamp(F,0,1);

            //gLog( "S" #Angle #F );

            Q = QuatSlerp(QuatFromRotator(Rotation),QuatFromRotator(rotator(Dir)),F);
            SetRotation(QuatToRotator(Q));
            Velocity = VSize(Velocity) * vector(Rotation);
        }
    }
}

simulated singular event HitWall( vector HitNormal, Actor Other )
{
    //gLog( "HitWall" #GON(Other) );

    if( Role == ROLE_Authority )
    {
        // Stick to vehicles
        if( Vehicle(Other) != None )
            Stick(Other, Location, -vector(Rotation));

        // Bounce or stick on everything else
        else if( !Bounce(Other, HitNormal) )
            Stick( Other, Location, HitNormal );

        // Make inert if not already
        if( Damage != 0 )
            MakeInert();
    }
    else
    {
        // Bounce on everything else
        if( Vehicle(Other) == None )
            Bounce(Other, HitNormal);
    }
}

simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    // Hit pawns
    if( xPawn(Other) != None )
        Hit(Other, HitLocation, HitNormal);
}

final simulated function MakeInert()
{
    Damage = 0;
    MomentumTransfer = 0;
    bIgnoreVehicles = True;
    AmbientSound = None;
    SetTimer(0, False);
}

function Stick(Actor Other, vector HitLocation, vector HitNormal)
{
    local rotator NewRotation;

    //gLog( "Stick" #GON(Other) #HitLocation #HitNormal );

    if( Role == ROLE_Authority )
    {
        // Adjust location and rotation
        AlignTo(Other, HitLocation, HitNormal, NewRotation);
        SetLocation(HitLocation);
        SetRotation(rotator(-vector(NewRotation)));

        // Hit
        HitEffects(Other, HitLocation, HitNormal);
        DealDamage(Other, HitLocation, HitNormal);

        // Abort if DealDamage destroyed our base and us
        if( bDeleteMe )
            return;

        // Make inert
        if( Damage != 0 )
            MakeInert();

        // If attached to vehicle, stay around indefinitely
        if( Vehicle(Other) != None )
        {
            bAlwaysRelevant = True;
            bOnlyDirtyReplication = True;
            AmbientSound = StickAmbientSound;
            Lifespan = 0;
            bIgnoreEncroachers = True;
        }

        // Replicate offset for base or location
        if( Other != None )
            BaseOffset = (HitLocation - Other.Location) << Other.Rotation;
        else
            bUpdateSimulatedPosition = True;

        // Stick
        bCollideWorld = False;
        SetPhysics(PHYS_None);
        SetHardBase(Other, BaseOffset);

        // Replicate this tick
        NetUpdateTime = Level.TimeSeconds - 1;
    }
}

simulated event PostNetReceive()
{
    local Actor RealBase;

    //gLog( "PostNetReceive" );

    if( Role != ROLE_Authority )
    {
        bNetNotify = Base == None || bCollideWorld;

        // Get original base, watch out for SetPhysics()
        RealBase = Base;

        // Disable physics
        SetTimer(0, False);
        if( !bCollideWorld )
            SetPhysics(PHYS_None);

        // Rebase using accurate offset
        if( RealBase != None )
            SetHardBase(RealBase, BaseOffset);

        // If attached to vehicle, stay around indefinitely
        if( Vehicle(RealBase) != None )
            Lifespan = 0;
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    PhysicsRate                     = 0.05
    AngularSpeed                    = 45

    DeathSound                      = Sound'G_Sounds.hrl_homing_reclaim'
    DeathSoundVolume                = 0.3
    DeathSoundRadius                = 128
    DeathSoundSlot                  = SLOT_Interact

    StickAmbientSound               = Sound'G_Sounds.hrl_homing_drone'


    // gProjectile
    bRegisterProjectile             = True
    bHitProjTarget                  = False

    ExtraGravity                    = 1.0
    DampenFactor                    = 0.05
    DampenFactorParallel            = 0.08

    HitGroupClass                   = class'GEffects.gHRLBeaconHitGroup'


    // Projectile
    Speed                           = 7000
    Damage                          = 70
    MomentumTransfer                = 30000
    MyDamageType                    = class'gDamTypeHRLBeacon'


    // Actor
    CollisionRadius                 = 4
    CollisionHeight                 = 4

    bCanBeDamaged                   = True
    bProjTarget                     = True
    bUseCylinderCollision           = True
    LifeSpan                        = 10
    bNetNotify                      = True

    StaticMesh                      = StaticMesh'G_Meshes.hrl_beacon_a'
    DrawScale                       = 0.1

    AmbientSound                    = Sound'G_Sounds.hrl_homing_fly'

    bDynamicLight                   = True
    LightType                       = LT_Steady
    LightEffect                     = LE_QuadraticNonIncidence
    LightPeriod                     = 0
    LightBrightness                 = 255
    LightHue                        = 28
    LightSaturation                 = 0
    LightRadius                     = 16
}