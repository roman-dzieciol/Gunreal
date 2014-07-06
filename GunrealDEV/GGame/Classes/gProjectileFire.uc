// ============================================================================
//  gProjectileFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gProjectileFire extends gWeaponFire;

var() int       ProjPerFire;

var()   array< class<Projectile> >  TeamProjectileClass;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    local int i;
    Super.PrecacheScan(S);

    for( i=0; i!=default.TeamProjectileClass.Length; ++i )
        S.PrecacheObject(default.TeamProjectileClass[i]);
}

// ============================================================================
// Firing
// ============================================================================
function rotator AdjustAim(vector Start, float InAimError)
{
    local rotator R;
    local vector HitLocation, HitNormal, StartTrace, EndTrace;

    R = Super.AdjustAim(Start, InAimError);

    // 3rd person view lets player aim up and down too
    if( PlayerController(Instigator.Controller) != None && PlayerController(Instigator.Controller).bAimingHelp )
    {
        StartTrace = Instigator.Location + Instigator.EyePosition();
        EndTrace = StartTrace + vector(R) * 16384;
        if( Trace(HitLocation, HitNormal, EndTrace, StartTrace, True) != None )
            return rotator(HitLocation - Start);
        else
            return rotator(EndTrace - Start);
    }
    else
        return R;
}

function DoFireEffect()
{
    local vector X, Y, Z, StartProj, StartTrace, HitLocation, HitNormal;
    local rotator AimRot, R;
    local Actor Other;
    local int i, SpawnCount;
    local float Alpha;

    Instigator.MakeNoise(1.0);

    // Get starting points
    Weapon.GetViewAxes(X, Y, Z);

    StartTrace = Instigator.Location + Instigator.EyePosition();

    StartProj = GetFireStart(X, Y, Z);

    // Check if projectile would spawn through a wall and adjust start location accordingly
    Other = Weapon.Trace(HitLocation, HitNormal, StartProj, StartTrace, False);

    if( Other != None )
        StartProj = HitLocation;

    // Adjust direction
    AimRot = AdjustAim(StartProj, AimError);

    // Weapon accuracy cone
    if( bAccuracyBase )
        Alpha += 1;

    if( bAccuracyRecoil )
        Alpha += AccuracyRecoil * AccuracyMultRecoil;

    if( bAccuracyStance && gPawn(Instigator) != None )
        Alpha += gPawn(Instigator).InaccuracyXhairStance * AccuracyMultStance;

    // Spawn projectile
    SpawnCount = Max(1, ProjPerFire);

    for( i = 0; i != SpawnCount; ++i )
    {
        if( Alpha != 0 )
        {
            if( bAccuracyCentered )
                R = rotator(vector(AimRot) + AccuracyBase*Alpha*VRand()*FRand());
            else
                R = rotator(vector(AimRot) + AccuracyBase*Alpha*VRand());
        }
        else
            R = AimRot;

        SpawnProjectile(StartProj, R);
    }

    // Add recoil
    if( bAccuracyRecoil )
        AccuracyRecoil = FMin(1, AccuracyRecoil + (1 / AccuracyRecoilShots)) + (default.FireRate / AccuracyRecoilRegen);
}

function Projectile SpawnProjectile(vector Start, rotator Dir)
{
    local Projectile P;
    local Actor ProjOwner;

    if( Level.Game.bTeamGame && TeamProjectileClass.Length != 0 )
        ProjectileClass = TeamProjectileClass[Min(Instigator.GetTeamNum(),TeamProjectileClass.Length-1)];

    if( ProjectileClass != None )
    {
        if( class<gProjectile>(ProjectileClass) != None && class<gProjectile>(ProjectileClass).default.bRegisterProjectile )
            ProjOwner = Weapon;

        P = Weapon.Spawn(ProjectileClass,ProjOwner,, Start, Dir);
    }

    return P;
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ProjPerFire         = 1
    NoAmmoSound         = Sound'WeaponSounds.P1Reload5'
    StartOffset         = (X=0,Y=0,Z=0)

    bLeadTarget         = True
    bInstantHit         = False
    WarnTargetPct       = 0.9

    FireForce           = "RocketLauncherFire"
}