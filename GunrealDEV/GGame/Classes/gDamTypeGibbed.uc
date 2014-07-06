// ============================================================================
//  gDamTypeGibbed.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeGibbed extends gDamageType
    abstract;

DefaultProperties
{
    DeathString             = "%k [Gibbed]"
    MaleSuicide             = "%o [Gibbed - Suicide]"
    FemaleSuicide           = "%o [Gibbed - Suicide]"

    GibPerterbation         = 1.0

    bAlwaysGibs             = True
    bLocationalHit          = False
    bArmorStops             = False
}