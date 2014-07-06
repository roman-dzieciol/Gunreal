// ============================================================================
//  gDamTypePoison.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypePoison extends gDamTypeWeapon
    abstract;

DefaultProperties
{
    DeathOverlay                = class'GEffects.gOverlay_AcidDeath'
    DeathString                 = "%k [Acid] %o"
    MaleSuicide                 = "%o [Acid - Suicide]"
    FemaleSuicide               = "%o [Acid - Suicide]"

    VehicleDamageScaling        = 0.75
    DamageThreshold             = 100
    bDelayedDamage              = True
    bCausesBlood                = False
    bLeaveBodyEffect            = True
    bArmorStops                 = False

    PawnDamageSounds(0)         = Sound'G_Proc.acd_p_tss'
    LowGoreDamageSounds(0)      = Sound'G_Proc.acd_p_tss'
}