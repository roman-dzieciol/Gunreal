// ============================================================================
//  g2K4Browser_ServerListBox.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4Browser_ServerListBox extends UT2k4Browser_ServerListBox;

function bool InternalOnOpen(GUIContextMenu Sender)
{
    Sender.ContextItems.Remove(0, Sender.ContextItems.Length);
    if( List.IsValid() )
    {
        Sender.ContextItems = ContextItems;
        RemoveFilterOptions(Sender);
    }
    else
    {
        Sender.ContextItems[0] = ContextItems[ADDFAVIDX];
        Sender.ContextItems[1] = ContextItems[OPENIPIDX];
    }

    return True;
}

DefaultProperties
{
}