// ============================================================================
//  gDamTypePlasmaBall.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypePlasmaBall extends gDamTypePlasma
    abstract;

DefaultProperties
{
    // DamageType
    DeathString                 = "%k [Plasma Gun] %o"
    MaleSuicide                 = "%o [Plasma Gun - Suicide]"
    FemaleSuicide               = "%o [Plasma Gun - Suicide]"

    bLocationalHit              = True
    bExtraMomentumZ             = True


    KDeathVel                   = 500
    KDeathUpKick                = 0 //150
}