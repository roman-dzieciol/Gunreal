// ============================================================================
//  gDamTypePlasmaMine.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypePlasmaMine extends gDamTypePlasma
    abstract;

DefaultProperties
{
    ShakeClass                  = class'GEffects.gShake_PlasmaMine'

    // DamageType
    DeathString                 = "%k [Plasma Mine] %o"
    MaleSuicide                 = "%o [Plasma Mine - Suicide]"
    FemaleSuicide               = "%o [Plasma Mine - Suicide]"


    KDeathVel                   = 800
    KDeathUpKick                = 0 //400
    bThrowRagdoll               = True
    bExtraMomentumZ             = True
}