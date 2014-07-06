// ============================================================================
//  gDamTypeWeapon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeWeapon extends WeaponDamageType
    abstract;


var() bool                      bIsHeadShot;

var() class<gShakeView>         ShakeClass;

var() class<gOverlayTemplate>   DeathOverlay;
var() class<gOverlayTemplate>   HitOverlay;

var() class<LocalMessage>       HeadshotMessage;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    S.PrecacheObject(default.DeathOverlay);
    S.PrecacheObject(default.HitOverlay);
}


// ============================================================================
//  gDamTypeWeapon
// ============================================================================

static function IncrementKills(Controller Killer)
{
    local xPlayerReplicationInfo xPRI;

    if( default.bIsHeadShot && PlayerController(Killer) != None )
    {
        PlayerController(Killer).ReceiveLocalizedMessage(Default.HeadshotMessage, 0, Killer.PlayerReplicationInfo, None, None);
        xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
        if( xPRI != None )
        {
            xPRI.HeadCount++;
            if( UnrealPlayer(Killer) != None && xPRI.HeadCount == 15 )
                UnrealPlayer(Killer).ClientDelayedAnnouncementNamed('HeadHunter', 15);
        }
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ShakeClass                  = None
    HeadshotMessage               = class'SpecialKillMessage'

    // DamageType
    DeathString                 = "%k [DamType] %o"
    MaleSuicide                 = "%o [DamType - Suicide]"
    FemaleSuicide               = "%o [DamType - Suicide]"

    ViewFlash                   = 0.0
    ViewFog                     = (X=0.0,Y=0.0,Z=0.0)

    DamageEffect                = None

    DamageWeaponName            = "WeaponName"

    bArmorStops                 = True
    bInstantHit                 = False
    bFastInstantHit             = False
    bAlwaysGibs                 = False
    bLocationalHit              = False
    bAlwaysSevers               = False
    bSpecial                    = False
    bDetonatesGoop              = False
    bSkeletize                  = False
    bCauseConvulsions           = False
    bSuperWeapon                = False
    bCausesBlood                = False
    bKUseOwnDeathVel            = False
    bKUseTearOffMomentum        = False
    bDelayedDamage              = False
    bNeverSevers                = False
    bThrowRagdoll               = False
    bRagdollBullet              = True
    bLeaveBodyEffect            = False
    bExtraMomentumZ             = False
    bFlaming                    = False
    bRubbery                    = False
    bCausedByWorld              = False
    bDirectDamage               = True
    bBulletHit                  = False
    bVehicleHit                 = False

    GibModifier                 = 1.0

    PawnDamageEffect            = None
    PawnDamageEmitter           = None
    //PawnDamageSounds            = None
    PawnDamageSounds(0)         = sound'G_Proc.body_hits_new'

    LowGoreDamageEffect         = None
    LowGoreDamageEmitter        = None
    //LowGoreDamageSounds         = None
    LowGoreDamageSounds(0)      = sound'G_Proc.body_hits_new'

    LowDetailEffect             = None
    LowDetailEmitter            = None

    FlashScale                  = 0.0
    FlashFog                    = (X=0.0,Y=0.0,Z=0.0)

    DamageDesc                  = 1
    DamageThreshold             = 1
    DamageKick                  = (X=0.0,Y=0.0,Z=0.0)
    DamageOverlayMaterial       = None
    DeathOverlayMaterial        = None
    DamageOverlayTime           = 0
    DeathOverlayTime            = 0

    GibPerterbation             = 0.1


    KDamageImpulse              = 8000
    KDeathVel                   = 0
    KDeathUpKick                = 0

    VehicleDamageScaling        = 1
    VehicleMomentumScaling      = 1

    // WeaponDamageType
    WeaponClass                 = None
}
