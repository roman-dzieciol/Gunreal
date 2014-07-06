// ============================================================================
//  gWeaponListButtonOption.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWeaponListButtonOption extends moButton;

var() string    DisabledStyleName;
var() string    AmmoStyleName;

var() string    WeaponName;
var() int       WeaponPrice;
var() int       AmmoPrice;

var   int       Money;
var   bool      bHasWeapon;

var   string    WeaponItemHint;
var() string    NoMoneyHint;
var() string    BuyAmmoHint;

function InternalOnCreateComponent(GUIComponent NewComp, GUIComponent Sender)
{
    Super.InternalOnCreateComponent(NewComp, Sender);

    if( GUIButton(NewComp) != None )
        NewComp.OnRendered = OnRendered_Button;
}

function OnRendered_Button(Canvas C)
{
    local string S;
    local float X, Y, W, H;//,XL,YL;
    local eFontScale f;
    local bool bHasMoney;

    if( MyButton != None && MyButton.Style != None )
    {
        if( bHasWeapon )
        {
            MyButton.Caption = WeaponName @ "Ammo";
            S = "$" $ AmmoPrice;
        }
        else
        {
            MyButton.Caption = WeaponName;
            S = "$" $ WeaponPrice;
        }

        //MyButton.Style.TextSize( C, MyButton.MenuState, S, XL, YL, MyButton.FontScale );

        X = ActualLeft();
        Y = ActualTop();
        W = ActualWidth() - MyButton.Style.BorderOffsets[2];
        H = ActualHeight();

        if( bHasWeapon )
            bHasMoney = class'gShopInfo'.static.CanAfford(Money, AmmoPrice);
        else
            bHasMoney = class'gShopInfo'.static.CanAfford(Money, WeaponPrice);

        if( !bHasMoney )
        {
            MyButton.Style = Controller.GetStyle(DisabledStyleName, f);

            if( MyButton.Hint != NoMoneyHint )
                MyButton.SetHint(NoMoneyHint);
        }
        else if( bHasWeapon )
        {
            MyButton.Style = Controller.GetStyle(AmmoStyleName, f);

            if( MyButton.Hint != BuyAmmoHint )
                MyButton.SetHint(BuyAmmoHint);
        }
        else
        {
            MyButton.Style = Controller.GetStyle(ButtonStyleName, f);

            if( MyButton.Hint != WeaponItemHint )
                MyButton.SetHint(WeaponItemHint);
        }

        MyButton.Style.DrawText(C, MyButton.MenuState, X, Y, W, H, TXTA_Right, S, MyButton.FontScale);
    }
}

function SetHint(string NewHint)
{
    Super.SetHint(NewHint);

    if( WeaponItemHint == "" )
        WeaponItemHint = NewHint;
}

//=============================================================================
// DefaultProperties
//=============================================================================
DefaultProperties
{
    ButtonStyleName     = "gWeaponButton"
    StyleName           = "gWeaponButton"
    DisabledStyleName   = "gWeaponButtonDisabled"
    AmmoStyleName       = "gAmmoButton"

    bStandardized       = False
    CaptionWidth        = 0.0

    NoMoneyHint         = "You cannot purchase a weapon that will send you further than -$500 into debt."
    BuyAmmoHint         = "Click to buy ammo."
}