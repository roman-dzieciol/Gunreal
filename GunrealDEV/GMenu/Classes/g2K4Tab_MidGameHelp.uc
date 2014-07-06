//-----------------------------------------------------------
//
//-----------------------------------------------------------
class g2K4Tab_MidGameHelp extends UT2K4Tab_MidGameHelp;




function Timer()
{
	local PlayerController PC;
	local int i;
	local array<string> GameTypeHints;

	PC = PlayerOwner();
	if (PC != None && PC.GameReplicationInfo != None && PC.GameReplicationInfo.GameClass != "")
	{
		GameClass = class<GameInfo>(DynamicLoadObject(PC.GameReplicationInfo.GameClass, class'Class', True));
		if (GameClass != None)
		{
			//get game description and hints from game class
			GameDescriptionBox.SetContent(GameClass.default.Description);
			AllGameHints.Length = 0;
			
			for( i=0; i<class'gUT2K4ServerLoading'.default.LoadingMessages.Length; ++i )
			{
				AllGameHints[AllGameHints.Length] = class'gUT2K4ServerLoading'.default.LoadingMessages[i];
			}
			
			GameTypeHints = GameClass.static.GetAllLoadHints();
			for( i=0; i<GameTypeHints.Length; ++i )
			{
				AllGameHints[AllGameHints.Length] = GameTypeHints[i];
			}
			
			if (AllGameHints.length > 0)
			{
				for (i = 0; i < AllGameHints.length; i++)
				{
					AllGameHints[i] = class'gUT2K4ServerLoading'.static.ParseLoadingHint(AllGameHints[i], PC, HintsBox.Style.FontColors[HintsBox.MenuState]);
					if (AllGameHints[i] == "")
					{
						AllGameHints.Remove(i, 1);
						i--;
					}
				}
				HintsBox.SetContent(AllGameHints[CurrentHintIndex]);
				HintCountLabel.Caption = string(CurrentHintIndex + 1) @ "/" @ string(AllGameHints.length);
				EnableComponent(PrevHintButton);
				EnableComponent(NextHintButton);
			}

			KillTimer();
			bReceivedGameClass = true;
		}
	}
}


DefaultProperties
{

}