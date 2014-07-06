// ============================================================================
//  gDamTypeTelefragged.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeTelefragged extends gDamageType
    abstract;

DefaultProperties
{
    DeathString             = "%k [Telefragged] %o"
    MaleSuicide             = "%o [Telefragged - Suicide]"
    FemaleSuicide           = "%o [Telefragged - Suicide]"

    GibPerterbation         = 1.0

    bAlwaysSevers           = True
    bAlwaysGibs             = True
    bLocationalHit          = False
    bArmorStops             = False
}