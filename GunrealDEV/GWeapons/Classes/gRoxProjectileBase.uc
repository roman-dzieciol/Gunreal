// ============================================================================
//  gRoxProjectileBase.uc ::
// ============================================================================
class gRoxProjectileBase extends gProjectile;


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gProjectile
    DetonateDelay                   = (Max=0.5)

    HitEffectClass                  = class'GEffects.gRoxHitWall'
    ImpactSound                     = Sound'G_Proc.rl.rl_boom1'
    ImpactSoundVolume               = 2.0


    // Projectile
    Damage                          = 100
    DamageRadius                    = 450
    MomentumTransfer                = 40000
    MyDamageType                    = class'gDamTypeRoxRocket'


    // Actor

    StaticMesh                      = StaticMesh'G_Meshes.Projectiles.rl_proj_a'
    DrawScale                       = 0.8
}