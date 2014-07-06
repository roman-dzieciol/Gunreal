// ============================================================================
//  gShopMenu.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopMenu extends gShopWindow;

var   automated     GUIButton                   b_ViewArea;
var   automated     GUIScrollTextBox            lb_Desc;

var   automated     GUIMultiOptionListBox       lb_Weapons;
var                 GUIMultiOptionList          li_Weapons;
var()               float                       ItemScaling;

var   automated     GUIButton                   b_OK;
var   automated     GUIButton                   b_Cancel;
var   automated     GUIButton                   b_Rebuy;

var   automated     GUILabel                    l_Loading;

var   automated     GUIImage                    i_WeaponBG;
var   automated     GUIImage                    i_DescBG;

var   automated     array<GUICheckBoxButton>    b_Bonuses;

var   automated     GUIButton                   b_Help;
var   automated     GUIButton                   b_Options;
var   automated     GUIButton                   b_Give;

var                 GUICheckBoxButton           b_Preview;
var                 GUICheckBoxButton           BonusCurrent;
var                 GUICheckBoxButton           BonusPending;

var                 gShopItem                   ShopItem;
var                 float                       SpinYaw;
var()               float                       SpinSpeed;

var                 array<gGUISlotImage>        Slots;
var                 array<gGUIImageButton>      LoadoutIcons;
var                 array<gGUISlotImage>        PreviewSlots;
var                 gGUISlotImage               SpecialSlot;
var                 gGUIGloveIcon               SpecialIcon;

var                 array<gGUISlotImage>        GloveSlots;
var                 array<gGUIGloveIcon>        GloveIcons;

var() localized     string                      WeaponItemHint;
var() localized     string                      WeaponIconHint;
var() localized     string                      BonusPreviewhint;

var                 bool                        bShopNotified;
var                 int                         ShopID;

var                 string                      HelpMenu;
var                 string                      GiveMenu;
var                 string                      OptionsMenu;

var()               Sound                       DoneSound;
var()               Sound                       WeaponBuySound;
var()               Sound                       WeaponSellSound;
var()               Sound                       AmmoBuySound;
var()               Sound                       DenySound;
var()               Sound                       DebtSound;
var()               Sound                       WarrantyBuySound;
var()               Sound                       WarrantyRefundSound;
var()               Sound                       ReleaseSound;

var()               Material                    PendingBonusMaterial;

var                 gShopClientMenu             Shop;

var					GUIImage					i_HealthBar;
var					color						HealthBarColor;
var					color						HealthBarColorDamaged;

// ============================================================================
//  Lifespan
// ============================================================================
function bool AllowOpen(string MenuClass)
{
    // Don't allow multiple instances of this menu
    if( MenuClass ~= "GMenu.gShopMenu" )
        return False;
    return True;
}

function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
    local gPlayer PC;

    Super.InitComponent(MyController, MyComponent);

    PC = gPlayer(PlayerOwner());

    // setup exit button
    b_ExitButton.SetHint(b_Cancel.Hint);
    b_ExitButton.OnClickSound = CS_None;

    // Spawn 3D weapon
    if( ShopItem == None )
        ShopItem = PC.Spawn(class'gShopItem', None);

    // make scrollbars fixed size
    lb_Desc.MyScrollBar.WinWidth = 16;
    lb_Weapons.MyScrollBar.WinWidth = 16;

    // Hide controls
    SetLoading(True);
}

event HandleParameters(string Param1, string Param2)
{
    local gPlayer PC;

    PC = gPlayer(PlayerOwner());
    ShopID = int(Param1);

    if( !InitShop(PC) )
    {
        Controller.CloseMenu(False);
        return;
    }

    PC.OnShopCloseMenu = OnShopCloseMenu;
}

event Free()
{
    local gPlayer PC;

    PC = gPlayer(PlayerOwner());
    if( PC != None )
    {
        PC.OnShopCloseMenu = None;
        if( !bShopNotified )
            PC.ReplicateShopMenuCancelled(ShopID);
    }

    if( ShopItem != None )
    {
        ShopItem.Destroy();
        ShopItem = None;
    }

    if( Shop != None )
        Shop.Free();
    Shop = None;

    Super.Free();
}

event bool NotifyLevelChange()
{
    local gPlayer PC;

    PC = gPlayer(PlayerOwner());

    if( PC != None )
    {
        PC.OnShopCloseMenu = None;
    }

    bPersistent = False;

    return Super.NotifyLevelChange();
}


function AddSystemMenu()
{
	Super.AddSystemMenu();

	i_HealthBar = GUIImage(t_WindowTitle.AddComponent( "XInterface.GUIImage" ));
	i_HealthBar.Image = texture'Engine.WhiteTexture';
	i_HealthBar.FocusInstead = t_WindowTitle;
	i_HealthBar.RenderWeight = 1;
	i_HealthBar.bScaleToParent = false;
	i_HealthBar.OnRender = HealthBarRender;
}

function HealthBarRender(Canvas C)
{
	local float X,Y,W,H;
	local float ML,MR,MT,MB;
	local float Alpha;
	
    if( !bVisible )
        return;
		
	ML = t_WindowTitle.ActualWidth() * (0.0575+0.0375) + 2;
	MR = 24;
	MT = 5;
	MB = 5;
		
    X = t_WindowTitle.ActualLeft() + ML;
    Y = t_WindowTitle.ActualTop() + MT;
    W = t_WindowTitle.ActualWidth() - ML - MR;
    H = t_WindowTitle.ActualHeight() - MT - MB;
    
    Alpha = GetHealthBarAlpha();

	if( Alpha > 0.25 )
	{
    	C.DrawColor = HealthBarColor;
    }
    else
    {
    	C.DrawColor = HealthBarColorDamaged;
    }
    
    C.Style = 5;
    C.SetPos(X,Y);
	C.DrawTile(texture'Engine.WhiteTexture', Alpha*W, H, 0,0,1,1 );
}

function float GetHealthBarAlpha()
{
    local gPlayer PC;
    local gTerminal T;

    PC = gPlayer(PlayerOwner());
    if( PC != None && PC.Pawn != None )
    {
    	foreach PC.Pawn.CollidingActors(class'gTerminal',T,256)
    	{
			return FClamp(T.GetSmoothHealth() / float(T.MaxHealth), 0, 1);
    	}
    }
    
	return 1.0;
}

// ============================================================================
//  Shop Delegates
// ============================================================================

function OnShop_InitBegin()
{
    local gGUISlotImage img;
    local int i;

    // create special slot
    img = CreateSlotImage();
    img.WinLeft = 0.02;
    img.WinTop = 0.7175;
    img.WinWidth = (1.0 - b_Bonuses[0].WinWidth - 0.04) / float(Shop.GetInventorySpace() + 1);
    img.WinHeight = img.WinWidth / 0.75;
    AppendComponent(img, True);
    SpecialSlot = img;

    // Create bonus preview
    b_Preview = new(None) class'GUICheckBoxButton'; // Free() in GUIMultiComponent.Free()
    b_Preview.WinWidth = 0.0375;
    b_Preview.WinHeight = 0.1;
    b_Preview.WinLeft = SpecialSlot.WinLeft + SpecialSlot.WinWidth;
    b_Preview.WinTop = SpecialSlot.WinTop + (SpecialSlot.WinHeight-b_Preview.WinHeight)*0.5;
    b_Preview.bBoundToParent = True;
    b_Preview.bScaleToParent = True;
    b_Preview.Hint = BonusPreviewHint;
    b_Preview.bAcceptsInput = False;
    b_Preview.bNeverFocus = True;
    AppendComponent(b_Preview, True);

    // create slot images
    for( i = 0; i != Shop.GetInventorySpace(); ++i )
    {
        img = CreateSlotImage();
        img.WinWidth = (1.0-b_Bonuses[0].WinWidth-0.04)/float((Shop.GetInventorySpace()+1));
        img.WinHeight = img.WinWidth / 0.75;
        img.WinTop = 0.7175;
        img.WinLeft = 0.02 + (img.WinWidth + b_Bonuses[0].WinWidth) + i * (img.WinWidth);

        AppendComponent(img, True);
        Slots[Slots.Length] = img;
    }
}

function OnShop_InitEnd()
{
    // Show controls
    SetLoading(False);
}

function OnShop_MoneyChange( int OldAmout, int NewAmount )
{
    local gWeaponListButtonOption com;
    local int i;

    for( i=0; i<li_Weapons.Elements.Length; i++ )
    {
        com = gWeaponListButtonOption(li_Weapons.GetItem(i));
        com.Money = NewAmount;
    }
}


// ============================================================================
//  Shop Delegates - Glove
// ============================================================================

function OnShop_ManifestGloveInit( int MIdx, class<Weapon> WC )
{
    local gGUISlotImage img;
    local gGUIGloveIcon icon;

    // slot
    img = CreateSlotImage();
    img.SetPosition( SpecialSlot.WinLeft, (SpecialSlot.WinTop - ((MIdx+1) * SpecialSlot.WinHeight)), SpecialSlot.WinWidth, SpecialSlot.WinHeight );
    AppendComponent( img, True );
    GloveSlots[GloveSlots.Length] = img;
    gHide( img );

    // icon
    icon = CreateGloveIcon( MIdx, WC );
    icon.AddSlot( GloveSlots[MIdx] );
    AppendComponent(icon, True);
    GloveIcons[GloveIcons.Length] = icon;
    gHide( icon );

    if( class<gWeapon>(WC) != None )
    {
        icon.Cost = Shop.GetAmmoCost( class<gWeapon>(WC), 1 );
    }
}

function OnShop_GloveInit( int MIdx, class<Weapon> WC, int Ammo )
{
    // create special icon
    SpecialIcon = CreateSpecialIcon( MIdx, WC );
    SpecialIcon.AddSlot(SpecialSlot);
    SpecialIcon.Ammo = Ammo;
    AppendComponent(SpecialIcon, True);
}

function OnShop_GloveBought( int MIdx, class<Weapon> WC, int Ammo, bool bDebt )
{
    // update icon
    SpecialIcon.InitFromGlove( MIdx, WC );
    SpecialIcon.Ammo = Ammo;

    // play buy sound
    if( bDebt )
        PlayerOwner().ClientPlaySound(DebtSound,,, SLOT_Interface);
    else
        PlayerOwner().ClientPlaySound(WeaponBuySound,,, SLOT_Interface);
}

function OnShop_GloveSold( int MIdx, class<Weapon> WC )
{
    SpecialIcon.Cost = 0;
    SpecialIcon.Ammo = 0;
    SpecialIcon.Image = None;
    SpecialIcon.FocusImage = None;
    SpecialIcon.Tag = -1;
}


// ============================================================================
//  Shop Delegates - Weapon
// ============================================================================

function OnShop_ManifestWeaponInit( int MIdx, class<gWeapon> GWC )
{
    local gWeaponListButtonOption btn;

    btn = new(None) class'gWeaponListButtonOption'; // TODO: use string in AddItem instead?
    btn.Tag = MIdx;
    btn.WeaponName = GWC.default.ItemName;
    btn.AmmoPrice = GWC.default.CostAmmo;
    btn.WeaponPrice = Shop.GetInitialWeaponCost(GWC);
    li_Weapons.AddItem("", btn);

    btn.SetHint(WeaponItemHint);
    btn.MyComponent.OnClick = OnClick_WeaponListButton;
    btn.MyComponent.OnRightClick = OnRightClick_WeaponListButton;
    btn.MyComponent.bRequireReleaseClick = True;
    btn.MyComponent.Tag = MIdx;
    btn.MyLabel.Tag = MIdx;
}

function OnShop_WeaponInit( int MIdx, int SIdx, class<gWeapon> GWC, int Ammo, byte bWarranty )
{
    // create icon
    CreateWeaponIcon( MIdx, SIdx, GWC, bWarranty, Ammo );
    gWeaponListButtonOption( li_Weapons.GetItem(MIdx) ).bHasWeapon = True;
}

function OnShop_WeaponAmmoBought( int LIdx, class<gWeapon> GWC, int Ammo, bool bDebt, bool bQuiet )
{
    if( !bQuiet )
    {
        // play buy sound
        if( bDebt )
            PlayerOwner().ClientPlaySound(DebtSound,,, SLOT_Interface);
        else
            PlayerOwner().ClientPlaySound(AmmoBuySound,,, SLOT_None);
    }

    // update icon
    LoadoutIcons[LIdx].Ammo = Ammo;
}

function OnShop_WeaponWarrantySold( int LIdx, class<gWeapon> GWC )
{
    // play warranty sound
    PlayerOwner().ClientPlaySound(WarrantyRefundSound,,, SLOT_None);

    // update icon
    LoadoutIcons[LIdx].bWarranty = 0;
}

function OnShop_WeaponSold( int MIdx, int LIdx, class<gWeapon> GWC )
{
    // remove icon
    RemoveWeaponIcon( MIdx, LIdx, GWC );
    PlayerOwner().ClientPlaySound(WeaponSellSound,,, SLOT_None);
    gWeaponListButtonOption( li_Weapons.GetItem(MIdx) ).bHasWeapon = False;
}

function OnShop_WeaponBought( int MIdx, int LIdx, int SIdx, class<gWeapon> GWC, int Ammo, byte bWarranty, bool bDebt, bool bQuiet )
{
    //Log( "OnShop_WeaponBought" @MIdx @LIdx @SIdx @GWC @Ammo @bWarranty @bDebt @bQuiet );

    if( !bQuiet )
    {
        // play buy sound
        if( bDebt )
            PlayerOwner().ClientPlaySound(DebtSound,,, SLOT_None);
        else
            PlayerOwner().ClientPlaySound(WeaponBuySound,,, SLOT_None);

        // play warranty sound
        if( bWarranty != 0 )
            PlayerOwner().ClientPlaySound(WarrantyBuySound,,, SLOT_None);
    }

    // create icon
    CreateWeaponIcon( MIdx, SIdx, GWC, bWarranty, Ammo) ;
    gWeaponListButtonOption( li_Weapons.GetItem(MIdx) ).bHasWeapon = True;
}

function OnShop_GloveAmmoBought( class<Weapon> WC, int Ammo, bool bDebt )
{
    if( bDebt )
        PlayerOwner().ClientPlaySound(DebtSound,,, SLOT_None);
    else
        PlayerOwner().ClientPlaySound(AmmoBuySound,,, SLOT_None);

    SpecialIcon.Ammo = Ammo;
}

function OnShop_RebuyBegin()
{
    local int i;

    // clear links
    for( i = 0; i != li_Weapons.Elements.Length; ++i )
    {
        moButton(li_Weapons.Elements[i]).MyButton.OnActivate = None;
        moButton(li_Weapons.Elements[i]).MyButton.OnDeActivate = None;
    }

    // destroy icons
    for( i = 0; i != LoadoutIcons.Length; ++i )
    {
        RemoveComponent(LoadoutIcons[i]);
        LoadoutIcons[i].Free();
    }
    LoadoutIcons.Length = 0;
}


// ============================================================================
//  Shop Delegates - Bonus
// ============================================================================

function OnShop_BonusInit( gMutator.EBonusMode Mode, gMutator.EBonusMode PendingMode )
{
    local GUICheckBoxButton bonus;

    //Log( "OnShop_BonusInit" @Mode @PendingMode );

    // Update bonus mode controls
    bonus = b_Bonuses[Mode];
    b_Preview.CheckedOverlay[0] = bonus.CheckedOverlay[0];
    b_Preview.CheckedOverlay[1] = bonus.CheckedOverlay[1];
    b_Preview.CheckedOverlay[2] = bonus.CheckedOverlay[2];
    b_Preview.CheckedOverlay[3] = bonus.CheckedOverlay[3];
    b_Preview.CheckedOverlay[4] = bonus.CheckedOverlay[4];
    b_Preview.Style = bonus.Style;
    b_Preview.Hint = bonus.Hint;

    OnShop_BonusUpdate(Mode, PendingMode);
}

function OnShop_BonusUpdate( gMutator.EBonusMode Mode, gMutator.EBonusMode PendingMode )
{
    local int i;

    //Log( "OnShop_BonusUpdate" @Mode @PendingMode );

    // clear
    for( i=0; i<b_Bonuses.Length; ++i )
        b_Bonuses[i].bChecked = False;

    // set
    BonusCurrent = b_Bonuses[Mode];
    BonusPending = b_Bonuses[PendingMode];
    BonusCurrent.bChecked = True;
}



// ============================================================================
//  Shop
// ============================================================================

function bool InitShop( gPlayer PC )
{
    Shop = new class'gShopClientMenu';

    Shop.OnInitBegin = OnShop_InitBegin;
    Shop.OnInitEnd = OnShop_InitEnd;
    Shop.OnMoneyChange = OnShop_MoneyChange;

    Shop.OnManifestGloveInit = OnShop_ManifestGloveInit;
    Shop.OnManifestWeaponInit = OnShop_ManifestWeaponInit;
    Shop.OnGloveInit = OnShop_GloveInit;
    Shop.OnWeaponInit = OnShop_WeaponInit;
    Shop.OnBonusInit = OnShop_BonusInit;

    Shop.OnBonusUpdate = OnShop_BonusUpdate;

    Shop.OnGloveAmmoBought = OnShop_GloveAmmoBought;
    Shop.OnGloveBought = OnShop_GloveBought;
    Shop.OnGloveSold = OnShop_GloveSold;

    Shop.OnWeaponAmmoBought = OnShop_WeaponAmmoBought;
    Shop.OnWeaponWarrantySold = OnShop_WeaponWarrantySold;
    Shop.OnWeaponSold = OnShop_WeaponSold;
    Shop.OnWeaponBought = OnShop_WeaponBought;
    Shop.OnRebuyBegin = OnShop_RebuyBegin;


    return Shop.Init(PC, ShopID);
}


// ============================================================================
//  Delegates - Gloves
// ============================================================================

function bool OnClick_GloveIcon(GUIComponent Sender)
{
    local class<Weapon> WC;

    if( !Sender.IsInBounds() )
        return False;

    WC = Shop.GetManifestGlove(Sender.Tag);
    if( WC != None )
    {
        if( Shop.GloveBuy(WC, Shop.GetInitialAmmo(WC)) )
            PlayerOwner().ClientPlaySound(SpecialIcon.ActivateSound,,, SLOT_None);
        else
            PlayDeny();
    }
    return True;
}

function bool OnRightClick_SpecialIcon(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    Shop.GloveSell();
    return True;
}

function OnActivate_SpecialIcon()
{
    SpecialIcon.InternalOnActivate();
    SpecialIconActivated();
}

function OnDeActivate_SpecialIcon()
{
    SpecialIcon.InternalOnDeActivate();
}

function OnTimer_SpecialIcon( GUIComponent Sender )
{
    local int i;

    if( !SpecialIcon.IsInBounds() )
    {
        for( i=0; i!=GloveIcons.Length; ++i )
            if( GloveIcons[i].IsInBounds() )
                return;

        SpecialIconDeActivated();
    }
}

function SpecialIconActivated()
{
    local int i;

    lb_Weapons.DisableMe();
    SpecialIcon.SetTimer(0.1,True);

    for( i=0; i!=GloveSlots.Length; ++i )
    {
        gShow(GloveSlots[i]);
        gShow(GloveIcons[i]);
    }
}

function SpecialIconDeActivated()
{
    local int i;

    SpecialIcon.SetTimer(0.0,False);
    lb_Weapons.EnableMe();

    for( i=0; i!=GloveSlots.Length; ++i )
    {
        GloveIcons[i].SetFocus(None);
        gHide(GloveSlots[i]);
        gHide(GloveIcons[i]);
    }
}


// ============================================================================
//  Delegates - View Area
// ============================================================================

function bool OnClick_ViewArea(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    WeaponAction( Shop.GetManifestWeapon(b_ViewArea.Tag), False );
    return True;
}

function bool OnRightClick_ViewArea(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    WeaponAction( Shop.GetManifestWeapon(b_ViewArea.Tag), True );
    return True;
}


// ============================================================================
//  Delegates - Weapons Icons
// ============================================================================

function bool OnClick_WeaponIcon(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    WeaponAction( Shop.GetManifestWeapon(Sender.Tag), False );
    return True;
}

function bool OnRightClick_WeaponIcon(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    WeaponAction( Shop.GetManifestWeapon(Sender.Tag), True );
    return True;
}

function OnChange_WeaponIcon(GUIComponent Sender)
{
    WeaponHighlight(Sender.Tag);
}


// ============================================================================
//  Delegates - Weapons List
// ============================================================================

function bool OnClick_WeaponListButton(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    if( moButton(Sender.MenuOwner) != None )
        moButton(Sender.MenuOwner).InternalOnClick(Sender);

    WeaponAction( Shop.GetManifestWeapon(Sender.Tag), False );
    return True;
}

function bool OnRightClick_WeaponListButton(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    WeaponAction( Shop.GetManifestWeapon(Sender.Tag), True );
    return True;
}

function OnChange_WeaponListBox(GUIComponent Sender)
{
    WeaponHighlight(li_Weapons.Index);
}

function OnCreateComponent_WeaponListBox(GUIComponent NewComp, GUIComponent Sender)
{
    //Log( "OnCreateComponent_WeaponListBox" @NewComp @Sender );

    // setup Weapon List
    if( GUIMultiOptionList(NewComp) != None )
    {
        li_Weapons = GUIMultiOptionList(NewComp);
        li_Weapons.ItemPadding = 0.0;
        li_Weapons.bDrawSelectionBorder = False;
        li_Weapons.OnPreDraw = OnPreDraw_WeaponList;
        li_Weapons.bHotTrack = True;
        li_Weapons.OnTrack = OnTrack_WeaponList;
        li_Weapons.OnRendered = OnRendered_WeaponList;
    }
    else if( moButton(NewComp) != None )
    {
        moButton(NewComp).OnCreateComponent = OnCreateComponent_WeaponListOption;
    }

    lb_Weapons.InternalOnCreateComponent(NewComp, Sender);
}

function OnCreateComponent_WeaponListOption(GUIComponent NewComp, GUIComponent Sender)
{
    //Log( "OnCreateComponent_WeaponListOption" @NewComp @Sender );

    if( GUIButton(NewComp) != None )
    {
        GUIButton(NewComp).CaptionAlign = TXTA_Left;
        GUIButton(NewComp).OnClickSound = CS_None;
    }

    if( moButton(Sender) != None )
        moButton(Sender).InternalOnCreateComponent(NewComp, Sender);
}

function OnTrack_WeaponList(GUIComponent Sender, int LastIndex)
{
    // change index on mouseover
    if( Sender == li_Weapons )
    {
        li_Weapons.SetIndex(li_Weapons.Index);
        li_Weapons.OnChange(li_Weapons);
    }
}

function OnRendered_WeaponList(Canvas C)
{
    if( Shop != None )
        Shop.CheckMoneyChange();
    if( gPlayer(PlayerOwner()).CachedGPRI.GetMoney() < 2000 )
    {
        //b_bonuses[0].MenuState = EMenuState.MSAT_Disabled;
        b_bonuses[0].MenuStateChange(MSAT_Blurry);

    } else
    {
        b_bonuses[0].MenuStateChange(MSAT_Disabled);
        //b_bonuses[0].MenuState = EMenuState.MSAT_Enabled;
    }
}

function bool OnPreDraw_WeaponList(Canvas C)
{
    // Keep the weapon list items fixed size
    li_Weapons.ItemScaling = ItemScaling * (480/C.ClipY);

    return False;
}


// ============================================================================
//  Delegates - Key Buttons
// ============================================================================

function bool OnClick_ButtonCancel(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    PlayerOwner().ClientPlaySound(ReleaseSound,,,SLOT_None);
    Controller.CloseMenu(False);
    return True;
}

function bool OnClick_ButtonDone(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    PlayerOwner().ClientPlaySound(ReleaseSound,,, SLOT_None);
    PlayerOwner().ClientPlaySound(DoneSound,,, SLOT_None);

    Shop.Finalize();
    bShopNotified = True;

    CloseSound = None;
    Controller.CloseMenu(False);
    return True;
}

function bool OnClick_ButtonRebuy(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    PlayerOwner().ClientPlaySound(ReleaseSound,,,SLOT_None);
    if( !Shop.Rebuy() )
        PlayDeny();

    return True;
}

function bool OnClick_ButtonHelp(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    Controller.OpenMenu(HelpMenu);
    return True;
}

function bool OnClick_ButtonGive(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    Controller.OpenMenu(GiveMenu);
    return True;
}

function bool OnClick_ButtonOptions(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    Controller.OpenMenu(OptionsMenu);
    return True;
}

function bool XButtonClicked( GUIComponent Sender )
{
    if( !Sender.IsInBounds() )
        return False;

    Controller.CloseMenu(False);
    return True;
}

function OnChange_ButtonBonus(GUIComponent Sender)
{
    if( Sender != None && Sender.Tag != -1 )
        Shop.BonusUpdate( EBonusMode(Sender.Tag) );
}


// ============================================================================
//  Delegates
// ============================================================================

function OnShopCloseMenu(bool bCommit)
{
    if( bCommit )
    {
        Shop.Finalize();
        bShopNotified = True;

        CloseSound = None;
        Controller.CloseMenu(False);
    }
    else
    {
        bShopNotified = True;
        Controller.RemoveMenu(self, False);
    }
}

function InternalOnRendered(Canvas C)
{
    local float ItemX, ItemY, ItemS, X,Y,W,H;
    local rotator R;
    local string S;

    if( Shop == None )
        return;

    C.Reset();
    C.SetDrawColor(255,255,255,255);

    // Draw weapon model
    SpinYaw = (SpinYaw + SpinSpeed * Controller.RenderDelta) % 65535;
    R.Yaw = SpinYaw;

    ItemX = (i_WeaponBG.Bounds[0] + (i_WeaponBG.Bounds[2] - i_WeaponBG.Bounds[0])/2) / C.ClipX;
    ItemY = (i_WeaponBG.Bounds[1] + (i_WeaponBG.Bounds[3] - i_WeaponBG.Bounds[1])/2) / C.ClipY;
    ItemS = (i_WeaponBG.Bounds[3] - i_WeaponBG.Bounds[1]) / C.ClipY;

    DrawActorAt(C, ShopItem, ItemX, ItemY, ItemS, R, 30);

    // Draw amount of money
    S = "$" $Shop.GetMoneyPrediction();

//    // Draw money delta
//    if( Shop.LoadoutCost > 0 )
//        S @= "-$" $int(Abs(Shop.LoadoutCost));
//    else if( Shop.LoadoutCost < 0 )
//        S @= "+$" $int(Abs(Shop.LoadoutCost));

    b_Give.Caption = S;

    // fixme: ugly
    if( BonusCurrent != BonusPending )
    {
        X = BonusPending.ActualLeft();
        Y = BonusPending.ActualTop();
        W = BonusPending.ActualWidth();
        H = BonusPending.ActualHeight();

        C.Style = 5;
        C.SetDrawColor(255,255,255,255);
        C.SetPos(X,Y);
        C.DrawTile(PendingBonusMaterial, W, H, 0, 0, PendingBonusMaterial.MaterialUSize(), PendingBonusMaterial.MaterialVSize());
    }
}

function InternalOnClose(optional Bool bCanceled)
{
    local PlayerController PC;

    PC = PlayerOwner();

    // Turn pause off if currently paused
    if( PC != None && PC.Level.Pauser != None )
        PC.SetPause(False);

    if( ShopItem != None )
    {
        ShopItem.Destroy();
        ShopItem = None;
    }

    Super.OnClose(bCanceled);
}

function bool FloatingPreDraw(Canvas C)
{
    if( PlayerOwner().GameReplicationInfo != None )
        SetVisibility(True);
    else
        SetVisibility(False);

    return False;
}


// ============================================================================
//  Shopping
// ============================================================================

function bool WeaponAction(class<gWeapon> GWC, bool bRightClick)
{
    local int LIdx;

    //Log( "WeaponAction" @GWC @bRightClick );

    // if invalid weapon, abort
    if( GWC == None || GWC.default.ItemSize < 1 )
        return PlayDeny(True);

    // on existing: rclick sells warranty/wepon, lclick buys ammo
    // on new: rclick buys weapon with warranty, lclick buys weapon without
    if( Shop.FindLoadoutWeaponIndex( GWC, LIdx) )
    {
        if( bRightClick )
        {
            // sell warranty if exists, or weapon if doesn't
            if( Shop.HasLoadoutWarranty(LIdx) )
            {
                Shop.WarrantySell(GWC, LIdx);
            }
            else
            {
                Shop.WeaponSell(GWC);
            }
        }
        else
        {
            if( !Shop.AmmoBuy(GWC, LIdx) )
                return PlayDeny(True);
        }
    }
    else
    {
        if( !Shop.WeaponBuy(GWC, Shop.GetInitialAmmo(GWC), bRightClick) )
            return PlayDeny(True);
    }

    return True;
}



// ============================================================================
//  Stuff
// ============================================================================

function RemoveWeaponIcon( int MIdx, int LIdx, class<gWeapon> GWC )
{
    local int i;
    local GUIComponent com;

    // clear links
    moButton(li_Weapons.Elements[MIdx]).MyButton.OnActivate = None;
    moButton(li_Weapons.Elements[MIdx]).MyButton.OnDeActivate = None;

    // remove focus
    com = LoadoutIcons[LIdx];
    com.LoseFocus(Self);
    LoadoutIcons.Remove(LIdx,1);

    // update icon list
    if( LIdx != LoadoutIcons.Length )
    {
        // set focus to next icon
        LoadoutIcons[LIdx].SetFocus(None);

        // update following icons
        for( i=LIdx; i<LoadoutIcons.Length; ++i )
        {
            LoadoutIcons[i].WinLeft -= com.WinWidth;
        }
    }

    // free icon
    RemoveComponent(com, False);
    com.Free();
}

function WeaponHighlight(int Idx)
{
    local int i;
    local gGUISlotImage img;
    local class<gWeapon> GWC;
    local StaticMesh SM;

    GWC = Shop.GetManifestWeapon(Idx);
    if( GWC != None )
    {
        b_ViewArea.Tag = Idx;

        // set description
        lb_Desc.SetContent(GWC.default.Description);

        // set preview mesh
        if( GWC.default.PickupClass != None )
            SM = GWC.default.PickupClass.default.StaticMesh;
        if( SM == None && GWC.default.FireModeClass[0] != None && GWC.default.FireModeClass[0].default.ProjectileClass != None )
            SM = GWC.default.FireModeClass[0].default.ProjectileClass.default.StaticMesh;

        ShopItem.SetStaticMesh(SM);

        // free slot images
        for( i=0; i!=PreviewSlots.Length; ++i )
        {
            if( PreviewSlots[i] != None )
            {
                RemoveComponent(PreviewSlots[i]);
                PreviewSlots[i].Free();
            }
        }
        PreviewSlots.Length = 0;

        // create slot images
        for( i=0; i!=GWC.default.ItemSize; ++i )
        {
            img = CreateSlotImage();
            img.bNeverFocus = True;
            img.WinWidth = 0.0275; // 22/800
            img.WinHeight = 0.0367; // 22/600
            img.WinLeft = i_WeaponBG.WinLeft + (i_WeaponBG.WinWidth-(img.WinWidth*GWC.default.ItemSize))*0.5 + i*img.WinWidth;
            img.WinTop = i_WeaponBG.WinTop + i_WeaponBG.WinHeight - 0.0067 - img.WinHeight; // 4/600

            AppendComponent(img, True);
            PreviewSlots[PreviewSlots.Length] = img;
        }
    }
}

function gGUISlotImage CreateSlotImage()
{
    local gGUISlotImage img;

    // setup slot
    img = new(None) class'gGUISlotImage'; // Free() in GUIMultiComponent.Free()
    return img;
}

function gGUIImageButton CreateWeaponIcon( int MIdx, int SIdx, class<gWeapon> WC, optional byte bWarranty, optional int Ammo)
{
    local gGUIImageButton img;

    // setup icon
    img = new class'gGUIImageButton'; // Free() in GUIMultiComponent.Free()
    img.SetPosition( Slots[SIdx].WinLeft, Slots[SIdx].WinTop, Slots[SIdx].WinWidth * WC.default.ItemSize, Slots[SIdx].WinHeight );
    img.OnChange = OnChange_WeaponIcon;
    img.OnClick = OnClick_WeaponIcon;
    img.OnRightClick = OnRightClick_WeaponIcon;
    img.InitFromWeapon( MIdx, WC, Ammo, bWarranty );
    img.SetHint( WeaponIconHint );

    // register icon
    AppendComponent(img, True);
    LoadoutIcons[LoadoutIcons.Length] = img;

    // link to weapon list
    moButton(li_Weapons.GetItem(MIdx)).MyButton.OnActivate = img.InternalOnActivate;
    moButton(li_Weapons.GetItem(MIdx)).MyButton.OnDeActivate = img.InternalOnDeActivate;

    return img;
}

function gGUIGloveIcon CreateSpecialIcon( int Idx, class<Weapon> WC )
{
    local gGUIGloveIcon img;

    // setup icon
    img = new class'gGUIGloveIcon'; // Free() in GUIMultiComponent.Free()
    img.SetPosition( SpecialSlot.WinLeft, SpecialSlot.WinTop, SpecialSlot.WinWidth, SpecialSlot.WinHeight );
    img.OnClick = OnClick_GloveIcon;
    img.OnRightClick = OnRightClick_SpecialIcon;
    img.OnTimer = OnTimer_SpecialIcon;
    img.OnActivate = OnActivate_SpecialIcon;
    img.OnDeactivate = OnDeactivate_SpecialIcon;
    img.InitFromGlove( Idx, WC );
    return img;
}

function gGUIGloveIcon CreateGloveIcon( int Idx, class<Weapon> WC )
{
    local gGUIGloveIcon img;

    // setup icon
    img = new class'gGUIGloveIcon'; // Free() in GUIMultiComponent.Free()
    img.SetPosition( GloveSlots[Idx].WinLeft, GloveSlots[Idx].WinTop, GloveSlots[Idx].WinWidth, GloveSlots[Idx].WinHeight );
    img.OnClick = OnClick_GloveIcon;
    img.OnRightClick = OnRightClick_SpecialIcon;
    img.InitFromGlove( Idx, WC );
    return img;
}

function DrawActorAt(Canvas C, Actor A, float PosX, float PosY, float Size, rotator ItemRot, float ItemFOV)
{
    local float Zoom, ItemRadius, Ratio;
    local vector ItemLoc;

    Ratio = C.ClipY / C.ClipX;
    ItemRadius = A.GetRenderBoundingSphere().W;
    Zoom = 1 / tan(ItemFOV/2/180*Pi);

    ItemLoc.X = Zoom;
    ItemLoc.Y = (PosX*2 - 1);
    ItemLoc.Z = (PosY*2 - 1) * Ratio * -1;
    ItemLoc *= ItemRadius;

    A.SetLocation(ItemLoc);
    A.SetRotation(ItemRot);
    A.SetDrawScale(Size);
    C.DrawScreenActor(A, ItemFOV, False, True);
    A.SetDrawScale(1);
}

function SetLoading(bool b)
{
    local int i;
    local eFontScale f;

    if(b)
    {
        // Hide controls
        gHide(b_OK);
        gHide(b_Rebuy);
        gHide(b_ViewArea);
        gHide(lb_Desc);
        gHide(lb_Weapons);
        gHide(i_DescBG);
        gHide(i_WeaponBG);

        for( i=0; i!=b_Bonuses.Length; ++i )
        {
            gHide(b_Bonuses[i]);
        }

        // show loading message
        l_Loading.Show();
    }
    else
    {
        // unhide controls
        gShow(b_OK);
        gShow(b_Rebuy);
        gShow(b_ViewArea);
        gShow(lb_Desc);
        gShow(lb_Weapons);
        gShow(i_DescBG);
        gShow(i_WeaponBG);

        for( i=0; i!=b_Bonuses.Length; ++i )
        {
            gShow(b_Bonuses[i]);
        }

        // hide loading message
        l_Loading.Hide();
        
        if( PlayerOwner() != None && !class'gPRI'.static.AllowDonate(PlayerOwner().GameReplicationInfo) )
        {
            b_Give.Style = Controller.GetStyle("gNoMoneyForYouButton", f);
			b_Give.bAcceptsInput=false;
			b_Give.bCaptureMouse=false;
			b_Give.bNeverFocus=true;
			b_Give.bTabStop=false;
        }
    }
}

function bool PlayDeny(optional bool bReturnValue)
{
    PlayerOwner().ClientPlaySound(DenySound,,, SLOT_None);
    return bReturnValue;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
	
	HealthBarColor				= (R=198,G=157,B=111,A=255)
	HealthBarColorDamaged		= (R=255,G=0,B=0,A=255)
    HelpMenu                    = "GMenu.gShoppingHelp"
    GiveMenu                    = "GMenu.gShoppingGive"
    OptionsMenu                 = "GMenu.gOptionsMenu"

    WeaponItemHint              = "Click to buy a weapon.|Click again to buy additional ammo."
    WeaponIconHint              = "Left-Click a weapon to buy additional ammo.|Right-click to sell weapon and ammo for half value."
    BonusPreviewhint            = "Preview"

    OnRendered                  = InternalOnRendered

    SpinSpeed                   = 4096
    ItemScaling                 = 0.045

    OpenSound                   = Sound'G_Sounds.Interface.shopping_open_1'
    CloseSound                  = Sound'G_Sounds.Interface.shopping_cancel_1'
    DoneSound                   = Sound'G_Sounds.Interface.shopping_c1'

    WeaponBuySound              = Sound'G_Sounds.g_ammo_2'
    AmmoBuySound                = Sound'G_Sounds.g_click_3'
    DenySound                   = Sound'G_Sounds.shopping_denied_1'
    DebtSound                   = Sound'G_Sounds.tic_f1'
    WarrantyBuySound            = Sound'G_Sounds.warranty_buy1'
    WarrantyRefundSound         = Sound'G_Sounds.warranty_refund1'
    ReleaseSound                = Sound'G_Sounds.tic_c1'

    WeaponSellSound             = Sound'G_Sounds.sell_1'

    PendingBonusMaterial        = Material'G_FX.belt_square_a2'

    Begin Object Class=GUIImage Name=o_WeaponBG
        Image=Texture'Engine.WhiteTexture'
        DropShadow=None
        ImageStyle=ISTY_Stretched
        ImageRenderStyle=MSTY_Alpha
        WinTop=0.07
        WinLeft=0.545
        WinWidth=0.433333
        WinHeight=0.34
        ImageColor=(R=255,G=255,B=255,A=30)
    End Object
    i_WeaponBG=o_WeaponBG

    Begin Object Class=GUIImage Name=o_DescBG
        Image=Texture'Engine.WhiteTexture'
        DropShadow=None
        ImageStyle=ISTY_Stretched
        ImageRenderStyle=MSTY_Alpha
        WinWidth=0.433333
        WinHeight=0.285000
        WinLeft=0.545000
        WinTop=0.420000
        ImageColor=(R=255,G=255,B=255,A=30)
    End Object
    i_DescBG=o_DescBG

    Begin Object Class=GUIMultiOptionListBox Name=o_Weapons
        WinWidth=0.518000
        WinHeight=0.635
        WinLeft=0.020000
        WinTop=0.070000
        bVisibleWhenEmpty=True
        NumColumns=1
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        DefaultListClass="GMenu.gShopWeaponList"
        OnCreateComponent=OnCreateComponent_WeaponListBox
        OnChange=OnChange_WeaponListBox
    End Object
    lb_Weapons=o_Weapons

    Begin Object Class=GUIScrollTextBox Name=WeaponDescription
        WinWidth=0.43
        WinHeight=0.270000
        WinLeft=0.550000
        WinTop=0.426
        bNoTeletype=True
        CharDelay=0.0015
        EOLDelay=0.25
        bNeverFocus=True
        bAcceptsInput=False
        bVisibleWhenEmpty=True
        FontScale=FNS_Small
        StyleName="gNoBackgroundFixed"
        bScaleToParent=True
        bBoundToParent=True
    End Object
    lb_Desc=WeaponDescription

    Begin Object Class=GUILabel Name=OLoading
        WinWidth=0.96
        WinHeight=0.69000
        WinLeft=0.020000
        WinTop=0.05
        TextAlign=TXTA_Center
        VertAlign=TXTA_Center
        StyleName="TextLabel"
        bBoundToParent=True
        bScaleToParent=True
        FontScale=FNS_Large
        Caption="..."
    End Object
    l_Loading=OLoading

    Begin Object Class=GUIButton Name=OOK
        WinWidth=0.190000
        WinHeight=0.100000
        WinLeft=0.788333
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        Caption="Done"
        StyleName="gShopButton"
        OnClick=OnClick_ButtonDone
        Hint="Click to finalize and exit."
        bRequireReleaseClick=True
    End Object
    b_OK=OOK

    Begin Object Class=GUIButton Name=OCancel
        WinWidth=0.190000
        WinHeight=0.100000
        WinLeft=0.020000
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        Caption="Cancel"
        StyleName="gShopButton"
        OnClick=OnClick_ButtonCancel
        Hint="Exits shopping interface. Press 'Use' to re-open it."
        bRequireReleaseClick=True
    End Object
    b_Cancel=OCancel

    Begin Object Class=GUIButton Name=OReBuy
        WinWidth=0.190000
        WinHeight=0.100000
        WinLeft=0.595000
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        Caption="Re-Buy"
        StyleName="gShopButton"
        OnClick=OnClick_ButtonRebuy
        Hint="Select last used loadout."
        bRequireReleaseClick=True
    End Object
    b_ReBuy=OReBuy

    Begin Object Class=GUIButton Name=OHelp
        WinWidth=0.037500
        WinHeight=0.050000
        WinLeft=0.020000
        WinTop=0.000000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        StyleName="gHelpButton"
        OnClick=OnClick_ButtonHelp
        Hint="Help"
        bRequireReleaseClick=True
    End Object
    b_Help=OHelp

    Begin Object Class=GUIButton Name=OOptions
        WinWidth=0.0375
        WinHeight=0.050000
        WinLeft=0.0575
        WinTop=0.000000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        StyleName="gOptionsButton"
        OnClick=OnClick_ButtonOptions
        Hint="Options"
        bRequireReleaseClick=True
    End Object
    b_Options=OOptions

    Begin Object Class=GUIButton Name=OGive
        WinWidth=0.191667
        WinHeight=0.100000
        WinLeft=0.221667
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        OnClick=OnClick_ButtonGive
        StyleName="gShopButton"
        Hint="Money Amount. Click to transfer money."
        bRequireReleaseClick=True
    End Object
    b_Give=OGive

    Begin Object Class=GUICheckBoxButton Name=OMoney
        WinWidth=0.0375
        WinHeight=0.100000
        WinLeft=0.4275 //0.5075
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        OnChange=OnChange_ButtonBonus
        Hint = "Money-Boost - Gives you $600 instantly, and increases all profits by 30% while active. (Only available if you have less than $2000)"
        CheckedOverlay(0)=Material'G_FX.Shop-S2'
        CheckedOverlay(1)=Material'G_FX.Shop-S2'
        CheckedOverlay(2)=Material'G_FX.Shop-S2'
        CheckedOverlay(3)=Material'G_FX.Shop-S2'
        CheckedOverlay(4)=Material'G_FX.Shop-S2'
        StyleName="MoneyBox"
        Tag=0
    End Object
    b_Bonuses(0)=OMoney

    Begin Object Class=GUICheckBoxButton Name=OArmor
        WinWidth=0.0375
        WinHeight=0.100000
        WinLeft=0.4675
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        OnChange=OnChange_ButtonBonus
        Hint = "Armor-Boost - Spawn with 75 Armor (equal to spawning with 175 Health)."
        CheckedOverlay(0)=Material'G_FX.Shop-A2'
        CheckedOverlay(1)=Material'G_FX.Shop-A2'
        CheckedOverlay(2)=Material'G_FX.Shop-A2'
        CheckedOverlay(3)=Material'G_FX.Shop-A2'
        CheckedOverlay(4)=Material'G_FX.Shop-A2'
        StyleName="ArmorBox"
        Tag=1
    End Object
    b_Bonuses(1)=OArmor

    Begin Object Class=GUICheckBoxButton Name=ORegen
        WinWidth=0.0375
        WinHeight=0.100000
        WinLeft=0.5075 //0.4275
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        OnChange=OnChange_ButtonBonus
        Hint = "Regeneration - Spawn with Regeneration, restoring 15 Health every 2 seconds (up to 150)."
        CheckedOverlay(0)=Material'G_FX.Shop-R2'
        CheckedOverlay(1)=Material'G_FX.Shop-R2'
        CheckedOverlay(2)=Material'G_FX.Shop-R2'
        CheckedOverlay(3)=Material'G_FX.Shop-R2'
        CheckedOverlay(4)=Material'G_FX.Shop-R2'
        StyleName="RegenBox"
        Tag=2
    End Object
    b_Bonuses(2)=ORegen

    Begin Object Class=GUICheckBoxButton Name=OShield
        WinWidth=0.0375
        WinHeight=0.100000
        WinLeft=0.5475
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        bFocusOnWatch=True
        OnChange=OnChange_ButtonBonus
        Hint="Invulnerability Shield - Spawn with a 1-Second Invulnerability Shield, which is activated instantly when you press 'Use'. It takes 10 seconds to recharge. In order to fire the Shield, you must not be standing within activation-range of a Shopping Terminal, Weapon Pickup, or Vehicle."
        CheckedOverlay(0)=Material'G_FX.Shop-O2'
        CheckedOverlay(1)=Material'G_FX.Shop-O2'
        CheckedOverlay(2)=Material'G_FX.Shop-O2'
        CheckedOverlay(3)=Material'G_FX.Shop-O2'
        CheckedOverlay(4)=Material'G_FX.Shop-O2'
        StyleName="ShieldBox"
        Tag=3
    End Object
    b_Bonuses(3)=OShield

    Begin Object Class=GUIButton Name=OViewArea
        WinTop=0.07
        WinLeft=0.545
        WinWidth=0.433333
        WinHeight=0.34
        bScaleToParent=True
        bBoundToParent=True
        StyleName="NoBackground"
        OnClick=OnClick_ViewArea
        OnRightClick=OnRightClick_ViewArea
        bRequireReleaseClick=True
    End Object
    b_ViewArea=OViewArea
}