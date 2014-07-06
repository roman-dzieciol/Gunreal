// ============================================================================
//  gShopClientMenu.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopClientMenu extends gShopClient
    config(User);

// possible tweaks
// make loadout use byte indices instead of class references?
// use own data structures internally?

var protected                 bool                        bInitialized;

var protected                 gPRI                        GPRI;
var protected                 gPlayer                     Player;

var protected                 gPlayer.sShopLoadout        Loadout;
var protected                 gPlayer.sShopLoadout        Inventory;
var() protected config        gPlayer.sShopLoadout        LastLoadout;
var protected                 array< class<gWeapon> >     WeaponManifest;
var protected                 array< class<Weapon> >      GloveManifest;

var protected                 int                         LoadoutCost;
var protected                 int                         InventoryValue;
var protected                 int                         OldMoney;

var() protected               gMutator.EBonusMode         PlayerBonus;
var() protected               gMutator.EBonusMode         PlayerPendingBonus;


// ============================================================================
//  Lifespan
// ============================================================================

function Free()
{
    GPRI = None;
    Player = None;

    OnInitBegin = None;
    OnInitEnd = None;

    OnManifestGloveInit = None;
    OnManifestWeaponInit = None;

    OnBonusInit = None;
    OnBonusUpdate = None;

    OnGloveInit = None;
    OnGloveAmmoBought = None;
    OnGloveBought = None;
    OnGloveSold = None;

    OnWeaponInit = None;
    OnWeaponAmmoBought = None;
    OnWeaponWarrantySold = None;
    OnWeaponSold = None;
    OnWeaponBought = None;
    OnRebuyBegin = None;
    OnRebuyEnd = None;

    OnMoneyChange = None;
}


function bool Init( gPlayer PC, int ShopID )
{
    Player = PC;
    if( Player == None )
        return False;

    // if there's no GPRI, don't open the menu
    GPRI = Player.GetGPRI();
    if( GPRI == None )
        return False;

    // get cached data, validate it
    if( ShopID == 0 || ShopID != Player.ServerLoadout.ID )
        return False;

    // load loadout
    Loadout = Player.ServerLoadout;
    if( Loadout.Manifest == None )
        return False;

    // load manifest
    WeaponManifest = Loadout.Manifest.static.GetWeaponClasses();
    GloveManifest = Loadout.Manifest.static.GetGloveClasses();

    // get loadout
    LoadoutCompress(Loadout);
    Inventory = Loadout;
    InventoryValue = 0;
    PlayerBonus = Inventory.BonusMode;
    PlayerPendingBonus = Inventory.PendingBonusMode;
    PredictInventoryValue();

    // load bonuses
    BonusUpdate(PlayerPendingBonus);

    // finished with loadout
    bInitialized = True;

    // notify delegates
    NotifySuccess();

    return True;
}

protected function NotifySuccess()
{
    local int i, SIdx;
    local class<gWeapon> GWC;

    // about to initialize
    OnInitBegin();

    // init weapons manifest
    for( i=0; i<WeaponManifest.Length; ++i )
        OnManifestWeaponInit(i, WeaponManifest[i]);

    // init glove manifest
    for( i=0; i<GloveManifest.Length; ++i )
        OnManifestGloveInit(i, GloveManifest[i]);

    // init glove
    OnGloveInit( GetManifestGloveIdx(Loadout.Glove), Loadout.Glove, Loadout.GloveAmmo );

    // init weapons
    for( i=0; i<ArrayCount(Loadout.Weapons); ++i )
    {
        GWC = Loadout.Weapons[i];
        if( GWC != None )
        {
            OnWeaponInit( GetManifestWeaponIdx(GWC), SIdx, GWC, Loadout.Ammo[i], Loadout.Warranty[i] );
            SIdx += GWC.default.ItemSize;
        }
    }

    // init bonus
    OnBonusInit(Loadout.BonusMode, Loadout.PendingBonusMode);

    // finished initialization
    OnInitEnd();
}

function Finalize()
{
    LoadoutCompress(Loadout);
    LastLoadout = Loadout;

    SaveConfig();
    Player.ReplicateClientLoadout(Loadout);
}


// ============================================================================
//  Delegates
// ============================================================================

delegate OnInitBegin();
delegate OnInitEnd();

delegate OnManifestGloveInit( int MIdx, class<Weapon> WC );
delegate OnManifestWeaponInit( int MIdx, class<gWeapon> GWC );

delegate OnBonusInit( gMutator.EBonusMode Mode, gMutator.EBonusMode PendingMode );
delegate OnBonusUpdate( gMutator.EBonusMode Mode, gMutator.EBonusMode PendingMode );

delegate OnGloveInit( int MIdx, class<Weapon> WC, int Ammo );
delegate OnGloveAmmoBought( class<Weapon> WC, int Ammo, bool bDebt );
delegate OnGloveBought( int MIdx, class<Weapon> WC, int Ammo, bool bDebt );
delegate OnGloveSold( int MIdx, class<Weapon> WC );

delegate OnWeaponInit( int MIdx, int SIdx, class<gWeapon> GWC, int Ammo, byte bWarranty );
delegate OnWeaponAmmoBought( int LIdx, class<gWeapon> GWC, int Ammo, bool bDebt, bool bQuiet );
delegate OnWeaponWarrantySold( int LIdx, class<gWeapon> GWC );
delegate OnWeaponSold( int MIdx, int LIdx, class<gWeapon> GWC );
delegate OnWeaponBought( int MIdx, int LIdx, int SIdx, class<gWeapon> GWC, int Ammo, byte bWarranty, bool bDebt, bool bQuiet );
delegate OnRebuyBegin();
delegate OnRebuyEnd();

delegate OnMoneyChange( int OldAmount, int NewAmount );


// ============================================================================
//  Bonus
// ============================================================================

function BonusUpdate( gMutator.EBonusMode NewMode )
{
    //Log( "BonusUpdate" @NewMode @Loadout.BonusMode @Loadout.PendingBonusMode @PlayerBonus @PlayerPendingBonus );

    if( Loadout.PendingBonusMode != NewMode )
    {
        // Switch straight away if dead
        if( Player != None && Player.Pawn == None )
        {
            Loadout.BonusMode = NewMode;

            // update prediction only if dead
            if( NewMode == BM_Money )
            {
                LoadoutCost -= class'gPawn'.default.BonusMoney;
            }
            else if( Loadout.PendingBonusMode == BM_Money )
            {
                LoadoutCost += class'gPawn'.default.BonusMoney;
            }
        }

        Loadout.PendingBonusMode = NewMode;
    }

    if( bInitialized )
        OnBonusUpdate( Loadout.BonusMode, Loadout.PendingBonusMode );
}


// ============================================================================
//  Glove
// ============================================================================

function bool GloveBuy(class<Weapon> WC, optional float AmmoAmount)
{
    local class<gWeapon> GWC;
    local float WeaponCost, AmmoCost, DiscountAmmo;

    //Log( "GloveBuy" @AmmoAmount @AmmoAmount @Loadout.Glove );

    // if invalid weapon, abort
    if( WC == None )
        return False;

    // if buying the same type again
    if( WC == Loadout.Glove )
    {
        // if invalid weapon or ammo amount, abort
        GWC = class<gWeapon>(WC);
        if( GWC == None || AmmoAmount <= 0 )
            return False;

        // check discount
        if( Inventory.Glove == GWC )
            DiscountAmmo = Inventory.GloveAmmo;

        // buy ammo
        if( CalcAmmoBuy( False, GWC, Loadout.GloveAmmo, AmmoAmount, AmmoCost, 0, DiscountAmmo ) )
        {
            // update money, change loadout, notify
            LoadoutCost += AmmoCost;
            Loadout.GloveAmmo += AmmoAmount;
            OnGloveAmmoBought(Loadout.Glove, Loadout.GloveAmmo, GPRI.GetMoney() - LoadoutCost <= 0);
            return True;
        }
        return False;
    }
    else
    {
        // Sell old glove
        GloveSell();

        GWC = class<gWeapon>(WC);
        if( GWC != None )
        {
            // get weapon cost
            WeaponCost = GetWeaponCost(GWC);

            // check discount
            if( Inventory.Glove == GWC )
            {
                WeaponCost *= GetSellMultiplier();
                DiscountAmmo = Inventory.GloveAmmo;
            }

            // buy weapon and ammo
            if( !DoBuyWeapon( GWC, AmmoAmount, WeaponCost, DiscountAmmo ) )
                return False;

            // update money
            LoadoutCost += WeaponCost;
        }

        // add to loadout
        Loadout.Glove = WC;
        Loadout.GloveAmmo = AmmoAmount;

        // notify
        OnGloveBought( GetManifestGloveIdx(WC), WC, AmmoAmount, (WeaponCost > 0 && GPRI.GetMoney() - LoadoutCost <= 0) );
    }

    return True;
}

function GloveSell()
{
    local class<Weapon> WC;
    local class<gWeapon> GWC;
    local float WeaponCost, AmmoAmount, AmmoValue, DiscountAmmo;

    //Log( "GloveSell" @Loadout.Glove @Loadout.GloveAmmo );

    WC = Loadout.Glove;
    if( WC == None )
        return;

    // update cost prediction
    GWC = class<gWeapon>(WC);
    if( GWC != None )
    {
        // calc weapon cost
        WeaponCost = GetWeaponCost( GWC, False );

        // check discount
        if( Inventory.Glove == GWC )
        {
            WeaponCost *= GetSellMultiplier();
            DiscountAmmo = Inventory.GloveAmmo;
        }

        // calc ammo cost
        AmmoAmount = Loadout.GloveAmmo;
        CalcAmmoSell( GWC, 0, AmmoAmount, AmmoValue, DiscountAmmo );

        // update money
        LoadoutCost -= WeaponCost + AmmoValue;
    }

    // change loadout
    Loadout.Glove = None;
    Loadout.GloveAmmo = 0;

    // notify
    OnGloveSold( GetManifestGloveIdx(WC), WC );
}


// ============================================================================
//  Weapon
// ============================================================================

function bool AmmoBuy( class<gWeapon> GWC, int LIdx, optional float NewAmount, optional bool bQuiet )
{
    local int DIdx;
    local float NewCost, DiscountAmmo;

    //Log( "AmmoBuy" @GWC @LIdx @NewAmount @bQuiet );

    // buy "inital amount" pack of ammo
    if( NewAmount == 0 )
        NewAmount = GetInitialAmmo(GWC);

    // check discount
    DIdx = GetDiscountIdx(GWC);
    if( DIdx != -1 )
        DiscountAmmo = Inventory.Ammo[DIdx];

    // buy ammo
    if( CalcAmmoBuy( False, GWC, Loadout.Ammo[LIdx], NewAmount, NewCost, 0, DiscountAmmo ) )
    {
        // update money, change loadout, notify
        LoadoutCost += NewCost;
        Loadout.Ammo[LIdx] += NewAmount;
        OnWeaponAmmoBought( LIdx, GWC, Loadout.Ammo[LIdx], (GPRI.GetMoney() - LoadoutCost <= 0), bQuiet );
        return True;
    }
    return False;
}

function bool WeaponBuy( class<gWeapon> GWC, float AmmoAmount, optional bool bWarranty, optional bool bQuiet )
{
    local int LIdx, SIdx, DIdx;
    local float WeaponCost, DiscountAmmo;

    //Log( "WeaponBuy" @GWC @AmmoAmount @bWarranty @bQuiet );

    // weapon must fit in slots
    SIdx = GetWeaponOffset(GWC);
    if( SIdx == -1 )
        return False;

    // check discount
    DIdx = GetDiscountIdx(GWC);
    if( DIdx != -1 )
        DiscountAmmo = Inventory.Ammo[DIdx];

    // buy weapon and ammo
    WeaponCost = GetWeaponValue( GWC, bWarranty, DIdx );
    if( !DoBuyWeapon( GWC, AmmoAmount, WeaponCost, DiscountAmmo ) )
        return False;

    // update money, change loadout, notify
    LoadoutCost += WeaponCost;
    LIdx = AddWeaponClass( Loadout, GWC, AmmoAmount, bWarranty );
    OnWeaponBought( GetManifestWeaponIdx(GWC), LIdx, SIdx, GWC, AmmoAmount, byte(bWarranty), (GPRI.GetMoney() - LoadoutCost <= 0), bQuiet );
    return True;
}

function WeaponSell( class<gWeapon> GWC )
{
    local int LIdx, DIdx;
    local float WeaponCost, AmmoValue, AmmoAmount, DiscountAmmo;

    //Log( "WeaponSell" @GWC );

    // update loadout
    if( FindWeaponIndex( Loadout, GWC, LIdx ) )
    {
        // check discount
        DIdx = GetDiscountIdx(GWC);
        if( DIdx != -1 )
            DiscountAmmo = Inventory.Ammo[DIdx];

        // calc cost
        WeaponCost = GetWeaponValue( GWC, Loadout.Warranty[LIdx] == 1, DIdx );
        AmmoAmount = Loadout.Ammo[LIdx];
        CalcAmmoSell( GWC, 0, AmmoAmount, AmmoValue, DiscountAmmo );

        // update money, change loadout, notify
        LoadoutCost -= WeaponCost + AmmoValue;
        RemoveWeaponIndex( Loadout, LIdx );
        OnWeaponSold( GetManifestWeaponIdx(GWC), LIdx, GWC );
    }
}

function bool WarrantySell(class<gWeapon> GWC, int LIdx)
{
    local int DIdx;
    local float Value;

    //Log( "WarrantySell" @GWC @LIdx );

    if( GWC == None )
        return False;

    // check discount, calc warranty value
    DIdx = GetDiscountIdx(GWC);
    Value = GetWeaponWarrantyCost(GWC);
    if( DIdx != -1 && Inventory.Warranty[DIdx] == 1 )
        Value -= GetWeaponWarrantyCost(GWC) * GetSellMultiplier();

    // update money
    LoadoutCost -= Value;

    // change loadout
    Loadout.Warranty[LIdx] = 0;

    // notify
    OnWeaponWarrantySold( LIdx, GWC );
    return True;
}

function bool Rebuy()
{
    local int i;
    local class<gWeapon> GWC;
    local gPlayer.sShopLoadout PrevLoadout;

    LoadoutCompress(LastLoadout);

    //Log( "ReBuy" );

    // if invalid manifest, abort
    if( LastLoadout.Manifest == None )
        return False;

    // notify
    OnRebuyBegin();

    // reset prediction
    LoadoutCost = -InventoryValue;

    // clear loadout
    PrevLoadout = Loadout;
    Loadout = default.Loadout;
    Loadout.ID = PrevLoadout.ID;
    Loadout.BonusMode = PrevLoadout.BonusMode;
    Loadout.PendingBonusMode = PrevLoadout.PendingBonusMode;

    // use last manifest
    Loadout.Manifest = LastLoadout.Manifest;
    WeaponManifest = Loadout.Manifest.static.GetWeaponClasses();

    // rebuy glove
    if( LastLoadout.Glove != None )
    {
        GloveBuy(LastLoadout.Glove, LastLoadout.GloveAmmo);
    }

    // rebuy weapons
    for( i=0; i!=ArrayCount(LastLoadout.Weapons); ++i )
    {
        GWC = LastLoadout.Weapons[i];
        if( GWC != None )
        {
            WeaponBuy(GWC, LastLoadout.Ammo[i], LastLoadout.Warranty[i] == 1, True);
        }
    }

    // notify
    OnRebuyEnd();

    return True;
}


// ============================================================================
//  Money Prediction
// ============================================================================

function PredictInventoryValue()
{
    local class<gWeapon> WC;
    local int i;

    for( i = 0; i != ArrayCount(Loadout.Weapons); ++i )
    {
        WC = Loadout.Weapons[i];

        if( WC != None )
        {
            //Log( "Loadout" @i @WC @Loadout.Ammo[i] @bWarranty );

            // Precache inventory value for cost prediction
            InventoryValue += GetWeaponCost(WC) * GetSellMultiplier();
            InventoryValue += GetAmmoCost(WC,Loadout.Ammo[i]) * GetSellMultiplier();

            if( Loadout.Warranty[i] == 1 )
                InventoryValue += GetWeaponWarrantyCost(WC) * GetSellMultiplier();
        }
    }

    if( class<gWeapon>(Loadout.Glove) != None )
    {
        if( Loadout.GloveAmmo > 0 )
        {
            InventoryValue += GetAmmoCost(class<gWeapon>(Loadout.Glove),Loadout.GloveAmmo) * GetSellMultiplier();
        }
    }
}

final function float GetSellMultiplier()
{
    return class'gShopInfo'.default.SellMultiplier;
}

final function float GetBuyMultiplier()
{
    return 1.0-GetSellMultiplier();
}

final function int GetMoneyPrediction()
{
    return GPRI.GetMoney() - LoadoutCost;
}

function CheckMoneyChange()
{
    local int NewMoney;

    NewMoney = GetMoneyPrediction();
    if( NewMoney != OldMoney )
    {
        OnMoneyChange( OldMoney, NewMoney );
        OldMoney = NewMoney;
    }
}

final function int GetDiscountIdx( class<gWeapon> GWC )
{
    local int DIdx;
    if( FindWeaponIndex( Inventory, GWC, DIdx ) )
        return DIdx;
    return -1;
}

protected function float GetWeaponValue( class<gWeapon> GWC, bool bWarranty, int DIdx )
{
    local float Value;

    Value = GetWeaponCost( GWC, bWarranty );
    if( DIdx != -1 )
    {
        Value -= GetWeaponCost( GWC, bWarranty && Inventory.Warranty[DIdx] == 1 ) * GetSellMultiplier();
    }
    return Value;
}

protected function bool CalcAmmoBuy
(   bool bFixedAmount
,   class<gWeapon> GWC
,   float CurrentAmount
,   out float NewAmount
,   out float NewCost
,   float ExtraCost
,   float DiscountAmmo )
{
    local int DiscountAmount;
    local float FixedAmount, BulletCost, DiscountCost;

    //Log( "CalcAmmoBuy" @GWC @CurrentAmount @NewAmount );

    // limit new amount to available free space
    FixedAmount = NewAmount;
    NewAmount = Max(0, GWC.static.StaticLimitNewAmmo(NewAmount, CurrentAmount));
    if( NewAmount > 0 )
    {
        BulletCost = GetBulletCost(GWC);

        // calc discount ammo cost & amount
        if( DiscountAmmo > 0 )
        {
            DiscountAmount = Clamp( DiscountAmmo - CurrentAmount, 0, NewAmount );
            if( DiscountAmount > 0 )
            {
                DiscountAmount = GetAffordableBullets(GWC, DiscountAmount, GPRI.GetMoney() - LoadoutCost, ExtraCost, 1.0 - GetSellMultiplier());
                DiscountCost = BulletCost * DiscountAmount * GetSellMultiplier();
                NewAmount -= DiscountAmount;
            }
        }

        // calc ammo cost & amount
        if( NewAmount > 0 )
        {
            NewAmount = GetAffordableBullets(GWC, NewAmount, GPRI.GetMoney() - LoadoutCost, ExtraCost + DiscountCost);
            NewCost = BulletCost * NewAmount;
        }
        else
        {
            NewCost = 0;
        }

        // calc cumulative ammo cost & amount
        NewAmount += DiscountAmount;
        NewCost += DiscountCost;

        // success only if can buy
        if( NewAmount > 0
        &&(!bFixedAmount || FixedAmount == NewAmount) )
        {
            return True;
        }
    }

    NewAmount = 0;
    NewCost = 0;
    return False;
}

protected function bool CalcAmmoSell( class<gWeapon> GWC, float NewAmount, out float CurrentAmount, out float Value, float DiscountAmmo )
{
    local int DiscountAmount;
    local float SellAmount, BulletCost;

    //Log( "CalcAmmoBuy" @GWC @NewAmount @NewAmount );

    Value = 0;

    if( NewAmount >= 0 && NewAmount < CurrentAmount )
    {
        BulletCost = GetBulletCost(GWC);
        SellAmount = CurrentAmount - NewAmount;

        // discount
        if( DiscountAmmo > 0 )
        {
            DiscountAmount = Clamp( DiscountAmmo - NewAmount, 0, SellAmount );
            if( DiscountAmount > 0 )
            {
                Value += BulletCost * DiscountAmount * GetSellMultiplier();
                SellAmount -= DiscountAmount;
            }
        }

        // normal
        if( SellAmount > 0 )
        {
            Value += BulletCost * SellAmount;
        }

        // update ammo amount
        CurrentAmount = NewAmount;
        return True;
    }

    return False;
}

function bool DoBuyWeapon( class<gWeapon> GWC, out float AmmoAmount, out float WeaponCost, float DiscountAmmo )
{
    local float AmmoCost, ExtraAmount, ExtraCost, InitialAmount, InitialCost;

    // if can't afford weapon, abort
    if( !CanAfford(GPRI.GetMoney() - LoadoutCost, WeaponCost) )
       return False;

    // calc ammo
    if( AmmoAmount > 0 )
    {
        // calc cost of initial ammo, must be able to buy
        InitialAmount = Min(AmmoAmount, GetInitialAmmo(GWC));
        if( !CalcAmmoBuy( True, GWC, 0, InitialAmount, InitialCost, WeaponCost, DiscountAmmo ) )
            return False;

        // calc cost of extra ammo
        if( AmmoAmount > InitialAmount )
        {
            ExtraAmount = AmmoAmount - InitialAmount;
            CalcAmmoBuy( False, GWC, InitialAmount, ExtraAmount, ExtraCost, WeaponCost + InitialCost, DiscountAmmo );
        }

        // calc cumulative ammo
        AmmoAmount = InitialAmount + ExtraAmount;
        AmmoCost = InitialCost + ExtraCost;
    }

    // update cost
    WeaponCost += AmmoCost;

    return True;
}


// ============================================================================
//  Loadout
// ============================================================================

final function int GetWeaponOffset( class<gWeapon> GWC )
{
    local int SIdx;
    SIdx = GetSlotOffset(Loadout);
    if( GWC.default.ItemSize <= GetInventorySpace() - SIdx )
        return SIdx;
    return -1;
}

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


final function bool HasLoadoutWarranty( int idx )
{
    return Loadout.Warranty[idx] == 1;
}

final function bool FindLoadoutWeaponIndex( class<gWeapon> WC, out int idx )
{
    return FindWeaponIndex(Loadout, WC, idx );
}

final function bool FindWeapon( gPlayer.sShopLoadout L, class<gWeapon> WC )
{
    local int i;
    return FindWeaponIndex( L, WC, i );
}

final function bool FindWeaponIndex( gPlayer.sShopLoadout L, class<gWeapon> WC, out int idx )
{
    for( idx=0; idx!=ArrayCount(L.Weapons); ++idx )
        if( L.Weapons[idx] == WC )
            return True;
    idx = -1;
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

final function class<gWeapon> GetLoadoutWeapon(int Idx)
{
    if( Idx >= 0 && Idx < ArrayCount(Loadout.Weapons) )
        return Loadout.Weapons[Idx];
    return None;
}

final function class<gWeapon> GetManifestWeapon(int Idx)
{
    if( Idx >= 0 && Idx < WeaponManifest.Length )
        return WeaponManifest[Idx];
    return None;
}

final function class<Weapon> GetManifestGlove(int Idx)
{
    if( Idx >= 0 && Idx < GloveManifest.Length )
        return GloveManifest[Idx];
    return None;
}

final function int GetManifestWeaponIdx( class<gWeapon> ItemClass )
{
    local int Idx;
    if( ItemClass != None )
        for( Idx=0; Idx<WeaponManifest.Length; ++Idx )
            if( WeaponManifest[Idx] == ItemClass )
                return Idx;
    return -1;
}

final function int GetManifestGloveIdx( class<Weapon> ItemClass )
{
    local int Idx;
    if( ItemClass != None )
        for( Idx=0; Idx<GloveManifest.Length; ++Idx )
            if( GloveManifest[Idx] == ItemClass )
                return Idx;
    return -1;
}


// ============================================================================
//  Accessors
// ============================================================================

static function bool CanAfford( float Money, float Cost, optional float ExtraCost ){
    return class'gShopInfo'.static.CanAfford(Money,Cost,ExtraCost);}

static final function int GetInitialAmmo( class<Weapon> WC ){
    return class'gShopInfo'.static.GetInitialAmmo(WC);}

static final function float GetInitialWeaponCost( class<gWeapon> WC, optional bool bWarranty ){
    return class'gShopInfo'.static.GetInitialWeaponCost(WC,bWarranty);}

static final function float GetWeaponCost( class<gWeapon> WC, optional bool bWarranty ){
    return class'gShopInfo'.static.GetWeaponCost(WC,bWarranty);}

static final function float GetWeaponWarrantyCost( class<gWeapon> WC ){
    return class'gShopInfo'.static.GetWeaponWarrantyCost(WC);}

static final function float GetAmmoCost( class<gWeapon> WC, int Amount ){
    return class'gShopInfo'.static.GetAmmoCost(WC,Amount);}

static final function float GetBulletCost( class<gWeapon> WC ){
    return class'gShopInfo'.static.GetBulletCost(WC);}

static final function float GetInitialAmmoCost( class<gWeapon> WC ){
    return class'gShopInfo'.static.GetInitialAmmoCost(WC);}

static final function float CalcAffordableAmmo( class<gWeapon> WC, out int Amount, int Money, optional int ExtraCost, optional float Discount ){
    return class'gShopInfo'.static.CalcAffordableAmmo(WC,Amount,Money,ExtraCost,Discount);}

static final function float GetAffordableClipAmmo( class<gWeapon> WC, int Amount, int Money, optional int ExtraCost, optional float Discount ){
    return class'gShopInfo'.static.GetAffordableClipAmmo(WC,Amount,Money,ExtraCost,Discount);}

static final function float GetAffordableBullets(class<gWeapon> WC, int Amount, int Money, optional int ExtraCost, optional float Discount){
    return class'gShopInfo'.static.GetAffordableBullets(WC,Amount,Money,ExtraCost,Discount);}

static final function bool IsItemIgnored(class<Inventory> Inv){
    return class'gShopInfo'.static.IsItemIgnored(Inv);}

static final function int GetInventorySpace(){
    return class'gPawnInventory'.default.InventorySpace;}





// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

}