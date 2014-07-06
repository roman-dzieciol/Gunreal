// ============================================================================
//  gTeleporterFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterFire extends gProjectileFire;

simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
    if( Bot(Instigator.Controller) != None )
        return Instigator.Location;
    else
        return Super.GetFireStart(X,Y,Z);
}

function rotator AdjustAim(vector Start, float InAimError)
{
    return Instigator.Controller.Rotation;
}

simulated function bool AllowFire()
{
    return Super.AllowFire() && (gTeleporterGun(Weapon).PodA == None || gTeleporterGun(Weapon).PodB == None);
}

function Projectile SpawnProjectile(vector Start, rotator Dir)
{
    local gTeleporterPod P;

    P = gTeleporterPod(Super.SpawnProjectile(Start, Dir));
    gTeleporterGun(Weapon).AddPod(P);

    return P;
}

simulated function vector AdjustTossDest(Actor Target)
{
    local vector V;

    V = Target.Location;

    if( JumpSpot(Target) != None )
    {
        V.Z += JumpSpot(Target).TranslocZOffset;
    }

    return V;
}


function bool PlayReload()
{   
    if( !gTeleporterGun(Weapon).HasMoreAmmo() )
        return false;

    return Super.PlayReload();
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ProjectileClass     = class'gTeleporterPod'

    FireRate            = 0.1
    bWaitForRelease     = True

    FireAnim            = "teleporter-fire-to-normal"
    FireSound           = Sound'G_Sounds.cg_telepod_fire'
    ReloadAnim          = "normal-to-teleporter"
    ReloadSound         = Sound'G_Sounds.cg_reload_grp'
    TweenTime           = 0.0

    StartOffset         = (X=25,Y=15,Z=-20)
    FireForce           = "TranslocatorFire"
}