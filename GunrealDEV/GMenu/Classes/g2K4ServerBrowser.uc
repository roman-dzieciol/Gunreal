// ============================================================================
//  g2K4ServerBrowser.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4ServerBrowser extends UT2k4ServerBrowser;



function CreateTabs()
{
    c_Tabs.OnCreateComponent = OnCreateComponent_Tab;
    Super.CreateTabs();
}

function OnCreateComponent_Tab(GUIComponent NewComp, GUIComponent Sender)
{
    local UT2K4Browser_ServerListPageBase P;

    P = UT2K4Browser_ServerListPageBase(NewComp);
    if( P != None )
    {
        if( P.sp_Main.DefaultPanels[0] == "GUI2K4.UT2K4Browser_ServerListBox" )
            P.sp_Main.DefaultPanels[0] = "GMenu.g2K4Browser_ServerListBox";
    }
}

function PopulateGameTypes()
{
    // don't populate
}

function InitializeGameTypeCombo(optional bool ClearFirst)
{
    local UT2K4Browser_ServersList  ListObj;

    // dummy gametype list
    PopulateGameTypes();
    co_GameType.MyComboBox.List.Clear();
    ListObj = new(None) class'GUI2K4.UT2K4Browser_ServersList';
    co_GameType.AddItem("All Gametypes", ListObj, "");
}

function InternalOnChange(GUIComponent Sender)
{
    if( GUITabButton(Sender) != None )
    {
        // Update gametype combo box visibility (Gunreal: hide it)
        co_GameType.DisableMe();
        co_GameType.Hide();
    }
}

function FilterClicked()
{
}

DefaultProperties
{
    bStandardServersOnly        = False

    PanelClass(0)="GUI2K4.UT2K4Browser_MOTD"
    PanelClass(1)="GUI2K4.UT2K4Browser_IRC"
    PanelClass(2)="GUI2K4.UT2K4Browser_ServerListPageFavorites"
    PanelClass(3)="GUI2K4.UT2K4Browser_ServerListPageLAN"
    PanelClass(4)="GUI2K4.UT2K4Browser_ServerListPageBuddy"
    PanelClass(5)="GMenu.g2K4Browser_ServerListPageInternet"

    Begin Object Class=g2K4Browser_Footer Name=gFooterPanel
        WinWidth=1.000000
        WinLeft=0.000000
        WinTop=0.917943
        TabOrder=4
    End Object
    t_Footer=gFooterPanel
}