// ============================================================================
//  gSniperFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSniperFire extends gInstantFire;

var() class<gSniperTrail>   BeamClass;
var() vector                BeamOffset;

// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.BeamClass);
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

function DoTrace(vector Start, rotator Dir)
{
    local vector X;

    MaxRange();

    X = vector(Dir);

    TracePart(Start, Start + (TraceRange * X), X, Dir, Instigator);
}

/*function DoTrace(vector Start, rotator Dir)
{
    local vector X, End, HitLocation, HitNormal, RefNormal;
    local Actor Other;
    local int Damage, ReflectNum;
    local bool bDoReflect;
    local gTracingAttachment Attachment;
    local Material HitMaterial;

    MaxRange();
    ReflectNum = 0;
    Attachment = gTracingAttachment(Weapon.ThirdPersonActor);

    while( True )
    {
        bDoReflect = False;

        X = vector(Dir);

        End = Start + (TraceRange * X);

        //TracePart(Start, End, X, Dir, Instigator);

        Other = Weapon.Trace(HitLocation, HitNormal, End, Start, True,, HitMaterial);

        if( Other != None && (Other != Instigator || ReflectNum > 0) )
        {
            if( bReflective && Other.IsA('xPawn') && xPawn(Other).CheckReflect(HitLocation, RefNormal, DamageMin*0.25) )
            {
                bDoReflect = True;
                HitNormal = vect(0,0,0);
            }
            else if( !Other.bWorldGeometry )
            {
                // Calc damage
                if( DamageMin != DamageMax && FRand() > 0.5 )
                    Damage = (DamageMin + Rand(1 + DamageMax - DamageMin)) * DamageAtten;
                else
                    Damage = DamageMin * DamageAtten;

                // Update hit effect
                if( !Other.IsA('HitScanBlockingVolume') )
                    Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);

                // Apply damage
                if(bHeadShots
                    && ((Vehicle(Other) != None && Vehicle(Other).CheckForHeadShot(HitLocation, X, 1.0) != None)
                    || (Pawn(Other) != None && Pawn(Other).IsHeadShot(HitLocation, X, 1.0))))
                    Other.TakeDamage(Damage*DamageAttenHeadShot, Instigator, HitLocation, Momentum*X, DamageTypeHeadShot);
                else
                    Other.TakeDamage(Damage, Instigator, HitLocation, Momentum*X, DamageType);

                // If pawn's dead, stop tracing
                if( Weapon == None )
                    return;

                HitNormal = vect(0, 0, 0);
            }
            else
            {
                 if( Attachment != None )
                    Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);
            }
        }
        else
        {
            HitLocation = End;
            HitNormal = vect(0, 0, 0);

            if( Attachment != None )
                Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);
        }

        if( bBeamEffect )
            SpawnBeamEffect(Start, Dir, HitLocation, HitNormal, ReflectNum);

        if( bDoReflect && ++ReflectNum < 4 )
        {
            Start = HitLocation;
            Dir = rotator(RefNormal); //rotator( X - 2.0*RefNormal*(X dot RefNormal) );
        }
        else
        {
            break;
        }
    }
}*/

function TracePart(vector Start, vector End, vector X, rotator Dir, Pawn Ignored)
{
    local vector HitLocation, HitNormal;
    local Actor Other;
    local gTracingAttachment Attachment;
    local Material HitMaterial;
    local int Damage;

    Attachment = gTracingAttachment(Weapon.ThirdPersonActor);

    Other = Ignored.Trace(HitLocation, HitNormal, End, Start, True,, HitMaterial);

    if( Other != None && Other != Ignored )
    {
        if( !Other.bWorldGeometry )
        {
            // Calc damage
            if( DamageMin != DamageMax && FRand() > 0.5 )
                Damage = (DamageMin + Rand(1 + DamageMax - DamageMin)) * DamageAtten;
            else
                Damage = DamageMin * DamageAtten;

            if( GameObjective(Other) != None )
                Damage *= ObjectiveDamageScaling;

            // Update hit effect
            if( !Other.IsA('HitScanBlockingVolume') )
                Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);

            if(bHeadShots
                && ( (Vehicle(Other) != None && Vehicle(Other).CheckForHeadShot(HitLocation, X, 1.0) != None)
                || (Pawn(Other) != None && Pawn(Other).IsHeadShot(HitLocation, X, 1.0)) ) )
                Other.TakeDamage(Damage * DamageAttenHeadShot, Instigator, HitLocation, Momentum * X, DamageTypeHeadShot);
            else
                Other.TakeDamage(Damage, Instigator, HitLocation, Momentum * X, DamageType);

            HitNormal = Vect(0, 0, 0);

            if( xPawn(Other) != None && HitLocation != Start )
                TracePart(HitLocation, End, X, Dir, xPawn(Other));
        }
        else
        {
             if( Attachment != None )
                Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);
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
        HitNormal = Vect(0, 0, 0);

        if( Attachment != None )
            Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);
    }

    if( bBeamEffect )
        SpawnBeamEffect(Start, Dir, HitLocation, HitNormal, 0);
}

function SpawnBeamEffect(vector Start, rotator Dir, vector HitLocation, vector HitNormal, int ReflectNum)
{
    local gSniperTrail E;
    local vector X,Y,Z;
    
    GetAxes(Dir,X,Y,Z);
    Start += BeamOffset.X*X + BeamOffset.Y*Y + BeamOffset.Z*Z;

    if( BeamClass != None )
    {
        E = Spawn(BeamClass, Instigator,, HitLocation, rot(0,0,0));
        if( E != None )
            E.SetHit(Start);
    }
}

function PlayFiring()
{
    Super.PlayFiring();
    SetTimer(1,False);
}

event Timer()
{
    if( ReloadSound != None && Weapon.HasAmmo() && Instigator != None )
        Instigator.PlayOwnedSound(ReloadSound, ReloadSoundSlot, ReloadSoundVolume,, ReloadSoundRadius);
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // gSniperFire
    bHeadShots                  = True
    DamageAttenHeadShot         = 2.0
    DamageTypeHeadShot          = class'gDamTypeSniperCannonHeadshot'

    BeamClass                   = class'gEffects.gSniperTrail'
    StartOffset                 = (X=40,Y=0,Z=0)
    BeamOffset                  = (X=40,Y=10,Z=-15)

    // gInstantFire
    bBeamEffect                 = True

    FlashEffectClass            = class'gEffects.gSniperFlash'
    FlashBone                   = "Muzzle"
    FlashBoneRotator            = (Pitch=0,Yaw=0,Roll=0)

    //    ShellActorClass       = class'gEffects.gShellMinigunJHP'
    //    ShellBone             = "Shells"
    //    ShellBoneRotator      = (Pitch=0,Yaw=0,Roll=0)

    // Instant
    DamageType                  = class'gWeapons.gDamTypeSniperCannon'
    DamageMin                   = 80
    DamageMax                   = 80
    TraceRange                  = 16384
    Momentum                    = 50000

    // gWeaponFire
    AccuracyBase                = 0.001
    AccuracyMultStance          = 75.0
    AccuracyMultRecoil          = 33.0
    AccuracyRecoilRegen         = 1.0
    AccuracyRecoilShots         = 1
    bAccuracyCentered           = False

    ReloadSoundVolume           = 1.0
    ReloadSoundRadius           = 153
    ReloadSoundSlot             = SLOT_None

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
    bModeExclusive              = False

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = ""
    FireAnim                    = "Fire"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.0
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Proc.sc_p_firebig'
    ReloadSound                 = Sound'G_Sounds.sc_reload1'
    NoAmmoSound                 = None

    FireForce                   = "NewSniperShot"

    FireRate                    = 2.0

    AmmoClass                   = class'gSniperAmmo'
    AmmoPerFire                 = 1

    ShakeOffsetMag              = (X=-30.0,Y=0.0,Z=20.0)
    ShakeOffsetRate             = (X=-2000.0,Y=0.0,Z=2000.0)
    ShakeOffsetTime             = 1.6
    ShakeRotMag                 = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotRate                = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotTime                = 2

    BotRefireRate               = 0.9

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    AimError                    = 800

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512
}