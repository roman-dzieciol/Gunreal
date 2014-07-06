// ============================================================================
//  gShopWeaponList.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopWeaponList extends GUIMultiOptionList;

function WheelDown()
{
    if( MyScrollBar != None )
    {
        // Gunreal: don't
        if( Top == 0 && ItemCount <= ItemsPerPage )
            return;

        if( Controller.CtrlPressed )
            MyScrollBar.MoveGripBy(ItemsPerPage);
        else
            MyScrollBar.MoveGripBy(1);
    }
    else
    {
        if( !Controller.CtrlPressed )
            Down();
        else
            PgDn();
    }
}

function bool InternalOnClick(GUIComponent Sender)
{
    local int NewIndex;

    //Log( "InternalOnClick" @Sender, name );

    if( ItemsPerPage == 0 )
        return False;

    NewIndex = CalculateIndex();

    if( !IsValidIndex(NewIndex) )
        return False;

    SilentSetIndex(NewIndex);

    // We must intercept the menu options's OnClick delegate, since most don't handle the click event unless
    // the click was on their component
    // However, we need to know when the option is clicked, so that I can send the notification upwards
    // Using the normal OnChange() chain of events is no good here, since GUIMultiOptionList passes OnChange()
    // to indicate that a component's value has changed

    // But I still need to allow a way for modders MenuOption subclasses to receive the OnClick as well
    if( GUIMenuOption(Sender) != None && !GUIMenuOption(Sender).MenuOptionClicked(Sender) )
        return True;

    if( Sender != Self )
        OnClick(Self);

    return True;
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
}