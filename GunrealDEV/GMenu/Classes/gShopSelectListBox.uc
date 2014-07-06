// ============================================================================
//  gShopSelectListBox.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopSelectListBox extends GUIMultiColumnListBox;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);
}


DefaultProperties
{
    StyleName               = "ListBox"
    DefaultListClass        = "GMenu.gShopSelectList"

    ColumnHeadings(0)       = "$G"
    ColumnHeadings(1)       = "$A"
    ColumnHeadings(2)       = "S"
    ColumnHeadings(3)       = "Name"

    HeaderColumnPerc(0)     = 0.15
    HeaderColumnPerc(1)     = 0.15
    HeaderColumnPerc(2)     = 0.1
    HeaderColumnPerc(3)     = 0.6
}
