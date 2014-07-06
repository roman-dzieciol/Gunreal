// ============================================================================
//  gPistonFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistonFire extends gInstantFire;

var   float                 SelfForceScale;
var   float                 SelfDamageScale;

var() Sound                 WallImpactSound;
var() float                 WallImpactSoundVolume;
var() float                 WallImpactSoundRadius;
var() Actor.ESoundSlot      WallImpactSoundSlot;

var() Sound                 PlayerImpactSound;
var() float                 PlayerImpactSoundVolume;
var() float                 PlayerImpactSoundRadius;
var() Actor.ESoundSlot      PlayerImpactSoundSlot;

var() float                 LowerMomentum;


// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.WallImpactSound);
    S.PrecacheObject(default.PlayerImpactSound);
}

function rotator AdjustAim(vector Start, float InAimError)
{
    local rotator Aim, EnemyAim;

    if( AIController(Instigator.Controller) != None )
    {
        Aim = Instigator.Rotation;

        if( Instigator.Controller.Enemy != None )
        {
            EnemyAim = rotator(Instigator.Controller.Enemy.Location - Start);
            Aim.Pitch = EnemyAim.Pitch;
        }

        return Aim;
    }
    else
    {
        return super.AdjustAim(Start, InAimError);
    }
}

function DoTrace(vector Start, rotator Dir)
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

    //Spawn(class'gDummy',,,Start);

    while( True )
    {
        bDoReflect = False;
        X = vector(Dir);
        End = Start + TraceRange * X;
        Other = Weapon.Trace(HitLocation, HitNormal, End, Start, True,, HitMaterial);

        if( Other != None && (Other != Instigator || ReflectNum > 0) )
        {
            if( bReflective && Other.IsA('xPawn') && xPawn(Other).CheckReflect(HitLocation, RefNormal, DamageMin * 0.25) )
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

                if( GameObjective(Other) != None )
                    Damage *= ObjectiveDamageScaling;

                // Update hit effect
                if( !Other.IsA('HitScanBlockingVolume') )
                    Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);

                // Apply damage
                if(bHeadShots
                    && ((Vehicle(Other) != None && Vehicle(Other).CheckForHeadShot(HitLocation, X, 1.0) != None)
                    || (Pawn(Other) != None && Pawn(Other).IsHeadShot(HitLocation, X, 1.0))))
                    Other.TakeDamage(Damage*DamageAttenHeadShot, Instigator, HitLocation, LowerMomentum*X, DamageTypeHeadShot);
                else
                    Other.TakeDamage(Damage, Instigator, HitLocation, LowerMomentum * X, DamageType);

                if( xPawn(Other) != None )
                {
                    if( PlayerImpactSound != None )
                        Other.PlaySound(PlayerImpactSound, PlayerImpactSoundSlot, PlayerImpactSoundVolume, False, PlayerImpactSoundRadius);
                }
                else
                {
                    if( WallImpactSound != None )
                        Other.PlaySound(WallImpactSound, WallImpactSoundSlot, WallImpactSoundVolume, False, WallImpactSoundRadius);
                }
                HitNormal = vect(0,0,0);
            }
            else
            {
                Damage = DamageMin * DamageAtten;
                if( GameObjective(Other) != None )
                    Damage *= ObjectiveDamageScaling;

                Instigator.TakeDamage(Damage*SelfDamageScale, Instigator, Instigator.Location, -SelfForceScale * Momentum * X, DamageType);

                if( Attachment != None )
                    Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);

                if( PlayerImpactSound != None )
                    Instigator.PlaySound(PlayerImpactSound, PlayerImpactSoundSlot, PlayerImpactSoundVolume, False, PlayerImpactSoundRadius);
            }

            // see if hit should set off some projectiles
            CheckSetOff(HitLocation);

            // If pawn's dead, stop tracing
            if( Weapon == None )
                return;
        }
        else
        {
//            HitLocation = End;
//            HitNormal = vect(0,0,0);
//
//             if( Attachment != None )
//                Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);
        }

        if( bBeamEffect )
            SpawnBeamEffect(Start, Dir, HitLocation, HitNormal, ReflectNum);

        if( bDoReflect && ++ReflectNum < 4 )
        {
            //Log("reflecting off"@Other@Start@HitLocation);
            Start = HitLocation;
            Dir = rotator(RefNormal); //rotator( X - 2.0*RefNormal*(X dot RefNormal) );
        }
        else
        {
            break;
        }
    }
}


function float MaxRange()
{
    TraceRange = default.TraceRange;
    return TraceRange;
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    LowerMomentum               = 15000

    // Instant
    DamageType                  = class'gDamTypePiston'
    DamageMin                   = 90
    DamageMax                   = 90
    TraceRange                  = 192
    Momentum                    = 50000

    // gWeaponFire
    bAccuracyBase               = False
    bAccuracyRecoil             = False
    bAccuracyStance             = False

    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = False
    bInstantHit                 = True

    bPawnRapidFireAnim          = False
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = True
    bModeExclusive              = True

    bAttachSmokeEmitter         = False
    bAttachFlashEmitter         = False

    PreFireTime                 = 0.0
    MaxHoldTime                 = 0.0

    PreFireAnim                 = "Charge"
    FireAnim                    = "normal-fire"
    FireLoopAnim                = ""
    FireEndAnim                 = ""
    ReloadAnim                  = ""

    PreFireAnimRate             = 1.0
    FireAnimRate                = 1.19
    FireLoopAnimRate            = 1.0
    FireEndAnimRate             = 1.0
    ReloadAnimRate              = 1.0
    TweenTime                   = 0.0

    FireSound                   = Sound'G_Sounds.cg_melee_fire'
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireForce                   = "ShieldGunFire"

    FireRate                    = 0.5
    ProjectileClass             = None

    AmmoClass                   = class'gPistonAmmo'
    AmmoPerFire                 = 0

    ShakeOffsetMag              = (X=-20.0,Y=0.00,Z=0.00)
    ShakeOffsetRate             = (X=-1000.0,Y=0.0,Z=0.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotRate                = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotTime                = 2

    BotRefireRate               = 0.0

    FlashEmitterClass           = class'xEffects.ForceRingA'
    SmokeEmitterClass           = None

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512

    SelfForceScale              = 1.0
    SelfDamageScale             = 0.3

    WallImpactSound             = Sound'G_Sounds.cg_melee_wall_impact'
    WallImpactSoundVolume       = 1.0
    WallImpactSoundRadius       = 255
    WallImpactSoundSlot         = SLOT_None

    PlayerImpactSound           = Sound'G_Sounds.cg_melee_player_impact'
    PlayerImpactSoundVolume     = 2.25
    PlayerImpactSoundRadius     = 255
    PlayerImpactSoundSlot       = SLOT_None
}