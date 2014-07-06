// ============================================================================
//  gPlasmaProjectile.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaProjectile extends gPlasmaProjectileBase;


simulated event PreBeginPlay()
{
    if( Role != ROLE_Authority )
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
        bCollideWorld = False;
    }

    Super.PreBeginPlay();
}

simulated function Hit( Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "Hit" #GON(Other) #bDeleteMe #bHitting );
    if( Role == ROLE_Authority && !bDeleteMe && !bHitting )
    {
        // Set off other projectiles
        CheckSetOff();

        Super.Hit(Other, HitLocation, HitNormal);
    }
}

simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    if( Role == ROLE_Authority )
    {
        // Reflect off some things
        if( CheckReflect(Other, HitLocation, HitNormal) )
            return;
    }

    Super.TouchTarget(Other, HitLocation, HitNormal);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gPlasmaProjectileBase
    BoostEffectClass            = Class'GEffects.gPlasmaBoostEmitter'
    HealEffectClass             = Class'GEffects.gPlasmaBoostEmitter'


    // gProjectile
    ExtraDamage                 = 7
    HitEffectClass              = Class'GEffects.gPlasmaExplosion'
    AttachmentClass             = Class'GEffects.gPlasmaEmitter'
    ReflectSound                = Sound'G_Sounds.hrl_plasma_deflect1'


    // Projectile
    Speed                       = 3072
    Damage                      = 22
    MomentumTransfer            = 15000
    MaxEffectDistance           = 8000
    MyDamageType                = Class'gDamTypePlasmaBall'

    ImpactSound                 = Sound'G_Proc.pl_p_explode'
    ExplosionDecal              = class'GEffects.gPlasmaScorch'
    ExploWallOut                = 5


    // Actor
    CollisionRadius             = 8
    CollisionHeight             = 8

    LightBrightness             = 64

    AmbientSound                = Sound'G_Sounds.pl_ballfly'
    SoundRadius                 = 192
}