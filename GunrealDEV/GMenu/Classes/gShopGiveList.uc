// ============================================================================
//  gShopGiveList.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopGiveList extends GUIMultiColumnList;

struct MyTestItem
{
    var int     Score;
    var int     Money;
    var string  PlayerName;
    var int     PlayerID;
};

var() array<MyTestItem> MyData;
var() float UpdateInterval;

function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
    Super.InitComponent(MyController, MyComponent);

    UpdatePRIS();

    SetTimer(UpdateInterval, True);
}

function Clear()
{
    MyData.Remove(0,MyData.Length);
    ItemCount = 0;
    Super.Clear();
}

event Timer()
{
    //Log("Timer");
    UpdatePRIS();
}

function UpdatePRIS()
{
    local int i,j;
    local GameReplicationInfo GRI;
    local array<PlayerReplicationInfo> NewPRIS;
    local PlayerReplicationInfo PRI;

    GRI = PlayerOwner().GameReplicationInfo;
    if( GRI != None )
        GRI.GetPRIArray( NewPRIS );

    for( i=0; i!=NewPRIS.Length; ++i )
    {
        // Remove invalid PRI's
        PRI = NewPRIS[i];
        if( PRI == None
        ||  PRI.bDeleteMe
        ||  PRI == PlayerOwner().PlayerReplicationInfo
        || (GRI.bTeamGame && PRI.Team != None && PRI.Team.TeamIndex != PlayerOwner().GetTeamNum()) )
        {
            NewPRIS.Remove(i,1);
            --i;
        }
    }

    for( i=0; i!=MyData.Length; ++i )
    {
        for( j=0; j!=NewPRIS.Length; ++j )
            if( MyData[i].PlayerID == NewPRIS[j].PlayerID )
                break;

        if( j != NewPRIS.Length )
        {
            // if found, update
            UpdateMyData(i,NewPRIS[j]);
            UpdatedItem(i);

            // Remove from list so only new ones will be left
            NewPRIS.Remove(j,1);
        }
        else
        {
            // else remove
            RemoveMyData(i);
            RemovedItem(i);
            --i;
        }
    }

    // Append new PRI
    for( i=0; i!=NewPRIS.Length; ++i )
    {
        j = MyData.Length;
        UpdateMyData(j,NewPRIS[i]);
        AddedItem(j);
    }

    NeedsSorting = True;
}

function UpdateMyData( int idx, PlayerReplicationInfo PRI )
{
    local MyTestItem TI;
    local gPRI GPRI;
    local int Money;

    GPRI = class'gPRI'.static.GetGPRI(PRI);
    if( GPRI != None )
        Money = GPRI.GetMoney();

    //Log("UpdateMyData" @PRI.PlayerName @GPRI @PRI.PlayerID  @Money );

    TI.Score = PRI.Score;
    TI.Money = Money;
    TI.PlayerName = PRI.PlayerName;
    TI.PlayerID = PRI.PlayerID;
    MyData[idx] = TI;
}

function RemoveMyData( int idx )
{
    MyData.Remove(idx,1);
}

function DrawItem(Canvas Canvas, int i, float X, float Y, float W, float H, bool bSelected, bool bPending)
{
    local float CellLeft, CellWidth;
    local string S;
    local GUIStyles DrawStyle;

    if( i >= SortData.Length || SortData[i].SortItem >= MyData.Length )
        return;

    // Draw the selection border
    if( bSelected )
    {
        SelectedStyle.Draw(Canvas,MenuState, X, Y-2, W, H+2 );
        DrawStyle = SelectedStyle;
    }
    else
        DrawStyle = Style;

    S = string(MyData[SortData[i].SortItem].Score);
    GetCellLeftWidth( 0, CellLeft, CellWidth );
    DrawStyle.DrawText( Canvas, MenuState, CellLeft, Y, CellWidth, H, TXTA_Center, S, FontScale );

    S = "$" $MyData[SortData[i].SortItem].Money;
    GetCellLeftWidth( 1, CellLeft, CellWidth );
    DrawStyle.DrawText( Canvas, MenuState, CellLeft, Y, CellWidth, H, TXTA_Center, S, FontScale );

    S = MyData[SortData[i].SortItem].PlayerName;
    GetCellLeftWidth( 2, CellLeft, CellWidth );
    DrawStyle.DrawText( Canvas, MenuState, CellLeft, Y, CellWidth, H, TXTA_Left, S, FontScale );
}

event string GetSortString(int i)
{
    local string ColumnData[4];

    ColumnData[0] = Right("00000000" $MyData[i].Score,8);
    ColumnData[1] = Right("00000000" $MyData[i].Money,8);
    ColumnData[2] = Caps(MyData[i].PlayerName);

    return ColumnData[SortColumn] $ColumnData[2];
}

function int GetSelectedPlayerID()
{
    if( Index > -1 )
        return MyData[SortData[Index].SortItem].PlayerID;
    else
        return -1;
}

// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog ( coerce string S ){
    class'GDebug.gDbg'.static.oLog( self, GetDebugLevelRef(), S, gDebugString() );}

simulated function string gDebugString();

// ============================================================================
//  Debug String
// ============================================================================
simulated final static function string StrShort( coerce string S ){
    return class'GDebug.gDbg'.static.StrShort( S );}

simulated final static operator(112) string # ( coerce string A, coerce string B ){
    return class'GDebug.gDbg'.static.Pound_StrStr( A,B );}

simulated final static function name GON( Object O ){
    return class'GDebug.gDbg'.static.GON( O );}

simulated final function string GPT( string S ){
    return class'GDebug.gDbg'.static.GPT( self, S );}

// ============================================================================
//  Debug Visual
// ============================================================================
simulated final function DrawAxesRot( vector Loc, rotator Rot, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesRot( GetDebugLevelRef(), Loc, Rot, Length, bStaying );}

simulated final function DrawAxesCoords( Coords C, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesCoords( GetDebugLevelRef(), C, Length, bStaying );}

simulated final function DrawAxesXYZ( vector Loc, vector X, vector Y, vector Z, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesXYZ( GetDebugLevelRef(), Loc, X, Y, Z, Length, bStaying );}

simulated final static function VarWatch( coerce string Desc, coerce string Value, optional bool bGraph ){
    class'GDebug.gDbg'.static.VarWatch( Desc, Value, bGraph );}

// ============================================================================
//  Debug Misc
// ============================================================================
simulated final function LevelInfo GetDebugLevelRef(){
    return PlayerOwner().Level;}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    UpdateInterval              = 0.3

    OnDrawItem                  = DrawItem

    ColumnHeadings(0)           = "Score"
    ColumnHeadings(1)           = "Money"
    ColumnHeadings(2)           = "Name"

    InitColumnPerc(0)           = 0.15
    InitColumnPerc(1)           = 0.15
    InitColumnPerc(2)           = 0.7

    SortColumn                  = 2
    SortDescending              = False

    ColumnHeadingHints(0)       = ""
    ColumnHeadingHints(1)       = ""
    ColumnHeadingHints(2)       = ""

    StyleName                   = "ServerBrowserGrid"
    SelectedStyleName           = "BrowserListSelection"
}
