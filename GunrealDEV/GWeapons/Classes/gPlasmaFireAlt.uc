// ============================================================================
//  gPlasmaFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaFireAlt extends gPlasmaFireBase;

var()   string              ChargeForce;
var()   float               ChargeTime;

var()   Sound               ChargeSound;
var()   float               ChargeSoundVolume;
var()   float               ChargeSoundRadius;

var()   Sound               ChargedSound;
var()   float               ChargedSoundVolume;
var()   float               ChargedSoundRadius;

var()   Sound               CancelSound;
var()   float               CancelSoundVolume;
var()   float               CancelSoundRadius;

var()   Sound               WarningSound;
var()   float               WarningSoundVolume;
var()   float               WarningSoundRadius;

var()   Sound               FireSoundBoosted;

// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.ChargeSound);
    S.PrecacheObject(default.ChargedSound);
    S.PrecacheObject(default.CancelSound);
    S.PrecacheObject(default.WarningSound);
    S.PrecacheObject(default.FireSoundBoosted);
}

simulated event ModeDoFire()
{
    local float AmmoOld, AmmoNew;
    //gLog( "ModeDoFire" @Weapon.AmmoAmount(ThisModeNum) );

    if( !AllowFire() )
        return;

    // Return to base state
    GotoState('');

    // Store ammo amount
    AmmoOld = Weapon.AmmoAmount(ThisModeNum);

    // if fired before fully charged, use firemode 0 instead
    if( HoldTime >= ChargeTime && AmmoOld >= AmmoPerFire )
    {
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

        // simulate Weapon.ConsumeAmmo() on net client
        AmmoNew = Weapon.AmmoAmount(ThisModeNum);

        if( AmmoNew == AmmoOld )
            AmmoNew -= AmmoPerFire;

        // MaxHoldTime fix
        if( bIsFiring && AmmoNew < AmmoPerFire )
            bIsFiring = False;
    }

    // Cancel fire
    else
    {
        if( Weapon.Role == ROLE_Authority )
        {
            GotoState('');
            HoldTime = 0;
        }
    }

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

    Load = AmmoPerFire;
    HoldTime = 0;

    if( Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None )
    {
        bIsFiring = False;
        Weapon.PutDown();
    }
}

simulated function ModeHoldFire()
{
    //gLog("ModeHoldFire");

    if( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire )
    {
        //Weapon.PlayOwnedSound( ChargeSound, FireSoundSlot, ChargeSoundVolume,, ChargeSoundRadius,,False );
        PlayAmbientSound(ChargeSound, ChargeSoundVolume*255, ChargeSoundRadius, 64);

        Super.ModeHoldFire();

        GotoState('Hold');
    }
}

state Hold
{
    simulated function BeginState()
    {
        //gLog( "BeginState" );
        SetTimer(ChargeTime, False);
        gPlasmaGun(Weapon).BeginCharging();
        Weapon.ClientPlayForceFeedback(ChargeForce);
    }

    simulated event Timer()
    {
        //gLog( "Timer" );
        if( Bot(Instigator.Controller) != None )
            Weapon.ImmediateStopFire();

        Weapon.PlayOwnedSound(ChargedSound, SLOT_None, ChargedSoundVolume,, ChargedSoundRadius);
        //Weapon.PlayOwnedSound( WarningSound, FireSoundSlot, WarningSoundVolume,, WarningSoundRadius );
        PlayAmbientSound(WarningSound, WarningSoundVolume*255, WarningSoundRadius, 64);
    }

    simulated event EndState()
    {
        //gLog( "EndState" );
        StopForceFeedback(ChargeForce);
        gPlasmaGun(Weapon).EndCharging();

        if( HoldTime < ChargeTime )
        {
            Weapon.PlayOwnedSound(CancelSound, FireSoundSlot, CancelSoundVolume,, CancelSoundRadius,, False);
            PlayAmbientSound(None);
        }
    }
}


simulated function DoFireEffect()
{
    //gLog( "DoFireEffect" @Weapon.AmmoAmount(ThisModeNum) @HoldTime  );
    Super.DoFireEffect();

    PlayAmbientSound(None);
}

// =============================================================================
// Anim
// =============================================================================
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
            else
            {
                Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
            }
        }
        else
        {
            Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
        }
    }

    if( BoostedFireSound != None && gPlasmaGun(Weapon).GetBoostDamageAtten() > 1 )
    {
        Weapon.PlayOwnedSound(BoostedFireSound, SLOT_None, BoostedFireSoundVolume,, BoostedFireSoundRadius);
        Weapon.PlayOwnedSound(FireSoundBoosted, FireSoundSlot, FireSoundVolume,, FireSoundRadius);
    }
    else
    {
        Weapon.PlayOwnedSound(FireSound,FireSoundSlot,FireSoundVolume,,FireSoundRadius);
    }

    ClientPlayForceFeedback(FireForce);  // jdf

    FireCount++;
}

function ServerPlayFiring()
{
    if( BoostedFireSound != None && gPlasmaGun(Weapon).GetBoostDamageAtten() > 1 )
    {
        Weapon.PlayOwnedSound(BoostedFireSound, SLOT_None, BoostedFireSoundVolume,, BoostedFireSoundRadius);
        Weapon.PlayOwnedSound(FireSoundBoosted, FireSoundSlot, FireSoundVolume,, FireSoundRadius);
    }
    else
    {
        Weapon.PlayOwnedSound(FireSound, FireSoundSlot, FireSoundVolume,, FireSoundRadius);
    }
}

DefaultProperties
{
    // gWeaponFire
    AccuracyBase                        = 0.01
    AccuracyMultStance                  = 1.0
    AccuracyMultRecoil                  = 1.0
    AccuracyRecoilRegen                 = 1.0
    AccuracyRecoilShots                 = 1
    bAccuracyRecoil                     = True

    bIsAltFire                          = True
    FlashEffectClass                    = class'GEffects.gPlasmaFlashCharged'
    FlashBone                           = "Muzzle"

    // gPlasmaAltFire
    ChargeForce                         = "BioRiflePowerUp"
    ChargeTime                          = 2
    BoostedProjectileClass              = class'gPlasmaProjectileChargedBoosted'
    TeamProjectileClass(0)              = class'gPlasmaProjectileChargedRed'
    TeamProjectileClass(1)              = class'gPlasmaProjectileCharged'
    BoostedTeamProjectileClass(0)       = class'gPlasmaProjectileChargedBoostedRed'
    BoostedTeamProjectileClass(1)       = class'gPlasmaProjectileChargedBoosted'

    ChargeSound                         = Sound'G_Sounds.pl_charge'
    ChargeSoundVolume                   = 1.0
    ChargeSoundRadius                   = 512

    ChargedSound                        = None
    ChargedSoundVolume                  = 1.0
    ChargedSoundRadius                  = 512

    CancelSound                         = Sound'G_Sounds.pl_winddown'
    CancelSoundVolume                   = 1.0
    CancelSoundRadius                   = 512

    FireSoundBoosted                    = Sound'G_Sounds.pl_fire_alt_boosted'
    BoostedFireSound                    = Sound'G_Sounds.pl_boostfire'
    BoostedFireSoundVolume              = 2.0
    BoostedFireSoundRadius              = 512

    WarningSound                        = Sound'G_Sounds.pl_charge_hold'
    WarningSoundVolume                  = 1.0
    WarningSoundRadius                  = 512

    // Other
    bSplashDamage                       = True
    bSplashJump                         = False
    bRecommendSplashDamage              = True
    bLeadTarget                         = True
    bInstantHit                         = False

    bPawnRapidFireAnim                  = False
    bReflective                         = False
    bFireOnRelease                      = True
    bWaitForRelease                     = False
    bModeExclusive                      = True

    bAttachSmokeEmitter                 = False
    bAttachFlashEmitter                 = False

    PreFireTime                         = 0
    MaxHoldTime                         = 4

    PreFireAnim                         = "PreFire"
    FireAnim                            = "alt-fire"
    FireLoopAnim                        = "FireLoop"
    FireEndAnim                         = "FireEnd"
    ReloadAnim                          = "Reload"

    PreFireAnimRate                     = 1.0
    FireAnimRate                        = 1.0
    FireLoopAnimRate                    = 1.0
    FireEndAnimRate                     = 1.0
    ReloadAnimRate                      = 1.0
    TweenTime                           = 0.1

    FireSound                           = Sound'G_Sounds.pl_fire_alt'
    ReloadSound                         = None
    NoAmmoSound                         = Sound'G_Proc.pl_p_deny'

    FireRate                            = 0.1 //0.75

    AmmoClass                           = class'gPlasmaAmmo'
    AmmoPerFire                         = 10

    ShakeRotMag                         = (X=100.0,Y=0.0,Z=0.0)
    ShakeRotRate                        = (X=1000.0,Y=0.0,Z=0.0)
    ShakeRotTime                        = 2
    ShakeOffsetMag                      = (X=-4.0,Y=0.0,Z=-4.0)
    ShakeOffsetRate                     = (X=1000.0,Y=0.0,Z=1000.0)
    ShakeOffsetTime                     = 2

    ProjectileClass                     = class'gPlasmaProjectileCharged'

    BotRefireRate                       = 1.0

    FlashEmitterClass                   = class'XEffects.ShockProjMuzFlash'
    SmokeEmitterClass                   = None

    TransientSoundVolume                = 1.0
    TransientSoundRadius                = 512
}