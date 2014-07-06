// ============================================================================
//  gTransFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTransFire extends gProjectileFire;

var() Sound                 TransFireSound;
var() String                TransFireForce;

var() Sound                 RecallFireSound;
var() String                RecallFireForce;

var() name                  RecallAnim;

var   class<Emitter>        ReclaimEmitterClass;

var() Sound                 ReclaimSound;
var() float                 ReclaimSoundVolume;
var() float                 ReclaimSoundRadius;
var() Actor.ESoundSlot      ReclaimSoundSlot;

// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.TransFireSound);
    S.PrecacheObject(default.RecallFireSound);
    S.PrecacheObject(default.ReclaimSound);

    S.PrecacheObject(default.ReclaimEmitterClass);
}

simulated function PlayFiring()
{
    if( TransLauncher(Weapon).bBeaconDeployed )
        Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
    else
        Weapon.PlayAnim(RecallAnim, FireAnimRate, TweenTime);

    ClientPlayForceFeedback(TransFireForce);  // jdf
}

/*function rotator AdjustAim(vector Start, float InAimError)
{
    return Instigator.Controller.Rotation;
}*/

simulated function bool AllowFire()
{
    return (TransLauncher(Weapon).AmmoChargeF >= 1.0);
}

function Projectile SpawnProjectile(vector Start, rotator Dir)
{
    local Projectile Beacon;

    Beacon = TransLauncher(Weapon).TransBeacon;

    if( Beacon == None )
    {
        if( Instigator == None || (Instigator.PlayerReplicationInfo == None) || Instigator.PlayerReplicationInfo.Team == None )
            Beacon = Weapon.Spawn(ProjectileClass,,, Start, Dir);
        else if( Instigator.PlayerReplicationInfo.Team.TeamIndex == 0 )
            Beacon = Weapon.Spawn(TeamProjectileClass[0],,, Start, Dir);
        else
            Beacon = Weapon.Spawn(TeamProjectileClass[1],,, Start, Dir);

        TransLauncher(Weapon).TransBeacon = TransBeacon(Beacon);
        Weapon.PlaySound(TransFireSound, SLOT_Interact, 128,,,, False);

        TransLauncher(Weapon).bBeaconDeployed = True;
    }
    else
    {
        TransLauncher(Weapon).ViewPlayer();

        if( TransBeacon(Beacon).Disrupted() )
        {
            if( Instigator != None && PlayerController(Instigator.Controller) != None )
                PlayerController(Instigator.Controller).ClientPlaySound(Sound'WeaponSounds.BSeekLost1');
        }
        else
        {
            if( ReclaimEmitterClass != None )
                Spawn(ReclaimEmitterClass,,, Beacon.Location, Beacon.Rotation);

            if( ReclaimSound != None )
                Beacon.PlaySound(ReclaimSound, ReclaimSoundSlot, ReclaimSoundVolume, False, ReclaimSoundRadius);

            Beacon.Destroy();
            Beacon = None;

            Weapon.PlaySound(RecallFireSound, SLOT_Interact,,,,, False);

            TransLauncher(Weapon).bBeaconDeployed = False;
        }
    }

    return Beacon;
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    StartOffset                 = (X=25,Y=5,Z=-20)

    // gWeaponFire
    bAccuracyBase               = False
    bAccuracyRecoil             = False
    bAccuracyStance             = False
    
    // WeaponFire
    bSplashDamage               = False
    bSplashJump                 = False
    bRecommendSplashDamage      = False
    bLeadTarget                 = False
    bInstantHit                 = False

    bPawnRapidFireAnim          = False
    bReflective                 = False
    bFireOnRelease              = False
    bWaitForRelease             = True
    bModeExclusive              = False

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

    FireSound                   = Sound'G_Sounds.rl_fire1'
    ReloadSound                 = None
    NoAmmoSound                 = None

    FireForce                   = "TranslocatorFire"

    FireRate                    = 0.25
    ProjectileClass             = class'GWeapons.gTransBeacon'

    AmmoClass                   = None
    AmmoPerFire                 = 1

    ShakeOffsetMag              = (X=-20.0,Y=0.00,Z=0.00)
    ShakeOffsetRate             = (X=-1000.0,Y=0.0,Z=0.0)
    ShakeOffsetTime             = 2
    ShakeRotMag                 = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotRate                = (X=0.0,Y=0.0,Z=0.0)
    ShakeRotTime                = 2

    BotRefireRate               = 0.3

    FlashEmitterClass           = None
    SmokeEmitterClass           = None

    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 512

    TransFireSound              = Sound'G_Sounds.cg_trans_fire'
    TransFireForce              = "TranslocatorFire"  // jdf

    RecallFireSound             = Sound'WeaponSounds.Translocator.TranslocatorModuleRegeneration'
    RecallFireForce             = "TranslocatorModuleRegeneration"  // jdf

    RecallAnim                  = "trans-recall"

    TeamProjectileClass[0]      = class'GWeapons.gTransBeacon'
    TeamProjectileClass[1]      = class'GWeapons.gTransBeacon'

    ReclaimEmitterClass         = None//class'GEffects.gPlaceholderEmitter'

    ReclaimSound                = Sound'G_Sounds.cg_trans_disc_reclaim'
    ReclaimSoundVolume          = 1.0
    ReclaimSoundRadius          = 255
    ReclaimSoundSlot            = SLOT_Misc
}