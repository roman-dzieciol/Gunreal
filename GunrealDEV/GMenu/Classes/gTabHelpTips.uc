//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gTabHelpTips extends gTabHelp;


function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
	local int i;
	local string S;
	
    Super.InitComponent(MyController, MyComponent);
	
	Text = "";
	for( i=0; i<class'gUT2K4ServerLoading'.default.LoadingMessages.Length; ++i )
	{
		S = class'gUT2K4ServerLoading'.static.ParseLoadingHint(class'gUT2K4ServerLoading'.default.LoadingMessages[i], PlayerOwner(), lb_Desc.Style.FontColors[0]);
		Text = Text $(i+1) $") " $S $"|| ||";
	}
	
    // load text
    lb_Desc.SetContent(Text);
}


DefaultProperties
{

}
