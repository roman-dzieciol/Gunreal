// ============================================================================
//  gTurretWeapon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurretWeapon extends gWeaponBase
    HideDropDown
    CacheExempt;


var() float                 BarrelDist;
var   int                   ShotsFired;


// ============================================================================
//  Firing
// ============================================================================

simulated function vector GetEffectStart()
{
    if( ShotsFired % 2 == 0 )
        return Super.GetEffectStart() - Get2ndBarrelOffset();
    else
        return Super.GetEffectStart() + Get2ndBarrelOffset();
}

final simulated function vector Get2ndBarrelOffset()
{
    local vector X,Y,Z;
    GetViewAxes(X, Y, Z);
    return Y * BarrelDist;
}

simulated function bool HasAmmo()
{
    return True;
}



// ============================================================================
//  Muzzle Flash
// ============================================================================

simulated function IncrementFlashCount(int Mode)
{
    if( gWeaponAttachment(ThirdPersonActor) != None )
    {
        if( Mode == 0 )
        {
            gWeaponAttachment(ThirdPersonActor).FlashCountIncrement(ShotsFired % 2);
            ++ShotsFired;
        }
        else
            gWeaponAttachment(ThirdPersonActor).FlashCountIncrement(2);
    }
}

simulated function ZeroFlashCount(int Mode)
{
    if( gWeaponAttachment(ThirdPersonActor) != None )
    {
        if( Mode == 0 )
            gWeaponAttachment(ThirdPersonActor).FlashCountZero(ShotsFired % 2);
        else
            gWeaponAttachment(ThirdPersonActor).FlashCountZero(2);
    }
}


// ============================================================================
//  AI
// ============================================================================



function byte BestMode()
{
    return 0;
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    BarrelDist                  = -32

    ItemName            = "Turret Weapon"

    FireModeClass(0)    = class'gTurretWeaponFire'
    FireModeClass(1)    = class'gTurretWeaponFire'

    bCanThrow           = False
    bNoInstagibReplace  = True

    PickupClass         = None
    AttachmentClass     = class'gTurretWeaponAttachment'

    Priority            = 1
    InventoryGroup      = 1

    DrawScale           = 1.0
    DrawType            = DT_None
    Mesh                = None
    AmbientGlow         = 64

    DisplayFOV          = 90
    PlayerViewOffset    = (X=0,Y=0,Z=-40)
    SmallViewOffset     = (X=0,Y=0,Z=-40)
    CenteredRoll        = 0

    EffectOffset        = (X=0,Y=0,Z=0)

    AIRating            = +0.68
    CurrentRating       = +0.68
}