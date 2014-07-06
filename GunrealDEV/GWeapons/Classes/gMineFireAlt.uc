// ============================================================================
//  gMineFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineFireAlt extends gNoFire;


function DoFireEffect()
{
    gMineGun(Weapon).DetonateLastMine();
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    FireRate            = 0.1
    bWaitForRelease     = True
    bModeExclusive      = False
}
