// ============================================================================
//  gShoppingHelp.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShoppingHelp extends gShopWindow;

var automated GUIbutton b_Close;
var automated GUITabControl t_Tabs;

function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
	local GUITabPanel p;
	
    Super.InitComponent(MyController, MyComponent);

	p = t_Tabs.AddTab("Shopping", "GMenu.gTabHelpShop");
	p.MyButton.Style = Controller.GetStyle("TabButtonFixed", FontScale);
	
	p = t_Tabs.AddTab("Gunreal Tips", "GMenu.gTabHelpTips");
	p.MyButton.Style = Controller.GetStyle("TabButtonFixed", FontScale);
}

function bool AllowOpen(string MenuClass)
{
    if( MenuClass ~= "GMenu.gShoppingHelp" )
        return False;
    else
        return True;
}

function bool OnPreDraw_Tabs(Canvas C)
{
    // fixed size
    t_Tabs.TabHeight =  0.06 * (480/C.ClipY);

    return False;
}

DefaultProperties
{
    WindowName      = "Gunreal Help"
    OpenSound       = Sound'G_Sounds.Interface.help1'

	Begin Object Class=GUITabControl Name=OTabs
        OnPreDraw=OnPreDraw_Tabs
        WinWidth=0.920000
        WinHeight=0.80
        WinLeft=0.040000
        WinTop=0.05
		TabHeight=0.04
		bFillSpace=False
		bAcceptsInput=true
		bDockPanels=true
		BackgroundStyleName="gNoBackgroundFixed"
		StyleName="gNoBackgroundFixed"
	End Object
	t_Tabs=OTabs

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
}
