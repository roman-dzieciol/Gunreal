// ============================================================================
//  gAmmo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gAmmo extends Ammunition
    abstract;

DefaultProperties
{
    ItemName                    = "Ammo"
    PickupClass                 = None

    IconMaterial                = None
    IconFlashMaterial           = None
    IconCoords                  = (X1=0,Y1=0,X2=0,Y2=0)

    MaxAmmo                     = 1
    InitialAmount               = 1

    bRecommendSplashDamage      = False // Unused
    bTossed                     = False // Unused
    bTrySplash                  = False // Unused
    bLeadTarget                 = False // Unused
    bInstantHit                 = False // Unused
    bSplashDamage               = False // Unused
    bTryHeadShot                = False // Unused

    ProjectileClass             = None  // Unused
    MyDamageType                = None  // Unused

    MaxRange                    = 0     // Unused
    WarnTargetPct               = 0.0   // Unused
    RefireRate                  = 0.0   // Unused

    FireSound                   = None  // Unused
}