// ============================================================================
//  gDamTypeMinigunAP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeMinigunAP extends gDamTypeMinigun
    abstract;

DefaultProperties
{
    DamageWeaponName            = "Minigun AP"
    WeaponClass                 = class'gMinigunAP'
    VehicleDamageScaling        = 0.7

    bArmorStops                 = True

    KDeathVel                   = 650
    KDeathUpKick                = 0 //150
}
