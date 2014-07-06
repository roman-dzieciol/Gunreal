// ============================================================================
//  gDamTypeTurret.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamTypeTurret extends VehicleDamageType;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    DeathString             = "%k [Turret] %o"
    MaleSuicide             = "%o [Turret - Suicide]"
    FemaleSuicide           = "%o [Turret - Suicide]"

    FlashFog                = (X=600.00000,Y=0.000000,Z=0.00000)
    VehicleClass            = class'gTurret'
    KDamageImpulse          = 2000

    bBulletHit              = True
    bRagdollBullet          = True
}