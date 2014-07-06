// ============================================================================
//  gVirtualPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gVirtualPickup extends gBasePickup;


var() class<gOverlayTemplate> OverlayClass;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    S.PrecacheObject(default.OverlayClass);
}


// ============================================================================
//  Pickup
// ============================================================================

function Inventory SpawnCopy(Pawn Other)
{
    VirtualPickup(Other);
    return None;
}

function VirtualPickup(Pawn P);

function AnnouncePickup( Pawn Receiver )
{
    Receiver.HandlePickup(self);
    PlaySound(PickupSound, SLOT_None, 1.0);
    if( OverlayClass != None && gPlayer(Receiver.Controller) != None )
        gPlayer(Receiver.Controller).ClientFlashOverlay(OverlayClass);
}

function float BotDesireability(Pawn Bot)
{
    return MaxDesireability;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
}
