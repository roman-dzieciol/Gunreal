// ============================================================================
//  gPawnInventory.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
#exec obj load file=G_Sounds.uax

class gPawnInventory extends gObject
    within gPawn
    config(User);

var bool bFilterUTWeapons;

var() int                   InventorySpace;

var() config bool           bFastWeaponSwitch;

var() Sound                 WeaponSwapSound;

simulated function Free()
{
    //gLog( "Free" );

    ClearOuter();
}


function bool AddInventory(Inventory NewItem)
{
    local Inventory Inv, LastOther, LastSlotted, DefaultWeapon;
    local Actor Holder;
    local string DefaultWeaponName;

    // get default weapon class
    DefaultWeaponName = Caps(RequiredEquipment[0]);

    //gLog("AddInventory" #NewItem #Inventory #Weapon #PendingWeapon);

    // The item should not have been destroyed if we get here.
    if( NewItem == None )
        gLog("Tried to add none inventory to" #Outer);

    // Skip if won't fit
    if( NewItem != None && !WillWeaponFit(class<gWeapon>(NewItem.class)) )
        return False;

    Holder = Outer;
    NewItem.SetOwner(Outer);
    NewItem.NetUpdateTime = Level.TimeSeconds - 1;

    // New items are added after last item of the same category
    // The categories are: Slotted, Default, Other

    // find last in each category
    for( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
    {
        // abort if already added
        if( Inv == NewItem )
            return False;

        // categorize
        if( DefaultWeapon == None && Caps(Inv.class) == DefaultWeaponName )
            DefaultWeapon = Inv;
        else if( gWeapon(Inv) != None && gWeapon(Inv).ItemSize > 0 )
            LastSlotted = Inv;
        else
            LastOther = Inv;
    }

    // find place in inventory chain
    if( gWeapon(NewItem) != None && gWeapon(NewItem).ItemSize > 0 )
    {
        // Slotted
        if( LastSlotted != None )
            Holder = LastSlotted;
    }
    else if( Caps(NewItem.class) == DefaultWeaponName )
    {
        // Default
        if( DefaultWeapon != None )
            Holder = DefaultWeapon;
        else if( LastSlotted != None )
            Holder = LastSlotted;
    }
    else
    {
        // Other
        if( LastOther != None )
            Holder = LastOther;
        else if( DefaultWeapon != None )
            Holder = DefaultWeapon;
        else if( LastSlotted != None )
            Holder = LastSlotted;
    }

    // Add to inventory chain
    NewItem.Inventory = Holder.Inventory;
    Holder.Inventory = NewItem;
    Holder.NetUpdateTime = Level.TimeSeconds - 1;

    if( Controller != None )
        Controller.NotifyAddInventory(NewItem);

    return True;
}

function bool WillWeaponFit(class<gWeapon> WeaponClass)
{
    local Inventory Inv;
    local gWeapon W;
    local int Count, SpaceUsed;

    if( WeaponClass == None || WeaponClass.default.ItemSize <= 1 )
        return True;

    for( Inv = Inventory; Inv != None && ++Count < 100; Inv = Inv.Inventory )
    {
        W = gWeapon(Inv);
        if( W != None && W.class != WeaponClass )
        {
            SpaceUsed += W.ItemSize;
        }
    }

    if( SpaceUsed + WeaponClass.default.ItemSize > InventorySpace )
        return False;

    return True;
}

simulated function PrevWeapon()
{
    local Weapon CurWeapon;

    //gLog( "PrevWeapon" #Weapon #PendingWeapon );

    if( Level.Pauser != None )
        return;

    if( gZoomingWeapon(Weapon) != None && gPlayer(Controller) != None )
    {
        if( gZoomingWeapon(Weapon).CanAdjustZoom(-1) )
            return;
    }

    if( Weapon == None && Controller != None )
    {
        Controller.SwitchToBestWeapon();
        return;
    }


    if( PendingWeapon != None && PendingWeapon.bForceSwitch )
    {
        SelectedWeapon = None;
        return;
    }

    CurWeapon = SelectedWeapon;

    if( CurWeapon == None )
    {
        CurWeapon = PendingWeapon;
        if( CurWeapon == None )
        {
            CurWeapon = Weapon;
        }
    }

    if( CurWeapon != None )
    {
        CurWeapon = GetPrevGunrealWeapon(CurWeapon);
        if( CurWeapon != None )
        {
            SelectedWeapon = CurWeapon;
            DisplaySelectedWeapon();
            if( default.bFastWeaponSwitch )
                SwitchToSelected();
        }
        return;
    }
    else
    {
        PrevUTWeapon();
        return;
    }

    if( PendingWeapon != None )
    {
        Weapon.PutDown();
    }
}

/* NextWeapon()
- switch to next inventory group weapon
*/
simulated function NextWeapon()
{
    local Weapon CurWeapon;

    //gLog( "NextWeapon" #Weapon #PendingWeapon );

    if( Level.Pauser != None )
        return;

    if( gZoomingWeapon(Weapon) != None && gPlayer(Controller) != None )
    {
        if( gZoomingWeapon(Weapon).CanAdjustZoom(1) )
            return;
    }

    if( Weapon == None && Controller != None )
    {
        Controller.SwitchToBestWeapon();
        return;
    }

    if( PendingWeapon != None && PendingWeapon.bForceSwitch )
    {
        SelectedWeapon = None;
        return;
    }

    CurWeapon = SelectedWeapon;

    if( CurWeapon == None )
    {
        CurWeapon = PendingWeapon;

        if( CurWeapon == None )
        {
            CurWeapon = Weapon;
        }
    }

    if( CurWeapon != None )
    {
        CurWeapon = GetNextGunrealWeapon(CurWeapon);
        if( CurWeapon != None )
        {
            SelectedWeapon = CurWeapon;
            DisplaySelectedWeapon();
            if( default.bFastWeaponSwitch )
                SwitchToSelected();
        }

        return;
    }
    else
    {
        NextUTWeapon();
        return;
    }

    if( PendingWeapon != None )
        Weapon.PutDown();
}

function AddDefaultInventory()
{
    local int i;

    //gLog( "AddDefaultInventory" #Weapon #PendingWeapon #Inventory );

    for( i=0; i<16; i++ )
        if( RequiredEquipment[i] != "" )
            CreateInventory(RequiredEquipment[i]);

    for( i=0; i<16; i++ )
        if( SelectedEquipment[i] == 1 && OptionalEquipment[i] != "" )
            CreateInventory(OptionalEquipment[i]);

    bFilterUTWeapons = True;
    Level.Game.AddGameSpecificInventory(Outer);
    bFilterUTWeapons = False;

    if( Controller != None && ShopInfo != None )
    {
        ShopInfo.PawnSpawned();
    }

    // HACK FIXME
    if( inventory != None )
        inventory.OwnerEvent('LoadOut');

    // Find the default gunreal weapon on server and set it on client
    SwitchToGunrealWeapon();
}

function CreateInventory(string InventoryClassName)
{
    local Inventory Inv;
    local class<Inventory> InventoryClass;

    InventoryClass = Level.Game.BaseMutator.GetInventoryClass(InventoryClassName);

    // filter out UT2K4 Weapons
    if( bFilterUTWeapons
    &&  class<Weapon>(InventoryClass) != None
    &&  InventoryClass.outer.name == 'xWeapons'
    &&  class<SuperShockRifle>(InventoryClass) == None
    &&  class<Redeemer>(InventoryClass) == None
    &&  class<Painter>(InventoryClass) == None
    &&  class<BallLauncher>(InventoryClass) == None )
        return;

    if( InventoryClass != None && FindInventoryType(InventoryClass) == None )
    {
        Inv = Spawn(InventoryClass);
        if( Inv != None )
        {
            Inv.GiveTo(Outer);
            if( Inv != None )
                Inv.PickupFunction(Outer);
        }
    }
}

simulated function SwitchToWeapon(Weapon W)
{
    //gLog( "ClientSwitchToWeapon" #GON(W) #GON(Weapon) #GON(PendingWeapon) #GON(Inventory) #GON(Controller) );

    PendingWeapon = W;

    if( Controller != None )
        Controller.StopFiring();

    if( Weapon == None )
    {
        ChangedWeapon();
    }
    else if( Weapon != PendingWeapon )
    {
        Weapon.PutDown();
    }
}

simulated function SwitchToGunrealWeapon()
{
    local Inventory Inv;
    local gWeapon Best;
    local int Count;

    //gLog( "SwitchToGunrealWeapon" #GON(Weapon) #GON(PendingWeapon) #GON(Inventory) #GON(Controller) );

    if( Inventory != None && Controller != None )
    {
        for( Inv=Inventory; Inv!=None && ++Count<100; Inv=Inv.Inventory )
        {
            if( gWeapon(Inv) != None )
            {
                if( Best == None || (Best.ItemSize <= 0 && gWeapon(Inv).ItemSize > 0) )
                {
                    Best = gWeapon(Inv);
                }
            }
        }

        //gLog( "SwitchToGunrealWeapon - Best" #GON(Best) );

        if( Best == None )
        {
            Controller.ClientSwitchToBestWeapon();
            return;
        }

        ClientSwitchToWeapon(Best);
    }
}

simulated function Weapon GetNextGunrealWeapon(Weapon Current)
{
    local Inventory Inv;
    local int Count;

    if( Current != None )
        Inv = Current.Inventory;

    do
    {
        if( Inv != None )
        {
            if( Weapon(Inv) != None )
                return Weapon(Inv);

            Inv = Inv.Inventory;
        }
        else
        {
            Inv = Inventory;
        }

        if( ++Count > 100 )
        {
            Warn( "Runaway loop" #GON(Current) );
            break;
        }
    }
    until( Inv == Current )

    return Current;
}

simulated function Weapon GetPrevGunrealWeapon(Weapon Current)
{
    local Inventory Inv;
    local Weapon GW;
    local int Count;

    for( Inv=Inventory; Inv!=None; Inv=Inv.Inventory )
    {
        if( Inv == Current )
        {
            if( GW != None )
                break;
        }
        else
        {
            if( Weapon(Inv) != None )
                GW = Weapon(Inv);
        }

        if( ++Count > 100 )
        {
            Warn( "Runaway loop" #GON(Current) );
            break;
        }
    }

    // GW is either Weapon before Inv==Current, Weapon before Inv==None or None
    if( GW != None )
        return GW;
    else
        return Current;
}

simulated function array<gWeapon> GetGunrealWeapons()
{
    local gWeapon GW;
    local array<gWeapon> Weapons;
    local Inventory Inv;
    local int Count;

    for( Inv=Inventory; Inv!=None && ++Count < 100; Inv=Inv.Inventory )
    {
        GW = gWeapon( Inv );
        if( GW != None )
        {
            Weapons[Weapons.Length] = GW;
        }
    }

    return Weapons;
}

simulated function DisplaySelectedWeapon()
{
    local gPlayer PC;
    local HUDBase HUD;

    if( SelectedWeapon == None )
        return;

    PC = gPlayer(Level.GetLocalPlayerController());

    if( PC != None )
    {
        HUD = HUDBase(PC.myHUD);

        if( HUD != None )
        {
            HUD.WeaponDrawTimer = Level.TimeSeconds + 1.5;
            HUD.WeaponDrawColor = SelectedWeapon.HudColor;
            HUD.LastWeaponName = SelectedWeapon.GetHumanReadableName();
        }
    }
}

simulated function SwitchWeapon(byte F)
{
    local int Count, idx;
    local Weapon W, NewWeapon;
    local Inventory Inv, Last;

    //gLog("SwitchWeapon" #F #GON(SelectedWeapon) #GON(PendingWeapon) #GON(Weapon) );

    if( Level.Pauser != None || Inventory == None )
        return;

    // select Gunreal weapon
    if( F > 0 && F < 9 )
    {
        // find belt weapon
        if( F <= 2 )
        {
            for( Inv=Inventory; Inv!=None && ++Count < 100; Inv=Inv.Inventory )
            {
                if( class'gWeapon'.static.IsGunrealWeapon(Inv.class )
                && (gWeapon(Inv) == None || gWeapon(Inv).ItemSize == 0)
                && ++idx == F)
                    break;
            }
        }

        // find slotted weapon
        else if( F > 2 )
        {
            F -= 2;
            for( Inv=Inventory; Inv!=None && ++Count < 100; Inv=Inv.Inventory )
            {
                if( gWeapon(Inv) != None && gWeapon(Inv).ItemSize > 0 )
                {
                    Last = Inv;
                    if( ++idx == F )
                        break;
                }
            }
            Inv = Last;
        }

        // select weapon
        if( Weapon(Inv) != None && Count < 100 )
        {
            SelectedWeapon = Weapon(Inv);
            DisplaySelectedWeapon();
            SwitchToSelected();
        }
        return;
    }

    // select next non-super UT weapon
    else if( F == 9 )
    {
        SelectedWeapon = None;
        Last = Weapon;

        if( Last != None )
            Inv = Last.Inventory;

        do
        {
            if( Inv != None )
            {
                W = Weapon( Inv );
                if( W != None
                    &&  gWeapon(W) == None
                    &&  W.InventoryGroup != 0
                    &&  W.InventoryGroup != 10
                    &&  W.HasAmmo() )
                {
                    NewWeapon = W.WeaponChange(W.InventoryGroup, False);
                    if( NewWeapon != None )
                        break;
                }

                Inv = Inv.Inventory;
            }
            else
                Inv = Inventory;

            if( ++Count > 100 )
            {
                Warn( "Runaway loop" #F );
                break;
            }
        }
        until( Inv == Last )
    }

    // select next UT super weapon
    else if( F == 0 )
    {
        SelectedWeapon = None;
        Last = Weapon;

        if( Last != None )
            Inv = Last.Inventory;

        do
        {
            if( Inv != None )
            {
                W = Weapon( Inv );

                if( W != None
                    &&  gWeapon(W) == None
                    &&  W.InventoryGroup == 0
                    &&  W.HasAmmo() )
                {
                    NewWeapon = W.WeaponChange(W.InventoryGroup, False);
                    if( NewWeapon != None )
                        break;
                }

                Inv = Inv.Inventory;
            }
            else
            {
                Inv = Inventory;
            }

            if( ++Count > 100 )
            {
                Warn( "Runaway loop" #F );
                break;
            }
        }
        until( Inv == Last )
    }
    else
    {
        SwitchUTWeapon(F);
        return;
    }

    if( NewWeapon == None )
        NewWeapon = Inventory.WeaponChange(F, True);

    if( NewWeapon == None )
        return;

    if( PendingWeapon != None && PendingWeapon.bForceSwitch )
        return;

    if( Weapon == None )
    {
        PendingWeapon = NewWeapon;
        ChangedWeapon();
    }
    else if( Weapon != NewWeapon || PendingWeapon != None )
    {
        PendingWeapon = NewWeapon;
        Weapon.PutDown();
    }
    else if( Weapon == newWeapon )
    {
        Weapon.Reselect();
    }
}

function SwitchToSelected()
{
    //gLog("SwitchToSelected" #GON(SelectedWeapon) #GON(PendingWeapon) #GON(Weapon) );

    if( SelectedWeapon == None )
        return;

    if( PendingWeapon != None && PendingWeapon.bForceSwitch )
    {
        SelectedWeapon = None;
        return;
    }

    SelectedWeapon = SelectedWeapon.WeaponChange(SelectedWeapon.InventoryGroup, False);

    if( Weapon == None )
    {
        PendingWeapon = SelectedWeapon;
        ChangedWeapon();
    }
    else if( Weapon != SelectedWeapon || PendingWeapon != None )
    {
        PendingWeapon = SelectedWeapon;
        Weapon.PutDown();
    }
    else if( Weapon == SelectedWeapon )
    {
        Weapon.Reselect();
    }

    SelectedWeapon = None;
}

function TossWeapon(vector TossVel)
{
    local vector X,Y,Z;

    GetAxes(Rotation,X,Y,Z);

    if( SelectedWeapon != None )
    {
        SelectedWeapon.Velocity = TossVel;
        SelectedWeapon.DropFrom(Location + 0.8 * CollisionRadius * X - 0.5 * CollisionRadius * Y);
    }
    else if( Weapon != None )
    {
        Weapon.Velocity = TossVel;
        Weapon.DropFrom(Location + 0.8 * CollisionRadius * X - 0.5 * CollisionRadius * Y);
    }
}

function ThrowWeapon()
{
    local vector X,Y,Z, TossVel, TossLoc;
    local gWeaponPickup P;
    local array<gWeaponPickup> WantedPickups;
    local array<gWeapon> ThrowableWeapons;
    local int i, Count, PickupSpace, FreeSpace;
    local Inventory Inv;
    local Weapon PickupWeapon;
    local bool bPickedUpOwned;

    if( !Level.Game.bAllowWeaponThrowing )
        return;

    // Create list of interesting touching pickups before the weapon is thrown
    foreach TouchingActors(class'gWeaponPickup', P)
    {
        if( class<gWeapon>(P.InventoryType) != None && class<gWeapon>(P.InventoryType).default.ItemSize > 1 )
        {
            Count = 0;
            PickupWeapon = None;
            for( Inv=Inventory; Inv!=None && ++Count < 100; Inv=Inv.Inventory )
            {
                if( Inv.class == P.InventoryType )
                {
                    PickupWeapon = Weapon(Inv);
                    break;
                }
            }

            if( PickupWeapon == None )
            {
                PickupSpace += class<gWeapon>(P.InventoryType).default.ItemSize;
                WantedPickups[WantedPickups.Length] = P;
            }
            else
            {
                P.UsedBy(Outer);
                bPickedUpOwned = True;
                SelectedWeapon = PickupWeapon;
            }
        }
    }

    if( WantedPickups.Length == 0 && bPickedUpOwned )
    {
        SwitchToSelected();
        return;
    }

    // calc toss params
    GetAxes(Rotation,X,Y,Z);
    TossVel = vector(GetViewRotation()) * ((Velocity Dot vector(GetViewRotation())) + 500) + Vect(0, 0, 250);
    TossLoc = Location + 0.8 * CollisionRadius * X - 0.5 * CollisionRadius * Y;

    // toss selected or current weapon
    if( IsGWeaponThrowable( gWeapon(SelectedWeapon) ) && gWeapon(SelectedWeapon).CanThrow() )
        FreeSpace = TossGunrealWeapon( gWeapon(SelectedWeapon), TossVel, TossLoc );
    else if( IsGWeaponThrowable( gWeapon(Weapon) ) && gWeapon(Weapon).CanThrow() )
        FreeSpace = TossGunrealWeapon( gWeapon(Weapon), TossVel, TossLoc );

    // if we need to throw more weapons to make space for pickups
    if( PickupSpace > FreeSpace )
    {
        // enumerate other throwable weapons, sorting from smallest
        FreeSpace = InventorySpace;
        Count = 0;
        for( Inv=Inventory; Inv!=None && ++Count < 100; Inv=Inv.Inventory )
        {
            if( IsGWeaponThrowable(gWeapon(Inv)) )
            {
                FreeSpace -= gWeapon(Inv).ItemSize;
                if( gWeapon(Inv).CanThrow() )
                {
                    for( i=0; i!=ThrowableWeapons.Length; ++i )
                        if( ThrowableWeapons[i].ItemSize > gWeapon(Inv).ItemSize )
                            break;
                    ThrowableWeapons.insert(i,1);
                    ThrowableWeapons[i] = gWeapon(Inv);
                }
            }
        }

        // toss more weapons
        for( i=0; i!=ThrowableWeapons.Length && PickupSpace > FreeSpace; ++i )
            FreeSpace += TossGunrealWeapon( ThrowableWeapons[i], TossVel - Y*(100.0+250.0*FRand()), TossLoc );
    }

    // try to pickup gunreal weapons
    if( WantedPickups.Length > 0 )
    {
        PlaySound(WeaponSwapSound, SLOT_None, 2.0);
        for( i=0; i!=WantedPickups.Length; ++i )
            WantedPickups[i].UsedBy(Outer);
    }

    ClientSwitchToGunrealWeapon();
}

final function bool IsGWeaponThrowable( gWeapon GW )
{
    return GW != None && GW.ItemSize > 1;
}

function int TossGunrealWeapon( gWeapon GW, vector TossVel, vector TossLoc )
{
    local int size;
    size = GW.ItemSize;
    GW.Velocity = TossVel;
    GW.DropFrom(TossLoc);
    return size;
}

DefaultProperties
{
    InventorySpace                      = 8
    bFastWeaponSwitch                   = True
    WeaponSwapSound                     = sound'G_Sounds.wep_swap_1'

}
