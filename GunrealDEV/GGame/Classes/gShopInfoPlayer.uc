// ============================================================================
//  gShopInfoPlayer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopInfoPlayer extends gShopInfo
    within gPlayer;



// ============================================================================
//  Shop
// ============================================================================
function Begin(Actor Shop)
{
    //gLog("Begin" #GON(Shop) );

    if( !IsShopping() )
    {
        ShopState = SS_Shopping;
        ShopActor = Shop;

        PrepareServerLoadout(++TransactionID);
    }
}

function End(Object O, optional bool bForce)
{
    //gLog( "End" #GON(O) #bForce );

    if( IsShopping() )
    {
        ShopState = SS_None;
        ShopActor = None;

        if( bForce )
            CloseMenu(false);
    }
}

function ForceCommit(Object O)
{
    CloseMenu(true);
}


// ============================================================================
//  Shop - GUI
// ============================================================================
function MenuClosed(int ID)
{
    //gLog( "MenuClosed" #ID );

    if( ID > 0 &&  ID == TransactionID )
        End(Self);
}

function PrepareServerLoadout(int ID)
{
    local gPlayer.sShopLoadout svLoadout;

    //gLog("PrepareServerLoadout" #ID);

    // gather
    svLoadout = GatherLoadout(ID);

    // send
    ReplicateServerLoadout(svLoadout);
}

function CloseMenu(bool bCommit)
{
    //gLog( "OpenMenu" @IsShopping() );
    ClientCloseShopMenu(bCommit);
}


// ============================================================================
//  Shop - Warranty
// ============================================================================
function PlayWarrantyVoid()
{
    //gLog( "PlayWarrantyVoid" @WarrantyVoidSound );
    Outer.ClientPlaySound(WarrantyVoidSound,,, SLOT_None);
}

function PlayWarrantyRefund()
{
    //gLog( "PlayWarrantyRefund" @WarrantyRefundSound );
    Outer.ClientPlaySound(WarrantyRefundSound,,, SLOT_None);
}

// ============================================================================
//  Shop - Owner accessors/mutators
// ============================================================================
function gPawn GetPawn()
{
    return gPawn(Pawn);
}

function gPRI GetGPRI()
{
    return Outer.GetGPRI();
}

function PlayerReplicationInfo GetPRI()
{
    return PlayerReplicationInfo;
}

// ============================================================================
//  Debug
// ============================================================================
simulated function string gDebugString()
{
    local string S;
    S = "" #IsShopping() #GON(GetPawn()) #GON(GetGPRI()) #BonusMode #PendingBonusMode #TransactionID;
    return "<<" $S $">>";
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
}
