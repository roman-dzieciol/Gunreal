// ============================================================================
//  gDamTypeMachineGun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeMachineGun extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    DeathOverlay                = class'GEffects.gOverlay_AcidDeath'
    WeaponClass                 = class'gMachineGun'
    bDetonatesGoop              = True
    bDelayedDamage              = True

    DeathString                 = "%k [Acid Machinegun] %o."
    MaleSuicide                 = "%o [Acid Machinegun - Suicide]"
    FemaleSuicide               = "%o [Acid Machinegun - Suicide]"


    KDeathVel                   = 500
    KDeathUpKick                = 0 //150

    bBulletHit                  = True


    VehicleDamageScaling        = 0.5
}
