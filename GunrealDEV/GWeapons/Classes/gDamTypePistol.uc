// ============================================================================
//  gDamTypePistol.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypePistol extends gDamTypeWeapon
    abstract;

defaultproperties
{
    DeathOverlay                = class'GEffects.gOverlay_AcidDeath'
    WeaponClass                 = class'gPistol'
    bDetonatesGoop              = True
    bDelayedDamage              = True

    DeathString                 = "%o [Acid Pistol] %k"
    MaleSuicide                 = "%o [Acid Pistol - Suicide]"
    FemaleSuicide               = "%o [Acid Pistol - Suicide]"


    KDeathVel                   = 500
    KDeathUpKick                = 0 //150

    bBulletHit                  = True

    VehicleDamageScaling        = 0.5
}