// ============================================================================
//  gShotgunFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotgunFire extends gInstantFire;

var() Sound     DualFireSound;
var() String    DualFireForce;
var() name      DualFireAnim;
var() float     DualFireAnimRate;
var() class<DamageType> DualDamageType;

var() byte      SingleCount;
var() byte      DoubleCount;

var() float ExtraDamage;
var() float ExtraDamageDist;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.DualFireSound);

    S.PrecacheObject(default.DualDamageType);
}

simulated function bool AllowFire()
{
    if( Weapon.GetFireMode(0).Load == 1 || Weapon.GetFireMode(0).Load == 2 )
        return( Weapon.AmmoCharge[0] >= Weapon.GetFireMode(0).Load );
    else
        return False;
}

simulated event PostBeginPlay()
{
    if( Weapon.HasAmmo() )
    {
        AmmoPerFire = 1;
        Load = 1;
    }

    Super.PostBeginPlay();
}

simulated function string gDebugString()
{
    return Weapon.GetFireMode(0).Load
    @Weapon.GetFireMode(0).AmmoPerFire
    @Weapon.AmmoCharge[0];
}

event ModeDoFire()
{
    //gLog( "ModeDoFire()" @AllowFire() );

    if( !AllowFire() )
        return;

    if( MaxHoldTime > 0.0 )
        HoldTime = FMin(HoldTime, MaxHoldTime);

    // server
    if( Weapon.Role == ROLE_Authority )
    {
        Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
        HoldTime = 0;   // if bot decides to stop firing, HoldTime must be reset first

        if( Instigator == None || Instigator.Controller == None )
            return;

        if( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, True);

        Instigator.DeactivateSpawnProtection();
    }

    // client
    if( Instigator.IsLocallyControlled() )
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
    {
        ServerPlayFiring();
    }

    Weapon.IncrementFlashCount(ThisModeNum);

    // set the next firing time. must be careful here so client and server do not get out of sync
    if( bFireOnRelease )
    {
        if( bIsFiring )
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    // Don't load ammo automatically
    Load = 0;//AmmoPerFire;
    AmmoPerFire = 0;
    HoldTime = 0;

    if( Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None )
    {
        bIsFiring = False;
        Weapon.PutDown();
    }
}

function DoFireEffect()
{
    local vector X,Y,Z, StartTrace;
    local rotator AimRot;
    local float Alpha;

    //gLog( "DoFireEffect()" @Load );

    Instigator.MakeNoise(1.0);

    // The to-hit trace always starts right in front of the eye
    Weapon.GetViewAxes(X,Y,Z);
    StartTrace = GetFireStart(X,Y,Z);
    AimRot = AdjustAim(StartTrace, AimError);

    // Weapon accuracy cone
    if( bAccuracyRecoil )
        Alpha += AccuracyRecoil * AccuracyMultRecoil;

    if( bAccuracyStance && gPawn(Instigator) != None )
        Alpha += gPawn(Instigator).InaccuracyXhairStance * AccuracyMultStance;

    if( Alpha != 0 )
    {
        if( bAccuracyCentered )
            AimRot = rotator(vector(AimRot) + AccuracyBase*Alpha*VRand()*FRand());
        else
            AimRot = rotator(vector(AimRot) + AccuracyBase*Alpha*VRand());
    }

    // Fire
    DoTrace(StartTrace, AimRot);

    // Add recoil
    AccuracyRecoil = FMin(1, AccuracyRecoil + (1/AccuracyRecoilShots) ) + (FireRate / AccuracyRecoilRegen);
}


function DoTrace( vector Start, rotator Dir )
{
    local vector X, End, HitLocation, HitNormal;
    local rotator R;
    local Actor Other;
    local int Damage, i, ShotCount;;
    local gShotgunAttachment Attachment;
    local Material HitMaterial;
    local class<DamageType> ShotDamageType;

    MaxRange();
    Attachment = gShotgunAttachment(Weapon.ThirdPersonActor);
    Attachment.OpenHitData();

    if( Load == 1 )
    {
        ShotCount = SingleCount;
        ShotDamageType = DamageType;
    }
    else
    {
        ShotCount = DoubleCount;
        ShotDamageType = DualDamageType;
    }

    // Fire
    for( i=0; i!=ShotCount; ++i )
    {
        R = rotator( vector(Dir) + AccuracyBase*VRand()*FRand() );
        X = vector(R);
        End = Start + TraceRange * X;
        Other = Weapon.Trace(HitLocation, HitNormal, End, Start, True,,HitMaterial);

        if( Other != None && Other != Instigator )
        {
            if( !Other.bWorldGeometry )
            {
                // Calc damage
                if( DamageMin != DamageMax && FRand() > 0.5 )
                        Damage = (DamageMin + Rand(1 + DamageMax - DamageMin)) * DamageAtten;
                else    Damage = DamageMin * DamageAtten;

                // Add extra close combat damage
                if( VSize(HitLocation-Start) < ExtraDamageDist )
                    Damage += ExtraDamage;

                if( GameObjective(Other) != None )
                    Damage *= ObjectiveDamageScaling;

                // Update hit effect
                if( !Other.IsA('HitScanBlockingVolume') )
                    Attachment.SetHitData( Other, HitLocation, HitNormal, HitMaterial );

                // Apply damage
                Other.TakeDamage( Damage, Instigator, HitLocation, Momentum*X, ShotDamageType );

                HitNormal = vect(0,0,0);
            }
            else if( Attachment != None )
            {
                Attachment.SetHitData( Other, HitLocation, HitNormal, HitMaterial );
            }

            // see if hit should set off some projectiles
            CheckSetOff(HitLocation);

            // If pawn's dead, stop tracing
            if( Weapon == None )
                return;
        }
        else
        {
            HitLocation = End;
            HitNormal = vect(0,0,0);
            Attachment.SetHitData( Other, HitLocation, HitNormal, HitMaterial );
        }
    }

    Attachment.CloseHitData();
}

function PlayFiring()
{
    //gLog( "PlayFiring()" );

    if( Load == 2 )
    {
        if( Weapon.HasAnim(DualFireAnim) )
            Weapon.PlayAnim(DualFireAnim, DualFireAnimRate, TweenTime);

        Weapon.PlayOwnedSound(DualFireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,Default.FireAnimRate/FireAnimRate,False);
        ClientPlayForceFeedback(DualFireForce);
        FireCount++;
    }
    else if( Load == 1 )
    {
        if( Weapon.HasAnim(FireAnim) )
            Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);

        Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,Default.FireAnimRate/FireAnimRate,False);
        ClientPlayForceFeedback(FireForce);
        FireCount++;
    }
}

/*function ServerPlayFiring()
{
    //gLog( "ServerPlayFiring()" @Load );
    Weapon.PlayOwnedSound(FireSound,FireSoundSlot,FireSoundVolume,,FireSoundRadius);
}*/

function FlashMuzzleFlash()
{
    local rotator R;
    local coords C;

    if( Instigator == None || !Instigator.IsFirstPerson() )
        return;

    if( FlashEffect != None )
    {
        if( Load == 2 )
                FlashEffect.Trigger(Weapon, Instigator);
        else    FlashEffect.Trigger(None, Instigator);
    }

    if( ShellActorClass != None && Level.DetailMode >= ShellDetailMode )
    {
        C = Weapon.GetBoneCoords(ShellBone);
        R = Weapon.GetBoneRotation(ShellBone,0);
        Spawn(ShellActorClass,Instigator,,C.Origin,R);
        if( Load == 2 )
            Spawn(ShellActorClass,Instigator,,C.Origin+C.XAxis*16,R);
    }

    if( ShellEffect != None && Level.DetailMode >= ShellDetailMode )
    {
        ShellEffect.SetLocation( Weapon.GetBoneCoords(ShellBone).Origin );
        ShellEffect.SetRotation( Weapon.GetBoneRotation(ShellBone,0) );
        ShellEffect.Trigger(Weapon, Instigator);
    }
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ExtraDamageDist             = 96
    ExtraDamage                 = 3

    DualDamageType              = class'gDamTypeShotgunDouble'
    DualFireSound               = Sound'G_Proc.sg_p_firedual'
    DualFireForce               = "RocketLauncher"

    // gShotgunFire
    DualFireAnim                = "Fire_dual"
    DualFireAnimRate            = 1.0
    SingleCount                 = 8
    DoubleCount                 = 14

    // gInstantFire
    FlashEffectClass            = class'GEffects.gShotGunFlash'
    FlashBone                   = "Muzzle"
    FlashBoneRotator            = (Pitch=0,Yaw=0,Roll=-16384)

    ShellActorClass             = class'gEffects.gShotgunShell'
    ShellBone                   = "Shells"
    ShellBoneRotator            = (Pitch=0,Yaw=0,Roll=0)

    // Instant
    DamageType                  = class'GWeapons.gDamTypeShotgun'
    DamageMin                   = 9
    DamageMax                   = 9
    TraceRange                  = 16384

    // gWeaponFire
    AccuracyBase                = 0.1
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 1.0
    AccuracyRecoilRegen         = 1.0
    AccuracyRecoilShots         = 2

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
    FireAnim                    = "Fire_single"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Proc.sg_p_fire'
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireForce                   = "FlakCannonFire"

    FireRate                    = 0.175

    AmmoClass                   = class'gShotgunAmmo'
    AmmoPerFire                 = 0

    ShakeOffsetMag              = (X=1.0,Y=1.0,Z=1.0)
    ShakeOffsetRate             = (X=1000.0,Y=1000.0,Z=1000.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=50.0,Y=50.0,Z=50.0)
    ShakeRotRate                = (X=10000.0,Y=10000.0,Z=10000.0)
    ShakeRotTime                = 2

    BotRefireRate               = 0.9

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}
