// ============================================================================
//  gWeaponFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWeaponFire extends WeaponFire;

// - Effects ------------------------------------------------------------------

var() class<Emitter>    SmokeEffectClass;
var() rotator           SmokeBoneRotator;
var() name              SmokeBone;

var() class<Emitter>    FlashEffectClass;
var() rotator           FlashBoneRotator;
var() name              FlashBone;

var() class<Actor>      ShellActorClass;
var() class<Emitter>    ShellEffectClass;
var() rotator           ShellBoneRotator;
var() name              ShellBone;
var() EDetailMode       ShellDetailMode;

var   Emitter           SmokeEffect;
var   Emitter           FlashEffect;
var   Emitter           ShellEffect;

// - Anims --------------------------------------------------------------------

var() bool              bIsAltFire;  // When True calls attachment animations for alt fire
var() bool              bAttachmentAnim;

// - Weapon Accuracy -----------------------------------------------------------

var() bool              bAccuracyBase;          // Enable base accuracy
var() bool              bAccuracyRecoil;        // Enable recoil accuracy
var() bool              bAccuracyStance;        // Enable stance accuracy
var() bool              bAccuracyCentered;      // Distribution centered instead of random
var() bool              bAccuracyCrosshair;     //

var() float             AccuracyBase;           // Base weapon inaccuracy
var() float             AccuracyMultStance;     // How big effect player stance has on accuracy
var() float             AccuracyMultRecoil;     // How big effect recoil has on accuracy
var() float             AccuracyRecoilShots;    // Recoil will be at 100% after this many successive shots
var() float             AccuracyRecoilRegen;    // How fast recoil fades out from 100%, in seconds

var() float             AccuracyApproxRecoil;
var() float             AccuracyApproxStance;
var() float             AccuracyApproxBase;


var   float             AccuracyRecoilDelta;    //
var   float             AccuracyRecoil;         //

var() vector            StartOffset; // +x forward, +y right, +z up


var()   Actor.ESoundSlot    FireSoundSlot;
var()   float               FireSoundVolume;
var()   float               FireSoundRadius;


var()   Sound               PreFireSound;
var()   float               PreFireSoundVolume;
var()   float               PreFireSoundRadius;
var()   Actor.ESoundSlot    PreFireSoundSlot;


var()   Sound               FireLoopSound;
var()   float               FireLoopSoundVolume;
var()   float               FireLoopSoundRadius;
var()   Actor.ESoundSlot    FireLoopSoundSlot;


var()   Sound               FireEndSound;
var()   float               FireEndSoundVolume;
var()   float               FireEndSoundRadius;
var()   Actor.ESoundSlot    FireEndSoundSlot;

var() float ClickTime;

var()   float               NoAmmoSoundVolume;
var()   float               NoAmmoSoundRadius;
var()   Actor.ESoundSlot    NoAmmoSoundSlot;

var()   Sound               ReloadFailSound;
var()   float               ReloadSoundVolume;
var()   float               ReloadSoundRadius;
var()   Actor.ESoundSlot    ReloadSoundSlot;

var     byte                PredIterations;
var     vector              PredLastPos;
var     vector              PredLastVel;
var     float               PredThreshold;
var     float               PredDot;

var()   float               AimSpreadZ;

// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    S.PrecacheObject(default.SmokeEffectClass);
    S.PrecacheObject(default.FlashEffectClass);
    S.PrecacheObject(default.ShellActorClass);
    S.PrecacheObject(default.ShellEffectClass);

    S.PrecacheObject(default.PreFireSound);
    S.PrecacheObject(default.FireLoopSound);
    S.PrecacheObject(default.FireEndSound);
    S.PrecacheObject(default.ReloadFailSound);
}

// ============================================================================
// Lifespan
// ============================================================================
event ModeTick(float DT)
{
    local float Alpha;

    if( bAccuracyRecoil )
    {
        if( Instigator.Controller != None )
        {
            //VarWatch( "Accuracy Recoil", AccuracyRecoil, True );
        }

        // Regen recoil inaccuracy
        DT = Level.TimeSeconds - AccuracyRecoilDelta;
        AccuracyRecoilDelta += DT;
        AccuracyRecoil = FMax( 0, AccuracyRecoil - (DT/AccuracyRecoilRegen) );
    }

    // Update crosshair scale
    if( gWeapon(Weapon) != None )
    {
        if( class'gWeapon'.default.bAccurateCrosshair )
        {
            // Weapon accuracy cone
            if( bAccuracyBase )
                Alpha += 1;

            if( bAccuracyRecoil )
                Alpha += AccuracyRecoil * AccuracyMultRecoil;

            if( bAccuracyStance && gPawn(Instigator) != None )
                Alpha += gPawn(Instigator).InaccuracyXhairStance * AccuracyMultStance;

            gWeapon(Weapon).InaccuracyLevel[ThisModeNum] = Alpha * AccuracyBase;
        }
        else
        {
            if( bAccuracyRecoil )
                Alpha = AccuracyRecoil * AccuracyApproxRecoil;

            if( bAccuracyStance && gPawn(Instigator) != None )
                Alpha += gPawn(Instigator).InaccuracyXhairStance * AccuracyApproxStance;

            gWeapon(Weapon).InaccuracyLevel[ThisModeNum] = Alpha * AccuracyApproxBase;
        }
    }
}

// ============================================================================
// Firing
// ============================================================================
simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
    if( Weapon.WeaponCentered() )
        return Instigator.Location + Instigator.EyePosition() + X*StartOffset.X + Z*StartOffset.Z;
    else
        return Instigator.Location + Instigator.EyePosition() + X*StartOffset.X + Y*StartOffset.Y*Weapon.Hand + Z*StartOffset.Z;
}

// ============================================================================
// Effects
// ============================================================================
simulated function DestroyEffects()
{
    if( SmokeEffect != None )
        SmokeEffect.Destroy();

    if( FlashEffect != None )
        FlashEffect.Destroy();

    if( ShellEffect != None )
        ShellEffect.Destroy();
}

simulated function InitEffects()
{
    // don't even spawn on server
    if( Level.NetMode == NM_DedicatedServer || gPlayer(Instigator.Controller) == None )
        return;

    if( SmokeEffectClass != None && (SmokeEffect == None || SmokeEffect.bDeleteMe) )
    {
        SmokeEffect = Spawn(SmokeEffectClass);
        if( SmokeEffect != None && SmokeBone != '' )
        {
            Weapon.AttachToBone(SmokeEffect, SmokeBone);
            if( SmokeBoneRotator != rot(0,0,0) )
                Weapon.SetBoneRotation( SmokeBone, SmokeBoneRotator, 0, 1 );
        }
    }

    if( FlashEffectClass != None && (FlashEffect == None || FlashEffect.bDeleteMe) )
    {
        FlashEffect = Spawn(FlashEffectClass);
        if( FlashEffect != None && FlashBone != '' )
        {
            Weapon.AttachToBone(FlashEffect, FlashBone);
            if( FlashBoneRotator != rot(0,0,0) )
                Weapon.SetBoneRotation( FlashBone, FlashBoneRotator, 0, 1 );
        }
    }

    if( ShellEffectClass != None && (ShellEffect == None || ShellEffect.bDeleteMe) )
    {
        ShellEffect = Spawn(ShellEffectClass);
        if( ShellEffect != None && ShellBone != '' )
        {
            if( ShellBoneRotator != rot(0,0,0) )
                Weapon.SetBoneRotation( ShellBone, ShellBoneRotator, 0, 1 );
        }
    }
}

function DrawMuzzleFlash(Canvas C)
{
    // Draw smoke first
    if( SmokeEffect != None && SmokeEffect.Base != Weapon )
    {
        SmokeEffect.SetLocation( Weapon.GetEffectStart() );
        C.DrawActor( SmokeEffect, False, False, Weapon.DisplayFOV );
    }

    if( FlashEffect != None && FlashEffect.Base != Weapon )
    {
        FlashEffect.SetLocation( Weapon.GetEffectStart() );
        C.DrawActor( FlashEffect, False, False, Weapon.DisplayFOV );
    }
}

function FlashMuzzleFlash()
{
    if( Instigator == None || !Instigator.IsFirstPerson() )
        return;

    if( FlashEffect != None )
        FlashEffect.Trigger(Weapon, Instigator);

    if( ShellActorClass != None && Level.DetailMode >= ShellDetailMode )
    {
        Spawn(ShellActorClass,Instigator,,Weapon.GetBoneCoords(ShellBone).Origin,Weapon.GetBoneRotation(ShellBone,0));
    }

    if( ShellEffect != None && Level.DetailMode >= ShellDetailMode )
    {
        ShellEffect.SetLocation( Weapon.GetBoneCoords(ShellBone).Origin );
        ShellEffect.SetRotation( Weapon.GetBoneRotation(ShellBone,0) );
        ShellEffect.Trigger(Weapon, Instigator);
    }
}

function StartMuzzleSmoke()
{
    if( SmokeEffect != None && !Level.bDropDetail )
        SmokeEffect.Trigger(Weapon, Instigator);
}

// ============================================================================
// Anim
// ============================================================================
function PlayPreFire()
{
    if( Weapon.Mesh != None && Weapon.HasAnim(PreFireAnim) )
        Weapon.PlayAnim(PreFireAnim, PreFireAnimRate, TweenTime);

    if( PreFireSound != None )
        Weapon.PlayOwnedSound(PreFireSound, PreFireSoundSlot, PreFireSoundVolume,, PreFireSoundRadius);
}

function PlayFiring()
{
    if( Weapon.Mesh != None )
    {
        if( FireCount > 0 )
        {
            if( Weapon.HasAnim(FireLoopAnim) )
            {
                Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);

                if( FireLoopSound != None )
                    Weapon.PlayOwnedSound(FireLoopSound, FireLoopSoundSlot, FireLoopSoundVolume,, FireLoopSoundRadius);
            }
            else if( Weapon.HasAnim(FireAnim) )
            {
                Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
            }
        }
        else if( Weapon.HasAnim(FireAnim) )
        {
            Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
        }
    }

    Weapon.PlayOwnedSound(FireSound, FireSoundSlot, FireSoundVolume,, FireSoundRadius);
    ClientPlayForceFeedback(FireForce);  // jdf

    FireCount++;
}

function PlayFireEnd()
{
    if( Weapon.Mesh != None && Weapon.HasAnim(FireEndAnim) )
        Weapon.PlayAnim(FireEndAnim, FireEndAnimRate, TweenTime);

    if( FireEndSound != None )
        Weapon.PlayOwnedSound(FireEndSound, FireEndSoundSlot, FireEndSoundVolume,, FireEndSoundRadius);
}

function bool PlayReload()
{   
    if( !Weapon.HasAmmo() )
        return false;

    if( Weapon.Mesh != None && Weapon.HasAnim(ReloadAnim) )
        Weapon.PlayAnim(ReloadAnim, ReloadAnimRate, TweenTime);
    else
        return false;
        
    if( ReloadSound != None )
        Weapon.PlayOwnedSound(ReloadSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);
    
    return true;
}

function ServerPlayFiring()
{
    Weapon.PlayOwnedSound(FireSound, FireSoundSlot, FireSoundVolume,, FireSoundRadius);
}

function ShakeView()
{
    Super.ShakeView();

    if( Weapon.Role < ROLE_Authority )
    {
        // Add recoil
        if( bAccuracyRecoil )
            AccuracyRecoil = FMin(1, AccuracyRecoil + (1/AccuracyRecoilShots) ) + (default.FireRate / AccuracyRecoilRegen);
    }
}

// ============================================================================
// Trajectory
// ============================================================================
simulated function bool IsInTossRange(Actor Target)
{
    local vector X,Y,Z,Start,Dest,Delta,Delta2D,Pred;
    local float G,Dist,Dist2D,DistZ;
    local float AL,AH,AA,FT,V;

    //stopwatch(False);

    if( Target == None )
        return False;

    // Cache constants
    V = ProjectileClass.default.Speed;

    G = -Target.PhysicsVolume.Gravity.Z*0.5;
    if( class<gProjectile>(ProjectileClass) != None )
    {
        G += G * class<gProjectile>(ProjectileClass).default.ExtraGravity;
    }

    // Rotation Axes
    if( Instigator.Controller != None )
            GetAxes( Instigator.Controller.Rotation, X,Y,Z );
    else    GetAxes( Instigator.Rotation, X,Y,Z );

    // Projectile Start
    Start = GetFireStart(X,Y,Z);

    // Projectile Destination
    Dest = AdjustTossDest(Target);

    // This increases range but needs special case code for flat objects on floor
    //Dest -= Normal(Dest-Start) *
    //(  FMin(Target.CollisionHeight,Target.CollisionRadius)
    //+  FMin(ProjectileClass.default.CollisionHeight,ProjectileClass.default.CollisionRadius) );


    // Cache vars
    Delta = Dest-Start+Pred;
    Delta2D = Delta*vect(1,1,0);
    Dist = VSize(Delta);
    Dist2D = VSize(Delta2D);
    DistZ = Delta.Z;

    // Aiming sngles
    // Prefer low trajectory
    AL = atan( ((V*V) - Sqrt((V*V*V*V) - (G * ((G*Dist2D*Dist2D) + (float(2)*DistZ*V*V))))) / (G*Dist2D), 1 );
    AH = atan( ((V*V) + Sqrt((V*V*V*V) - (G * ((G*Dist2D*Dist2D) + (float(2)*DistZ*V*V))))) / (G*Dist2D), 1 );
    AA = FMin(AL,AH);

/*  OPTIMIZED UNTESTED
    AA = atan( V / (sqrt((V*V) + float(2)*G*DistZ)), 1 );
    return AA == AA;
*/

    // Log params
/*    gLog("IsInTossRange"
    @"A="$Target.name
    @"AL="$AL
    @"AH="$AH
    @"AA="$AA
    );*/

    // NaN Check
    if( AA != AA )
        return False;

    // Flight Time
    FT = Dist2D / (V * cos(AA));
    if( FT != FT )
        return False;

    // Basic prediction
    Pred = Target.Velocity * FT;
    if( Pred != vect(0,0,0) )
    {
        // Cache vars
        Delta = Dest-Start+Pred;
        Delta2D = Delta*vect(1,1,0);
        Dist = VSize(Delta);
        Dist2D = VSize(Delta2D);
        DistZ = Delta.Z;

        // Aiming sngles, Prefer low trajectory
        AL = atan( ((V*V) - Sqrt((V*V*V*V) - (G * ((G*Dist2D*Dist2D) + (float(2)*DistZ*V*V))))) / (G*Dist2D), 1 );
        AH = atan( ((V*V) + Sqrt((V*V*V*V) - (G * ((G*Dist2D*Dist2D) + (float(2)*DistZ*V*V))))) / (G*Dist2D), 1 );
        AA = FMin(AL,AH);

        // NaN Check
        if( AA != AA )
            return False;

        // Flight Time
        FT = Dist2D / (V * cos(AA));
        if( FT != FT )
            return False;
    }

    //stopwatch(True);
    return True;
}

simulated function vector CalcTossAngle(Actor Target, optional bool bPredict)
{
    local vector X,Y,Z,Start,Dest,Delta,Delta2D,Aim,Pred,PredDiff,BestAim;
    local float G,Dist,Dist2D,DistZ,PDot,PXDot,AL,AH,AA,FT,V;
    local int PredCount;
    //local int i;
    //local float PXY,PZ,PT,FA;
    //local vector VA,VB;

    //stopwatch(False);

    // Rotation Axes
    if( Instigator.Controller != None )
            GetAxes( Instigator.Controller.Rotation, X,Y,Z );
    else    GetAxes( Instigator.Rotation, X,Y,Z );

    BestAim = X;

    if( Target == None )
        return BestAim;

    // Projectile Start
    Start = GetFireStart(X,Y,Z);

    // Projectile Destination
    Dest = AdjustTossDest(Target);

    // This increases range but needs special case code for flat objects on floor
    //Dest -= Normal(Dest-Start) *
    //(  FMin(Target.CollisionHeight,Target.CollisionRadius)
    //+  FMin(ProjectileClass.default.CollisionHeight,ProjectileClass.default.CollisionRadius) );

    // Cache constants
    V = ProjectileClass.default.Speed;

    G = -Target.PhysicsVolume.Gravity.Z*0.5;
    if( class<gProjectile>(ProjectileClass) != None )
    {
        G += G * class<gProjectile>(ProjectileClass).default.ExtraGravity;
    }

    PredDiff = PredLastPos - Dest;
    PDot = Normal(Target.Velocity) dot Normal(PredLastVel);
    PXDot = Normal(Target.Velocity) dot vect(0,0,1);

    while( True )
    {
        // Cache vars
        Delta = Dest-Start+Pred;
        Delta2D = Delta*vect(1,1,0);
        Dist = VSize(Delta);
        Dist2D = VSize(Delta2D);
        DistZ = Delta.Z;

        // Aiming Angle
        // Prefer low trajectory
        //AL = atan((PS - Sqrt(PS*PS - float(2)*G*(DistZ + 0.5*G*((Dist2D*Dist2D)/(PS*PS))))) / (G*Dist2D/PS),1);
        //AH = atan((PS + Sqrt(PS*PS - float(2)*G*(DistZ + 0.5*G*((Dist2D*Dist2D)/(PS*PS))))) / (G*Dist2D/PS),1);
        AL = atan( ((V*V) - Sqrt((V*V*V*V) - (G * ((G*Dist2D*Dist2D) + (float(2)*DistZ*V*V))))) / (G*Dist2D), 1 );
        AH = atan( ((V*V) + Sqrt((V*V*V*V) - (G * ((G*Dist2D*Dist2D) + (float(2)*DistZ*V*V))))) / (G*Dist2D), 1 );

        AA = FMin(AL,AH);
        if( AA != AA )
        {
            //gLog( "CalcTossAngle AA NaN" #Target #AL #AH );
            return BestAim;
        }

        // Flight Time
        FT = Dist2D / (V * cos(AA));
        if( FT != FT )
        {
            //gLog( "CalcTossAngle FT NaN" #Target #AA #V );
            return BestAim;
        }

        // Aim vector
        Aim = Normal(Delta2D)*cos(AA) + vect(0,0,1)*sin(AA);
        BestAim = Aim;

        // Log params
      /*gLog("CalcTossAngle"
      @"C="$PredCount
      @"A="$Target.name
      @"AL="$AL
      @"AH="$AH
      @"AA="$AA
      @"FT="$FT*1000
      @"D="$VSize(Pred)
      @"V="$VSize(Target.Velocity)
      @"A="$VSize(Target.Acceleration)
      @"PD="$PDot
      @"PXDot="$PXDot
      );*/

        if( bPredict )
        {
            if( PredCount++ >= PredIterations )
                break;

            if( Target.Physics == PHYS_Falling )
            {
                // bunnyhopping
                Pred = Target.Velocity * FT * vect(1,1,0.1);
            }
            else
            {
                Pred = Target.Velocity * FT;
            }

            // strafing in place
            if( VSize(PredDiff) < Target.CollisionRadius*PredThreshold
            && PDot < PredDot )
            {
                Pred *= -0.15+FRand()*0.3;
                PredCount = PredIterations;
            }

            // todo:: use relative rotation dot instead of absolute location ?
        }
        else
        {
            break;
        }
    }

    // Trajectory graph
    // You may want to disable prediction & spread before validating
    /*AimError = 0;
    Weapon.ClearStayingDebugLines();
    Weapon.DrawStayingDebugLine(Start,Start+Aim*VSize(Start-Dest),0,128,255);
    Weapon.DrawStayingDebugLine(Start,Dest,128,0,255);
    PXY = V * cos(AA);
    PZ = V * sin(AA);
    VB = Normal(Delta2D)*(PXY*PT) + vect(0,0,1)*(PZ*PT-0.5*G*PT*PT);
    for( i=0; i!=int(FT*100); ++i )
    {
        FA = (i/(FT*100))*255;
        PT = i*0.01;
        VA = VB;
        VB = Normal(Delta2D)*(PXY*PT) + vect(0,0,1)*(PZ*PT-0.5*G*PT*PT);
        Weapon.DrawStayingDebugLine(Start+VA,Start+VB,255-byte(FA),byte(FA),0);
        //log( pt @Start+VA @Start+VB @(PXY*PT) @( PZ*PT + 0.5*G*PT*PT )  );
    }*/

    PredLastPos = Dest;
    PredLastVel = Target.Velocity;
    //stopwatch(True);
    return BestAim;
}

simulated function vector AdjustTossDest(Actor Target)
{
    if( gPawn(Target) != None )
    {
        // aim splash damage weapons at feet
        if( bSplashDamage && Target.Base != None && Target.Location.Z < Instigator.Location.Z )
        {
            return Target.Location - vect(0,0,0.8)*Target.CollisionHeight;
        }
    }

    return Target.Location;
}

function rotator AdjustTossAim(vector Start, float InAimError, Bot B)
{
    local vector FireDir;
    local rotator FireRot;
    local float FireSpread,FireDist;

    //gLog( "AdjustBotAim" @Projectileclass.Name );

    if( !SavedFireProperties.bInitialized )
    {
        SavedFireProperties.AmmoClass = AmmoClass;
        SavedFireProperties.ProjectileClass = ProjectileClass;
        SavedFireProperties.WarnTargetPct = WarnTargetPct;
        SavedFireProperties.MaxRange = MaxRange();
        SavedFireProperties.bTossed = bTossed;
        SavedFireProperties.bTrySplash = bRecommendSplashDamage;
        SavedFireProperties.bLeadTarget = bLeadTarget;
        SavedFireProperties.bInstantHit = bInstantHit;
        SavedFireProperties.bInitialized = True;
    }

    // make sure bot has a valid target
    if( B.Target == None || B.Target == B.Pawn )
    {
        B.Target = B.Enemy;
        if( B.Target == None )
        {
            //Log( "AdjustBotAim NO TARGET" );
            return B.Rotation;
        }
    }

    if( Pawn(B.Target) != None )
        B.Target = Pawn(B.Target).GetAimTarget();

    // perfect aim at stationary objects
    if( Pawn(B.Target) == None )
    {
        FireRot = rotator(CalcTossAngle(B.Target,True));
        B.SetRotation(FireRot);
        //Log( "AdjustBotAim STATIONARY" );
        return FireRot;
    }

    // Aim
    FireDist = VSize(B.Target.Location - B.Pawn.Location);
    FireSpread = B.AdjustAimError
    (   AimError
    ,   FireDist
    ,   B.Target == B.Enemy && B.DefendMelee(FireDist)
    ,   SavedFireProperties.bInstantHit
    ,   SavedFireProperties.bLeadTarget && B.bLeadTarget
    );
    FireDir = CalcTossAngle(B.Target,True);
    FireRot = rotator(FireDir);
    FireRot.Yaw += FireSpread;
    FireRot.Pitch += FireSpread*AimSpreadZ;

    B.InstantWarnTarget(B.Target,SavedFireProperties,FireDir);
    B.ShotTarget = Pawn(B.Target);
    B.SetRotation(FireRot);

    return FireRot;
}

// ============================================================================
// Debug
// ============================================================================


// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog ( coerce string S ){
    class'GDebug.gDbg'.static.oLog( self, GetDebugLevelRef(), S, gDebugString() );}

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
    class'GDebug.gDbg'.static.DrawAxesRot( GetDebugLevelRef(), Loc, Rot, Length, bStaying );}

simulated final function DrawAxesCoords( Coords C, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesCoords( GetDebugLevelRef(), C, Length, bStaying );}

simulated final function DrawAxesXYZ( vector Loc, vector X, vector Y, vector Z, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesXYZ( GetDebugLevelRef(), Loc, X, Y, Z, Length, bStaying );}

simulated final static function VarWatch( coerce string Desc, coerce string Value, optional bool bGraph ){
    class'GDebug.gDbg'.static.VarWatch( Desc, Value, bGraph );}

// ============================================================================
//  Debug Misc
// ============================================================================
simulated final function LevelInfo GetDebugLevelRef(){
    return Level;}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // gWeaponFire
    ShellDetailMode             = DM_High

    AimSpreadZ                  = 0.0

    AccuracyBase                = 0.1
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 0.25
    AccuracyRecoilShots         = 4

    AccuracyApproxRecoil        = 1.0
    AccuracyApproxStance        = 2.0
    AccuracyApproxBase          = 0.05

    bAccuracyBase               = True
    bAccuracyRecoil             = True
    bAccuracyStance             = True
    bAccuracyCentered           = True

    FireSoundVolume             = 1.0
    FireSoundRadius             = 256
    FireSoundSlot               = SLOT_Interact //SLOT_None

    PreFireSound                = None
    PreFireSoundVolume          = 1.0
    PreFireSoundRadius          = 256
    PreFireSoundSlot            = SLOT_None

    FireLoopSound               = None
    FireLoopSoundVolume         = 1.0
    FireLoopSoundRadius         = 256
    FireLoopSoundSlot           = SLOT_None

    FireEndSound                = None
    FireEndSoundVolume          = 1.0
    FireEndSoundRadius          = 256
    FireEndSoundSlot            = SLOT_None

    ReloadFailSound             = None
    ReloadSoundVolume           = 1.0
    ReloadSoundRadius           = 256
    ReloadSoundSlot             = SLOT_None

    NoAmmoSoundVolume           = 1.0
    NoAmmoSoundRadius           = 256
    NoAmmoSoundSlot             = SLOT_None

    PredIterations              = 1
    PredThreshold               = 4
    PredDot                     = 0.0

    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = False
    bInstantHit                 = True

    bPawnRapidFireAnim          = False
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = False
    bModeExclusive              = True

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = "PreFire"
    FireAnim                    = "Fire"
    FireLoopAnim                = "FireLoop"
    FireEndAnim                 = "FireEnd"
    ReloadAnim                  = "Reload"

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.3

    FireSound                   = None
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireForce                   = "NewSniperShot"
    ReloadForce                 = "BReload9"
    NoAmmoForce                 = ""

    FireRate                    = 0.5
    DamageAtten                 = 1.0

    AmmoClass                   = None
    AmmoPerFire                 = 0

    ShakeOffsetMag              = (X=0.0,Y=0.0,Z=0.0)
    ShakeOffsetRate             = (X=0.0,Y=0.0,Z=0.0)
    ShakeOffsetTime             = 0
    ShakeRotMag                 = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotRate                = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotTime                = 0

    ProjectileClass             = None

    BotRefireRate               = 0.95
    WarnTargetPct               = 0.0

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    AimError                    = 600
    SpreadStyle                 = SS_None
    Spread                      = 0.0

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512

    ClickTime                   = 0.33
}