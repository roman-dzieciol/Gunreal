// ============================================================================
//  gShopSelectList.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopSelectList extends GUIMultiColumnList;

var gShopMenu ShopMenu;


function MyOnDrawItem(Canvas Canvas, int i, float X, float Y, float W, float H, bool bSelected, bool bPending)
{
    local float CellLeft, CellWidth;
    local class<gWeapon> WC;

    if( bSelected )
        SelectedStyle.Draw(Canvas, MSAT_Pressed, X, Y-2, W, H+2 );

    WC = ShopMenu.Shop.GetLoadoutWeapon(i);
    if( WC == None )
        return;

    GetCellLeftWidth( 0, CellLeft, CellWidth );
    Style.DrawText( Canvas, MenuState, CellLeft, Y, CellWidth, H, TXTA_Center, "$"$WC.default.CostWeapon, FontScale );

    GetCellLeftWidth( 1, CellLeft, CellWidth );
    Style.DrawText( Canvas, MenuState, CellLeft, Y, CellWidth, H, TXTA_Center, "$"$WC.default.CostAmmo, FontScale );

    GetCellLeftWidth( 2, CellLeft, CellWidth );
    Style.DrawText( Canvas, MenuState, CellLeft, Y, CellWidth, H, TXTA_Center, string(WC.default.ItemSize), FontScale );

    GetCellLeftWidth( 3, CellLeft, CellWidth );
    Style.DrawText( Canvas, MenuState, CellLeft, Y, CellWidth, H, TXTA_Left, WC.default.ItemName, FontScale );
}

function string GetSortString(int i)
{
    local class<gWeapon> WC;

    WC = ShopMenu.Shop.GetLoadoutWeapon(i);
    if( WC == None )
       return "";

    return WC.default.ItemName;
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
    if( Super.InternalOnKeyEvent(Key, State, delta) )
        return True;

    /*if( State==1 )
    {
        switch( Key )
        {
        case 0x0D: //IK_Enter
            MyServersList.Connect(False);
            return True;
            break;
        case 0x74: //IK_F5
            MyPage.RefreshList();
            return True;
            break;
        }
    }*/
    return False;
}

DefaultProperties
{

    SortColumn              = 0
    OnDrawItem              = MyOnDrawItem
    OnKeyEvent              = InternalOnKeyEvent

    bVisible                = True
    bVisibleWhenEmpty       = True
    RenderWeight            = 1

    Hint                    = "Select weapons"
    bMultiSelect            = False
    ExpandLastColumn        = True
}
