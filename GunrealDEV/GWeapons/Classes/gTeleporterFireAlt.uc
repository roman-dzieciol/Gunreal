// ============================================================================
//  gTeleporterFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterFireAlt extends gNoFire;


function DoFireEffect()
{
    gTeleporterGun(Weapon).ReclaimLastPod();
}
 
 
// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    FireRate            = 0.1
    bWaitForRelease     = True
}
