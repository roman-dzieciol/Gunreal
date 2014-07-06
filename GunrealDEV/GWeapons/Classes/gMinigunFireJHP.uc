// ============================================================================
//  gMinigunFireJHP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunFireJHP extends gMinigunFire;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    FireSound           = Sound'G_Proc.mini_p_fire_a'
    ShellActorClass     = class'gEffects.gShellMinigunJHP'

    // Instant
    DamageType          = class'GWeapons.gDamTypeMinigunJHP'
    DamageMin           = 15
    DamageMax           = 15
    Momentum            = 8000

    FireRate            = 0.107
    AmmoClass           = class'gMinigunAmmoJHP'

    FlashEffectClass    = class'GEffects.gMinigunFlashJHP'
}