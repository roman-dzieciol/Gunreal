// ============================================================================
//  gShotgunFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotgunFireAlt extends gNoFire;

simulated function string gDebugString()
{
    return Weapon.GetFireMode(0).Load
    @Weapon.GetFireMode(0).AmmoPerFire
    @Weapon.AmmoCharge[0];
}

simulated function bool AllowFire()
{
    if( Weapon.GetFireMode(0).Load == 0 || Weapon.GetFireMode(0).Load == 1 )
        return( Weapon.AmmoCharge[0] >= Weapon.GetFireMode(0).Load + 1 );
    else
        return( Weapon.AmmoCharge[0] >= Weapon.GetFireMode(0).Load );
}

event ModeDoFire()
{
    //gLog( "ModeDoFire()" @AllowFire() );

    if( !AllowFire() )
        return;

    if( MaxHoldTime > 0.0 )
        HoldTime = FMin(HoldTime, MaxHoldTime);

    // Load shell
    gShotgun(Weapon).LoadShell();

    // server
    if( Weapon.Role == ROLE_Authority )
    {
        Weapon.ConsumeAmmo(ThisModeNum, Load);
        DoFireEffect();
        HoldTime = 0;   // if bot decides to stop firing, HoldTime must be reset first
        if( (Instigator == None) || (Instigator.Controller == None) )
            return;

        if( AIController(Instigator.Controller) != None )
            AIController(Instigator.Controller).WeaponFireAgain(BotRefireRate, True);

        Instigator.DeactivateSpawnProtection();
    }

    // client
    if( Instigator.IsLocallyControlled() )
    {
        ShakeView();
        PlayFiring();
        FlashMuzzleFlash();
        StartMuzzleSmoke();
    }
    else // server
    {
        ServerPlayFiring();
    }

    Weapon.IncrementFlashCount(ThisModeNum);

    // set the next firing time. must be careful here so client and server do not get out of sync
    if( bFireOnRelease )
    {
        if( bIsFiring )
            NextFireTime += MaxHoldTime + FireRate;
        else
            NextFireTime = Level.TimeSeconds + FireRate;
    }
    else
    {
        NextFireTime += FireRate;
        NextFireTime = FMax(NextFireTime, Level.TimeSeconds);
    }

    Load = AmmoPerFire;
    HoldTime = 0;

    if( Instigator.PendingWeapon != Weapon && Instigator.PendingWeapon != None )
    {
        bIsFiring = False;
        Weapon.PutDown();
    }
}


// ============================================================================
// Anims
// ============================================================================


function PlayPreFire()
{
}

function PlayFiring()
{
}

function PlayFireEnd()
{
}



// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    FireRate=0.371
    BotRefireRate=0
}
