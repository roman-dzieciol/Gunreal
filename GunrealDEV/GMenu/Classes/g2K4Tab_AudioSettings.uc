// ============================================================================
//  g2K4Tab_AudioSettings.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4Tab_AudioSettings extends UT2K4Tab_AudioSettings;

var automated moSlider      sl_GameMusicVol;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local int i;
    local bool bIsWin32;

    bIsWin32 = ( ( PlatformIsWindows() ) && ( !PlatformIs64Bit() ) );

    Super(Settings_Tabs).InitComponent(MyController, MyOwner);

    if ( bIsWin32 )
    {
        for(i = 0;i < ArrayCount(AudioModes);i++)
            co_Mode.AddItem(AudioModes[i]);
    }
    else
    {
        co_Mode.AddItem("OpenAL");
    }

    for(i = 0;i < ArrayCount(VoiceModes);i++)
        co_Voices.AddItem(VoiceModes[i]);

    for(i = 0;i < ArrayCount(AnnounceModes);i++)
        co_Announce.AddItem(AnnounceModes[i]);

    i_BG2.WinWidth=0.503398;
    i_BG2.WinHeight=0.453045;
    i_BG2.WinLeft=0.004063;
    i_BG2.WinTop=0.540831;

    i_BG3.WinWidth=0.475078;
    i_BG3.WinHeight=0.453045;
    i_BG3.WinLeft=0.518712;
    i_BG3.WinTop=0.540831;

    i_BG1.ManageComponent(sl_MusicVol);
    i_BG1.ManageComponent(sl_GameMusicVol);
    i_BG1.ManageComponent(sl_EffectsVol);
    i_BG1.ManageComponent(co_Mode);
    i_BG1.ManageComponent(ch_LowDetail);
    i_BG1.ManageComponent(ch_Default);
    i_BG1.ManageComponent(ch_reverseStereo);
    i_BG1.ManageComponent(co_Voices);
    i_BG1.ManageComponent(ch_MatureTaunts);
    i_BG1.ManageComponent(ch_AutoTaunt);
    i_BG1.ManageComponent(ch_MessageBeep);

    i_BG2.ManageComponent(sl_VoiceVol);
    i_BG2.ManageComponent(co_Announce);

//  i_BG3.ManageComponent(sl_TTS);
    i_BG3.ManageComponent(ch_TTS);
    i_BG3.ManageComponent(ch_TTSIRC);
    i_BG3.ManageComponent(ch_OnlyTeamTTS);
    i_BG3.ManageComponent(ch_VoiceChat);
    i_BG3.ManageComponent(b_VoiceChat);

    i_BG2.ManageComponent(co_StatusAnnouncer);
    i_BG2.ManageComponent(co_RewardAnnouncer);

    class'CacheManager'.static.GetAnnouncerList( Announcers );
    for ( i = 0; i < Announcers.Length; i++ )
    {
        if ( Announcers[i].FriendlyName != "" )
        {
            co_StatusAnnouncer.AddItem( Announcers[i].FriendlyName,,string(i) );
            co_RewardAnnouncer.AddItem( Announcers[i].FriendlyName,,string(i) );
        }
    }

    // !!! FIXME: Might use a preinstalled system OpenAL in the future on
    // !!! FIXME:  Mac or Unix, but for now, we don't...  --ryan.
    if ( !PlatformIsWindows() )
        ch_Default.DisableMe();

    sl_MusicVol.SetCaption("Menu Music Volume");
}

function InternalOnChange(GUIComponent Sender)
{
    local PlayerController PC;

    PC = PlayerOwner();

    if( Sender == sl_MusicVol )
    {
        class'gMainMenu'.default.MenuMusicVolume = sl_MusicVol.GetValue();
        class'gMainMenu'.default.bMenuMusicInitialized = True;
        class'gMainMenu'.static.StaticSaveConfig();

        if( PC.Level.IsEntry() )
        {
            PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume" @sl_MusicVol.GetValue());
            PC.ConsoleCommand("SetMusicVolume" @sl_MusicVol.GetValue());

            // Play music
            if( PC.Level.Song != "" && PC.Level.Song != "None" )
                PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
            else
                PC.ClientSetMusic( class'UT2K4MainMenu'.default.MenuSong, MTRAN_Instant );
        }

        Super(Settings_Tabs).InternalOnChange(Sender);
    }
    else if( Sender == sl_GameMusicVol )
    {
        if( PC.Level.IsEntry() )
        {
            gMainMenu(PageOwner.ParentPage).IngameMusicVolume = sl_GameMusicVol.GetValue();
        }
        else
        {
            PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume" @sl_GameMusicVol.GetValue());
            PC.ConsoleCommand("SetMusicVolume" @sl_GameMusicVol.GetValue());

            // Play music
            if( PC.Level.Song != "" && PC.Level.Song != "None" )
                PC.ClientSetMusic( PC.Level.Song, MTRAN_Instant );
            else
                PC.ClientSetMusic( class'UT2K4MainMenu'.default.MenuSong, MTRAN_Instant );
        }

        Super(Settings_Tabs).InternalOnChange(Sender);
    }
    else
    {
        Super.InternalOnChange(Sender);
    }
}


function InternalOnLoadINI(GUIComponent Sender, string s)
{
    local float Volume;
    local PlayerController PC;

    PC = PlayerOwner();

    Super.InternalOnLoadINI(Sender,s);

    if( Sender == sl_MusicVol )
    {
        if( PC.Level.IsEntry() )
        {
            Volume = float(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice MusicVolume"));
            sl_MusicVol.SetComponentValue(Volume,true);
        }
        else
        {
            Volume = class'gMainMenu'.default.MenuMusicVolume;
            sl_MusicVol.SetComponentValue(Volume,true);
        }

    }
    else if( Sender == sl_GameMusicVol )
    {
        if( PC.Level.IsEntry() )
        {
            Volume = gMainMenu(PageOwner.ParentPage).IngameMusicVolume;
            sl_GameMusicVol.SetComponentValue(Volume,true);
        }
        else
        {
            Volume = float(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice MusicVolume"));
            sl_GameMusicVol.SetComponentValue(Volume,true);
        }
    }
}

function SaveSettings()
{
    local PlayerController PC;
    local bool bSave, bReboot;

    Super(Settings_Tabs).SaveSettings();
    PC = PlayerOwner();

    if (PC.AnnouncerLevel != iAnnounce)
    {
        PC.AnnouncerLevel = iAnnounce;
        PC.default.AnnouncerLevel = PC.AnnouncerLevel;
        bSave = True;
    }

    if (PC.AnnouncerVolume != iVoice)
    {
        PC.AnnouncerVolume = iVoice;
        PC.default.AnnouncerVolume = iVoice;
        bSave = True;
    }

/*  if ( PC.TextToSpeechVoiceVolume != fTTS )
    {
        PC.TextToSpeechVoiceVolume = fTTS;
        bSave = True;
    }
*/
    if ( PC.bOnlySpeakTeamText != bOnlyTeamTTS )
    {
        PC.bOnlySpeakTeamText = bOnlyTeamTTS;
        bSave = True;
    }

    if ( PC.bNoTextToSpeechVoiceMessages == bTTS )
    {
        PC.bNoTextToSpeechVoiceMessages = !bTTS;
        bSave = True;
    }

    if ( class'UT2K4IRC_Page'.default.bIRCTextToSpeechEnabled != bTTSIRC )
    {
        class'UT2K4IRC_Page'.default.bIRCTextToSpeechEnabled = bTTSIRC;
        class'UT2K4IRC_Page'.static.StaticSaveConfig();
    }

    if (PC.bNoMatureLanguage == bMature)
    {
        PC.bNoMatureLanguage = !bMature;
        PC.default.bNoMatureLanguage = !bMature;
        bSave = True;
    }

    if (PC.bNoAutoTaunts != iVoiceMode > 0)
    {
        PC.bNoAutoTaunts = iVoiceMode > 0;
        PC.default.bNoAutoTaunts = PC.bNoAutoTaunts;
        bSave = True;
    }

    if (PC.bNoVoiceTaunts != iVoiceMode > 1)
    {
        PC.bNoVoiceTaunts = iVoiceMode > 1;
        PC.default.bNoVoiceTaunts = PC.bNoVoiceTaunts;
        bSave = True;
    }

    if (PC.bNoVoiceMessages != iVoiceMode == 3)
    {
        PC.bNoVoiceMessages = iVoiceMode == 3;
        PC.default.bNoVoiceMessages = PC.bNoVoiceMessages;
        bSave = True;
    }

    if( PC.Level.IsEntry() )
    {
        //PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume" @sl_MusicVol.GetValue());
    }
    else
    {
        //PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice MusicVolume" @sl_GameMusicVol.GetValue());
    }

    if (fEffects != sl_EffectsVol.GetValue())
        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice SoundVolume"@fEffects);

    if (bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice ReverseStereo")) != bRev)
        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice ReverseStereo"@bRev);

    if (bDefault != bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseDefaultDriver")))
    {
        PC.ConsoleCommand("set ini:Engine.Engine.AudioDevice UseDefaultDriver"@bDefault);
        bReboot = True;
    }

    if( PC.MyHud != None )
    {
        if ( PC.myHUD.bMessageBeep != bBeep )
        {
            PC.myHUD.bMessageBeep = bBeep;
            PC.myHUD.SaveConfig();
        }
    }

    else
    {
        if ( class'HUD'.default.bMessageBeep != bBeep )
        {
            class'HUD'.default.bMessageBeep = bBeep;
            class'HUD'.static.StaticSaveConfig();
        }
    }

    if ( !PC.Level.IsDemoBuild() && PC.IsA('UnrealPlayer') )
    {
        if ( PC.GetCustomStatusAnnouncerClass() != sStatAnnouncer )
        {
            PC.SetCustomStatusAnnouncerClass(sStatAnnouncer);
            bSave = True;
        }

        if ( PC.GetCustomRewardAnnouncerClass() != sRewAnnouncer )
        {
            PC.SetCustomRewardAnnouncerClass(sRewAnnouncer);
            bSave = True;
        }
    }

    if (bVoiceChat != bool(PC.ConsoleCommand("get ini:Engine.Engine.AudioDevice UseVoIP")))
    {
        if (bVoiceChat)
            PC.EnableVoiceChat();
        else PC.DisableVoiceChat();

        bReboot = False;
    }

    if (bSave)
        PC.SaveConfig();

    if ( PC.bAutoTaunt != bAuto )
        PC.SetAutoTaunt(bAuto);

    if ( !PC.Level.IsDemoBuild() && !PC.IsA('UnrealPlayer') )
    {
        if ( !(class'UnrealPlayer'.default.CustomStatusAnnouncerPack ~= sStatAnnouncer) ||
             !(class'UnrealPlayer'.default.CustomRewardAnnouncerPack ~= sRewAnnouncer) )
        {
            class'UnrealPlayer'.default.CustomStatusAnnouncerPack = sStatAnnouncer;
            class'UnrealPlayer'.default.CustomRewardAnnouncerPack = sRewAnnouncer;
            class'UnrealPlayer'.static.StaticSaveConfig();
        }
    }

    if (bReboot)
        PC.ConsoleCommand("SOUND_REBOOT");
}

DefaultProperties
{


    Begin Object class=moSlider Name=GameMusicVolume
        WinWidth=0.450000
        WinLeft=0.018164
        WinTop=0.070522
        Caption="Ingame Music Volume"
        LabelJustification=TXTA_Left
        ComponentJustification=TXTA_Right
        CaptionWidth=0.5
        ComponentWidth=-1
        bAutoSizeCaption=True
        MinValue=0.0
        MaxValue=1.0
        OnLoadINI=InternalOnLoadINI
        OnChange=InternalOnChange
        INIOption="@Internal"
        INIDefault="0.5"
        Hint="Adjusts the volume of the ingame music."
        TabOrder=0
    End Object
    sl_GameMusicVol=GameMusicVolume
}