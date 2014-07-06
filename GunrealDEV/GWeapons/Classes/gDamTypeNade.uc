// ============================================================================
//  gDamTypeNade.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeNade extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    ShakeClass                  = class'GEffects.gShake_Nade'

    bDelayedDamage              = True
    bExtraMomentumZ             = True

    // DamageType
    DeathString                 = "%k [Grenade] %o"
    MaleSuicide                 = "%o [Grenade - Suicide]"
    FemaleSuicide               = "%o [Grenade - Suicide]"
}