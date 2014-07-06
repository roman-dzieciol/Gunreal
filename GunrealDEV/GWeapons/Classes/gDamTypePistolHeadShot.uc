// ============================================================================
//  gDamTypePistolHeadShot.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypePistolHeadshot extends gDamTypePistol
    abstract;

defaultproperties
{
    bAlwaysSevers               = True
    bSpecial                    = True

    bIsHeadShot                 = True
    bArmorStops                 = False

    VehicleDamageScaling        = 0.65
}