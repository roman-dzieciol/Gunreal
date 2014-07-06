// ============================================================================
//  g2K4Tab_GameTypeBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4Tab_GameTypeBase extends UT2K4Tab_GameTypeBase;



var gGameTypeFilter GameTypeFilter;
var globalconfig gGenericFilter.EGunrealFilter MenuGameTypeFilter;

var automated GUISectionBackground sb_Options;
var automated moCheckBox ch_GameTypeFilter;


function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

    ch_GameTypeFilter.Checked( MenuGameTypeFilter == F_Yes );
}

function OnChange_GameTypeFilter(GUIComponent Sender)
{
    if( ch_GameTypeFilter.IsChecked() )
        MenuGameTypeFilter = F_Yes;
    else
        MenuGameTypeFilter = F_Maybe;
    SaveConfig();
    ReinitGameTypes();
}

function ReinitGameTypes()
{
    local bool bTemp;

    // Temporarily disable notification in all components
    bTemp = Controller.bCurMenuInitialized;
    Controller.bCurMenuInitialized = False;

    GameTypes.Remove(0,GameTypes.Length);
    li_Games.Clear();
    PopulateGameTypes();
    InitPreview();

    Controller.bCurMenuInitialized = bTemp;
}

function PopulateGameTypes()
{
    local int i;
    local array<CacheManager.GameRecord> CustomTypes;

    class'CacheManager'.static.GetGameTypeList(GameTypes);

    // Get the list of valid gametypes, and separate them into the appropriate lists
    // All official gametypes go into the large listbox
    // All custom gametypes go into the combo box (sorry guys!)
    for( i = 0; i < GameTypes.Length; i++ )
    {
        if( GameTypeFilter.GetFilter(GameTypes[i].ClassName) > MenuGameTypeFilter )
            continue;

        if( HasMaps(GameTypes[i]) )
        {
            if( GameTypes[i].GameTypeGroup < 3 )
                AddEpicGameType( GameTypes[i].GameName, GameTypes[i].MapListClassName);
            else
                CustomTypes[CustomTypes.Length] = GameTypes[i];
        }
        else if( GameTypes[i].GameTypeGroup >= 3 )
        {
            Log("Gametype"@GameTypes[i].ClassName@"found but it has no maps", 'Warning');
        }
    }

//  li_Games.SortList();

    if( CustomTypes.Length > 0 )
    {
        li_Games.Add(CustomGameCaption,None,"",True);

        for( i = 0; i < CustomTypes.Length; i++ )
        {
            if( HasMaps(CustomTypes[i]) )
            {
                if( CustomTypes[i].GameTypeGroup >= 3 )
                    AddEpicGameType( CustomTypes[i].GameName, CustomTypes[i].MapListClassName);
            }
        }
        li_Games.Insert(0,EpicGameCaption,None,"",True,True);
        li_Games.SetIndex(1);
    }
}

DefaultProperties
{
    MenuGameTypeFilter = F_Yes

    Begin Object Class=gGameTypeFilter Name=OGameTypeFilter
    End Object
    GameTypeFilter=OGameTypeFilter

    // Left Component Group
    Begin Object Class=GUISectionBackground Name=osb_Games
        WinWidth=0.482500
        WinHeight=0.793016
        WinLeft=0.023750
        WinTop=0.043125
        TabOrder=0
        TopPadding=0.025
        BottomPadding=0.025
        Caption="Available Game Types"
    End Object
    sb_Games=osb_Games

    Begin Object Class=GUIListBox Name=olb_Games
        WinWidth=0.438457
        WinHeight=0.699328
        WinLeft=0.045599
        WinTop=0.107583
        bSorted=True
        bBoundToParent=True
        bScaleToParent=True
        bVisibleWhenEmpty=True
        OnChange=InternalOnChange
        StyleName="NoBackground"
        SelectedStyleName="ListSelection"
        FontScale=FNS_Large
        TabOrder=0
    End Object
    lb_Games=olb_Games

    Begin Object Class=GUISectionBackground Name=osb_Options
        WinWidth=0.482149
        WinHeight=0.143505
        WinLeft=0.023750
        WinTop=0.849241
        Caption="Options"
        BottomPadding=0.07
    End Object
    sb_Options=osb_Options

    Begin Object Class=moCheckbox Name=och_GameTypeFilter
        OnChange=OnChange_GameTypeFilter
        WinWidth=0.397601
		WinHeight=0.034549
		WinLeft=0.059730
		WinTop=0.930337
        Caption="Only Compatible Game Types"
        Hint="Hides all game types that might be incompatible."
        TabOrder=1
        bAutoSizeCaption=True
        ComponentWidth=0.1
        CaptionWidth=0.9
        bSquare=True
    End Object
    ch_GameTypeFilter=och_GameTypeFilter
}