// ============================================================================
//  gGUIFixedComboBox.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGUIFixedComboBox extends gGUIComboBox;



DefaultProperties
{
    Begin Object Class=GUIEditBox Name=OEditBox1
        bNeverScale=True
        TextStr=""
        RenderWeight=0.5
        StyleName="gFixedEditBox"
    End Object
    Edit=OEditBox1

    Begin Object Class=GUIComboButton Name=OShowList
        bNeverScale=True
        bRepeatClick=False
        bTabStop=False
        RenderWeight=0.6
    End Object
    MyShowListBtn=OShowList

    Begin Object Class=GUIListBox Name=OListBox1
        bNeverScale=True
        StyleName="gFixedComboListBox"
        SelectedStyleName="gFixedListSelection"
        bVisible=False
        FontScale=FNT_Medium
        bTabStop=False
        RenderWeight=0.7
    End Object
    MyListBox=OListBox1
}
