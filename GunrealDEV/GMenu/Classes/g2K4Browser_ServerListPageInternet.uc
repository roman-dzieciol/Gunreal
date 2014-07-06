// ============================================================================
//  g2K4Browser_ServerListPageInternet.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4Browser_ServerListPageInternet extends UT2k4Browser_ServerListPageInternet;


function Refresh()
{
    GameTypeChanged(UT2K4Browser_ServersList(Browser.co_GameType.GetObject()));

    Super(UT2K4Browser_ServerListPageMS).Refresh();

    SaveConfig();

    // hardcoded gMutator filter
    AddQueryTerm( "mutator", "gMutator", QT_Equals );

    // Run query
    Browser.Uplink().StartQuery(CTM_Query);
    SetFooterCaption(StartQueryString);
}

function ServerListChanged(GUIComponent Sender)
{
    local int i, j;
    local GameInfo.KeyValuePair pair;

    if( !bAllowUpdates || Controller.ContextMenu != None )
        return;

    li_Rules.Clear();
    li_Players.Clear();

    CheckSpectateButton(li_Server.IsValid());
    CheckJoinButton(li_Server.IsValid());

    i = li_Server.CurrentListId();
    if( i < 0 )
        return;

    // when changing selected servers, get their rules
    if( Sender != None )
        PingServer( i, PC_Clicked, li_Server.Servers[i]);

    // Gunreal: add gametype information
    pair.Key = "Gametype";
    pair.Value = li_Server.Servers[i].GameType;
    li_Rules.AddNewRule(pair);

    for( j = 0; j < li_Server.Servers[i].ServerInfo.Length; j++ )
        li_Rules.AddNewRule(li_Server.Servers[i].ServerInfo[j]);

    for( j = 0; j < li_Server.Servers[i].PlayerInfo.Length; j++ )
        li_Players.AddNewPlayer(li_Server.Servers[i].PlayerInfo[j]);

    li_Players.SortList();
    li_Rules.SortList();
}

DefaultProperties
{

}