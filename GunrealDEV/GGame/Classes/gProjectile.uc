// ============================================================================
//  gProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gProjectile extends Projectile;


// - Constants ----------------------------------------------------------------

const GST_Vehicle = 11;
const GST_Player = 12;


// - Damage -------------------------------------------------------------------

var() float                 Health;

var() float                 ExtraDamage;
var() class<DamageType>     ExtraDamageType;

var() float                 DamageCurve;
var() float                 MomentumCurve;
var() float                 DealDamageMinRadius;
var() float                 ObjectiveDamageScaling;
var() vector                ExplosionOFfset;
var() range                 DetonateDelay;

var() int                   HeadShotDamage;
var() class<DamageType>     HeadShotDamageType;

var() class<gProjectile>    MineClass;

var   bool                  bHitting;

var() bool                  bProximitySetOff;
var() float                 SetOffDistance;



// - Effects ------------------------------------------------------------------

var()   class<Actor>        AttachmentClass;
var     Actor               Attachment;

var()   class<gHitGroup>    HitGroupClass;
var()   class<Actor>        HitEffectClass;

var()   float               ImpactSoundVolume;
var()   float               ImpactSoundRadius;
var()   ESoundSlot          ImpactSoundSlot;

var()   float               SpawnSoundVolume;
var()   float               SpawnSoundRadius;
var()   ESoundSlot          SpawnSoundSlot;

var() class<Emitter>        BounceEmitterClass;

var() Sound                 BounceSound;
var() float                 BounceSoundVolume;
var() float                 BounceSoundVolumeCurve;
var() float                 BounceSoundRadius;
var() ESoundSlot            BounceSoundSlot;



// - Physics ------------------------------------------------------------------

var() float                 ExtraGravity;

var() float                 DampenFactor;
var() float                 DampenFactorParallel;

var() float                 StuckThreshold;
var() float                 BounceFXThreshold;
var() float                 BounceThreshold;
var   vector                BounceLoc;

var   Actor                 IgnoreActor;

var   vector                BaseOffset;
var   bool                  bIgnoreBaseChange;


// ----------------------------------------------------------------------------

var   Actor                 ServerOwner;
var   TeamInfo              InstigatorTeam;

var() bool                  bCheckTeam;
var() bool                  bHitProjTarget;
var() bool                  bRegisterProjectile;
var() bool                  bIgnoreTeamMates;
var() bool                  bIgnoreController;
var() bool                  bIgnoreBase;
var() bool                  bIgnorePainVolume;


replication
{

    reliable if( bNetDirty && Role == ROLE_Authority )
        BaseOffset;
}


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    S.PrecacheObject(default.ExtraDamageType);
    S.PrecacheObject(default.AttachmentClass);
    S.PrecacheObject(default.HitGroupClass);
    S.PrecacheObject(default.HitEffectClass);
    S.PrecacheObject(default.HeadShotDamageType);
    S.PrecacheObject(default.BounceEmitterClass);
    S.PrecacheObject(default.MineClass);

    S.PrecacheObject(default.BounceSound);

}


// ============================================================================
//  LifeTime
// ============================================================================

event PreBeginPlay()
{
    //gLog( "PreBeginPlay" );

    if( Role == ROLE_Authority )
    {
        // Setup instigator
        SetupInstigator(Instigator, True);

        // Don't replicate owner
        if( Owner != None )
        {
            ServerOwner = Owner;
            SetOwner(None);
        }

        // Register projectile with weapon
        if( bRegisterProjectile && gWeapon(ServerOwner) != None )
            gWeapon(ServerOwner).RegisterProjectile(self);

        // Warn controller's shoot target
        if( InstigatorController != None
        &&  InstigatorController.ShotTarget != None
        &&  InstigatorController.ShotTarget.Controller != None )
            InstigatorController.ShotTarget.Controller.ReceiveProjectileWarning( Self );
    }

    Super.PreBeginPlay();
}

simulated event PostBeginPlay()
{
    //gLog( "PostBeginPlay" );

    // Do spawn effects
    if( Role == ROLE_Authority )
        SpawnEffects();

    // Spawn projectile attachment
    if( Level.NetMode != NM_DedicatedServer && AttachmentClass != None )
    {
        Attachment = Spawn(AttachmentClass, Self);
        Attachment.SetBase(Self);
    }

    // Init velocity.
    // TODO: Maybe should this be ROLE_Authority only, because of rotation replication?
    if( Role == ROLE_Authority )
    {
        if( Speed != 0 )
            Velocity = vector(Rotation) * Speed;
    }

    // Init extra gravity as acceleration.
    // Must be simulated from start.
    if( ExtraGravity != 0 )
        Acceleration = PhysicsVolume.default.Gravity * ExtraGravity;

    bReadyToSplash = True;
}

//simulated event PostNetBeginPlay()
//{
//    //gLog( "PostNetBeginPlay" );
//    Super.PostNetBeginPlay();
//}

simulated event Destroyed()
{
    //gLog( "Destroyed" #bDeleteMe );

    if( Role == ROLE_Authority )
    {
        // UnRegister projectile with weapon
        if( bRegisterProjectile && gWeapon(ServerOwner) != None )
        {
            gWeapon(ServerOwner).UnRegisterProjectile(self);
            bRegisterProjectile = False;
        }
    }

    // Destroy visual effects
    DestroyEffects();

    Super.Destroyed();
}

simulated function DestroyEffects()
{
    //gLog( "DestroyEffects" );

    // Stop ambient sound
    AmbientSound = None;

    // Destroy attachment or make it self-destruct
    if( Attachment != None && !Attachment.bDeleteMe )
    {
        if( bNoFx )
        {
            Attachment.Destroy();
        }
        else
        {
            Attachment.Trigger(self,Instigator);
            Attachment.SetBase(None);
            Attachment = None;
        }
    }
}

final simulated function SetupInstigator(Pawn NewInstigator, optional bool bForce)
{
    //gLog( "SetupInstigator" #GON(NewInstigator) #bForce );

    if( Role == ROLE_Authority && NewInstigator != None && (bForce || (!NewInstigator.bDeleteMe && NewInstigator != Instigator)) )
    {
        // Ignore this actor
        IgnoreActor = NewInstigator;

        // Get Instigator and his controller
        Instigator = NewInstigator;
        InstigatorController = Instigator.Controller;

        // Get team of instigator
        if( bCheckTeam && InstigatorController != None && InstigatorController.PlayerReplicationInfo != None && InstigatorController.PlayerReplicationInfo.Team != None )
            InstigatorTeam = InstigatorController.PlayerReplicationInfo.Team;
        else
            InstigatorTeam = None;
    }
}

final function NotifyControllerDestroyed()
{
    //gLog( "NotifyControllerDestroyed" );

    // Die on logout
    if( DetonateDelay.Max == 0 )
        Destroy();
    else
        DelayedDetonate();
}

final function NotifyControllerTeamChange( int OldTeam, int NewTeam )
{
    //gLog( "NotifyControllerTeamChange" #OldTeam #NewTeam );

    // Die on team switch
    if( DetonateDelay.Max == 0 )
        Destroy();
    else
        DelayedDetonate();
}


event Trigger( Actor Other, Pawn EventInstigator )
{
    //gLog( "Trigger" #GON(Other) #GON(EventInstigator) );
    if( Role == ROLE_Authority )
    {
        // Hit on trigger
        Hit( Base, Location, vector(Rotation) );
    }
}

simulated event PhysicsVolumeChange( PhysicsVolume Volume )
{
    //gLog("PhysicsVolumeChange" #GON(Volume) );

    // Update extra gravity
    if( ExtraGravity != 0 )
        Acceleration = Volume.default.Gravity * ExtraGravity;
}

simulated singular event Touch(Actor Other)
{
    //gLog( "Touch" #GON(Other) );

    if( Role == ROLE_Authority )
    {
        if( Other != IgnoreActor                                            // Ignore special Actor, usually the Instigator
        &&  Other != None && !Other.bDeleteMe                               // Ignore if Other just got destroyed
        && (Other.bBlockActors || (Other.bProjTarget && bHitProjTarget)) )  // Touch potentially interesting actors only
        {
            // World geometry (ie blocking volumes) should use hitwall instead
            if( Other.bWorldGeometry )
            {
                HitWall(-vector(Rotation), Other);
                return;
            }

            // Ignore teammates?
            if( bIgnoreTeamMates
            &&  bCheckTeam
            &&  Level.Game.bTeamGame
            &&  Pawn(Other) != None
            &&  InstigatorTeam == Pawn(Other).GetTeam()
            && (bIgnoreController || InstigatorController == None || InstigatorController != Pawn(Other).Controller) )
                return;

            // Ignore instigator controller pawns?
            if( bIgnoreController
            &&  Pawn(Other) != None
            &&  InstigatorController != None
            &&  InstigatorController == Pawn(Other).Controller
            &&(!Level.Game.bTeamGame || !bCheckTeam || InstigatorTeam == Pawn(Other).GetTeam()) )
                return;

            // Ignore our base?
            if( bIgnoreBase
            &&  Base != None
            &&  Base == Other )
                return;

            //gLog( "Touch" #GON(Other) );

            TouchTarget(Other, Location, -vector(Rotation));
        }
    }
    else
    {
        // Ragdolls hack
        if( Role < ROLE_Authority && Other.Role == ROLE_Authority && xPawn(Other) != None )
            ClientSideTouch(Other, Location);
    }
}

simulated function ClientSideTouch(Actor Other, vector HitLocation)
{
    //gLog( "TouchTarget" #GON(Other) #HitLocation );

    Other.TakeDamage(Damage, Instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
}

simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "TouchTarget" #GON(Other) #HitLocation #HitNormal );

    // Hit everything
    if( Role == ROLE_Authority )
        Hit(Other, HitLocation, HitNormal);
}

simulated singular event HitWall(vector HitNormal, Actor Other)
{
    //gLog( "HitWall" #GON(Other) #HitNormal );

    // Hit everything
    if( Role == ROLE_Authority )
        Hit(Other, Location, HitNormal);
}

simulated event Landed(vector HitNormal)
{
    //gLog( "Landed" #HitNormal );

    // Let HitWall handle it
    HitWall(HitNormal, Level);
}

simulated event EncroachedBy(Actor Other)
{
    local vector HitNormal;

    //gLog( "EncroachedBy" #GON(Other) );

    // Get approximate HitNormal
    if( Other != None )
    {
        if( Other.Velocity != vect(0,0,0) )
            HitNormal = Normal(Other.Velocity);
        else
            HitNormal = Normal(Location - Other.Location);
    }

    // Let HitWall handle it
    HitWall(HitNormal, Other);
}

event bool EncroachingOn( Actor Other )
{
    //gLog( "EncroachingOn" #GON(Other) #( Other.Brush != None || Brush(Other) != None ) );
    if( Other.Brush != None || Brush(Other) != None )
        return True;

    return False;
}

//event RanInto( Actor Other )
//{
//    //gLog( "RanInto" #GON(Other) );
//}

event BaseChange()
{
    //gLog( "BaseChange" #GON(Base) #Location #RelativeLocation #RelativeRotation );

    // Hit when base removed
    if( Role == ROLE_Authority && !bIgnoreBaseChange && Base == None && !bDeleteMe )
        Hit(None, Location, vector(Rotation));
}

final simulated function SetHardBase(Actor NewBase, vector Offset)
{
    //gLog( "SetHardBase" #GON(NewBase) #Offset );

    // Rebase bHardAttached actor correcting the offset
    if( NewBase != None )
    {
        // Unbase if based
        if( Base != None )
        {
            bIgnoreBaseChange = True;
            SetBase(None);
            bIgnoreBaseChange = False;
        }

        // Correct the location
        SetLocation( NewBase.Location + (Offset >> NewBase.Rotation) );

        // Attach
        SetBase(NewBase);
    }
}

final simulated function bool Bounce(Actor Other, vector HitNormal)
{
    local vector VN;
    local float CurSpeed;

    //gLog( "Bounce" #GON(Other) #HitNormal );

    // Don't bounce from moving movers as this is unreliable atm
    if( Mover(Other) != None && Other.Velocity != vect(0,0,0) )
        return False;

    // Rotate randomly
    RandSpin(500000);

    // Get collision speed
    CurSpeed = VSize(Velocity);

    // Bounce or stick
    if( CurSpeed > BounceThreshold && VSize(BounceLoc-Location) > StuckThreshold )
    {
        //gLog( "Bounce" #GON(Other) #HitNormal #CurSpeed );

        // Bounce effects
        if( Level.NetMode != NM_DedicatedServer )
        {
            if( BounceSound != None )
                PlaySound( BounceSound, BounceSoundSlot , BounceSoundVolume*(FMin(CurSpeed/Speed,1)**BounceSoundVolumeCurve), , BounceSoundRadius );

            if( CurSpeed > BounceFXThreshold && EffectIsRelevant( Location, False ) && BounceEmitterClass != None )
                Spawn( BounceEmitterClass,,, Location, rotator(HitNormal) );
        }

        // Bounce velocity
        VN = (Velocity dot HitNormal) * HitNormal;
        Velocity = -VN * DampenFactor + (Velocity - VN) * DampenFactorParallel;
        BounceLoc = Location;
        return True;
    }
    return False;
}

simulated function Stick(Actor Other, vector HitLocation, vector HitNormal)
{
    local gProjectile P;
    local rotator HitRotation;

    //gLog( "Stick" #GON(Other) #HitLocation #HitNormal );

    if( MineClass != None && Role == ROLE_Authority )
    {
        // Disable collision
        SetCollision(False,False,False);
        bCollideWorld = False;
        bProjTarget = False;

        // Adjust location and rotation
        AlignTo(Other, HitLocation, HitNormal, HitRotation);

        // Create mine
        P = Spawn(MineClass, ServerOwner,, HitLocation, HitRotation);
        if( P != None && !P.bDeleteMe )
            P.InitMine(self, Other);

        // Die
        Destroy();
    }
}

simulated function AlignTo(Actor Other, out vector HitLocation, out vector HitNormal, out rotator HitRotation)
{
    local vector HL, HN, Offset;

    //gLog( "AlignTo" #GON(Other) #HitLocation #HitNormal #HitRotation #VSize(Velocity) );

    // Align to movers
    if( Mover(Other) != None )
    {
        Offset = FMax(VSize(Other.Velocity), VSize(Velocity)) * 2.0 * Normal(Velocity-Other.Velocity);
        if( !Other.TraceThisActor(HL, HN, HitLocation+Offset, HitLocation-Offset, GetCollisionExtent()) )
        {
            HitLocation = HL;
            HitNormal = HN;
        }
    }

    // Calc SpawnRotation
    HitRotation = rotator(HitNormal);
}

simulated function InitMine(gProjectile Spawner, Actor NewBase);

function bool IsStationary()
{
    return Physics == PHYS_None;
}


// ============================================================================
// Damage
// ============================================================================

event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    //gLog( "TakeDamage" #Damage #GON(InstigatedBy) #GON(DamageType) );

    if( Role == ROLE_Authority && Damage > 0 && Health > 0 && !bDeleteMe )
    {
        if( bIgnorePainVolume && InstigatedBy == None && Momentum == vect(0,0,0) && DamageType != None && !DamageType.default.bDirectDamage )
        {
            return;
        }

        // Decrease health
        Health -= Damage;
        if( Health <= 0 )
        {
            // Swap Instigator
            SetupInstigator(InstigatedBy);

            // Hit
            if( DamageType != None && DamageType.default.bDelayedDamage )
            {
                // Splash damage causes delayed detonation
                DelayedDetonate();
            }
            else
            {
                // Instant damage causes instant detonation
                Hit(Base, Location, vector(Rotation));
            }
        }
    }
}

simulated function HurtRadius( float DamageAmount, float DamageRadius, class<DamageType> DamageType, float Momentum, vector HitLocation )
{
    Warn("Deprecated");
}

final simulated function DealDamage(Actor HitActor, vector HitLocation, vector HitNormal)
{
    local Actor A;
    local float DamageScale, Dist, FinalDamage;
    local vector Dir, Delta, Momentum, BlastLoc;

    //gLog( "DealDamage" #GON(HitActor) );

    if( !bHurtEntry )
        bHurtEntry = True;
    else
        return;

    MakeNoise(1.0);


    if( HitActor != None && !HitActor.bDeleteMe && HitActor.bCanBeDamaged && HitActor != Self && HitActor.Role == ROLE_Authority )
    {
        if( DamageRadius > 0 )
            HitNormal = Normal(HitLocation - HitActor.Location);
        Momentum = MomentumTransfer * -HitNormal;
        ApplyDirectDamage(HitActor, Damage, HitLocation, HitNormal, Momentum);
    }

    if( DamageRadius > 0 )
    {
        HitLocation = Location;

        // TODO: convert into world space and fasttrace, it's in local space atm
        ExplosionOffset = vect(0,0,0);

        foreach VisibleCollidingActors(class'Actor', A, FMax(DamageRadius, DealDamageMinRadius), HitLocation+ExplosionOffset)
        {
            if( A == None || A.bDeleteMe )
                continue;

            // don't let blast damage affect fluid - VisibleCollisingActors doesn't really work for them - jag
            if( A != HitActor && !A.bDeleteMe && A.bCanBeDamaged && A != Self && A.Role == ROLE_Authority && !A.IsA('FluidSurfaceInfo') )
            {
                BlastLoc = A.Location;
                Delta = BlastLoc - HitLocation;
                Dir = Normal(Delta);

                if( A.bBlockActors )
                {
                    if( A.TraceThisActor(BlastLoc, HitNormal, HitLocation + Dir*16384, HitLocation, vect(1,1,0) * default.CollisionRadius + vect(0,0,1) * default.CollisionHeight) )
                    {
                        continue;
                    }
                    else
                    {
                        Delta = BlastLoc - HitLocation;
                        Dir = Normal(Delta);
                    }
                }

                Dist = VSize(Delta);

                if( Dist > DamageRadius )
                    continue;

                HitNormal = -Dir;
                DamageScale = 1 - (Dist / DamageRadius);
                FinalDamage = Damage * (DamageScale ** DamageCurve);
                Momentum = MomentumTransfer * Dir * (DamageScale ** MomentumCurve);

                ApplyBlastDamage(A, FinalDamage, BlastLoc, HitNormal, Momentum);
            }
        }
    }

    bHurtEntry = False;
}

final simulated function ApplyDirectDamage(Actor A, float Amount, vector HitLocation, vector HitNormal, vector Momentum)
{
    local Pawn P;
    local float AdditionalScale;
    
    if( A == None )
    	return;

    if( Instigator == None || Instigator.Controller == None )
        A.SetDelayedDamageInstigatorController(InstigatorController);

    if( Vehicle(A) != None && Vehicle(A).Health > 0 )
    {
        A.TakeDamage( Amount,Instigator,HitLocation,Momentum,MyDamageType );
	    if( A == None )
	    	return;

        // Headshot
        if( HeadShotDamage > 0 )
        {
            P = Vehicle(A).CheckForHeadShot( Location, vector(Rotation),AdditionalScale );

            if( P != None )
                P.TakeDamage( HeadShotDamage,Instigator,HitLocation,Momentum,HeadShotDamageType );
        }

        if( DamageRadius > 0 )
            Vehicle(A).DriverRadiusDamage( Amount,DamageRadius,InstigatorController,MyDamageType,MomentumTransfer,HitLocation );

        if( ExtraDamage > 0 )
            Vehicle(A).TakeDamage( ExtraDamage,Instigator,HitLocation,Momentum,ExtraDamageType );
    }
    else if( Pawn(A) != None )
    {
        if( HeadShotDamage == 0 || !Pawn(A).IsHeadShot(Location,vector(Rotation),AdditionalScale) )
            A.TakeDamage( Amount,Instigator,HitLocation,Momentum,MyDamageType );
        else
            A.TakeDamage( HeadShotDamage,Instigator,HitLocation,Momentum,HeadShotDamageType );
    }
    else if( GameObjective(A) != None )
    {
        A.TakeDamage( Amount*ObjectiveDamageScaling,Instigator,HitLocation,Momentum,MyDamageType );
    }
    else
    {
        A.TakeDamage( Amount,Instigator,HitLocation,Momentum,MyDamageType );
    }
}

final simulated function ApplyBlastDamage(Actor A, float Amount, vector HitLocation, vector HitNormal, vector Momentum)
{
    if( Instigator == None || Instigator.Controller == None )
        A.SetDelayedDamageInstigatorController(InstigatorController);

    if( GameObjective(A) != None )
    {
        A.TakeDamage( Amount*ObjectiveDamageScaling,Instigator,HitLocation,Momentum,MyDamageType );
    }
    else
    {
        A.TakeDamage( Amount,Instigator,HitLocation,Momentum,MyDamageType );
        if( Vehicle(A) != None && Vehicle(A).Health > 0 )
        {
            if( DamageRadius > 0 )
                Vehicle(A).DriverRadiusDamage( Amount,DamageRadius,InstigatorController,MyDamageType,MomentumTransfer,HitLocation );

            if( ExtraDamage > 0 )
                Vehicle(A).TakeDamage( ExtraDamage,Instigator,HitLocation,Momentum,ExtraDamageType );
        }
    }
}

simulated function Shutdown()
{
    if( bNetTemporary && Role < ROLE_Authority )
    {
        Destroy();
    }
    else
    {
        SetCollision(False, False);
        SetPhysics(PHYS_None);
        DestroyEffects();
    }
}

final simulated function DisableCollision()
{
    SetCollision(False,False,False);
    bCollideWorld = False;
    bProjTarget = False;
}

simulated function Hit( Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "Hit" #GON(Other) #bDeleteMe #bHitting );
    if( Role == ROLE_Authority && !bDeleteMe && !bHitting )
    {
        bHitting = True;
        bCanBeDamaged = False;
        HitEffects(Other, HitLocation, HitNormal);
        DealDamage(Other, HitLocation, HitNormal);
        Destroy();
    }
}

simulated function Explode(vector HitLocation, vector HitNormal)
{
    Hit( Base, HitLocation, HitNormal );
}

simulated function BlowUp(vector HitLocation)
{
    Hit( Base, HitLocation, vector(rotation) );
}

final singular function ProximityTouch( Actor Other )
{
    //gLog( "ProximityTouch" #GON(Other) );

    // Duplicate of gProjectile.Touch which apparently can't be called from gProximityFuze.Touch because it's singular.
    // Oh well.. this is even faster. Just keep in sync.
    if( Role == ROLE_Authority )
    {
        if( Other != IgnoreActor                                            // Ignore special Actor, usually the Instigator
        &&  Other != None && !Other.bDeleteMe                               // Ignore if Other just got destroyed
        && (Other.bBlockActors || (Other.bProjTarget && bHitProjTarget)) )  // Touch potentially interesting actors only
        {
            // World geometry (ie blocking volumes) should use hitwall instead
            if( Other.bWorldGeometry )
            {
                HitWall(-vector(Rotation), Other);
                return;
            }

            // Ignore teammates?
            if( bIgnoreTeamMates
            &&  bCheckTeam
            &&  Level.Game.bTeamGame
            &&  Pawn(Other) != None
            &&  InstigatorTeam == Pawn(Other).GetTeam()
            && (bIgnoreController || InstigatorController == None || InstigatorController != Pawn(Other).Controller) )
                return;

            // Ignore instigator controller pawns?
            if( bIgnoreController
            &&  Pawn(Other) != None
            &&  InstigatorController != None
            &&  InstigatorController == Pawn(Other).Controller
            &&(!Level.Game.bTeamGame || !bCheckTeam || InstigatorTeam == Pawn(Other).GetTeam()) )
                return;

            // Ignore our base?
            if( bIgnoreBase
            &&  Base != None
            &&  Base == Other )
                return;

            TouchTarget(Other, Location, -vector(Rotation));
        }
    }
}

singular function ProximitySetOff( Pawn InstigatedBy, class<DamageType> DamageType )
{
    //gLog( "ProximitySetOff" #GON(InstigatedBy) #GON(DamageType) );
}

final function CheckSetOff()
{
    local gProjectile P;

    foreach CollidingActors(class'gProjectile', P, SetOffDistance)
    {
        if( P.bProximitySetOff && P.SetOffDistance > VSize(Location - P.Location) - CollisionRadius - P.CollisionRadius )
            P.ProximitySetOff(Instigator, MyDamageType);
    }
}

// ============================================================================
//  Effects
// ============================================================================

function SpawnEffects()
{
    if( SpawnSound != None )
        PlaySound(SpawnSound, SpawnSoundSlot, SpawnSoundVolume, False, SpawnSoundRadius, 1.0, True);
}

function HitEffects(Actor HitActor, vector HitLocation, vector HitNormal)
{
    //gLog( "HitEffects" #GON(HitActor) );

    if( HitEffectClass != None )
        Spawn(HitEffectClass, Self,, HitLocation, rotator(HitNormal));
    else if( HitGroupClass != None )
        Spawn(HitGroupClass.static.GetHitEffectEx(Self, HitActor, HitLocation, HitNormal),,, HitLocation, rotator(HitNormal));

    if( ExplosionDecal != None && Pawn(HitActor) == None && gTerminalShield(HitActor) == None /*&& DecalIsRelevant(ExplosionDecal)*/ )
        Spawn(ExplosionDecal, Self,, Location, rotator(-HitNormal));

    if( ImpactSound != None )
        PlaySound(ImpactSound, ImpactSoundSlot, ImpactSoundVolume, False, ImpactSoundRadius, , True);
}


// ============================================================================
//  DelayedDetonate
// ============================================================================

final function DelayedDetonate()
{
    if( bCanBeDamaged )
        GotoState('DelayedDetonating');
}

state DelayedDetonating
{
    ignores TakeDamage, Touch, HitWall, Landed, EncroachedBy, BaseChange, Trigger;

Begin:
    //gLog("Begin");
    bCanBeDamaged = False;
    Sleep( RandRange(DetonateDelay.Min, DetonateDelay.Max) );
    Hit(Base, Location, vector(Rotation));
}


// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog ( coerce string S ){
    class'GDebug.gDbg'.static.aLog( self, Level, S, gDebugString() );}

simulated function string gDebugString()
{
    local string S;

    S = S #Location;
    /*S = "" #bDeleteMe #Physics #Location #RelativeLocation #RelativeRotation #GON(Base);

    if( Base != None )
        S = S #(Base.Location-Location) #BaseOffset;*/

    return S;
}


// ============================================================================
//  Debug String
// ============================================================================
simulated final static function string StrShort( coerce string S ){
    return class'GDebug.gDbg'.static.StrShort( S );}

simulated final static operator(112) string # ( coerce string A, coerce string B ){
    return class'GDebug.gDbg'.static.Pound_StrStr( A,B );}

simulated final static function name GON( Object O ){
    return class'GDebug.gDbg'.static.GON( O );}

simulated final function string GPT( string S ){
    return class'GDebug.gDbg'.static.GPT( self, S );}

// ============================================================================
//  Debug Visual
// ============================================================================
simulated final function DrawAxesRot( vector Loc, rotator Rot, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesRot( self, Loc, Rot, Length, bStaying );}

simulated final function DrawAxesCoords( Coords C, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesCoords( self, C, Length, bStaying );}

simulated final function DrawAxesXYZ( vector Loc, vector X, vector Y, vector Z, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesXYZ( self, Loc, X, Y, Z, Length, bStaying );}

simulated final static function VarWatch( coerce string Desc, coerce string Value, optional bool bGraph ){
    class'GDebug.gDbg'.static.VarWatch( Desc, Value, bGraph );}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gProjectile
    DetonateDelay                       = (Min=0,Max=0.0)
    ExplosionOffset                     = (Z=16)

    DampenFactor                        = 0.3
    DampenFactorParallel                = 0.5

    BounceFXThreshold                   = 512
    StuckThreshold                      = 1.0
    BounceThreshold                     = 50

    BounceSound                         = None
    BounceSoundVolume                   = 1.0
    BounceSoundVolumeCurve              = 0.5
    BounceSoundRadius                   = 230
    BounceSoundSlot                     = SLOT_None

    BounceEmitterClass                  = None

    bHitProjTarget                      = True
    bCheckTeam                          = True
    bIgnoreBase                         = True
    bIgnorePainVolume                   = False


    SetOffDistance                      = 128
    ObjectiveDamageScaling              = 1.0
    DealDamageMinRadius                 = 768
    DamageCurve                         = 1.0
    MomentumCurve                       = 1.0

    Health                              = 0
    ExtraGravity                        = 0

    ExtraDamage                         = 0
    ExtraDamageType                     = None

    AttachmentClass                     = None
    HitGroupClass                       = None
    HitEffectClass                      = None

    ImpactSound                         = None
    ImpactSoundVolume                   = 1.0
    ImpactSoundRadius                   = 384
    ImpactSoundSlot                     = SLOT_None


    // Projectile
    Speed                               = 0
    MaxSpeed                            = 0
    TossZ                               = 0

    bSwitchToZeroCollision              = False
    bNoFX                               = False
    bSpecialCalcView                    = False
    bScriptPostRender                   = False

    Damage                              = 0
    DamageRadius                        = 0
    MomentumTransfer                    = 10000
    MyDamageType                        = class'DamageType'

    SpawnSound                          = None
    SpawnSoundVolume                    = 1.0
    SpawnSoundRadius                    = 384
    SpawnSoundSlot                      = SLOT_None

    ExplosionDecal                      = None
    ExploWallOut                        = 0

    // Actor
    CollisionRadius                     = 16
    CollisionHeight                     = 16
    bProjTarget                         = False
    bCollideActors                      = True
    bCollideWorld                       = True
    bBlockActors                        = False
    bBlockKarma                         = False
    bBlockZeroExtentTraces              = True
    bBlockNonZeroExtentTraces           = True
    bUseCylinderCollision               = True
    bUseCollisionStaticMesh             = False

    bHardAttach                         = True
    bCanBeDamaged                       = False
    bIgnoreTerminalVelocity             = True
    bOrientToVelocity                   = False
    bBounce                             = True
    bIgnoreEncroachers                  = False
    LifeSpan                            = 60
    Physics                             = PHYS_Falling

    bAcceptsProjectors                  = False
    bDisturbFluidSurface                = True
    DrawType                            = DT_StaticMesh
    AmbientGlow                         = 0
    DrawScale                           = 1.0
    PrePivot                            = (X=0,Y=0,Z=0)

    bGameRelevant                       = True
    bReplicateMovement                  = True
    bReplicateInstigator                = False
    bNetInitialRotation                 = True
    bNetTemporary                       = False
    bOnlyDirtyReplication               = False
    bUpdateSimulatedPosition            = False
    bSkipActorPropertyReplication       = False
    bAlwaysRelevant                     = False
    RemoteRole                          = ROLE_SimulatedProxy

    bUnlit                              = True
    bDynamicLight                       = False
    LightType                           = LT_None
    LightEffect                         = LE_None
    LightPeriod                         = 0
    LightBrightness                     = 0
    LightHue                            = 0
    LightSaturation                     = 0
    LightRadius                         = 0

    AmbientSound                        = None
    SoundRadius                         = 320
    SoundVolume                         = 255

    TransientSoundVolume                = 1.0
    TransientSoundRadius                = 384
}
