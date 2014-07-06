// ============================================================================
//  gMainMenu.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMainMenu extends UT2K4GUIPage;


var automated   BackgroundImage     i_Background;

var automated   GUILabel            l_Seperator;
var automated   GUILabel            l_Seperator2;
var automated   GUILabel            l_Seperator3;
var automated   GUILabel            l_RightClick;
var automated   GUILabel            l_CurrentVersion;

var automated   GUIButton           b_Singleplayer;
var automated   GUIButton           b_Multiplayer;
var automated   GUIButton           b_Botmatch;
var automated   GUIButton           b_Campaign;
var automated   GUIButton           b_HostGame;
var automated   GUIButton           b_JoinGame;
var automated   GUIButton           b_Credits;
var automated   GUIButton           b_Options;
var automated   GUIButton           b_Quit;
var automated   GUIButton           b_UpdateVersion;

var             bool                bAllowClose;

var() config    string              MenuSong;

var localized   string              FireWallTitle;
var localized   string              FireWallMsg;

var() class<Emitter> LogoEmitterClass;
var() vector LogoEmitterOffset;
var Emitter LogoEmitter;

var string CreditsPage;

var int LatestVersion;
var int CurrentVersion;

var() string GunrealURL[2];
var() gVersionCheck VersionCheck;

var float HideCreditsTime;

var bool bForcedMusic;

var float IngameMusicVolume;
var config float MenuMusicVolume;
var config bool bMenuMusicInitialized;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

    class'UT2K4SPTab_Base'.default.ProfileClass                     = class'gGameProfile';
    class'UT2K4SPTab_DetailEnemies'.default.ProfileClass            = class'gGameProfile';
    class'UT2K4SPTab_DetailMatch'.default.ProfileClass              = class'gGameProfile';
    class'UT2K4SPTab_DetailPhantom'.default.ProfileClass            = class'gGameProfile';
    class'UT2K4SPTab_ExtraLadder'.default.ProfileClass              = class'gGameProfile';
    class'UT2K4SPTab_LadderBase'.default.ProfileClass               = class'gGameProfile';
    class'UT2K4SPTab_Ladder'.default.ProfileClass                   = class'gGameProfile';
    class'UT2K4SPTab_SingleLadder'.default.ProfileClass             = class'gGameProfile';
    class'UT2K4SPTab_CustomLadder'.default.ProfileClass             = class'gGameProfile';
    class'UT2K4SPTab_Qualification'.default.ProfileClass            = class'gGameProfile';
    class'UT2K4SPTab_TeamQualification'.default.ProfileClass        = class'gGameProfile';
    class'UT2K4SPTab_Profile'.default.ProfileClass                  = class'gGameProfile';
    class'UT2K4SPTab_ProfileNew'.default.ProfileClass               = class'gGameProfile';
    class'UT2K4SPTab_TeamManagement'.default.ProfileClass           = class'gGameProfile';
    class'UT2K4SPTab_Tutorials'.default.ProfileClass                = class'gGameProfile';

    Background = MyController.DefaultPens[0];

    b_UpdateVersion.Hide();
    b_UpdateVersion.DisableMe();
    SetTimer(0.66, True);

    if( !default.bMenuMusicInitialized )
    {
        default.bMenuMusicInitialized = True;
        default.MenuMusicVolume = float(PlayerOwner().ConsoleCommand("get ini:Engine.Engine.AudioDevice SoundVolume"));
        StaticSaveConfig();
    }

    // Force music, play with own volume
	Log("MENU MUSIC" @MenuSong);
    IngameMusicVolume = float(PlayerOwner().ConsoleCommand("get ini:Engine.Engine.AudioDevice MusicVolume"));
    PlayerOwner().ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume" @default.MenuMusicVolume);
    PlayerOwner().ConsoleCommand("SetMusicVolume" @default.MenuMusicVolume);
    PlayerOwner().StopAllMusic(0);
    PlayerOwner().ClientSetMusic(MenuSong, MTRAN_FastFade);
}

function OnNewVersion( int Version )
{
    b_UpdateVersion.bVisible = True;
    b_UpdateVersion.Caption = "Download v" $Version;
    b_UpdateVersion.Tag = 1;
    b_UpdateVersion.EnableMe();
    b_UpdateVersion.Show();
}

function Opened(GUIComponent Sender)
{
    if( bDebugging )
        log(Name$".Opened()   Sender:"$Sender,'Debug');

    if( Sender != None && PlayerOwner().Level.IsPendingConnection() )
        PlayerOwner().ConsoleCommand("CANCEL");

    b_Singleplayer.bVisible = True;
    b_Multiplayer.bVisible = True;
    b_Botmatch.bVisible = False;
    b_Campaign.bVisible = False;
    b_HostGame.bVisible = False;
    b_JoinGame.bVisible = False;
    b_Credits.bVisible = False;
    l_Seperator3.bVisible = False;
    l_RightClick.bVisible = False;

    Super.Opened(Sender);
}

function InternalOnOpen()
{
    Controller.PerformRestore();
}

function bool InternalOnKeyEvent(out byte Key,out byte State,float delta)
{
    if( Key == 0x1B && state == 1 )  // Escape pressed
        bAllowClose = True;

    return False;
}

function bool InternalOnCanClose(optional bool bCancelled)
{
    if( bAllowClose )
        ButtonClick(b_Quit);

    bAllowClose = False;

    return PlayerOwner().Level.IsPendingConnection();
}

function InternalOnReopen()
{
    if( !PlayerOwner().Level.IsPendingConnection() )
        Opened(None);
}

function bool InternalOnRightClick(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    if( !b_Singleplayer.bVisible )
    {
        b_Singleplayer.bVisible = True;
        b_Multiplayer.bVisible = True;
        b_Botmatch.bVisible = False;
        b_Campaign.bVisible = False;
        b_HostGame.bVisible = False;
        b_JoinGame.bVisible = False;
        l_RightClick.bVisible = False;
    }

    return True;
}

function OnClose(optional Bool bCancelled)
{
    if( LogoEmitter != None )
    {
        LogoEmitter.Destroy();
        LogoEmitter = None;
    }

    PlayerOwner().ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume" @IngameMusicVolume);
    PlayerOwner().ConsoleCommand("SetMusicVolume" @IngameMusicVolume);
}

function bool ButtonClick(GUIComponent Sender)
{
    if( !Sender.IsInBounds() )
        return False;

    switch( Sender )
    {
        case b_Singleplayer:
            b_Singleplayer.bVisible = False;
            b_Multiplayer.bVisible = False;
            b_Botmatch.bVisible = True;
            b_Campaign.bVisible = True;
            l_RightClick.bVisible = True;
            return True;

        case b_Multiplayer:
            b_Singleplayer.bVisible = False;
            b_Multiplayer.bVisible = False;
            b_HostGame.bVisible = True;
            b_JoinGame.bVisible = True;
            l_RightClick.bVisible = True;
            return True;

        case b_Botmatch:
            Profile("InstantAction");
            Controller.OpenMenu(Controller.GetInstantActionPage());
            Profile("InstantAction");
            return True;

        case b_Campaign:
            Profile("SinglePlayer");
            Controller.OpenMenu(Controller.GetSinglePlayerPage());
            Profile("SinglePlayer");
            return True;

        case b_JoinGame:
            if( !Controller.AuthroizeFirewall() )
            {
                Controller.OpenMenu("GUI2K4.UT2K4GenericMessageBox", FireWallTitle, FireWallMsg);
                return False;
            }

            Profile("ServerBrowser");
            Controller.OpenMenu(Controller.GetServerBrowserPage());
            Profile("ServerBrowser");
            return True;

        case b_HostGame:
            if( !Controller.AuthroizeFirewall() )
            {
                Controller.OpenMenu("GUI2K4.UT2K4GenericMessageBox",FireWallTitle,FireWallMsg);
                return False;
            }

            Profile("MPHost");
            Controller.OpenMenu(Controller.GetMultiplayerPage());
            Profile("MPHost");
            return True;

        case b_Options:
            Profile("Settings");
            Controller.OpenMenu(Controller.GetSettingsPage());
            Profile("Settings");
            return True;

        case b_Credits:
            Profile("Credits");
            Controller.OpenMenu(CreditsPage);
            Profile("Credits");
            return True;

        case b_Quit:
            Profile("Quit");
            Controller.OpenMenu(Controller.GetQuitPage());
            Profile("Quit");
            return True;

        case b_UpdateVersion:
            Profile("UpdateVersion");
            PlayerOwner().ConsoleCommand("START" @GunrealURL[Sender.Tag]);
            Profile("UpdateVersion");
            return True;

        default:
            StopWatch(True);
    }

    return True;
}

function bool ButtonHover(GUIComponent Sender)
{
    switch( Sender )
    {
        case b_Options:
            b_Credits.bVisible = True;
            l_Seperator3.bVisible = True;
            l_CurrentVersion.bVisible = False;

            HideCreditsTime = PlayerOwner().Level.TimeSeconds + 3;
            return True;

        case b_UpdateVersion:
            l_CurrentVersion.bVisible = True;
            return True;

        default:
            l_CurrentVersion.bVisible = False;
            b_Credits.bVisible = False;
            l_Seperator3.bVisible = False;
            return True;
    }

    return True;
}

event Timer()
{
    if( b_Credits.bVisible && HideCreditsTime < PlayerOwner().Level.TimeSeconds )
    {
        b_Credits.bVisible = False;
        l_Seperator3.bVisible = False;
    }

    if( VersionCheck == None && PlayerOwner() != None && Viewport(PlayerOwner().Player) != None )
    {
        VersionCheck = PlayerOwner().Spawn(class'gVersionCheck');
        VersionCheck.OnNewVersion = OnNewVersion;
    }
}

function bool NotifyLevelChange()
{
    if( bDebugging )
        log(Name@"NotifyLevelChange  PendingConnection:"$PlayerOwner().Level.IsPendingConnection());

    if( LogoEmitter != None )
    {
        LogoEmitter.Destroy();
        LogoEmitter = None;
    }

    return PlayerOwner().Level.IsPendingConnection();
}

event Free()
{
    PlayerOwner().ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume" @IngameMusicVolume);
    PlayerOwner().ConsoleCommand("SetMusicVolume" @IngameMusicVolume);

    if( LogoEmitter != None )
    {
        LogoEmitter.Destroy();
        LogoEmitter = None;
    }

    if( VersionCheck != None )
    {
        VersionCheck.OnNewVersion = None;
        VersionCheck.Destroy();
        VersionCheck = None;
    }

    Super.Free();
}

function bool InternalOnDraw(Canvas C)
{
    if(LogoEmitter == None && PlayerOwner() != None) {
        LogoEmitter = PlayerOwner().Spawn(LogoEmitterClass);
        InternalOnRendered(C); // cause it to setup the Emitter
        return True; // skip one frame of drawing, to make sure the emitter is going
    }
    return LogoEmitter == None;
}

function InternalOnRendered(Canvas C) {
    local vector CamPos, X, Y, Z;
    local rotator CamRot;

    if(LogoEmitter != None) {
        C.Reset();
        C.SetDrawColor(255,255,255,255);

        C.GetCameraLocation(CamPos, CamRot);
        GetAxes(CamRot, X, Y, Z);
        LogoEmitter.SetLocation(CamPos + X*LogoEmitterOffset.X + Y*LogoEmitterOffset.Y + Z*LogoEmitterOffset.Z);
        LogoEmitter.SetRotation(CamRot);
        C.DrawScreenActor(LogoEmitter, 30, False, True);
    }
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    GunrealURL(0) = "http://www.gunreal.com"
    GunrealURL(1) = "http://www.gunreal.com/download2.htm"

    Begin Object Class=BackgroundImage Name=PageBackground
        Image=Material'G_Menu.menu.menu_shader'
        ImageStyle=ISTY_Scaled
        ImageRenderStyle=MSTY_Alpha
        X1=0
        Y1=0
        X2=1024
        Y2=768
    End Object

    Begin Object Class=GUIButton Name=SingleplayerButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Singleplayer"
        CaptionAlign=TXTA_Center
        Hint="Singleplayer"
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.2
        WinHeight=0.08
        WinLeft=0.55
        WinTop=0.06
        bNeverFocus=True
        bRequireReleaseClick=True
    End Object

    Begin Object Class=GUILabel Name=Seperator
        Caption="|"
        TextAlign=TXTA_Center
        TextFont="gMainMenuFont"
        TextColor=(R=255,G=255,B=255,A=255)
        WinWidth=0.02
        WinHeight=0.08
        WinLeft=0.75
        WinTop=0.06
    End Object

    Begin Object Class=GUIButton Name=MultiplayerButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Multiplayer"
        CaptionAlign=TXTA_Center
        Hint="Multiplayer"
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.2
        WinHeight=0.08
        WinLeft=0.77
        WinTop=0.06
        bNeverFocus=True
        bRequireReleaseClick=True
    End Object

    Begin Object Class=GUIButton Name=BotmatchButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Botmatch"
        CaptionAlign=TXTA_Center
        Hint="Play a bot match"
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.2
        WinHeight=0.08
        WinLeft=0.55
        WinTop=0.06
        bNeverFocus=True
        bVisible=False
        bRequireReleaseClick=True
    End Object

    Begin Object Class=GUIButton Name=CampaignButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Campaign"
        CaptionAlign=TXTA_Center
        Hint="Play through the Tournament"
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.2
        WinHeight=0.08
        WinLeft=0.77
        WinTop=0.06
        bNeverFocus=True
        bVisible=False
        bRequireReleaseClick=True
    End Object

    Begin Object Class=GUIButton Name=HostGameButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Host Game"
        CaptionAlign=TXTA_Center
        Hint="Start a server and invite others to join your game"
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.2
        WinHeight=0.08
        WinLeft=0.55
        WinTop=0.06
        bNeverFocus=True
        bVisible=False
        bRequireReleaseClick=True
    End Object

    Begin Object Class=GUIButton Name=JoinGameButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Join Game"
        CaptionAlign=TXTA_Center
        Hint="Play with human opponents over a LAN or the internet"
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.2
        WinHeight=0.08
        WinLeft=0.77
        WinTop=0.06
        bNeverFocus=True
        bVisible=False
        bRequireReleaseClick=True
    End Object

    Begin Object Class=GUIButton Name=CreditsButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Credits"
        CaptionAlign=TXTA_Center
        Hint="Credits"
        OnClick=ButtonClick
        WinWidth=0.15
        WinHeight=0.08
        WinLeft=0.48
        WinTop=0.85
        bNeverFocus=True
        bVisible=False
        bRequireReleaseClick=True
    End Object

    Begin Object Class=GUILabel Name=Seperator3
        Caption="|"
        TextAlign=TXTA_Center
        TextFont="gMainMenuFont"
        TextColor=(R=255,G=255,B=255,A=255)
        WinWidth=0.02
        WinHeight=0.08
        WinLeft=0.63
        WinTop=0.85
        bVisible=False
    End Object

    Begin Object Class=GUIButton Name=OptionsButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Options"
        CaptionAlign=TXTA_Center
        Hint="Change your controls and settings"
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.15
        WinHeight=0.08
        WinLeft=0.65
        WinTop=0.85
        bNeverFocus=True
        bRequireReleaseClick=True
    End Object

    Begin Object Class=GUILabel Name=Seperator2
        Caption="|"
        TextAlign=TXTA_Center
        TextFont="gMainMenuFont"
        TextColor=(R=255,G=255,B=255,A=255)
        WinWidth=0.02
        WinHeight=0.08
        WinLeft=0.8
        WinTop=0.85
    End Object

    Begin Object Class=GUIButton Name=QuitButton
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption="Exit"
        CaptionAlign=TXTA_Center
        Hint="Exit the game"
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.15
        WinHeight=0.08
        WinLeft=0.82
        WinTop=0.85
        bNeverFocus=True
    End Object

    Begin Object Class=GUILabel Name=o_RightClick
        Caption="[RIGHT-CLICK TO GO BACK]"
        TextAlign=TXTA_Center
        TextFont="UT2IRCFont"
        TextColor=(R=128,G=128,B=128,A=255)
        WinWidth=0.42
        WinHeight=0.04
        WinLeft=0.55
        WinTop=0.02
        bNeverFocus=True
        bVisible=False
    End Object

    Begin Object Class=GUILabel Name=o_CurrentVersion
        Caption=""
        TextAlign=TXTA_Center
        TextFont="UT2IRCFont"
        TextColor=(R=128,G=128,B=128,A=255)
        WinWidth=0.305
        WinHeight=0.04
        WinLeft=0.02
        WinTop=0.93
        bVisible=False
        bNeverFocus=True
    End Object

    Begin Object Class=GUIButton Name=o_UpdateVersion
        FontScale=FNS_Small
        StyleName="gMainMenuTextButton"
        Caption=""
        CaptionAlign=TXTA_Center
        Hint="Open the Gunreal website."
        OnClick=ButtonClick
        OnHover=ButtonHover
        WinWidth=0.305
        WinHeight=0.080000
        WinLeft=0.020000
        WinTop=0.850000
        bNeverFocus=True
        Tag=0
    End Object

    CreditsPage             = "GMenu.gCreditsPage"

    OnRendered              = InternalOnRendered
    OnDraw                  = InternalOnDraw
    LogoEmitterClass        = class'GEffects.gMainMenuEmitter'
    LogoEmitterOffset       = (X=850,Y=-87,Z=0)

    bDebugging              = False

    OnOpen                  = InternalOnOpen
    OnCanClose              = InternalOnCanClose
    OnKeyEvent              = InternalOnKeyEvent
    OnReopen                = InternalOnReopen
    OnRightClick            = InternalOnRightClick

    i_Background            = PageBackground

    l_Seperator             = Seperator
    l_Seperator2            = Seperator2
    l_Seperator3            = Seperator3
    l_RightClick            = o_RightClick
    l_CurrentVersion        = o_CurrentVersion

    b_Singleplayer          = SingleplayerButton
    b_Multiplayer           = MultiplayerButton
    b_Botmatch              = BotmatchButton
    b_Campaign              = CampaignButton
    b_HostGame              = HostGameButton
    b_JoinGame              = JoinGameButton
    b_Credits               = CreditsButton
    b_Options               = OptionsButton
    b_Quit                  = QuitButton
    b_UpdateVersion         = o_UpdateVersion

    WinWidth                = 1.0
    WinHeight               = 1.0
    WinTop                  = 0.0
    WinLeft                 = 0.0

    bRenderWorld            = False
    bAllowClose             = False
    bAllowedAsLast          = True
    bDisconnectOnOpen       = True

    MenuSong                = "Gunreal_Menu"

    FireWallTitle           = "Important"
    FireWallMsg             = "It has been determined that the Windows Firewall is enabled and that UT2004 is not yet authorized to connect to the internet.  Authorization is required in order to use the online components of the game.  Please refer to the README.TXT for more information."
}
