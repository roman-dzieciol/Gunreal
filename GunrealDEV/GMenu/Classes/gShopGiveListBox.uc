// ============================================================================
//  gShopGiveListBox.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopGiveListBox extends GUIMultiColumnListBox;


function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
    Super.InitComponent(MyController, MyComponent);
}

function int GetSelectedPlayerID()
{
    if( gShopGiveList(List) != None )
        return gShopGiveList(List).GetSelectedPlayerID();
    else
        return -1;
}

function UpdatePRIS()
{
    if( gShopGiveList(List) != None )
        gShopGiveList(List).UpdatePRIS();
}

DefaultProperties
{
    DefaultListClass        = "GMenu.gShopGiveList"
}
