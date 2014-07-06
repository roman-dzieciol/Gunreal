// ============================================================================
//  gDamTypeMinigunJHP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeMinigunJHP extends gDamTypeMinigun
    abstract;

DefaultProperties
{
    DamageWeaponName            = "Minigun JHP"
    WeaponClass                 = class'gMinigunJHP'
    VehicleDamageScaling        = 0.66

    
    KDeathVel                   = 500
    KDeathUpKick                = 0 //150
}
