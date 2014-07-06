// ============================================================================
//  gmoComboBox.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gmoComboBox extends moComboBox;

var() string ComponentStyleName;

function InternalOnCreateComponent(GUIComponent NewComp, GUIComponent Sender)
{
    Super.InternalOnCreateComponent(NewComp, Sender);
    NewComp.StyleName = ComponentStyleName;
}


DefaultProperties
{
    ComponentClassName="GMenu.gGUIComboBox"
}
