// ============================================================================
//  gPistolBullet.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistolBullet extends gProjectile;


var() int                   AcidSeconds;
var() class<DamageType>     AcidDamageType;
var() float                 AcidDamage;
var() float                 AcidTimer;


simulated event PreBeginPlay()
{
    if( Role == ROLE_Authority )
    {
        // Add whizz-by volume
        Spawn(class'gProjectileWhizzBy', Self);
    }
    else
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
    local gAcidTimer T;

    //gLog( "Hit" #GON(Other) #bDeleteMe #bHitting );
    if( Role == ROLE_Authority && !bDeleteMe && !bHitting )
    {
        // Set off other projectiles
        CheckSetOff();

        // Add poison
        if( Pawn(Other) != None )
        {
            T = class'gAcidTimer'.static.GetAcidTimer(Other, True);
            if( T != None )
                T.Update( AcidSeconds, AcidDamageType, AcidDamage, AcidTimer, Instigator );
        }

        Super.Hit(Other, HitLocation, HitNormal);
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    AcidDamage                  = 5;
    AcidTimer                   = 1
    AcidDamageType              = class'gDamTypePistolAcid'
    AcidSeconds                 = 3


    // gProjectile
    ExtraGravity                = 1

    HeadShotDamage              = 25
    HeadShotDamageType          = class'gDamTypePistolheadShot'

    HitEffectClass              = class'GEffects.gAcidHitEffect'

    ImpactSound                 = Sound'G_Proc.acd_g_glass_hit'
    ImpactSoundRadius           = 100


    // Projectile
    Speed                       = 6500
    Damage                      = 10
    MomentumTransfer            = 15000
    MyDamageType                = class'gDamTypePistol'
    ExplosionDecal              = class'GEffects.gAcidScorch'


    // Actor
    CollisionRadius             = 2
    CollisionHeight             = 2
    bUseCylinderCollision       = False
    LifeSpan                    = 8.0

    StaticMesh                  = StaticMesh'G_Meshes.Projectiles.acid_bullet_p'
    DrawScale                   = 0.4
}