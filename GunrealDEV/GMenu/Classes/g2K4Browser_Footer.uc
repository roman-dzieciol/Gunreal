// ============================================================================
//  g2K4Browser_Footer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4Browser_Footer extends UT2k4Browser_Footer;



function gHide( GUIComponent C )
{
    C.DisableMe();
    C.Hide();
}

function gShow( GUIComponent C )
{
    C.EnableMe();
    C.Show();
}

function UpdateActiveButtons(UT2K4Browser_Page CurrentPanel)
{
    if( CurrentPanel == None )
        return;

    UpdateButtonState( b_Join,     CurrentPanel.IsJoinAvailable( b_Join.Caption ) );
    UpdateButtonState( b_Refresh,  CurrentPanel.IsRefreshAvailable( b_Refresh.Caption ) );
    UpdateButtonState( b_Spectate, CurrentPanel.IsSpectateAvailable( b_Spectate.Caption ) );

    gHide(b_Filter);
    gHide(ch_Standard);
}

DefaultProperties
{

}