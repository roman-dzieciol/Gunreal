// ============================================================================
//  gShoppingGive.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShoppingGive extends gShopWindow;

var() localized string Text;

//var automated GUIImage i_ListBG;
var automated gShopGiveListBox lb_Give;
var automated GUIButton b_Close;
var automated GUILabel l_Desc;

var automated GUIButton b_Give1h;
var automated GUIButton b_Give2h;
var automated GUIButton b_Give5h;
var automated GUIButton b_Give1k;
var automated GUIButton b_Give2k;
var automated GUIButton b_Give5k;
var automated GUIButton b_GiveAll;

function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
    Super.InitComponent(MyController, MyComponent);

    // make scrollbar fixed size
    lb_Give.MyScrollBar.WinWidth = 16;
    lb_Give.MyList.OnChange = OnChange_PlayerList;
    OnChange_PlayerList(None);
}

function bool AllowOpen(string MenuClass)
{
    if( MenuClass ~= "GMenu.gShoppingGive" )
        return False;
    else
        return True;
}

function OnChange_PlayerList(GUIComponent Sender)
{
    local int TargetID;

    TargetID = lb_Give.GetSelectedPlayerID();
    if( TargetID == -1 )
    {
        gHide(b_Give1h);
        gHide(b_Give2h);
        gHide(b_Give5h);
        gHide(b_Give1k);
        gHide(b_Give2k);
        gHide(b_Give5k);
        gHide(b_GiveAll);
    }
    else
    {
        gShow(b_Give1h);
        gShow(b_Give2h);
        gShow(b_Give5h);
        gShow(b_Give1k);
        gShow(b_Give2k);
        gShow(b_Give5k);
        gShow(b_GiveAll);
    }
}

function bool OnClick_ButtonGive( GUIComponent Sender )
{
    local int TargetID;
    local int Amount;
    local gPRI GPRI;

    Amount = Sender.Tag;
    if( Amount == -1 )
        return True;

    TargetID = lb_Give.GetSelectedPlayerID();
    if( TargetID == -1 )
        return True;

    GPRI = class'gPRI'.static.GetGPRI(PlayerOwner().PlayerReplicationInfo);
    if( GPRI != None )
    {
        GPRI.DonateMoney(TargetID,Amount);
        lb_Give.UpdatePRIS();
    }

    return True;
}

DefaultProperties
{
    WindowName      = "Give Money"

    Begin Object Class=GUILabel Name=o_Desc
        WinWidth=0.96
        WinHeight=0.05
        WinLeft=0.020000
        WinTop=0.05
        bBoundToParent=True
        bScaleToParent=True
        Caption="Select a player from the list then click a button on the right."
        TextAlign=TXTA_Left
        StyleName="gNoBackgroundFixed"
    End Object
    l_Desc=o_Desc

    Begin Object Class=GUIImage Name=o_ListBG
        Image=Texture'Engine.WhiteTexture'
        DropShadow=None
        ImageStyle=ISTY_Stretched
        ImageRenderStyle=MSTY_Alpha
        WinWidth=0.65
        WinHeight=0.750000
        WinLeft=0.020000
        WinTop=0.100000
        ImageColor=(R=255,G=255,B=255,A=30)
    End Object
    //i_ListBG=o_ListBG

    Begin Object Class=gShopGiveListBox Name=OGive
        WinWidth=0.65
        WinHeight=0.750000
        WinLeft=0.020000
        WinTop=0.100000
        bNeverFocus=False
        bAcceptsInput=True
        StyleName="gNoBackgroundFixed"
        bScaleToParent=True
        bBoundToParent=True
    End Object
    lb_Give=OGive

    Begin Object Class=GUIButton Name=OClose
        WinWidth=0.2
        WinHeight=0.100000
        WinLeft=0.4
        WinTop=0.870000
        bBoundToParent=True
        bScaleToParent=True
        Caption="Done"
        StyleName="gShopButton"
        Hint="Close help."
        OnClick=XButtonClicked
    End Object
    b_Close=OClose


    Begin Object Class=GUIButton Name=o_Give1h
        WinWidth=0.31
        WinHeight=0.100000
        WinLeft=0.67
        WinTop=0.1
        bBoundToParent=True
        bScaleToParent=True
        Caption="Give $100"
        StyleName="gShopButton"
        Tag=100
        OnClick=OnClick_ButtonGive
    End Object
    b_Give1h=o_Give1h

    Begin Object Class=GUIButton Name=o_Give2h
        WinWidth=0.31
        WinHeight=0.100000
        WinLeft=0.67
        WinTop=0.21
        bBoundToParent=True
        bScaleToParent=True
        Caption="Give $200"
        StyleName="gShopButton"
        Tag=200
        OnClick=OnClick_ButtonGive
    End Object
    b_Give2h=o_Give2h

    Begin Object Class=GUIButton Name=o_Give5h
        WinWidth=0.31
        WinHeight=0.100000
        WinLeft=0.67
        WinTop=0.32
        bBoundToParent=True
        bScaleToParent=True
        Caption="Give $500"
        StyleName="gShopButton"
        Tag=500
        OnClick=OnClick_ButtonGive
    End Object
    b_Give5h=o_Give5h

    Begin Object Class=GUIButton Name=o_Give1k
        WinWidth=0.31
        WinHeight=0.100000
        WinLeft=0.67
        WinTop=0.43
        bBoundToParent=True
        bScaleToParent=True
        Caption="Give $1000"
        StyleName="gShopButton"
        Tag=1000
        OnClick=OnClick_ButtonGive
    End Object
    b_Give1k=o_Give1k

    Begin Object Class=GUIButton Name=o_Give2k
        WinWidth=0.31
        WinHeight=0.100000
        WinLeft=0.67
        WinTop=0.54
        bBoundToParent=True
        bScaleToParent=True
        Caption="Give $2000"
        StyleName="gShopButton"
        Tag=2000
        OnClick=OnClick_ButtonGive
    End Object
    b_Give2k=o_Give2k

    Begin Object Class=GUIButton Name=o_Give5k
        WinWidth=0.31
        WinHeight=0.100000
        WinLeft=0.67
        WinTop=0.65
        bBoundToParent=True
        bScaleToParent=True
        Caption="Give $5000"
        StyleName="gShopButton"
        Tag=5000
        OnClick=OnClick_ButtonGive
    End Object
    b_Give5k=o_Give5k

    Begin Object Class=GUIButton Name=o_GiveAll
        WinWidth=0.31
        WinHeight=0.100000
        WinLeft=0.67
        WinTop=0.76
        bBoundToParent=True
        bScaleToParent=True
        Caption="Give Everything"
        StyleName="gShopButton"
        Tag=0
        OnClick=OnClick_ButtonGive
    End Object
    b_GiveAll=o_GiveAll
}
