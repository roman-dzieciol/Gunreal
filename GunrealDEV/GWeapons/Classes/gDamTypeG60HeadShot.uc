// ============================================================================
//  gDamTypeG60HeadShot.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeG60Headshot extends gDamTypeG60Shell
    abstract;

DefaultProperties
{
    DeathString                 = "%k [G-60 Headshot] %o"
    MaleSuicide                 = "%o [G-60 Headshot - Suicide]"
    FemaleSuicide               = "%o [G-60 Headshot - Suicide]"

    bIsHeadShot                 = True
    bAlwaysSevers               = True
    bSpecial                    = True
    bArmorStops                 = False
}