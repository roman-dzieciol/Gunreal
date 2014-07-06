// ============================================================================
//  gDamTypePiston.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypePiston extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    // DamageType
    DeathString                 = "%k [Piston] %o"
    MaleSuicide                 = "%o [Piston - Suicide]"
    FemaleSuicide               = "%o [Piston - Suicide]"

    WeaponClass                 = class'gPistonGun'
    bDetonatesGoop              = True
    bExtraMomentumZ             = True

    bKUseOwnDeathVel            = True
    KDeathVel                   = 450
    KDeathUpKick                = 0 //300

    VehicleMomentumScaling      = 1.0
    VehicleDamageScaling        = 0.5
}