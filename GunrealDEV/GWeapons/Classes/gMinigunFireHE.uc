// ============================================================================
//  gMinigunFireHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunFireHE extends gMinigunProjectileFire;

DefaultProperties
{
    FireSound           = Sound'G_Proc.mini_p_fire_c'
    ProjectileClass     = class'GWeapons.gMinigunProjectileHE'
    ShellActorClass     = class'gEffects.gShellMinigunHE'

    StartOffset         = (X=20,Y=5,Z=-10)
    FireRate            = 0.28
    AmmoClass           = class'gMinigunAmmoHE'

    FireSoundVolume     = 1.3
}