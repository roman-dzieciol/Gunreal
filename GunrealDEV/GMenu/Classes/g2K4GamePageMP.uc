// ============================================================================
//  g2K4GamePageMP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4GamePageMP extends UT2K4GamePageMP;

function StartGame(string GameURL, bool bAlt)
{
    local GUIController C;

    C = Controller;

    if( bAlt )
    {
        if( mcServerRules != None )
            GameURL $= mcServerRules.Play();

        // Append optional server flags
        PlayerOwner().ConsoleCommand("relaunch"@GameURL@"-mod=Gunreal -server -log=server.log");
    }
    else
        PlayerOwner().ClientTravel(GameURL $ "?Listen",TRAVEL_Absolute,False);

    C.CloseAll(False,True);
}

DefaultProperties
{

    PanelClass(0)="GMenu.g2K4Tab_GameTypeMP"
    PanelClass(1)="GMenu.g2K4Tab_MainSP"
    PanelClass(2)="GUI2K4.UT2K4Tab_RulesBase"
    PanelClass(3)="GMenu.g2K4Tab_MutatorMP"
    PanelClass(4)="GUI2K4.UT2K4Tab_BotConfigMP"
    PanelClass(5)="GUI2K4.UT2K4Tab_ServerRulesPanel"
}