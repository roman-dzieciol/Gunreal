// ============================================================================
//  gMinigunFireAP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunFireAP extends gMinigunFire;

DefaultProperties
{
    FireSound           = Sound'G_Proc.mini_p_fire_b'
    ShellActorClass     = class'gEffects.gShellMinigunAP'

    AccuracyBase                = 0.02
    AccuracyMultStance          = 2.0
    AccuracyMultRecoil          = 0.25
    AccuracyRecoilRegen         = 0.33
    AccuracyRecoilShots         = 6
    bAccuracyCentered           = False

    // Instant
    DamageType          = class'GWeapons.gDamTypeMinigunAP'
    DamageMin           = 27
    DamageMax           = 27
    Momentum            = 50000

    FireRate            = 0.1935

    AmmoClass           = class'gMinigunAmmoAP'
}
