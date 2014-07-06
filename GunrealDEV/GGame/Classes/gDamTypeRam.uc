// ============================================================================
//  gDamTypeRam.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeRam extends gDamageType
    abstract;

DefaultProperties
{
    DeathString         = "%k [Collision] %o"
    MaleSuicide         = "%o [Collision - Suicide]"
    FemaleSuicide       = "%o [Collision - Suicide]"

    GibPerterbation     = 0.5
    GibModifier         = 2.0
    bLocationalHit      = False
    bCausedByWorld      = True
    DamageThreshold     = 5
}
