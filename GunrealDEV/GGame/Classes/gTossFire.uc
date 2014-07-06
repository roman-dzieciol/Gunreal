// ============================================================================
//  gTossFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTossFire extends gProjectileFire;

// ============================================================================
// Firing
// ============================================================================
simulated function bool AllowFire()
{
    if( Bot(Instigator.Controller) != None )
    {
        if( !IsInTossRange(gWeapon(Weapon).GetBotTarget()) )
        {
            Bot(Instigator.Controller).StopFiring();
            return False;
        }
    }

    return Super.AllowFire();
}

// ============================================================================
// AI
// ============================================================================
function rotator AdjustAim(vector Start, float InAimError)
{
    // Override bot aim adjustment
    if( Bot(Instigator.Controller) != None )
        return AdjustTossAim(Start, InAimError, Bot(Instigator.Controller));

    return Super.AdjustAim(Start, InAimError);
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    FireForce   = "FlakCannonAltFire"
}