// ============================================================================
//  gTransBeacon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTransBeacon extends TransBeacon;

/*  REFS
----------------------------------------
Find 'TranslocatorBeacon' in 'D:\games\UT2004\UnrealGame\Classes\SquadAI.uc' :
D:\games\UT2004\UnrealGame\Classes\SquadAI.uc/1928:  local TranslocatorBeacon T;
Found 'TranslocatorBeacon' 1 time(s).
----------------------------------------
Find 'TranslocatorBeacon' in 'D:\games\UT2004\UnrealGame\Classes\TranslocatorBeacon.uc' :
D:\games\UT2004\UnrealGame\Classes\TranslocatorBeacon.uc/1: class TranslocatorBeacon extends Projectile;
D:\games\UT2004\UnrealGame\Classes\TranslocatorBeacon.uc/3: var TranslocatorBeacon NextBeacon;
D:\games\UT2004\UnrealGame\Classes\TranslocatorBeacon.uc/29:  local TranslocatorBeacon T;
Found 'TranslocatorBeacon' 3 time(s).
----------------------------------------
Find 'TranslocatorBeacon' in 'D:\games\UT2004\UnrealGame\Classes\UnrealMPGameInfo.uc' :
D:\games\UT2004\UnrealGame\Classes\UnrealMPGameInfo.uc/27: var TranslocatorBeacon BeaconList;
Found 'TranslocatorBeacon' 1 time(s).
----------------------------------------
Find 'TranslocatorBeacon' in 'D:\games\UT2004\XWeapons\Classes\TransBeacon.uc' :
D:\games\UT2004\XWeapons\Classes\TransBeacon.uc/5: class TransBeacon extends TranslocatorBeacon;
Found 'TranslocatorBeacon' 1 time(s).
Search complete, found 'TranslocatorBeacon' 26 time(s). (5 files.)
*/

/*  REFS
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\UTClassic\classes\ClassicTransBeacon.uc' :
D:\games\UT2004\UTClassic\classes\ClassicTransBeacon.uc/1: class ClassicTransbeacon extends Transbeacon;
Found 'TransBeacon' 1 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc' :
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/6:     local TransBeacon TransBeacon;
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/8:     if( TransLauncher(Weapon).TransBeacon == None )
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/11:    TransBeacon = Weapon.Spawn(class'ClassicTransBeacon',,, Start, Dir);
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/13:    TransBeacon = Weapon.Spawn(class'ClassicRedBeacon',,, Start, Dir);
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/15:    TransBeacon = Weapon.Spawn(class'ClassicBlueBeacon',,, Start, Dir);
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/16:         TransLauncher(Weapon).TransBeacon = TransBeacon;
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/22:         TransLauncher(Weapon).TransBeacon.Destroy();
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/23:         TransLauncher(Weapon).TransBeacon = None;
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/26:     return TransBeacon;
Found 'TransBeacon' 11 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\XWeapons\Classes\BlueBeacon.uc' :
D:\games\UT2004\XWeapons\Classes\BlueBeacon.uc/1: class BlueBeacon extends TransBeacon;
Found 'TransBeacon' 1 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\XWeapons\Classes\LimitationVolume.uc' :
D:\games\UT2004\XWeapons\Classes\LimitationVolume.uc/16:  if( ((bLimitTransDisc) && (TransBeacon(Other)!=None)) || ((bLimitProjectiles) && (Projectile(Other)!=None)) )
Found 'TransBeacon' 1 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\XWeapons\Classes\RedBeacon.uc' :
D:\games\UT2004\XWeapons\Classes\RedBeacon.uc/1: class RedBeacon extends TransBeacon;
Found 'TransBeacon' 1 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\XWeapons\Classes\TransBeacon.uc' :
D:\games\UT2004\XWeapons\Classes\TransBeacon.uc/5: class TransBeacon extends TranslocatorBeacon;
Found 'TransBeacon' 1 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\XWeapons\Classes\TransbeaconTeleporter.uc' :
D:\games\UT2004\XWeapons\Classes\TransbeaconTeleporter.uc/17:  if( (TransBeacon(Other) == None) || (myJumpSpot == None) )
D:\games\UT2004\XWeapons\Classes\TransbeaconTeleporter.uc/21:  if( TransBeacon(Other).Trail != None )
D:\games\UT2004\XWeapons\Classes\TransbeaconTeleporter.uc/22:      TransBeacon(Other).Trail.mRegen = False;
Found 'TransBeacon' 3 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\XWeapons\Classes\TransFire.uc' :
D:\games\UT2004\XWeapons\Classes\TransFire.uc/29:     local TransBeacon TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransFire.uc/31:     if( TransLauncher(Weapon).TransBeacon == None )
D:\games\UT2004\XWeapons\Classes\TransFire.uc/34:    TransBeacon = Weapon.Spawn(class'XWeapons.TransBeacon',,, Start, Dir);
D:\games\UT2004\XWeapons\Classes\TransFire.uc/36:    TransBeacon = Weapon.Spawn(class'XWeapons.RedBeacon',,, Start, Dir);
D:\games\UT2004\XWeapons\Classes\TransFire.uc/38:    TransBeacon = Weapon.Spawn(class'XWeapons.BlueBeacon',,, Start, Dir);
D:\games\UT2004\XWeapons\Classes\TransFire.uc/39:         TransLauncher(Weapon).TransBeacon = TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransFire.uc/45:         if( TransLauncher(Weapon).TransBeacon.Disrupted() )
D:\games\UT2004\XWeapons\Classes\TransFire.uc/52:    TransLauncher(Weapon).TransBeacon.Destroy();
D:\games\UT2004\XWeapons\Classes\TransFire.uc/53:    TransLauncher(Weapon).TransBeacon = None;
D:\games\UT2004\XWeapons\Classes\TransFire.uc/57:     return TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransFire.uc/66:     ProjectileClass=class'XWeapons.TransBeacon'
Found 'TransBeacon' 14 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\XWeapons\Classes\TransLauncher.uc' :
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/10: var TransBeacon TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/29:         TransBeacon,RepAmmo;
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/58:   if( (TransBeacon != None) && TransBeacon.IsMonitoring(B.Focus) )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/112:   if( TransBeacon != None )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/115:    TransBeacon.bNoAI = True;
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/116:    TransBeacon.Destroy();
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/117:    TransBeacon = None;
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/136:     Transbeacon.SetLocation(TransBeacon.Location + Instigator.Anchor.Location + (Instigator.CollisionHeight - Instigator.Anchor.CollisionHeight) * vect(0,0,1)- Instigator.Location);
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/149:   TransBeacon.Velocity = Bot(Instigator.Controller).AdjustToss(TransBeacon.Speed, TransBeacon.Location, TTargetLoc,False);
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/150:   TransBeacon.SetTranslocationTarget(Bot(Instigator.Controller).RealTranslocationTarget);
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/171:   if( (TransBeacon != None) && TransBeacon.IsMonitoring(Transbeacon.TranslocationTarget) )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/173:    if( (GameObject(B.Focus) != None) && (B.Focus != Transbeacon.TranslocationTarget) )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/179:    if  ( (Transbeacon.TranslocationTarget == Instigator.Controller.MoveTarget)
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/180:      || (Transbeacon.TranslocationTarget == Instigator.Controller.RouteGoal)
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/181:      || (Transbeacon.TranslocationTarget == Instigator.Controller.RouteCache[0])
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/182:      || (Transbeacon.TranslocationTarget == Instigator.Controller.RouteCache[1])
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/183:      || (Transbeacon.TranslocationTarget == Instigator.Controller.RouteCache[2])
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/184:      || (Transbeacon.TranslocationTarget == Instigator.Controller.RouteCache[3]) )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/297:     if( (PlayerController(Instigator.Controller) != None) && (PlayerController(Instigator.Controller).ViewTarget == TransBeacon) )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/301:         if( TransBeacon != None )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/303:    Transbeacon.SetRotation(PlayerController(Instigator.Controller).Rotation);
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/304:    Transbeacon.SoundVolume = Transbeacon.default.SoundVolume;
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/311:     if( TransBeacon!=None )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/315:             PlayerController(Instigator.Controller).SetViewTarget(TransBeacon);
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/316:             PlayerController(Instigator.Controller).ClientSetViewTarget(TransBeacon);
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/317:             PlayerController(Instigator.Controller).SetRotation( TransBeacon.Rotation );
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/318:    Transbeacon.SoundVolume = ViewBeaconVolume;
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/325:  if( (TransBeacon == None) || (Instigator.Controller.IsA('PlayerController') && (PlayerController(Instigator.Controller).ViewTarget == TransBeacon)) )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/336:  if( (PlayerController(Instigator.Controller) != None) && (PlayerController(Instigator.Controller).ViewTarget == TransBeacon) )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/353:    dist = VSize(TransBeacon.Location - Instigator.Location);
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/373:   if( TransBeacon == None )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/407:     if( TransBeacon != None )
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/408:         TransBeacon.Destroy();
Found 'TransBeacon' 42 time(s).
----------------------------------------
Find 'TransBeacon' in 'D:\games\UT2004\XWeapons\Classes\TransRecall.uc' :
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/25:     if( !success && (Weapon.Role == ROLE_Authority) && (TransLauncher(Weapon).TransBeacon != None) )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/33: function bool AttemptTranslocation(vector dest, TransBeacon TransBeacon)
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/39:     if( !TranslocSucceeded(dest,TransBeacon) )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/48: function bool TranslocSucceeded(vector dest, TransBeacon TransBeacon)
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/54:     if( TransBeacon.Physics != PHYS_None )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/56:         newdest = TransBeacon.Location - Instigator.CollisionRadius * Normal(TransBeacon.Velocity);
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/60:     if( (dest != Transbeacon.Location) && Instigator.SetLocation(TransBeacon.Location) )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/81:     local TransBeacon TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/94:     TransBeacon = TransLauncher(Weapon).TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/97:     if( TransBeacon.Disrupted() )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/104:     dest = TransBeacon.Location;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/105:     if( TransBeacon.Physics == PHYS_None )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/109:     HitActor = Weapon.Trace(HitLocation,HitNormal,dest,TransBeacon.Location,True);
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/111:         dest = TransBeacon.Location;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/113:     TransBeacon.SetCollision(False, False, False);
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/152:     if( !bFailedTransloc && AttemptTranslocation(dest,TransBeacon) )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/192:     TransBeacon.Destroy();
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/193:     TransLauncher(Weapon).TransBeacon = None;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/199:     local TransBeacon TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/205:         TransBeacon = TransLauncher(Weapon).TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/206:         TransLauncher(Weapon).TransBeacon = None;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/208:         Instigator.GibbedBy(TransBeacon.Disruptor);
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/209:         TransBeacon.Destroy();
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/216:     if( TransLauncher(Weapon).TransBeacon != None )
Found 'TransBeacon' 32 time(s).
Search complete, found 'TransBeacon' 363 time(s). (15 files.)
*/

var() float                 Health;

var   bool                  bDetonating;

var   class<Emitter>        DeathEmitterClass;

var() Sound                 DeathSound;
var() float                 DeathSoundVolume;
var() float                 DeathSoundRadius;
var() ESoundSlot            DeathSoundSlot;


var() float                     DampenFactor;
var() float                     DampenFactorParallel;

var() class<Emitter>            BounceEmitterClass;

var() Sound                     BounceSound;
var() float                     BounceSoundVolume;
var() float                     BounceSoundVolumeCurve;
var() float                     BounceSoundRadius;
var() ESoundSlot                BounceSoundSlot;

var() float                     StuckThreshold;
var() float                     BounceFXThreshold;
var() float                     BounceThreshold;
var   vector                    BounceLoc;


// ============================================================================
//  Physics
// ============================================================================
simulated event HitWall( vector HitNormal, Actor Other )
{
    local vector VN;
    local float CurSpeed;
    local CTFBase B;

    //gLog( "HitWall" #Other #HitNormal #bBounce #VSize(Velocity) );

    bCanHitOwner = True;

    CurSpeed = VSize(Velocity);
    if( CurSpeed > BounceThreshold && VSize(BounceLoc-Location) > StuckThreshold )
    {
        // bounce effects
        if( Level.NetMode != NM_DedicatedServer )
        {
            if( BounceSound != None )
                PlaySound( BounceSound, BounceSoundSlot , BounceSoundVolume*(FMin(CurSpeed/Speed,1)**BounceSoundVolumeCurve), , BounceSoundRadius );

            if( CurSpeed > BounceFXThreshold && EffectIsRelevant( Location, False ) && BounceEmitterClass != None )
                Spawn( BounceEmitterClass,,, Location, rotator(HitNormal) );
        }

        // bounce
        VN = (Velocity dot HitNormal) * HitNormal;
        Velocity = -VN * DampenFactor + (Velocity - VN) * DampenFactorParallel;
        BounceLoc = Location;
    }
    else
    {
        foreach TouchingActors(class'CTFBase', B)
            break;

        if( B != None )
        {
            if( CurSpeed < 100 )
            {
                Velocity = 90 * Normal(Velocity);
            }
        }
        else
        {
            Stick( HitNormal, Other );
        }
    }
}


simulated function Stick( vector HitNormal, Actor Other )
{
    local vector X, Y, Z;

    //gLog( "Stick" #Other #HitNormal #VSize(Velocity) );

    // stick to ground

    bBounce = False;
    SetPhysics(PHYS_None);
    SetBase(Other);

    GetAxes(Rotation, X, Y, Z);

    if( HitNormal.Z > MINFLOORZ )
    {
        // Align to surface
        Z = HitNormal;
        Y = Z cross X;
        X = Y cross Z;
    }

    SetRotation(OrthoRotation(X, Y, Z));
}

simulated event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    if( Level.Game.bTeamGame && InstigatedBy != None && InstigatedBy.PlayerReplicationInfo != None
    && (Instigator == None || InstigatedBy.PlayerReplicationInfo.Team == Instigator.PlayerReplicationInfo.Team) )
        return;

    if( Damage > 0 )
    {
        Health -= Damage;
        if( Health < 0 )
            Detonate(None, Location, vector(Rotation));
    }
}

simulated function Detonate(Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "Detonate" #GON(Other) #bDeleteMe #bDetonating );
    if( Role == ROLE_Authority && !bDeleteMe && !bDetonating )
    {
        bDetonating = True;

        if( DeathEmitterClass != None )
            Spawn(DeathEmitterClass,,, Location, Rotation);

        if( DeathSound != None )
            PlaySound(DeathSound, DeathSoundSlot, DeathSoundVolume, False, DeathSoundRadius);

        MakeNoise(1.0);
        Destroy();
    }
}

simulated event Timer();

// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog( coerce string S ){
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
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    BounceEmitterClass          = None//class'gGrenadeHitWall'


    BounceSound                 = Sound'G_Sounds.cg_trans_impact_bump'
    BounceSoundVolume           = 1.0
    BounceSoundRadius           = 255
    BounceSoundSlot             = SLOT_None
    BounceSoundVolumeCurve      = 2.0

    DampenFactor                = 0.1
    DampenFactorParallel        = 0.3

    BounceFXThreshold           = 512
    StuckThreshold              = 1.0
    BounceThreshold             = 50

    StaticMesh                  = StaticMesh'G_Meshes.combo_trans1'
    DrawScale                   = 0.5
    PrePivot                    = (X=0.0,Y=0.0,Z=20.0)


    TransTrailClass             = None
    TransFlareClass             = None

    Health                      = 7

    DeathEmitterClass           = None//class'GEffects.gPlaceholderEmitter'

    DeathSound                  = Sound'G_Sounds.cg_trans_disc_death'
    DeathSoundVolume            = 1.0
    DeathSoundRadius            = 255
    DeathSoundSlot              = SLOT_Misc

    AmbientSound                = Sound'G_Sounds.cg_trans_disc_ambient'
    SoundRadius                 = 7
    SoundVolume                 = 250
    SoundPitch                  = 64
}