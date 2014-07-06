// ============================================================================
//  gGib.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGib extends Gib;

var() float Health;
var() class<Projector> ImpactProjector;
var() class<Emitter> HitClass;
var() class<Emitter> ExplodeClass;
var() class<gGibTrail> gTrailClass;
var int HitCount;
var gGibTrail gTrail;
var array<Projector> Impacts;

var() float ExtraGravity;

// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    S.PrecacheObject(default.ImpactProjector);
    S.PrecacheObject(default.HitClass);
    S.PrecacheObject(default.ExplodeClass);
    S.PrecacheObject(default.gTrailClass);
}

//simulated event PostBeginPlay()
//{
//  super.PostBeginPlay();
//  //LifeSpan *= 1 + FRand();
//}

simulated event PreBeginPlay() {
    local PlayerController PC;
    PC = Level.GetLocalPlayerController();
    if( PC.BeyondViewDistance(Location, CullDistance) )
    {
        Destroy();
        return;
    }
    super.PreBeginPlay();
    SetTimer(30, False);
}

simulated event PostBeginPlay() {
    if( Level.bDropDetail )
        LifeSpan *= 0.5;
    super.PostBeginPlay();

    Acceleration = PhysicsVolume.default.Gravity * ExtraGravity;
}

simulated function SpawnImpactProjector(vector HitNormal) {
    if(ImpactProjector != None && !PhysicsVolume.bNoDecals) {
        Impacts[Impacts.Length] = Spawn(ImpactProjector,self,,Location, rotator(-HitNormal));
        if( Impacts[Impacts.Length-1] != None )
            Impacts[Impacts.Length-1].LifeSpan = 0;
        else {
            log(self@"failed to spawn impact projector??");
            Impacts.Remove(1,Impacts.Length-1);
        }
        // since we're attaching it's lifespan to ours, we nullify it's lifespan stuff.
    }
}

simulated event Destroyed() {
    local int x;
    for(x = 0; x < Impacts.Length; x++) {
        Impacts[x].AbandonProjector(0.1);
        Impacts[x].Destroy();
    }
    super.Destroyed();
}

simulated event HitWall( vector HitNormal, Actor Wall )
{
    local float Speed, MinSpeed;

    SetCollision(True);
    HitCount++;
    Velocity = DampenFactor * ((Velocity dot HitNormal) * HitNormal*(-2.0) + Velocity);
    RandSpin(100000);
    Speed = VSize(Velocity);

    if( Level.DetailMode == DM_Low )
    {
        MinSpeed = 200;
    }
    else
    {
        MinSpeed = 100;
    }

    //gLog( "HW" #MinSpeed #Speed );

    //if( !bFlaming && Speed > MinSpeed )
    //if( HitCount < 2 )
    if( Speed > MinSpeed )
    {
        if( Level.NetMode != NM_DedicatedServer /*&& !Level.bDropDetail*/ )
        {
            if( GibGroupClass.default.BloodHitClass != None )
                Spawn( GibGroupClass.default.BloodHitClass,,, Location, rotator(-HitNormal) );
            SpawnImpactProjector(HitNormal);

            //if( /*LifeSpan < 7.3 &&*/ Level.DetailMode != DM_Low )
                //PlaySound(HitSounds[Rand(2)]);
        }
    }

    //if( Speed < 20 )
    else if( Speed < MinSpeed )
    {
        bBounce = False;
    }
    PlaySound(sound'G_Proc.gore_g_splat', , 255, , 65);
}

simulated event Landed( vector HitNormal )
{
    //gLog( "Landed" );

    SetPhysics(PHYS_None);
    if(!bFlaming && !Level.bDropDetail && Level.DetailMode != DM_Low) {
        if(GibGroupClass.default.BloodHitClass != None) {
            spawn(GibGroupClass.default.BloodHitClass,,,Location,rotator(-HitNormal));
        }
        SpawnImpactProjector(HitNormal);
    }
}

simulated function SpawnTrail()
{
//  if(gTrail != None) return;
//  if( Level.NetMode != NM_DedicatedServer )
//  {
//      if( bFlaming )
//      {
//          Trail = Spawn(class'HitFlameBig', self,,Location,Rotation);
//          Trail.LifeSpan = 4 + 2*FRand();
//          //LifeSpan = Trail.LifeSpan;
//          Trail.SetTimer(LifeSpan - 3.0,False);
//      }
//      else
//      {
            //Trail = Spawn(TrailClass, self,, Location, Rotation);
//          gTrail = Spawn(gTrailClass, self,, Location, Rotation);
//          gTrail.LifeSpan = 1.8;
//      }
//      gTrail.SetPhysics( PHYS_Trailer );
//      RandSpin( 64000 );
//  }
    RandSpin(64000);
}

simulated event Timer()
{
    local Pawn P;
    local bool bFound;
    foreach VisibleCollidingActors(class'Pawn', P, 600) {
        if(P.Health > 0) {
            bFound = True;
            break;
        }
    }
    if(!bFound && !PlayerCanSeeMe()) {
        Destroy();
    } else {
        SetTimer(2, False);
    }
}



simulated event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType )
{
    //gLog( "TakeDamage" #Damage #Health );

    //Health -= Damage;
    if( Level.NetMode != NM_DedicatedServer /*&& !Level.bDropDetail*/ )
    {
        //if( GibGroupClass.default.BloodHitClass != None )
            Spawn( class'gEffects.gBodyHitEmitter',,, Location, rotator(-Momentum) );
    }
    PlaySound( HitSounds[Rand(2)] );
    SpawnTrail();
    SetPhysics(PHYS_Falling);
    //Velocity = VRand() * Clamp(((vsize(Momentum)+1) * 1000), 200, 800);
    //glog(self@"Incoming Momentum:"@Momentum@"size="@vsize(momentum));

    velocity = (momentum + (vrand() * 100));
    if(vsize(momentum) > 1200) {
        while(vsize(velocity) > 1200) {
            velocity = velocity * 0.5;
        }
    } else if(vsize(momentum) < 600) {
        while(vsize(velocity) < 600) {
            velocity = velocity * 1.5;
        }
    }
    //velocity = (momentum * 500) + (vrand() * 100);
    //velocity.X = (momentum.x * 500) + (vrand() * 100);
    //if(velocity.X < -1200) velocity.X = -1200;
    //if(velocity.X > -600 && velocity.X < 1) velocity.X = -600;
    //if(velocity.X > 1200) velocity.X = 1200;
    //if(velocity.x > 1 && velocity.X < 600) velocity.X = 600;
    //velocity.Y = momentum.x * 1000;
    //if(velocity.Y < -1200) velocity.Y = -1200;
    //if(velocity.Y > -600 && velocity.Y < 1) velocity.Y = -600;
    //if(velocity.Y > 1200) velocity.Y = 1200;
    //if(velocity.Y > 1 && velocity.Y < 600) velocity.Y = 600;

    velocity.Z = clamp( (vsize(Momentum) + 1) * 300, 300, 600);
    Acceleration = PhysicsVolume.default.Gravity * ExtraGravity;
    HitCount = 0;
    RandSpin(100000);
//  if( Health > 0 )
//  {
//      if( HitClass != None )
//          Spawn( HitClass,,, Location, rotator(Momentum) );
//  }
//  else
//  {
//      if( ExplodeClass != None )
//          Spawn( ExplodeClass,,, Location, rotator(Momentum) );
//      Destroy();
//  }
}

//simulated event Touch( Actor Other )
//{
//    gLog( "Touch" #Other );
//}



simulated event PhysicsVolumeChange( PhysicsVolume Volume )
{
    //gLog("PhysicsVolumeChange" #GON(Volume) );

    // Update extra gravity
    if( Physics == PHYS_Falling )
        Acceleration = Volume.default.Gravity * ExtraGravity;
}


// ============================================================================
// Debug
// ============================================================================


// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog ( coerce string S ){
 class'GDebug.gDbg'.static.aLog( self, Level, S, gDebugString() );}

simulated function string gDebugString();

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
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ExtraGravity                = 1.0
    DampenFactor                = 0.40
    HitClass                    = class'GEffects.gRedBloodPuff'
    ExplodeClass                = class'GEffects.gRedBloodPuff'
    gTrailClass                 = class'GEffects.gGibTrail'

    GibGroupClass               = class'gGibGroup'
    LifeSpan                    = 180
    Health                      = 30

    bCollideActors              = False
    bProjTarget                 = True

    ImpactProjector             = class'gBloodSplatterHeadshot'
    bUseCylinderCollision       = True
    CollisionHeight             = 6
    CollisionRadius             = 6
    CullDistance                = 8000
    // Only the Head gib should leave the gBloodSplatterGibs, I guess.
}
