// ============================================================================
//  gHRLPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLPickup extends gWeaponPickup;


var float NextFireTime;


function InitDroppedPickupfor( Inventory Inv )
{
    local gWeapon GW;

    Super.InitDroppedPickupFor(Inv);

    GW = gWeapon(Inv);
    if( GW != None )
    {
        //gLog( "AA" #AmmoAmount[0] #AmmoAmount[1] );
        NextFireTime = GW.GetFireMode(0).NextFireTime;
        if( GW.DeadHolder != None && !GW.DeadHolder.bDeleteMe )
        {
            bBloody = True;
            SpawnBloodProjector();
        }
    }

    LifeSpan = 0;
    SetTimer(60, False);
}

function Inventory SpawnCopy( pawn Other )
{
    local Inventory Copy;

    Copy = Super.SpawnCopy(Other);
    if( gHRL(Copy) != None )
    {
        gHRL(Copy).GetFireMode(0).NextFireTime = NextFireTime;
    }

    return Copy;
}


DefaultProperties
{
    InventoryType       = class'gHRL'
    PickupMessage       = "You got the Heavy Rocket Launcher."
    StaticMesh          = StaticMesh'G_Weapons.HRL.pkup_hrl'
    DrawScale           = 0.38
}