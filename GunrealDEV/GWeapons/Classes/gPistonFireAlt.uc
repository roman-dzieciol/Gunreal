// ============================================================================
//  gPistonFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistonFireAlt extends gNoFire;

var() class<DamageType> DamageType;
var() int               Damage;
var() int               DamageVehicle;
var() float             Range;
var() float             AmmoRegen;


var() class<Emitter>    HealHitClass;
var() class<Emitter>    HealFlashClass;


// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.DamageType);
}

simulated event PostBeginPlay()
{
    if( Weapon.Role == ROLE_Authority )
    {
        SetTimer(1, True);
    }

    Super.PostBeginPlay();
}

event Timer()
{
    if( !bIsFiring )
    {
        if( !Weapon.AmmoMaxed(ThisModeNum) )
            Weapon.AddAmmo(AmmoRegen, ThisModeNum);
    }
}

function DoFireEffect()
{
    local vector X,Y,Z, StartTrace;
    local rotator AimRot;

    Instigator.MakeNoise(1.0);

    Weapon.GetViewAxes(X,Y,Z);
    StartTrace = GetFireStart(X,Y,Z);
    AimRot = AdjustAim(StartTrace, AimError);

    DoTrace(StartTrace, AimRot);
}

function DoTrace(vector Start, rotator Dir)
{
    local vector X, End, HitLocation, HitNormal;
    local Actor Other;
    local Material HitMaterial;
    local float Dmg, DmgMult;

    X = vector(Dir);
    End = Start + Range * X;
    Other = Weapon.Trace(HitLocation, HitNormal, End, Start, True,,HitMaterial);

    if( Other != None && Other != Instigator )
    {
        if( !Other.bWorldGeometry )
        {
            if( Vehicle(Other) != None )
            {
                Dmg = DamageVehicle;
                DmgMult = (1.0 / Vehicle(Other).LinkHealMult);
            }
            else
            {
                Dmg = Damage;
                DmgMult = 1.0;
            }

            Dmg = FMin(Dmg, Weapon.AmmoAmount(ThisModeNum));
            if( Dmg > 0 && Weapon.ConsumeAmmo(ThisModeNum, Dmg )
                && Other.HealDamage(Dmg * DmgMult, Instigator.Controller, DamageType))
            {
                // success
                if( HealHitClass != None )
                    Spawn(HealHitClass,,, HitLocation, rotator(HitNormal));
            }
            else
            {
                // failure
            }
        }
    }
    else
    {
        HitLocation = End;
        HitNormal = Normal(End - Start);
    }
}

function FlashMuzzleFlash()
{
    if( Instigator == None || !Instigator.IsFirstPerson() )
        return;

    if( HealFlashClass != None && FlashBone != '' )
    {
        if( FlashBoneRotator != rot(0,0,0) )
            Weapon.SetBoneRotation( FlashBone, FlashBoneRotator, 0, 1 );

        FlashEffect = Spawn(HealFlashClass, Instigator,, Weapon.GetBoneCoords(FlashBone).Origin, Weapon.GetBoneRotation(FlashBone));
        if( FlashEffect != None )
            Weapon.AttachToBone(FlashEffect, FlashBone);
    }
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    HealHitClass                = class'GEffects.gPistonHealHit'
    HealFlashClass              = class'GEffects.gPistonHealFlash'
    FlashBone                   = "Muzzle"
    FlashBoneRotator            = (Pitch=0,Yaw=0,Roll=0)

    Damage                      = 25
    DamageVehicle               = 50
    Range                       = 256
    DamageType                  = class'gDamTypePistonHeal'
    AmmoRegen                   = 5


    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = False
    bInstantHit                 = True

    bPawnRapidFireAnim          = True
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = False
    bModeExclusive              = True

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = ""
    FireAnim                    = "trans-fire"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = None
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireRate                    = 1.0
    ProjectileClass             = None

    AmmoClass                   = class'gPistonAmmo'
    AmmoPerFire                 = 0

    ShakeOffsetMag              = (X=-20.0,Y=0.00,Z=0.00)
    ShakeOffsetRate             = (X=-1000.0,Y=0.0,Z=0.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotRate                = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotTime                = 2

    BotRefireRate               = 1.0

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}