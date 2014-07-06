// ============================================================================
//  gShopInfo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopInfo extends gObject
    abstract;


enum EShopState
{
    SS_None
,   SS_Shopping
};

var   EShopState            ShopState;
var   Actor                 ShopActor;
var   gMutator.EBonusMode   BonusMode;
var   gMutator.EBonusMode   PendingBonusMode;
var   gMutator.EBonusMode   LastSelectedBonusMode;
var   gPlayer.sShopLoadout  VirtualLoadout;
var   int                   TransactionID;

var() Sound                 WarrantyVoidSound;
var() Sound                 WarrantyRefundSound;
var() float                 MaxDebtOnBuy;
var() float                 SellMultiplier;
var() bool                  bInstantBonusChange;


// ============================================================================
//  Lifespan
// ============================================================================
event Created()
{
    //gLog( "Created" );
}

function Free()
{
    //gLog( "Free" );

    ShopActor = None;
    VirtualLoadout = default.VirtualLoadout;

    if( GetPawn() != None )
        GetPawn().ShopInfo = None;

    ClearOuter();
}

// ============================================================================
//  Pawn
// ============================================================================
function PawnSpawned()
{
    local gPawn P;
    //local gPRI GPRI;

    //gLog( "PawnSpawned" );

    P = GetPawn();
    if( P != None )
    {
        P.BonusMode = BonusMode;
        P.PendingBonusMode = PendingBonusMode;
        BuyPending();
    }
}

function PawnPossessed()
{
    local gPawn P;
    //local gPRI GPRI;

    //gLog( "PawnPossessed" );

    if( IsShopping() )
        End(Self, True);

    P = GetPawn();
    if( P != None )
    {
        P.ShopInfo = Self;
    }
}

function PawnDied()
{
    local gPawn P;
    local gPRI GPRI;

    //gLog( "PawnDied" );

    P = GetPawn();
    GPRI = GetGPRI();

    if( P != None )
    {
        P.ShopInfo = None;
    }

    if( BonusMode == PendingBonusMode )
    {
        // Give bonus on every respawn
        if( BonusMode == BM_Money && GPRI.GetMoney() < 2000 )
        {
            GPRI.UpdateMoney(class'gPawn'.default.BonusMoney, class'gMessageMoneyBonus', None, None);
        } else if( BonusMode == BM_Money && GPRI.GetMoney() > 1999 )
        {
            if( LastSelectedBonusMode == 0 )
            {
                BonusMode = BM_Armor;
                PendingBonusMode = BM_Armor;
            } else
            {
                BonusMode = LastSelectedBonusMode;
                PendingBonusMode = LastSelectedBonusMode;
            }
            ChangeBonusMode();
        }
    }
    else
    {
        ChangeBonusMode();
    }

    if( IsShopping() )
        End(Self, True);
}

function PawnReset(Pawn P)
{
    local gPlayer.sShopLoadout L;
    local int Count;
    local Inventory Inv;

    //gLog( "PawnReset" #P);

    if( P != None )
    {
        // gather
        L = GatherLoadout(++TransactionID);

        // neutralize inventory
        for( Inv = P.Inventory; Inv != None; Inv = Inv.Inventory )
        {
            if( ++Count > 100 )
                break;

            if( gWeapon(Inv) != None )
            {
                RemoveWarranty(gWeapon(Inv).WarrantyMode);
            }
        }

        // save as virtual
        VirtualLoadout = L;
    }
}

// ============================================================================
//  Shop
// ============================================================================
function Begin(Actor Shop)
{
    //gLog( "Begin");

    if( !IsShopping() )
    {
        ShopState = SS_Shopping;
        ShopActor = Shop;
    }
}

function End(Object O, optional bool bForce)
{
    //gLog( "End" #GON(O) #bForce );

    if( IsShopping() )
    {
        ShopState = SS_None;
        ShopActor = None;
    }
}

final function bool IsShopping()
{
    return ShopState == SS_Shopping;
}

function ForceCommit(Object O);


// ============================================================================
//  Shop - Buying/Selling
// ============================================================================
function BuyLoadout(gPlayer.sShopLoadout L)
{
    local gPawn P;
    local Weapon OldWeapon;

    //gLog( "BuyLoadout" @L.BonusMode );
    //DumpLoadout(L, "BuyLoadout PRE");

    P = GetPawn();

    // Remember which weapon player was holding
    if( P != None )
        OldWeapon = P.Weapon;

    // verify loadout
    VerifyLoadout(L);

    // Store chosen bonus mode
    PendingBonusMode = L.PendingBonusMode;

    // If dead. change immediately
    if( P == None || bInstantBonusChange )
    {
        if( BonusMode != PendingBonusMode )
        {
            ChangeBonusMode();
        }
    }
    else
    {
        P.PendingBonusMode = PendingBonusMode;
    }

    // sell unwanted items
    SellExcessLoadout(L);

    // buy extra items
    BuyExtraLoadout(L);

    // If after shopping player no longer has a weapon in hand, or it was switched to a different one, select a default gunreal weapon
    if( P != None && (OldWeapon == None || P.Weapon == None) )
        P.ClientSwitchToGunrealWeapon();

    //DumpLoadout(L, "BuyLoadout POST");
}

function VerifyLoadout(out gPlayer.sShopLoadout L)
{
    local class<gShopManifest> MC;
    local array< class<gWeapon> > WL;
    local array< class<Weapon> > GL;
    local int SlotsRemaining, lidx, widx;
    local class<gWeapon> GWC;

    //gLog( "VerifyLoadout" );
    //DumpLoadout(L, "VerifyLoadout PRE");

    MC = GetManifestClass(GetPRI().Level.Game);
    WL = MC.static.GetWeaponClasses();
    GL = MC.static.GetGloveClasses();
    SlotsRemaining = class'gPawnInventory'.default.InventorySpace;

    // check weapons
    for( lidx=0; lidx<ArrayCount(L.Weapons); ++lidx )
    {
        GWC = L.Weapons[lidx];
        if( GWC != None )
        {
            // must fit in slots
            if( SlotsRemaining - GWC.default.ItemSize >= 0 )
            {
                // find in manifest
                for( widx=0; widx<WL.Length; ++widx )
                    if( WL[widx] == GWC )
                        break;

                // if found
                if( widx < WL.Length )
                {
                    // clamp ammo amount
                    L.Ammo[lidx] = Clamp(L.Ammo[lidx], 0, GetMaxAmmo(GWC));

                    // update slots
                    SlotsRemaining -= GWC.default.ItemSize;

                    // remove weapom from list to filter out subsequent duplicates in loadout and speed things up
                    WL.Remove(widx,1);
                    continue;
                }
            }
        }

        // if invalid, reset
        L.Weapons[lidx] = None;
        L.Ammo[lidx] = 0;
        L.Warranty[lidx] = 0;
    }

    // check glove
    if( L.Glove != None )
    {
        // find in manifest
        for( widx=0; widx<GL.Length; ++widx )
            if( GL[widx] == L.Glove )
                break;

        // if found
        if( widx < GL.Length )
        {
            // clamp ammo amount
            L.GloveAmmo = Clamp(L.GloveAmmo, 0, GetMaxAmmo(L.Glove));
        }
        else
        {
            L.Glove = None;
        }
    }

    // if no glove selected, select default
    if( L.Glove == None )
    {
        L.Glove = GL[0];
        L.GloveAmmo = 0;
    }

    // tidy up loadout
    LoadoutCompress(L);

    //DumpLoadout(L, "VerifyLoadout POST");
}

function bool BuyPending()
{
    local gWeapon GW;
    local int vidx;

    //gLog( "BuyPending" );
    //DumpLoadout(VirtualLoadout, "BuyPending PRE");

    // pawn must be present
    if( GetPawn() != None )
    {
        // weapons
        for( vidx=0; vidx<ArrayCount(VirtualLoadout.Weapons); ++vidx )
        {
            if( VirtualLoadout.Weapons[vidx] != None )
            {
                GW = gWeapon(SpawnWeapon(VirtualLoadout.Weapons[vidx]));
                if( GW != None )
                {
                    GW.AddAmmo(VirtualLoadout.Ammo[vidx], 0);
                    if( HasWarranty(VirtualLoadout.Warranty[vidx]) )
                        EnableWarranty(GW.WarrantyMode);
                }
            }
        }

        // glove
        GW = gWeapon(SpawnWeapon(VirtualLoadout.Glove));
        if( GW != None )
        {
            // buy ammo if gWeapon
            GW.AddAmmo(VirtualLoadout.GloveAmmo, 0);
        }

        // reorder inventory
        ReorderInventory(GetPawn(), VirtualLoadout);

        GetPawn().ClientSwitchToGunrealWeapon();

        // reset
        VirtualLoadout = default.VirtualLoadout;
        return True;
    }
    return False;
}

function BuyRecommended()
{
    local Inventory Inv;
    local gWeapon W;
    local Pawn P;
    local int Ammo, NewAmmo;

    //gLog("BuyRecommended" );

    P = GetPawn();
    if( P != None )
    {
        // buy a bit of ammo for all primary weapons
        for( Inv = P.Inventory; Inv != None; Inv = Inv.Inventory )
        {
            W = gWeapon(Inv);
            if( W != None && W.ItemSize > 1 )
            {
                Ammo = W.AmmoCharge[0];
                NewAmmo = GetInitialAmmo(W.class);
                if( Ammo < NewAmmo )
                    BuyExtraAmmo( W, Ammo, NewAmmo );
            }
        }

        // buy lots of ammo for all weapons
        for( Inv = P.Inventory; Inv != None; Inv = Inv.Inventory )
        {
            W = gWeapon(Inv);
            if( W != None && !IsItemIgnored(W.Class) )
            {
                Ammo = W.AmmoCharge[0];
                NewAmmo = GetMaxAmmo(W.class) * 0.5;
                if( Ammo < NewAmmo )
                    BuyExtraAmmo( W, Ammo, NewAmmo );
            }
        }

        // TODO: glove ammo
    }
}



function gPlayer.sShopLoadout GatherLoadout(int ID)
{
    local class<gShopManifest> MC;
    local array< class<gWeapon> > WL;
    local array< class<Weapon> > GL;
    local int i, idx, Count;
    local Inventory Inv;
    local gPlayer.sShopLoadout svLoadout;
    local Weapon W;
    local gWeapon GW;
    local Pawn P;

    //gLog("GatherLoadout" #ID);

    // get manifes
    MC = GetManifestClass(Controller(outer).Level.Game);
    GL = MC.static.GetGloveClasses();
    WL = MC.static.GetWeaponClasses();

//@TODO: register only shoppable ammo

    // Loadout
    P = GetPawn();
    if( P != None )
    {
        // Get inventory
        for( Inv = P.Inventory; Inv != None; Inv = Inv.Inventory )
        {
            if( ++Count > 100 )
                break;

            W = Weapon(Inv);
            if( W != None )
            {
                GW = gWeapon(W);
                if( GW != None && !IsItemIgnored(GW.Class) )
                {
                    // slotted gWeapons
                    if( idx < ArrayCount(svLoadout.Weapons) )
                    {
                        svLoadout.Weapons[idx] = GW.class;
                        svLoadout.Ammo[idx] = GW.AmmoCharge[0];
                        svLoadout.Warranty[idx] = GW.WarrantyMode;
                        ++idx;
                    }
                }
                else if( svLoadout.Glove == None )
                {
                    // glove
                    for( i = 0; i < GL.Length; ++i )
                    {
                        if( W.Class == GL[i] )
                        {
                            svLoadout.Glove = W.Class;
                            svLoadout.GloveAmmo = W.AmmoCharge[0];
                        }
                    }
                }
            }
        }
    }
    else
    {
        // Get virtual items
        svLoadout = VirtualLoadout;
    }

    // default glove
    if( svLoadout.Glove == None )
    {
        svLoadout.Glove = GL[0];
    }

    // Bonus
    svLoadout.BonusMode = BonusMode;
    svLoadout.PendingBonusMode = PendingBonusMode;

    // Manifest
    svLoadout.Manifest = MC;

    // ID
    svLoadout.ID = ID;

    // tidy up
    LoadoutCompress(svLoadout);

    return svLoadout;
}

// ============================================================================
//  Selling excess items
// ============================================================================
function SellExcessLoadout(gPlayer.sShopLoadout L)
{
    local Inventory Inv, NextInv;
    local Pawn P;
    local Weapon W;
    local gWeapon GW;
    local class<gWeapon> GWC;
    local int lidx, vidx;
    local class<gShopManifest> MC;
    local array< class<gWeapon> > WL;
    local array< class<Weapon> > GL;

    //gLog( "SellExcessLoadout" );
    //DumpLoadout(L, "SellExcessLoadout");

    P = GetPawn();
    MC = GetManifestClass(Controller(outer).Level.Game);
    WL = MC.static.GetWeaponClasses();
    GL = MC.static.GetGloveClasses();

    // if old item not in loadout sell item and ammo, otherwise sell excess ammo only
    if( P == None )
    {
        // virtual weapons
        for( vidx=0; vidx<ArrayCount(VirtualLoadout.Weapons); ++vidx )
        {
            if( VirtualLoadout.Weapons[vidx] != None )
            {
                if( !FindWeaponIndex(L, VirtualLoadout.Weapons[vidx], lidx) )
                    SellExcessVirtualWeapon(VirtualLoadout.Warranty[vidx], VirtualLoadout.Weapons[vidx], VirtualLoadout.Ammo[vidx]);
                else
                {
                    SellExcessVirtualAmmo(L.Ammo[lidx], VirtualLoadout.Weapons[vidx], VirtualLoadout.Ammo[vidx]);
                    SellExcessVirtualWarranty(L.Warranty[lidx], VirtualLoadout.Weapons[vidx], VirtualLoadout.Warranty[vidx]);
                }
            }
        }

        // virtual glove
        GWC = class<gWeapon>(VirtualLoadout.Glove);
        if( GWC != None )
        {
            if( GWC != L.Glove )
                SellExcessVirtualWeapon(0, GWC, VirtualLoadout.GloveAmmo);
            else
                SellExcessVirtualAmmo(L.GloveAmmo, GWC, VirtualLoadout.GloveAmmo);
            VirtualLoadout.Glove = GWC;
        }
        else if( VirtualLoadout.Glove != L.Glove )
        {
            VirtualLoadout.Glove = None;
        }
    }
    else
    {
        for( Inv=P.Inventory; Inv!=None; Inv=NextInv )
        {
            NextInv = Inv.Inventory;
            W = Weapon(Inv);
            if( W != None )
            {
                GW = gWeapon(W);
                GWC = class<gWeapon>(W.Class);
                if( GW != None && !IsItemIgnored(GWC) )
                {
                    // weapons
                    if( !FindWeaponIndex(L, GWC, lidx) )
                        SellExcessWeapon(GW);
                    else
                    {
                        SellExcessAmmo(L.Ammo[lidx], GW);
                        SellExcessWarranty(L.Warranty[lidx], GW);
                    }
                }
                else if( MC.static.FindGloveIndexByClass(W.Class) != -1 )
                {
                    // glove
                    if( GWC != None )
                    {
                        if( GWC != L.Glove )
                            SellExcessWeapon(GW);
                        else
                            SellExcessAmmo(L.GloveAmmo, GW);
                    }
                    else if( W.Class != L.Glove )
                    {
                        RemoveWeapon(W);
                    }
                }
            }
        }
    }
}

final function SellExcessVirtualWeapon( byte Warranty, out class<gWeapon> OldItem, out int OldAmmo )
{
    //gLog( "SellExcessVirtualWeapon" #Warranty #OldItem #OldAmmo );
    CashSellWeapon(OldItem, OldAmmo, HasWarranty(Warranty));
    OldItem = None;
    OldAmmo = 0;
    Warranty = 0;
}

final function SellExcessVirtualAmmo( int NewAmmo, class<gWeapon> OldItem, out int OldAmmo )
{
    //gLog( "SellExcessVirtualAmmo" #NewAmmo #OldItem #OldAmmo );
    if( OldAmmo > NewAmmo )
    {
        CashSellAmmo(OldItem, OldAmmo - NewAmmo);
        OldAmmo = NewAmmo;
    }
}

final function SellExcessVirtualWarranty( byte NewWarranty, class<gWeapon> OldItem, out byte OldWarranty )
{
    local int w;
    //gLog( "SellExcessVirtualAmmo" #NewWarranty #OldItem #OldWarranty );
    if( !HasWarranty(NewWarranty) && HasWarranty(OldWarranty) )
    {
        CashSellWarranty(OldItem);
        w = OldWarranty;
        RemoveWarranty(w);
        OldWarranty = w;
    }
}

final function SellExcessWeapon( gWeapon OldItem )
{
    //gLog( "SellExcessWeapon" #OldItem );
    CashSellWeapon(OldItem.class, OldItem.AmmoCharge[0], HasWarranty(OldItem.WarrantyMode));
    RemoveWeapon(OldItem);
}

final function SellExcessAmmo( int NewAmmo, gWeapon OldItem )
{
    local int Ammo;
    //gLog( "SellExcessAmmo" #NewAmmo #OldItem );
    Ammo =  OldItem.AmmoCharge[0] - NewAmmo;
    if( Ammo > 0 )
    {
        CashSellAmmo(OldItem.class, Ammo);
        OldItem.ConsumeAmmo(0,Ammo);
    }
}

final function SellExcessWarranty( int NewWarranty, gWeapon OldItem )
{
    //gLog( "SellExcessAmmo" #NewAmmo #OldItem );
    if( !HasWarranty(NewWarranty) && HasWarranty(OldItem.WarrantyMode) )
    {
        CashSellWarranty(OldItem.class);
        RemoveWarranty(OldItem.WarrantyMode);
    }
}


// ============================================================================
//  Buying additional items
// ============================================================================
function BuyExtraLoadout(gPlayer.sShopLoadout L)
{
    local Pawn P;
    local Weapon W;
    local gWeapon GW;
    local class<gWeapon> GWC;
    local int lidx, vidx;
    local class<gShopManifest> MC;
    local array< class<gWeapon> > WL;
    local array< class<Weapon> > GL;

    //gLog( "BuyExtraLoadout" );
    //DumpLoadout(L, "BuyExtraLoadout");

    P = GetPawn();
    MC = GetManifestClass(Controller(outer).Level.Game);
    WL = MC.static.GetWeaponClasses();
    GL = MC.static.GetGloveClasses();

    // if new weapon not in loadout buy weapon and ammo, otherwise buy extra ammo only
    if( P == None )
    {
        // virtual weapons
        for( lidx=0; lidx<ArrayCount(L.Weapons); ++lidx )
        {
            if( L.Weapons[lidx] != None )
            {
                if( !FindWeaponIndex(VirtualLoadout, L.Weapons[lidx], vidx) )
                    BuyExtraVirtualWeapon(L.Warranty[lidx], L.Weapons[lidx], L.Ammo[lidx]);
                else
                {
                    BuyExtraVirtualAmmo(VirtualLoadout.Ammo[vidx], L.Weapons[lidx], L.Ammo[lidx]);
                    BuyExtraVirtualWarranty(VirtualLoadout.Warranty[vidx], L.Weapons[lidx], L.Warranty[lidx]);
                }
            }
        }

        // virtual glove
        GWC = class<gWeapon>(L.Glove);
        if( GWC != None )
        {
            if( L.Glove != VirtualLoadout.Glove )
            {
                // if can't buy, use default
                if( !BuyExtraVirtualWeapon(0, GWC, L.GloveAmmo) )
                {
                    L.Glove = GL[0];
                    L.GloveAmmo = 0;
                }
                else
                    L.Glove = GWC;
            }
            else
                BuyExtraVirtualAmmo(VirtualLoadout.GloveAmmo, GWC, L.GloveAmmo);
        }
        else
        {
            // do nothing?
        }

        // update stored loadout
        VirtualLoadout = L;
    }
    else
    {
        // weapons
        for( lidx=0; lidx<ArrayCount(L.Weapons); ++lidx )
        {
            if( L.Weapons[lidx] != None )
            {
                if( !FindGWeaponClass(L.Weapons[lidx],GW) )
                    BuyExtraWeapon(L.Warranty[lidx], L.Weapons[lidx], L.Ammo[lidx]);
                else
                {
                    BuyExtraAmmo(GW, GW.AmmoCharge[0], L.Ammo[lidx]);
                    BuyExtraWarranty(GW, L.Warranty[lidx]);
                }
            }
        }

        // glove
        GWC = class<gWeapon>(L.Glove);
        if( GWC != None )
        {
            if( !FindGWeaponClass(GWC,GW) )
            {
                // if can't buy, use default
                if( !BuyExtraWeapon(0, GWC, L.GloveAmmo) )
                {
                    L.Glove = GL[0];
                    L.GloveAmmo = 0;
                    SpawnWeapon(L.Glove);
                }
                else
                {
                    L.Glove = GWC;
                    if( !FindWeaponClass(L.Glove,W) )
                    {
                        SpawnWeapon(L.Glove);
                    }
                }
            }
            else
                BuyExtraAmmo(GW, GW.AmmoCharge[0], L.GloveAmmo);
        }
        else if( L.Glove != None )
        {
            if( !FindWeaponClass(L.Glove,W) )
            {
                SpawnWeapon(L.Glove);
            }
        }

        // reorder inventory
        ReorderInventory(P, L);
    }
}

final function bool BuyExtraWeapon( byte Warranty, out class<gWeapon> NewItem, out int NewAmmo )
{
    local int Cost, InitialAmmo, AmmoCost, ExtraCost, ExtraAmmo;
    local gWeapon GW;
    local bool bWarranty;

    //gLog( "BuyExtraWeapon" #Warranty #NewItem #NewAmmo );
    bWarranty = HasWarranty(Warranty);

    // if can't afford weapon, remove from loadout
    Cost = GetWeaponCost(NewItem, bWarranty);
    if( CanAfford(GetGPRI().GetMoney(), Cost) )
    {
        if( NewAmmo > 0 )
        {
            InitialAmmo = GetInitialAmmo(NewItem);

            // if can't afford initial ammo, abort
            AmmoCost = GetAmmoCost(NewItem, Min(NewAmmo, InitialAmmo));
            if( !CanAfford(GetGPRI().GetMoney(), AmmoCost, Cost) )
            {
                NewItem = None;
                NewAmmo = 0;
                return False;
            }

            // calc affordable amount (beyond initial amount)
            // uses same rules as buying manually extra ammo
            if( NewAmmo > InitialAmmo )
            {
                ExtraAmmo = NewAmmo - InitialAmmo;
                ExtraCost = CalcAffordableAmmo(NewItem, ExtraAmmo, GetGPRI().GetMoney() - Cost - AmmoCost);
                NewAmmo = InitialAmmo + ExtraAmmo;
            }
        }

        // spawn weapon
        GW = gWeapon(SpawnWeapon(NewItem));
        if( GW != None )
        {
            GW.AddAmmo(NewAmmo, 0);
            if( bWarranty )
                EnableWarranty(GW.WarrantyMode);

            CashBuyWeapon(NewItem, NewAmmo, bWarranty);
            return True;
        }
    }

    NewItem = None;
    NewAmmo = 0;
    return False;
}


final function bool BuyExtraAmmo( gWeapon OldItem, int OldAmmo, out int NewAmmo )
{
    local int Ammo, Cost;

    //gLog( "BuyExtraAmmo" #OldItem #OldAmmo #NewAmmo );
    Ammo = NewAmmo - OldAmmo;
    if( Ammo > 0 )
    {
        // calc affordable amount (beyond initial amount)
        Cost = CalcAffordableAmmo(OldItem.class, Ammo, GetGPRI().GetMoney());
        NewAmmo = OldAmmo + Ammo;
        if( Ammo == 0 )
            return False;

        CashBuyAmmo(OldItem.class, Ammo);
        OldItem.AddAmmo(Ammo, 0);
    }
    return True;
}


final function bool BuyExtraWarranty( gWeapon OldItem, out byte NewWarranty )
{
    local int Cost, w;

    //gLog( "BuyExtraWarranty" #OldItem #OldItem.WarrantyMode #NewWarranty );

    if( !HasWarranty(OldItem.WarrantyMode) && HasWarranty(NewWarranty) )
    {
        w = NewWarranty;

        // if can't afford warranty, remove from loadout
        Cost = GetWeaponWarrantyCost(OldItem.class);
        if( !CanAfford(GetGPRI().GetMoney(), Cost) )
        {
            RemoveWarranty(w);
            NewWarranty = w;
            return False;
        }

        CashBuyWarranty(OldItem.class);
        EnableWarranty(OldItem.WarrantyMode);
    }

    return True;
}

final function bool BuyExtraVirtualWeapon( byte Warranty, out class<gWeapon> NewItem, out int NewAmmo )
{
    local int Cost, InitialAmmo, AmmoCost, ExtraCost, ExtraAmmo;
    local bool bWarranty;

    //gLog( "BuyExtraVirtualWeapon" #Warranty #NewItem #NewAmmo );
    bWarranty = HasWarranty(Warranty);

    // if can't afford weapon, remove from loadout
    Cost = GetWeaponCost(NewItem, bWarranty);
    if( !CanAfford(GetGPRI().GetMoney(), Cost) )
    {
        NewItem = None;
        NewAmmo = 0;
        return False;
    }

    if( NewAmmo > 0 )
    {
        InitialAmmo = GetInitialAmmo(NewItem);

        // if can't afford initial ammo, abort
        AmmoCost = GetAmmoCost(NewItem, Min(NewAmmo, InitialAmmo));
        if( !CanAfford(GetGPRI().GetMoney(), AmmoCost, Cost) )
        {
            NewItem = None;
            NewAmmo = 0;
            return False;
        }

        // calc affordable amount (beyond initial amount)
        // uses same rules as buying manually extra ammo
        if( NewAmmo > InitialAmmo )
        {
            ExtraAmmo = NewAmmo - InitialAmmo;
            ExtraCost = CalcAffordableAmmo(NewItem, ExtraAmmo, GetGPRI().GetMoney() - Cost - AmmoCost);
            NewAmmo = InitialAmmo + ExtraAmmo;
        }
    }

    CashBuyWeapon(NewItem, NewAmmo, bWarranty);
    return True;
}

final function bool BuyExtraVirtualAmmo( int OldAmmo, class<gWeapon> NewItem, out int NewAmmo )
{
    local int Ammo, Cost;

    //gLog( "BuyExtraVirtualAmmo" #OldAmmo #NewItem #NewAmmo );
    Ammo = NewAmmo - OldAmmo;
    if( Ammo > 0 )
    {
        // calc affordable amount
        Cost = CalcAffordableAmmo(NewItem, Ammo, GetGPRI().GetMoney());
        NewAmmo = OldAmmo + Ammo;
        if( Ammo == 0 )
            return False;

        CashBuyAmmo(NewItem, Ammo);
    }
    return True;
}

final function bool BuyExtraVirtualWarranty( byte OldWarranty, class<gWeapon> NewItem, out byte NewWarranty )
{
    local int Cost, w;

    //gLog( "BuyExtraVirtualWarranty" #OldWarranty #NewItem #NewWarranty );

    if( !HasWarranty(OldWarranty) && HasWarranty(NewWarranty) )
    {
        w = NewWarranty;

        // if can't afford warranty, remove from loadout
        Cost = GetWeaponWarrantyCost(NewItem);
        if( !CanAfford(GetGPRI().GetMoney(), Cost) )
        {
            RemoveWarranty(w);
            NewWarranty = w;
            return False;
        }

        CashBuyWarranty(NewItem);
        EnableWarranty(w);
        NewWarranty = w;
    }

    return True;
}

// ============================================================================
//  Cash handling and feedback
// ============================================================================
final protected function CashSellWeapon( class<gWeapon> GWC, int Ammo, bool bWarranty)
{
    //gLog( "CashSellWeapon" #GWC #Ammo #bWarranty );

    // sell ammo
    if( Ammo > 0 )
        CashSellAmmo(GWC, Ammo);

    // sell weapon
    GetGPRI().UpdateMoney(GetWeaponCost(GWC)*SellMultiplier, class'gMessageMoneyShop', GetPRI(), GWC );

    // sell warranty
    if( bWarranty )
        CashSellWarranty(GWC);
}

final protected function CashSellAmmo( class<gWeapon> GWC, int Ammo)
{
    //gLog( "CashSellAmmo" #GWC #Ammo  );
    // sell ammo
    GetGPRI().UpdateMoney(GetAmmoCost(GWC, Ammo)*SellMultiplier, class'gMessageMoneyShop', GetPRI(), class'gAmmo');
}

final protected function CashSellWarranty( class<gWeapon> GWC )
{
    //gLog( "CashSellWarranty" #GWC );
    GetGPRI().UpdateMoney(GetWeaponWarrantyCost(GWC)*SellMultiplier, class'gMessageShopWarranty', GetPRI(), GWC);
}


final protected function CashBuyWeapon( class<gWeapon> GWC, int Ammo, bool bWarranty)
{
    //gLog( "CashBuyWeapon" #GWC #Ammo #bWarranty );
    // sell ammo
    if( Ammo > 0 )
        CashBuyAmmo(GWC, Ammo);

    // sell weapon
    GetGPRI().UpdateMoney(-GetWeaponCost(GWC), class'gMessageMoneyShop', GetPRI(), GWC );

    // sell warranty
    if( bWarranty )
        CashBuyWarranty(GWC);
}

final protected function CashBuyAmmo( class<gWeapon> GWC, int Ammo)
{
    //gLog( "CashBuyAmmo" #GWC #Ammo  );
    // sell ammo
    GetGPRI().UpdateMoney(-GetAmmoCost(GWC, Ammo), class'gMessageMoneyShop', GetPRI(), class'gAmmo');
}

final protected function CashBuyWarranty( class<gWeapon> GWC )
{
    //gLog( "CashBuyWarranty" #GWC );
    GetGPRI().UpdateMoney(-GetWeaponWarrantyCost(GWC), class'gMessageShopWarranty', GetPRI(), GWC);
}


// ============================================================================
//  Shop - Warranty
// ============================================================================
function RefundWarranty( gWeapon W )
{
    local class<gWeapon> GWC;
    local int Ammo;
    local float Mult;

    GWC = W.class;

    if( W.WarrantyMode == 1 )
        Mult = 1.0;
    else
        Mult = SellMultiplier;

    // Sell ammo
    Ammo = W.AmmoCharge[0];
    if( Ammo > 0 )
        GetGPRI().UpdateMoney(GetAmmoCost(GWC, Ammo)*Mult, class'gMessageMoneyShop', GetPRI(), class'gAmmo');

    // sell weapon
    GetGPRI().UpdateMoney(GetWeaponCost(GWC)*Mult, class'gMessageMoneyShop', GetPRI(), GWC);

    // Remove warranty
    RemoveWarranty(W.WarrantyMode);

    // play sound
    PlayWarrantyRefund();
}

final static function bool HasWarranty( int w )
{
    return w == 1;
}

final static function EnableWarranty( out int w )
{
    //Log( "EnableWarranty" @w );
    w = 1;
}

final static function RemoveWarranty( out int w )
{
    //Log( "RemoveWarranty" @w );
    w = 0;
}

final static function gWeapon GetWeaponByDamageType(Pawn InstigatedBy, class<gDamTypeWeapon> DamageType)
{
    local class<gWeapon> GWC;
    local gWeapon GW;

    if( DamageType != None && InstigatedBy != None )
    {
        GWC = class<gWeapon>(DamageType.default.WeaponClass);
        if( GWC != None )
        {
            // Get weapon that dealt the damage
            if( gWeapon(InstigatedBy.Weapon) != None && InstigatedBy.Weapon.class == GWC )
                GW = gWeapon(InstigatedBy.Weapon);
            else
                GW = gWeapon(InstigatedBy.FindInventoryType(GWC));
        }
    }

    return GW;
}

final static function DamageWarranty(Pawn Injured, Pawn InstigatedBy, int Damage, class<gDamTypeWeapon> DamageType )
{
    local gWeapon GW;

    // find killer's weapon and remove warranty from it if it dealt enough damage
    GW = GetWeaponByDamageType(InstigatedBy, DamageType);
    if( GW != None && GW.WarrantyDamage >= 0 && GW.WarrantyMode != 0 )
    {
        GW.WarrantyDamage -= FClamp(Damage, 0, Injured.Health);
        if( GW.WarrantyDamage < 0 )
        {
            RemoveWarranty(GW.WarrantyMode);
            if( gPlayer(InstigatedBy.Controller) != None )
                gPlayer(InstigatedBy.Controller).ShopInfo.PlayWarrantyVoid();
        }
    }
}

final static function KillWarranty(Pawn InstigatedBy, class<gDamTypeWeapon> DamageType )
{
    local gWeapon GW;

    // find killer's weapon and remove warranty from it
    GW = GetWeaponByDamageType(InstigatedBy, DamageType);
    if( GW != None && GW.WarrantyMode != 0 )
    {
        RemoveWarranty(GW.WarrantyMode);
        if( gPlayer(InstigatedBy.Controller) != None )
            gPlayer(InstigatedBy.Controller).ShopInfo.PlayWarrantyVoid();
    }
}

function PlayWarrantyVoid();
function PlayWarrantyRefund();

// ============================================================================
//  Shop - Utils
// ============================================================================

function ChangeBonusMode()
{
    local gPRI GPRI;

    if( BonusMode != PendingBonusMode )
    {
        GPRI = GetGPRI();

        if( PendingBonusMode == BM_Money && GPRI.GetMoney() > 1999 )
            return; // fail

        // if we had bonus money ability
        if( BonusMode == BM_Money )
        {
            GPRI.UpdateMoney(-class'gPawn'.default.BonusMoney,class'gMessageMoneyBonus',,,, True );
        }
        // if we will have bonus money ability
        else if( PendingBonusMode == BM_Money )
        {
            GPRI.UpdateMoney(class'gPawn'.default.BonusMoney,class'gMessageMoneyBonus',,,, True );
        }

        BonusMode = PendingBonusMode;
        LastSelectedBonusMode = BonusMode;
    }
}

function bool CanRefillAmmo( class<gWeapon> WC )
{
    return CanAfford(GetGPRI().GetMoney(), WC.default.CostAmmo);
}

static function bool CanAfford(float Money, float Cost, optional float ExtraCost)
{
    //Log("----CanAfford Money (" $ Money $ ")- Cost (" $ Cost $ ") = " $ (Money - Cost));
    //Log("    CanAfford?" @ (Money >= 0 && Money - Cost >= default.MaxDebtOnBuy));

    //if( Money >= 0 && Money - Cost >= default.MaxDebtOnBuy )
        //return True;

    return (Cost <= 0 || (Money >= 0 && Money - Cost - ExtraCost >= default.MaxDebtOnBuy));
}

static final function class<Ammunition> GetAmmoClass( class<Weapon> WC )
{
    if( WC.default.FireModeClass[0] != None )
        return WC.default.FireModeClass[0].default.AmmoClass;
}

static final function int GetInitialAmmo( class<Weapon> WC )
{
    local class<Ammunition> A;

    A = GetAmmoClass(WC);
    if( A != None )
        return A.default.InitialAmount;
    return 0;
}

static final function int GetMaxAmmo( class<Weapon> WC )
{
    local class<Ammunition> A;

    A = GetAmmoClass(WC);
    if( A != None )
        return A.default.MaxAmmo;
    return 0;
}

static final function float GetInitialAmmoCost( class<gWeapon> WC )
{
    return WC.default.CostAmmo;
}

static final function float GetInitialWeaponCost( class<gWeapon> WC, optional bool bWarranty )
{
    return GetWeaponCost(WC,bWarranty) + GetInitialAmmoCost(WC);
}

static final function float GetWeaponCost( class<gWeapon> WC, optional bool bWarranty )
{
    if( bWarranty )
        return WC.default.CostWeapon + GetWeaponWarrantyCost(WC);
    else
        return WC.default.CostWeapon;
}

static final function float GetWeaponWarrantyCost( class<gWeapon> WC )
{
    return WC.default.CostWeapon * WC.default.WarrantyPercent;
}

static final function float GetBulletCost( class<gWeapon> WC )
{
    local class<Ammunition> A;

    A = GetAmmoClass(WC);
    if( A != None )
    {
        return WC.default.CostAmmo / A.default.InitialAmount;
    }
    return 0;
}

static final function float GetAmmoCost( class<gWeapon> WC, int Amount )
{
    return GetBulletCost(WC) * Amount;
}

static final function float CalcAffordableAmmo(class<gWeapon> WC, out int Amount, int Money, optional int ExtraCost, optional float Discount)
{
    local float BulletCost, AvailableMoney;
    local class<Ammunition> A;

    A = GetAmmoClass(WC);
    if( A != None && Money >= 0 && A.default.InitialAmount > 0 )
    {
        BulletCost = WC.default.CostAmmo / A.default.InitialAmount;
        BulletCost -= BulletCost * Discount;
        if( BulletCost == 0 )
            return 0;

        AvailableMoney = Money - default.MaxDebtOnBuy - ExtraCost;
        if( AvailableMoney > 0 )
        {
            if( BulletCost * Amount > AvailableMoney )
                Amount = AvailableMoney / BulletCost;

            return BulletCost * Amount;
        }
    }

    Amount = 0;
    return 0;
}

static final function float GetAffordableBullets(class<gWeapon> WC, int Amount, int Money, optional int ExtraCost, optional float Discount)
{
    local float BulletCost, AvailableMoney;
    local class<Ammunition> A;

    A = GetAmmoClass(WC);
    if( A != None && Money >= 0 && A.default.InitialAmount > 0 )
    {
        BulletCost = WC.default.CostAmmo / A.default.InitialAmount;
        BulletCost -= BulletCost * Discount;
        if( BulletCost <= 0 )
            return 0;

        AvailableMoney = Money - default.MaxDebtOnBuy - ExtraCost;
        if( AvailableMoney > 0 )
        {
            if( BulletCost * Amount > AvailableMoney )
                Amount = AvailableMoney / BulletCost;

            return Amount;
        }
    }

    return 0;
}

static final function float GetAffordableClipAmmo(class<gWeapon> WC, int Amount, int Money, optional int ExtraCost, optional float Discount)
{
    local float ClipCost, AvailableMoney;
    local class<Ammunition> A;

    A = GetAmmoClass(WC);
    if( A != None && Money >= 0 && A.default.InitialAmount > 0 )
    {
        ClipCost = WC.default.CostAmmo;
        ClipCost -= ClipCost * Discount;
        if( ClipCost == 0 )
            return 0;

        AvailableMoney = Money - default.MaxDebtOnBuy - ExtraCost;
        if( AvailableMoney > 0 )
        {
            return Min(int(AvailableMoney / ClipCost)*A.default.InitialAmount, Amount);
        }
    }

    return 0;
}

final function bool FindGWeaponClass( class<gWeapon> WC, out gWeapon W )
{
    local Inventory Inv;

    for( Inv=GetPawn().Inventory; Inv!=None; Inv=Inv.Inventory )
    {
        if( Inv.Class == WC )
        {
            W = gWeapon(Inv);
            return True;
        }
    }
    return False;
}

final function bool FindWeaponClass( class<Weapon> WC, out Weapon W )
{
    local Inventory Inv;

    for( Inv=GetPawn().Inventory; Inv!=None; Inv=Inv.Inventory )
    {
        if( Inv.Class == WC )
        {
            W = Weapon(Inv);
            return True;
        }
    }
    return False;
}

final function bool FindWeapon( Weapon W )
{
    local Inventory Inv;
    for( Inv=GetPawn().Inventory; Inv!=None; Inv=Inv.Inventory )
        if( Inv == W )
            return True;
    return False;
}

static final function bool IsItemIgnored( class<Inventory> Inv )
{
    return class<gWeapon>(Inv) == None || class<gWeapon>(Inv).default.ItemSize <= 0;
}

function Weapon SpawnWeapon( class<Weapon> WC )
{
    local Pawn P;
    local Weapon W;

    P = GetPawn();

    // spawn weapon
    W = P.Spawn(WC,P);
    if( W != None )
    {
        // give to player
        if( gWeapon(W) != None )
            gWeapon(W).GiveToEx(P,,True);
        else
            W.GiveTo(P);

        // find in inventory
        if( FindWeapon(W) )
            return W;
    }

    return None;
}

function RemoveWeapon( Weapon W )
{
    local int i;

    if( gWeapon(W) != None )
        gWeapon(W).WarrantyMode = 0;

    W.ClientWeaponThrown();

    for( i = 0; i != W.NUM_FIRE_MODES; ++i )
    {
        if( W.GetFireMode(i).bIsFiring )
            W.StopFire(i);
    }

    if( W.Instigator != None )
        W.DetachFromPawn(W.Instigator);

    W.Destroy();
}

function class<gShopManifest> GetManifestClass( GameInfo G )
{
    if( G.IsA('Invasion') )
    {
        return class'gManifest_Invasion';
    }
    else if( G.bTeamGame )
    {
        if( G.bAllowVehicles )
            return class'gManifest_VTDM';
        else
            return class'gManifest_TDM';
    }
    else
    {
        if( G.bAllowVehicles )
            return class'gManifest_VDM';
        else
            return class'gManifest_DM';
    }
}


// ============================================================================
//  Loadout
// ============================================================================
final function int GetSlotOffset(gPlayer.sShopLoadout L)
{
    local int i, pos;

    for( i=0; i!=ArrayCount(L.Weapons); ++i )
    {
        if( L.Weapons[i] != None )
            pos += L.Weapons[i].default.ItemSize;
    }

    return pos;
}

final function LoadoutCompress(out gPlayer.sShopLoadout L)
{
    local int i, j;
    local gPlayer.sShopLoadout CL;

    for( i = 0; i != ArrayCount(L.Weapons); ++i )
    {
        if( L.Weapons[i] != None )
        {
            CL.Weapons[j] = L.Weapons[i];
            CL.Ammo[j] = L.Ammo[i];
            CL.Warranty[j] = L.Warranty[i];
            ++j;
        }
    }

    CL.BonusMode = L.BonusMode;
    CL.PendingBonusMode = L.PendingBonusMode;
    CL.Manifest = L.Manifest;
    CL.Glove = L.Glove;
    CL.GloveAmmo = L.GloveAmmo;
    CL.ID = L.ID;
    L = CL;
}

final function RemoveWeaponIndex(out gPlayer.sShopLoadout L, int idx)
{
    local int i, j;
    local gPlayer.sShopLoadout CL;

    //Log( "RemoveWeaponIndex" @idx );

    for( i=0; i!=ArrayCount(L.Weapons); ++i )
    {
        if( L.Weapons[i] != None && i != idx )
        {
            CL.Weapons[j] = L.Weapons[i];
            CL.Ammo[j] = L.Ammo[i];
            CL.Warranty[j] = L.Warranty[i];
            ++j;
        }
    }

    CL.BonusMode = L.BonusMode;
    CL.PendingBonusMode = L.PendingBonusMode;
    CL.Manifest = L.Manifest;
    CL.Glove = L.Glove;
    CL.GloveAmmo = L.GloveAmmo;
    CL.ID = L.ID;
    L = CL;
}


final function bool FindWeaponIndex( gPlayer.sShopLoadout L, class<gWeapon> WC, out int idx )
{
    local int i;

    for( i=0; i!=ArrayCount(L.Weapons); ++i )
    {
        if( L.Weapons[i] == WC )
        {
            idx = i;
            return True;
        }
    }

    return False;
}

final function bool FindEmptyIndex( gPlayer.sShopLoadout L, out int idx )
{
    local int i;

    for( i=0; i!=ArrayCount(L.Weapons); ++i )
    {
        if( L.Weapons[i] == None )
        {
            idx = i;
            return True;
        }
    }

    return False;
}

final function int AddWeaponClass( out gPlayer.sShopLoadout L, class<gWeapon> WC, int Ammo, optional bool bWarranty )
{
    local int i;

    //Log( "AddWeaponClass" @WC @Ammo );

    for( i=0; i!=ArrayCount(L.Weapons); ++i )
    {
        if( L.Weapons[i] == None )
        {
            L.Weapons[i] = WC;
            L.Ammo[i] = Ammo;
            L.Warranty[i] = byte(bWarranty);
            return i;
        }
    }

    return -1;
}

final function DumpLoadout( gPlayer.sShopLoadout L, coerce string Caption )
{
    local int i;

    gLog( "DumpLoadout" #Caption );
    for( i=0; i!=ArrayCount(L.Weapons); ++i )
    {
        gLog( "DumpLoadout - Weapon" #L.Weapons[i] #L.Warranty[i] #L.Ammo[i] );
    }

    gLog( "DumpLoadout - Glove" #L.Glove #L.GloveAmmo );
    gLog( "DumpLoadout - Bonus" #L.BonusMode #L.PendingBonusMode );
    gLog( "DumpLoadout - Manifest" #L.Manifest );
    gLog( "DumpLoadout - ID" #L.ID );
}

final function ReorderInventory( Pawn P, gPlayer.sShopLoadout L )
{
    local int lidx, widx;
    local array<Inventory> InvArray;
    local Inventory Inv, NextInv;

    //gLog( "ReorderInventory" #P );

    // populate InvArray and clear inventory chain
    for( Inv=P.Inventory; Inv!=None; Inv=NextInv )
    {
        InvArray[InvArray.Length] = Inv;
        NextInv = Inv.Inventory;
        Inv.Inventory = None;
    }
    P.Inventory = None;

    // first add loadout items
    for( lidx=0; lidx<ArrayCount(L.Weapons); ++lidx )
    {
        if( L.Weapons[lidx] != None )
        {
            for( widx=0; widx<InvArray.Length; ++widx )
            {
                if( L.Weapons[lidx] == InvArray[widx].class )
                {
                    P.AddInventory(InvArray[widx]);
                    InvArray.Remove(widx,1);
                    break;
                }
            }
        }
    }

    // then add everything else
    for( widx=0; widx<InvArray.Length; ++widx )
    {
        P.AddInventory(InvArray[widx]);
    }
}

// ============================================================================
//  Shop - GUI
// ============================================================================
function MenuClosed(int ID);

// ============================================================================
//  Shop - Owner accessors/mutators
// ============================================================================
function gPRI GetGPRI()
{
    return None;
}

function PlayerReplicationInfo GetPRI()
{
    return None;
}

function gPawn GetPawn()
{
    return None;
}

// ============================================================================
//  Debug
// ============================================================================
simulated function string gDebugString()
{
    local string S;
    S = "" #IsShopping() #GON(GetPawn()) #GON(GetGPRI()) #BonusMode #PendingBonusMode;
    return "<<" $S $">>";
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    WarrantyVoidSound       = Sound'G_Sounds.warranty_end1'
    WarrantyRefundSound     = Sound'G_Sounds.warranty_refund1'

    MaxDebtOnBuy            = -500
    SellMultiplier          = 0.5
}
