//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gUT2K4ServerLoading extends UT2K4ServerLoading;


var() localized array<string> LoadingMessages;
var() localized string ExtraTips;

simulated function SetImage()
{
	local int i, cnt;
	local string str;
	local material mat;

	mat = Material'MenuBlack';
	DrawOpImage(Operations[0]).Image = mat;

	if ( Backgrounds.Length == 0 )
	{
		Warn("No background images configured for"@Name);
		return;
	}

	do
	{
		i = Rand(Backgrounds.Length);
		str = Backgrounds[i];
		if ( str == "" )
		{
			Warn("Invalid value for "$Name$".Backgrounds["$i$"]");
		}
		else 
		{
			class'gPlayerHUD'.default.LastBackground = str;
			class'gPlayerHUD'.static.StaticSaveConfig();
			mat = DLOTexture(str);
		}
	}

	until (mat != None || ++cnt >= 10);

	if ( mat == None )
		Warn("Unable to find any valid images for vignette class"@name$"!");

	DrawOpImage(Operations[0]).Image = mat;
}

simulated function SetText()
{
	local DrawOpText HintOp;

	DrawOpText(Operations[2]).Text = "Loading" @ StripMap(MapName);

	if (Level.IsSoftwareRendering())
		return;

	HintOp = DrawOpText(Operations[3]);
	if ( HintOp == None )
		return;
	
	HintOp.Text = ExtraTips $ParseLoadingHint(default.LoadingMessages[Rand(LoadingMessages.Length)], Level.GetLocalPlayerController(), HintOp.DrawColor) ;
}

static function string ParseLoadingHint(string Hint, PlayerController Ref, color HintColor)
{
	local string CurrentHint, Cmd, Result;
	local int pos;

	pos = InStr(Hint, "%");
	if ( pos == -1 )
		return Hint;
		
	do
	{
		CurrentHint $= Left(Hint,pos);
		Hint = Mid(Hint, pos+1);
		pos = InStr(Hint, "%");
		if ( pos == -1 )
		{
			CurrentHint $= Hint;
			break;
		}

		Cmd = Left(Hint,pos);
		Result = class'GameInfo'.static.GetKeyBindName(Cmd,Ref);
		if( Result == Cmd || Result == "" )
			continue;
			
		CurrentHint $= class'GameInfo'.static.MakeColorCode(class'GameInfo'.default.BindColor) $ Result $ class'GameInfo'.static.MakeColorCode(HintColor);
		Hint = Mid(Hint, pos+1);
		pos = InStr(Hint, "%");
		if ( pos == -1 )
		{
			CurrentHint $= Hint;
			break;
		}
	} 
	until ( Hint == "" || pos == -1 );
	
	return CurrentHint;
}

DefaultProperties
{
	ExtraTips="See all tips in the in-game menu.|| ||"

	Begin Object Class=DrawOpImage Name=OpBackground
		Top=0
		Lft=0
		Width=1.0
		Height=1.0
		DrawColor=(R=255,B=255,G=255,A=255)
		SubXL=1024
		SubYL=768
	End Object
	Operations(0)=OpBackground

	Begin Object Class=DrawOpText Name=OpLoading
		Top=0.48
		Lft=0.05
		Height=0.5
		Width=0.93
		DrawColor=(R=0,B=0,G=0,A=255)
		Justification=1
		Text=""
		FontName="GMenu.gLoadingLargeFont"
		bWrapText=False
	End Object
	Operations(1)=OpLoading

	Begin Object Class=DrawOpText Name=OpMapname
		Top=0.48
		Lft=0.05
		Height=0.5
		Width=0.93
		DrawColor=(R=0,B=0,G=0,A=255)
		Justification=1
		Text="Loading"
		FontName="GMenu.gLoadingLargeFont"
		bWrapText=False
	End Object
	Operations(2)=OpMapname

	Begin Object Class=DrawOpText Name=OpHint
		Top=0.8
		Height=0.2
		Lft=0.05
		DrawColor=(R=192,B=192,G=192,A=255)
		Width=0.93
		Justification=0
		FontName="GMenu.gLoadingSmallFont"
	End Object
	Operations(3)=OpHint
	
	LoadingMessages(0)="You make $200 per kill, plus $1 damage-money for each point of damage dealt to players and vehicles (max of $200)."
	LoadingMessages(1)="You earn your damage money even if someone else makes the kill."
	LoadingMessages(2)="You can make any purchase as long as you aren't in debt, and as long as the purchase won't drain your cash further than -$500."
	LoadingMessages(3)="The Shopping Terminal's shield can take 200 damage before it is destroyed."
	LoadingMessages(4)="When killed, rich players drop 1/5 of any excess money over $2,000. For example, a player with $4,000 will drop $400 when killed."
	LoadingMessages(5)="You make $500 extra per level in a Spree."
	LoadingMessages(6)="You make $200 extra per level in a Multi-kill."
	LoadingMessages(7)="You can give money to anyone on your team, by clicking the money button that displays your current cash on the Shopping Screen."
	LoadingMessages(8)="In team-games, excess money you make beyond $10,000 is evenly distributed among your team."
	LoadingMessages(9)="Press 'Use' (%USE%) to pick up a weapon off the ground, or 'Throw Weapon' (%THROWWEAPON%) to swap it with the one you're holding."
	LoadingMessages(10)="The Survival Timer appears when you've been alive for 3 minutes, and gives you a $200 bonus per kill."
	LoadingMessages(11)="The No-Kill Timer appears when you haven't made a kill for 2 minutes, and gives you 1x cash-doubling for your next kill. Every 30 seconds that you don't make a kill, the doubler goes up by one (maximum of 5), and each number increases the value of your next kill by $200 (so 3x will give you $600 extra)."
	LoadingMessages(12)="The No-Kill Timer stops counting when you make a kill, and resets its 2-minute timer. When actively counting up, it pauses while you're dead, but resumes immediately when you respawn. Like all Timers, the cash-doublers you've earned remain until you spend them."
	LoadingMessages(13)="Headshots deal 2x more damage than body-shots."
	LoadingMessages(14)="The Heavy Rocket Launcher has a front-facing defensive shield that activates when you crouch. It can absorb 100 damage, and deflect Plasma Balls entirely."
	LoadingMessages(15)="Teleportation creates a blast at your destination that damages nearby players."
	LoadingMessages(16)="Ammo is included in the cost of buying and selling weapons, so bear in mind that when you sell a gun that is depleted of ammo, it will be worth less than a freshly-bought weapon."
	LoadingMessages(17)="The duration of Acid health-drain can be shortened by Mini-Health pickups, or removed entirely by regular Health pickups."
	LoadingMessages(18)="The Heavy Rocket Launcher, Explosive Minigun, and Armor-Piercing Minigun are only available in vehicular game-modes."
	LoadingMessages(19)="You can perform a high crouch-jump by crouching, then jumping."
	LoadingMessages(20)="If you buy a weapon via right-click, it will come with a Warranty (costs 30% extra). Red Warranties give you a full refund on the weapon value if you die without either making a kill, or dealing 200 damage to infantry with that weapon."
	LoadingMessages(21)="Kill-dropped weapons that you pick up come with a Green Warranty, worth half the weapon's value. Like Red Warranties, green ones are spent if you make a kill with that weapon, or deal 200 damage to infantry."
	LoadingMessages(22)="You can sell weapons for half value at Shopping Terminals, by right-clicking on them in the Shopping Screen's weapon belt. (or on owned weapons in the list)"
	LoadingMessages(23)="If you already own a weapon, right-clicking on it in the shopping list will sell it, rather than buy a Warranty."
	LoadingMessages(24)="You can buy more ammo for owned weapons by left-clicking on them."
	LoadingMessages(25)="Right-clicking on an owned weapon that has a Warranty will sell the Warranty itself first, then the weapon."
	LoadingMessages(26)="You can read these tips by also by hitting Escape ingame, and going to Help."
	LoadingMessages(27)="If you can't afford any weapons, switch your special ability to Money Boost."
	LoadingMessages(28)="In Capture the Flag, the flag carrier can crouch and remain still to activate a Healing Ward that heals all nearby players (including enemies)."
}