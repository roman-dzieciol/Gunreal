// ============================================================================
//  gOptionsMenu.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gOptionsMenu extends gShopWindow;

var automated GUIbutton b_Close;

var automated gmoFixedComboBox c_Sway;
var automated gmoFixedComboBox c_Detail;
var automated gmoFixedComboBox c_Clothing;

var automated GUILabel l_Interface;

var automated gmoCheckBox k_HitIndicator;
var automated gmoCheckBox k_MineOwner;
var automated gmoCheckBox k_Adrenaline;
var automated gmoCheckBox k_FastWeaponSwitch;
var automated gmoCheckBox k_RelativeCrosshair;

var() localized string SwayText[3];
var() localized string DetailText[3];
var() localized string ClothingText[3];

function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
    local int i;
    Super.InitComponent(MyController, MyComponent);

    for( i=0; i!=ArrayCount(SwayText); ++i )
        c_Sway.AddItem(SwayText[i]);

    for( i=0; i!=ArrayCount(DetailText); ++i )
        c_Detail.AddItem(DetailText[i]);

    for( i=0; i!=ArrayCount(ClothingText); ++i )
        c_Clothing.AddItem(ClothingText[i]);
}

function bool AllowOpen(string MenuClass)
{
    if( MenuClass ~= "GMenu.gOptionsMenu" )
        return False;
    else
        return True;
}

function OnChange_Internal( GUIComponent Sender )
{
    local gPlayer PC;

    PC = gPlayer(PlayerOwner());
    if( PC == None )
        return;

    Switch( Sender )
    {
    case k_HitIndicator:
        PC.bHitSounds = k_HitIndicator.IsChecked();
        PC.ServerSetHitSounds(PC.bHitSounds);
        break;

    case k_MineOwner:
        PC.bShowMineOwner = k_MineOwner.IsChecked();
        break;

    case k_Adrenaline:
        PC.bAdrenalineTracks = k_Adrenaline.IsChecked();
        break;

    case k_FastWeaponSwitch:
        class'gPawnInventory'.default.bFastWeaponSwitch = k_FastWeaponSwitch.IsChecked();
        break;

    case k_RelativeCrosshair:
        class'gWeapon'.default.bAccurateCrosshair = k_RelativeCrosshair.IsChecked();
        break;

    case c_Sway:
        class'gWeapon'.default.SwayMode = c_Sway.GetIndex();
        break;

    case c_Detail:
        PC.Level.DetailChange(EDetailMode(c_Detail.GetIndex()));
        break;

    case c_Clothing:
        class'gPawn'.default.ClothingType = c_Clothing.GetIndex();
        break;
    }

    PC.SaveConfig();
    PC.Level.SaveConfig();
    class'gWeapon'.static.StaticSaveConfig();
    class'gPawn'.static.StaticSaveConfig();
    class'gPawnInventory'.static.StaticSaveConfig();
}

function OnLoadINI_Internal(GUIComponent Sender, string s)
{
    local gPlayer PC;

    PC = gPlayer(PlayerOwner());

    if( PC == None )
        return;

    Switch( Sender )
    {
        case k_HitIndicator:
            k_HitIndicator.SetComponentValue(PC.bHitSounds, True);
            break;

        case k_MineOwner:
            k_MineOwner.SetComponentValue(PC.bShowMineOwner, True);
            break;

        case k_Adrenaline:
            k_Adrenaline.SetComponentValue(PC.bAdrenalineTracks, True);
            break;

        case k_FastWeaponSwitch:
            k_FastWeaponSwitch.SetComponentValue(class'gPawnInventory'.default.bFastWeaponSwitch, True);
            break;

        case k_RelativeCrosshair:
            k_RelativeCrosshair.SetComponentValue(class'gWeapon'.default.bAccurateCrosshair, True);
            break;

        case c_Sway:
            c_Sway.SilentSetIndex(class'gWeapon'.default.SwayMode);
            break;

        case c_Detail:
            c_Detail.SilentSetIndex(PC.Level.DetailMode);
            break;

        case c_Clothing:
            c_Clothing.SilentSetIndex(class'gPawn'.default.ClothingType);
            break;
    }
}

DefaultProperties
{
    WindowName          = "Gunreal Options"

    WinWidth            = 420
    WinHeight           = 440
    WinLeft             = 110
    WinTop              = 20

    SwayText(0)         = "Realistic"
    SwayText(1)         = "Drag"
    SwayText(2)         = "None"

    DetailText(0)       = "Low"
    DetailText(1)       = "Medium"
    DetailText(2)       = "Full (slower)"

    ClothingText(0)     = "Gunreal"
    ClothingText(1)     = "Military"
    //ClothingText(2)     = "Chains"
    //ClothingText(3)     = "Slacks"
    ClothingText(2)     = "None"

    Begin Object Class=GUIButton Name=OClose
        WinWidth=0.2
        WinHeight=0.100000
        WinLeft=0.4
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        Caption="OK"
        StyleName="gShopButton"
        Hint="Close."
        OnClick=XButtonClicked
    End Object
    b_Close=OClose

    Begin Object Class=gmoFixedComboBox Name=OSway
        WinWidth=0.9
        WinHeight=0.04
        WinLeft=0.05
        WinTop=0.1
        Caption="Weapon Sway"
        Hint="Weapon sway type."
        bReadOnly=True
        bBoundToParent=True
        bScaleToParent=True
        bStandardized=False
        IniOption="@Internal"
        OnLoadINI=OnLoadINI_Internal
        OnChange=OnChange_Internal
        LabelStyleName="gFixedOptionLabel"
        ComponentStyleName="gFixedCombo"
    End Object
    c_Sway=OSway

    Begin Object Class=gmoFixedComboBox Name=ODetail
        WinWidth=0.9
        WinHeight=0.04
        WinLeft=0.05
        WinTop=0.2
        Caption="Special Effects"
        Hint="Particle quality and world detail. Huge influence on framerate."
        bReadOnly=True
        bBoundToParent=True
        bScaleToParent=True
        bStandardized=False
        IniOption="@Internal"
        OnLoadINI=OnLoadINI_Internal
        OnChange=OnChange_Internal
        LabelStyleName="gFixedOptionLabel"
        ComponentStyleName="gFixedCombo"
    End Object
    c_Detail=ODetail

    Begin Object Class=gmoFixedComboBox Name=OClothing
        WinWidth=0.9
        WinHeight=0.04
        WinLeft=0.05
        WinTop=0.3
        Caption="Clothing sounds"
        Hint="Clothing sounds"
        bReadOnly=True
        bBoundToParent=True
        bScaleToParent=True
        bStandardized=False
        IniOption="@Internal"
        OnLoadINI=OnLoadINI_Internal
        OnChange=OnChange_Internal
        LabelStyleName="gFixedOptionLabel"
        ComponentStyleName="gFixedCombo"
    End Object
    c_Clothing=OClothing

    Begin Object class=GUILabel Name=OInterface
        Caption="Interface"
        TextAlign=TXTA_Center
        TextFont="UT2SmallHeaderFont"
        TextColor=(R=255,G=255,B=255,A=255)
        WinWidth=0.9
        WinHeight=0.1
        WinLeft=0.05
        WinTop=0.4
    End Object
    l_Interface=OInterface

    Begin Object class=gmoCheckBox name=OHitIndicator
        WinWidth=0.9
        WinHeight=0.04
        WinLeft=0.05
        WinTop=0.5
        bStandardized=False
        Caption="Hit-Indicator Sounds"
        Hint="Play distinct sound when something is damaged"
        IniOption="@Internal"
        OnLoadINI=OnLoadINI_Internal
        OnChange=OnChange_Internal
        LabelStyleName="gFixedOptionLabel"
        ComponentStyleName="gFixedCheckBox"
    End Object
    k_HitIndicator=OHitIndicator

    Begin Object class=gmoCheckBox name=OMineOwner
		WinWidth=0.900000
		WinHeight=0.040000
		WinLeft=0.050000
		WinTop=0.56
        bStandardized=False
        Caption="Show Owner of Mines"
        Hint="Looking straight at a mine from close distance will display it's owner."
        IniOption="@Internal"
        OnLoadINI=OnLoadINI_Internal
        OnChange=OnChange_Internal
        LabelStyleName="gFixedOptionLabel"
        ComponentStyleName="gFixedCheckBox"
    End Object
    k_MineOwner=OMineOwner

    Begin Object class=gmoCheckBox name=OAdrenaline
		WinWidth=0.900000
		WinHeight=0.040000
		WinLeft=0.050000
		WinTop=0.62
        bStandardized=False
		MenuState=MSAT_Disabled
        Caption="Adrenaline Tracks"
        Hint="Adrenaline Tracks"
        IniOption="@Internal"
        OnLoadINI=OnLoadINI_Internal
        OnChange=OnChange_Internal
        LabelStyleName="gFixedOptionLabel"
        ComponentStyleName="gFixedCheckBox"
    End Object
    k_Adrenaline=OAdrenaline

    Begin Object class=gmoCheckBox name=OFastWeaponSwitch
		WinWidth=0.900000
		WinHeight=0.040000
		WinLeft=0.050000
		WinTop=0.68
        bStandardized=False
        Caption="Fast Weapon Switch"
        Hint="Fast Weapon Switch"
        IniOption="@Internal"
        OnLoadINI=OnLoadINI_Internal
        OnChange=OnChange_Internal
        LabelStyleName="gFixedOptionLabel"
        ComponentStyleName="gFixedCheckBox"
    End Object
    k_FastWeaponSwitch=OFastWeaponSwitch

    Begin Object class=gmoCheckBox name=ORelativeCrosshair
		WinWidth=0.900000
		WinHeight=0.040000
		WinLeft=0.050000
		WinTop=0.74
        bStandardized=False
        Caption="Relative Crosshair"
        Hint="Turning this on makes the crosshair size relative to each weapon's maximum accuracy. For example, the Shotgun and Minigun will have somewhat enlarged crosshairs, even at their maximum accuracy, whereas the Sniper Cannon and G-60 will have small crosshairs, indicating their aiming precision."
        IniOption="@Internal"
        OnLoadINI=OnLoadINI_Internal
        OnChange=OnChange_Internal
        LabelStyleName="gFixedOptionLabel"
        ComponentStyleName="gFixedCheckBox"
    End Object
    k_RelativeCrosshair=ORelativeCrosshair
}