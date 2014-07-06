// ============================================================================
//  gDamTypePlasmaBallCharged.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypePlasmaBallCharged extends gDamTypePlasma
    abstract;

DefaultProperties
{
    ShakeClass                  = class'GEffects.gShake_Plasma'

    // DamageType
    DeathString                 = "%k [Plasma Gun] %o"
    MaleSuicide                 = "%o [Plasma Gun - Suicide]"
    FemaleSuicide               = "%o [Plasma Gun - Suicide]"

    KDeathVel                   = 1000
    KDeathUpKick                = 0 //350
    bThrowRagdoll               = True
    bExtraMomentumZ             = True
}
