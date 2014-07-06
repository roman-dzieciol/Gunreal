// ============================================================================
//  gDamTypeMachineGunHeadShot.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeMachineGunHeadShot extends gDamTypeMachineGun
    abstract;

DefaultProperties
{
    bArmorStops             = False
    bAlwaysSevers           = True
    bSpecial                = True

    bIsHeadShot             = True

    VehicleDamageScaling    = 0.65
}