// ============================================================================
//  gDamTypeSniperCannonHeadshot.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeSniperCannonHeadshot extends gDamTypeSniperCannon
    abstract;


DefaultProperties
{
    DeathString                 = "%k [Sniper Headshot] %o"
    MaleSuicide                 = "%o [Sniper Headshot - Suicide]"
    FemaleSuicide               = "%o [Sniper Headshot - Suicide]"

    bIsHeadShot                 = True
    bAlwaysSevers               = True
    bSpecial                    = True
    bArmorStops                 = False
}