// ============================================================================
//  gInvasion.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gInvasion extends Invasion;


function Bot SpawnBot(optional string botName)
{
    local Bot NewBot;
    local RosterEntry Chosen;
    local UnrealTeamInfo BotTeam;
    local array<xUtil.PlayerRecord> PlayerRecords;
    local xUtil.PlayerRecord PR;

    BotTeam = GetBotTeam();
    if( bCustomBots && (class'DMRosterConfigured'.Default.Characters.Length > NumBots)  )
    {
        class'xUtil'.static.GetPlayerList(PlayerRecords);
        PR = class'xUtil'.static.FindPlayerRecord(class'DMRosterConfigured'.Default.Characters[NumBots]);
        Chosen = class'xRosterEntry'.Static.CreateRosterEntry(PR.RecordIndex);
    }

    if( Chosen == None )
    {
        if( SecondBot > 0 )
        {
            BotName = InvasionBotNames[SecondBot + 1];
            SecondBot++;
            if ( SecondBot > 6 )
                SecondBot = 0;
        }
        else
        {
            SecondBot = 1 + 2 * Rand(4);
            BotName = InvasionBotNames[SecondBot];
        }
        Chosen = class'xRosterEntry'.static.CreateRosterEntryCharacter(botName);
    }

    if( Chosen.PawnClass == None )
        Chosen.Init();

    // Gunreal: use our bot class
    NewBot = Spawn(class'gBot');
    if( NewBot != None )
    {
        AdjustedDifficulty = AdjustedDifficulty + 2;
        InitializeBot(NewBot,BotTeam,Chosen);
        AdjustedDifficulty = AdjustedDifficulty - 2;
        NewBot.bInitLifeMessage = true;
    }
    return NewBot;
}


DefaultProperties
{

    GameName="Gunreal Invasion"
}