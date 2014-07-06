// ============================================================================
//  gWeaponAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWeaponAttachment extends xWeaponAttachment;

// - Constants ----------------------------------------------------------------

const GST_Vehicle = 11;
const GST_Player = 12;

// - Muzzle Flash -------------------------------------------------------------

var() class<Emitter>        FlashEffectClass;
var() name                  FlashBone;
var() rotator               FlashBoneRotator;
var   Emitter               FlashEffect;

var() class<Actor>          ShellActorClass;
var() class<Emitter>        ShellEffectClass;
var() name                  ShellBone;
var() rotator               ShellBoneRotator;
var() EDetailMode           ShellDetailMode;
var   Emitter               ShellEffect;

// - Effects ------------------------------------------------------------------

var() float                 WeaponLightDuration;
var() float                 WeaponLightInterval;
var() bool                  bWeaponLight;
var() bool                  bWaterSplash;

// - Rotary Weapon ------------------------------------------------------------

var() bool                  bRotary;
var() name                  SpinBone;
var() rotator               SpinBoneAxis;
var() class<gRotaryWeapon>  RotaryClass;
var() class<gSpinEffect>    SpinEffectClass;
var() gSpinEffect           SpinEffect;
var   bool                  bSpin;

// - Misc ---------------------------------------------------------------------

var() int                   IgnoredMode;

var   byte                  LocalCount;
var   byte                  LocalMode;

var   PlayerController      LocalPlayer;


// ============================================================================
//  Replication
// ============================================================================
replication
{
    // Variables that server should send to clients
    reliable if( bNetDirty && Role == ROLE_Authority )
        bSpin;
}


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    S.PrecacheObject(default.FlashEffectClass);
    S.PrecacheObject(default.ShellActorClass);
    S.PrecacheObject(default.ShellEffectClass);
}


// ============================================================================
//  Lifespan
// ============================================================================
simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( Level.Netmode == NM_DedicatedServer )
        return;

    LocalPlayer = Level.GetLocalPlayerController();

    if( FlashEffectClass != None )
        FlashEffect = Emitter(SpawnAttached(FlashEffectClass, FlashBone, FlashBoneRotator));

    if( ShellEffectClass != None )
        ShellEffect = Emitter(SpawnAttached(ShellEffectClass, ShellBone, ShellBoneRotator));
}

simulated event PostNetBeginPlay()
{
    if( Instigator != None && gPawn(Instigator) != None )
    {
        gPawn(Instigator).SetWeaponAttachment(self);
        if( bRotary && Level.NetMode != NM_DedicatedServer )
        {
            SpinEffect = gSpinEffect(class'gBasedActor'.static.GetBasedActor(Instigator, SpinEffectClass, True));
            SpinEffect.Initialize(self);
        }
    }
}

simulated event Destroyed()
{
    if( FlashEffect != None )
        FlashEffect.Destroy();

    if( ShellEffect != None )
        ShellEffect.Destroy();

    if( SpinEffect != None )
        SpinEffect.Destroy();

    Super.Destroyed();
}

// ============================================================================
//  Weapon Interface
// ============================================================================
final simulated function FlashCountIncrement(int Mode)
{
    //gLog("FlashCountIncrement" #Mode);

    if( Mode != IgnoredMode )
    {
        FlashCount = (++FlashCount & 0x7F) | (Mode << 7);
        ThirdPersonEffects();
        NetUpdateTime = Level.TimeSeconds - 1;
    }
}

final simulated function FlashCountZero(int Mode)
{
    if( Mode != IgnoredMode )
    {
        FlashCount = Mode << 7;
        ThirdPersonEffects();
        NetUpdateTime = Level.TimeSeconds - 1;
    }
}

// ============================================================================
//  Hit
// ============================================================================
simulated event ThirdPersonEffects()
{
    LocalCount = FlashCount & 0x7F;
    LocalMode = FlashCount >> 7;

    //gLog("TPE" #FlashCount #LocalCount #LocalMode);

    if( Level.NetMode == NM_DedicatedServer || LocalMode == IgnoredMode || gPawn(Instigator) == None )
        return;

    //gLog("TPE 2" #FlashCount #LocalCount #LocalMode);

    if( LocalCount == 0 )
    {
        gPawn(Instigator).StopFiring();
    }
    else
    {
        // Notify pawn
        if( LocalMode == 0 )
            gPawn(Instigator).StartFiring(bHeavy, bRapidFire);
        else
            gPawn(Instigator).StartFiring(bHeavy, bAltRapidFire);

        if( Level.TimeSeconds - LastRenderTime > 0.2 && Instigator.Controller != LocalPlayer )
            return;

        if( !Instigator.IsFirstPerson() )
            ShowMuzzleFlash();

        // Light
        if( bWeaponLight )
            WeaponLight();
    }
}

simulated function ShowMuzzleFlash()
{
    // Muzzle Flash
    if( FlashEffect != None )
        FlashEffect.Trigger(Self, Instigator);

    if( Level.DetailMode >= ShellDetailMode )
    {
        // Shell spawner
        if( ShellActorClass != None )
            Spawn(ShellActorClass, Instigator,, GetBoneCoords(ShellBone).Origin, GetBoneRotation(ShellBone,0));

        // Shell spawner
        if( ShellEffect != None )
            ShellEffect.Trigger(Self, Instigator);
    }
}

simulated function vector GetTipLocation()
{
    if( Instigator != None )
    {
        if( Instigator.IsFirstPerson() )
        {
            if( Instigator.Weapon != None )
                return Instigator.Weapon.GetEffectStart();
        }
        else
        {
            if( Mesh != None && FlashBone != '' )
                return GetBoneCoords(FlashBone).Origin;
        }
    }

    // Fallback
    if( FlashEffect != None )
    {
        //gLog( "tipB1" );
        return FlashEffect.Location;
    }

    //gLog( "tipB2" );
    return Location;
}

function SetHitData(Actor HitActor, vector HitLocation, vector HitNormal, optional Material HitMaterial);

function UpdateHit(Actor HitActor, vector HitLocation, vector HitNormal)
{
    Warn("Deprecated");
}


// ============================================================================
//  Effects
// ============================================================================

simulated function WeaponLight()
{
    if( LocalCount > 0 && !Level.bDropDetail
    && (Level.TimeSeconds - LastRenderTime < WeaponLightInterval || PlayerController(Instigator.Controller) != None) )
    {
        if( Instigator.IsFirstPerson() )
        {
            LitWeapon = Instigator.Weapon;
            LitWeapon.bDynamicLight = True;
        }
        else
        {
            bDynamicLight = True;
        }

        GotoState('LightsOn','Begin');
    }
    else
    {
        GotoState('');
    }
}

simulated state LightsOn
{
    simulated event EndState()
    {
        if( LitWeapon != None )
        {
            LitWeapon.bDynamicLight = False;
            LitWeapon = None;
        }

        bDynamicLight = False;
    }

Begin:
    Sleep(WeaponLightDuration);
    GotoState('');
}

simulated function CheckForSplash();



// ============================================================================
//  Ambient Effects
// ============================================================================

simulated function SetOverlayMaterial( Material mat, float time, bool bOverride )
{
    //gLog( "SetOverlayMaterial" #mat #time #bOverride );

    // UDamage overlay cannot be overriden with another one
    if( mat != None && OverlayMaterial != None && mat != OverlayMaterial && OverlayMaterial == class'gPawn'.default.UDamageWeaponMaterial )
        return;

    // UDamage always overrides
    if( mat == class'gPawn'.default.UDamageWeaponMaterial )
        bOverride = True;

    Super.SetOverlayMaterial(mat,time,bOverride);
}


// ============================================================================
//  Misc
// ============================================================================

simulated function Actor SpawnAttached(class<Actor> C, name Bone, rotator BoneRot)
{
    local Actor A;

    if( C != None )
    {
        A = Spawn(C, Self);
        if( A != None && Bone != '' )
        {
            AttachToBone(A, Bone);
            if( BoneRot != rot(0, 0, 0) )
                SetBoneRotation(Bone, BoneRot, 0, 1);
        }
    }

    return A;
}


// ============================================================================
//  Debug
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
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    SplashEffect                = class'BulletSplash'
    ShellDetailMode             = DM_High

    bWeaponLight                = True
    WeaponLightDuration         = 0.1
    WeaponLightInterval         = 0.15

    RelativeLocation            = (X=0,Y=0,Z=0)
    RelativeRotation            = (Pitch=0,Yaw=0,Roll=32768)

    IgnoredMode                 = -1

    SpinBone                    = ""
    SpinBoneAxis                = (Pitch=0,Yaw=0,Roll=1)
    RotaryClass                 = class'gRotaryWeapon'
    SpinEffectClass             = class'gSpinEffect'

    DrawType                    = DT_Mesh
    DrawScale                   = 0.5

    AmbientGlow                 = 0
    bUnlit                      = False
    bUseDynamicLights           = True
    bUseLightingFromBase        = False
    bShadowCast                 = True
    bStaticLighting             = True
}
