// ============================================================================
//  gSpammerProjectileBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerProjectileBase extends gProjectile;


var() class<Actor>      HitEffectClassLow;


static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.HitEffectClassLow);
}

function HitEffects( Actor HitActor, vector HitLocation, vector HitNormal )
{
    local gSpammerCylinder C;
    local gSpammerSoundCylinder SC;
    local float Alpha;

    // Don't spawn emitter if another one was spawned next to it
    foreach TouchingActors(class'gSpammerCylinder', C)
        break;

    if( C == None )
    {
        Spawn(class'gSpammerCylinder');

        if( Level.DetailMode > DM_Low )
            Spawn(HitEffectClass,,, HitLocation, rotator(HitNormal));
        else
            Spawn(HitEffectClassLow,,, HitLocation, rotator(HitNormal));

        // Reduce volume if another explosion was nearby
        foreach TouchingActors(class'gSpammerSoundCylinder', SC)
            break;

        if( SC == None )
        {
            Spawn(class'gSpammerSoundCylinder');
            Alpha = 1;
        }
        else
        {
            Alpha = FMin(1,VSize(Location-SC.Location)/ImpactSoundRadius) ** 2;
        }

        if( ImpactSound != None )
            PlaySound(ImpactSound, ImpactSoundSlot, ImpactSoundVolume * Alpha, False, ImpactSoundRadius * Alpha );
    }
    else
    {
        Spawn(HitEffectClassLow,,, HitLocation, rotator(HitNormal));
    }

    // Decal
    if( ExplosionDecal != None && Pawn(HitActor) == None /*&& DecalIsRelevant(ExplosionDecal)*/ )
        Spawn(ExplosionDecal,self,,Location, rotator(-HitNormal));
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    HitEffectClassLow           = class'GEffects.gSpammerExplosionLow'


    // gProjectile
    bRegisterProjectile         = True
    bIgnoreTeamMates            = True
    bIgnoreController           = True
    bHitProjTarget              = False

    HitEffectClass              = class'GEffects.gSpammerExplosion'
    ImpactSound                 = Sound'G_Proc.sp_p_pop'


    // Projectile
    Damage                      = 28
    DamageRadius                = 340
    MomentumTransfer            = 15000
    MyDamageType                = class'gDamTypeSpammer'
    MaxEffectDistance           = 7000.0


    // Actor
    CollisionRadius             = 4
    CollisionHeight             = 4
    bSwitchToZeroCollision      = True

    bUnlit                      = False
    DrawScale                   = 0.1
    StaticMesh                  = StaticMesh'G_Meshes.Projectiles.spam_chargenew0'
}