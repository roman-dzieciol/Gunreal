// ============================================================================
//  gPlasmaFireBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaFireBase extends gTossFire;

var     float                       NoAmmoTime;
var()   class<Projectile>           BoostedProjectileClass;

var()   Sound                       BoostedFireSound;
var()   float                       BoostedFireSoundVolume;
var()   float                       BoostedFireSoundRadius;

var()   array< class<Projectile> >  BoostedTeamProjectileClass;


// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    local int i;
    Super.PrecacheScan(S);

    S.PrecacheObject(default.BoostedProjectileClass);
    S.PrecacheObject(default.BoostedFireSound);

    for( i=0; i!=default.BoostedTeamProjectileClass.Length; ++i )
        S.PrecacheObject(default.BoostedTeamProjectileClass[i]);
}

simulated function bool AllowFire()
{
    //gLog( "AllowFire" @Weapon.AmmoAmount(ThisModeNum) );

    if( Weapon.AmmoAmount(ThisModeNum) < AmmoPerFire )
    {
        if( PlayerController(Instigator.Controller) != None && Level.TimeSeconds > class'gPlasmaFireBase'.default.NoAmmoTime )
        {
            Instigator.PlayOwnedSound(NoAmmoSound, SLOT_Interact, NoAmmoSoundVolume, True, NoAmmoSoundRadius);
            class'gPlasmaFireBase'.default.NoAmmoTime = Level.TimeSeconds + FireRate;
        }

        return False;
    }

    return True;
}

simulated function PlayAmbientSound(Sound S, optional byte Volume, optional float Radius, optional byte Pitch)
{
    if( Weapon == None || Instigator == None )
        return;

    if( S == None )
    {
        Instigator.SoundVolume = Instigator.default.SoundVolume;
        Instigator.SoundRadius = Instigator.default.SoundRadius;
        Instigator.SoundPitch = Instigator.default.SoundPitch;
        Instigator.AmbientSoundScaling = Instigator.default.AmbientSoundScaling;
    }
    else
    {
        Instigator.SoundVolume = Volume;
        Instigator.SoundRadius = Radius;
        Instigator.SoundPitch = Pitch;
        Instigator.AmbientSoundScaling = 2.0;
    }

    Instigator.AmbientSound = S;
}


// ============================================================================
//  Projectile
// ============================================================================
function Projectile SpawnProjectile(vector Start, rotator Dir)
{
    DamageAtten = gPlasmaGun(Weapon).GetBoostDamageAtten();

    if( DamageAtten > 1 )
    {
        ProjectileClass = BoostedProjectileClass;

        if( Level.Game.bTeamGame )
            ProjectileClass = BoostedTeamProjectileClass[Min(Instigator.GetTeamNum(), TeamProjectileClass.Length-1)];
    }
    else
    {
        ProjectileClass = default.ProjectileClass;

        if( Level.Game.bTeamGame )
            ProjectileClass = TeamProjectileClass[Min(Instigator.GetTeamNum(),TeamProjectileClass.Length-1)];
    }

    return Super.SpawnProjectile(Start, Dir);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    AimSpreadZ              = 0.25

    FireSoundVolume         = 1.0
    FireSoundRadius         = 512

    NoAmmoSoundVolume       = 1.0
    NoAmmoSoundRadius       = 256

    StartOffset             = (X=20,Y=10,Z=-15)
}