// ============================================================================
//  gMachineGunBullet.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMachineGunBullet extends gPistolBullet;

DefaultProperties
{
    AcidDamageType          = class'gDamTypeMachineGunAcid'
    AcidSeconds             = 1
    AcidDamage              = 10
    AcidTimer               = 2


    // gProjectile
    HeadShotDamage          = 15
    HeadShotDamageType      = class'gDamTypeMachineGunHeadShot'


    // Projectile
    Damage                  = 20
    MomentumTransfer        = 15000
    MyDamageType            = class'gDamTypeMachineGun'


    // Actor
    StaticMesh              = StaticMesh'G_Meshes.Projectiles.acid_bullet_mg'
}