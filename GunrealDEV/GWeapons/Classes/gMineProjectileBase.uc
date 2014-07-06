// ============================================================================
//  gMineProjectileBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineProjectileBase extends gProjectile;


function HitEffects(Actor HitActor, vector HitLocation, vector HitNormal)
{
    // Explode up
    Super.HitEffects(HitActor, HitLocation, vect(0,0,1));
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

    // gProjectile
    bRegisterProjectile             = True
    bIgnoreTeamMates                = True
    bIgnoreController               = True
    bHitProjTarget                  = False
    Health                          = 1
    DetonateDelay                   = (Max=1.0)

    HitEffectClass                  = class'gMineExplosion'

    ImpactSound                     = Sound'G_Proc.cg_boom_c'
    ImpactSoundVolume               = 2.0


    // Projectile
    Damage                          = 140
    DamageRadius                    = 450
    MomentumTransfer                = 40000
    MyDamageType                    = class'gDamTypeLandMine'


    // Actor
    CollisionRadius                 = 4
    CollisionHeight                 = 2

    bUnlit                          = False
    StaticMesh                      = StaticMesh'G_Meshes.combo_mine1'
    DrawScale                       = 0.35
    PrePivot                        = (X=0,Y=0,Z=5)
    TransientSoundVolume            = 0.8
}