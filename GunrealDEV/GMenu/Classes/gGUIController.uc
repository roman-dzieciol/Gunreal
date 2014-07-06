// ============================================================================
//  gGUIController.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGUIController extends UT2K4GUIController;

DefaultProperties
{
    DefaultStyleNames(0)    = "GMenu.gSTY2RoundButton"
    DefaultStyleNames(1)    = "GMenu.gSTY2RoundScaledButton"
    DefaultStyleNames(2)    = "GMenu.gSTY2SquareButton"
    DefaultStyleNames(3)    = "GMenu.gSTY2ListBox"
    DefaultStyleNames(4)    = "GMenu.gSTY2ScrollZone"
    DefaultStyleNames(5)    = "GMenu.gSTY2TextButton"
    DefaultStyleNames(6)    = "GMenu.gSTY2Page"
    DefaultStyleNames(7)    = "GMenu.gSTY2Header"
    DefaultStyleNames(8)    = "GMenu.gSTY2Footer"
    DefaultStyleNames(9)    = "GMenu.gSTY2TabButton"
    DefaultStyleNames(10)   = "GMenu.gSTY2CharButton"
    DefaultStyleNames(11)   = "GMenu.gSTY2ArrowLeft"
    DefaultStyleNames(12)   = "GMenu.gSTY2ArrowRight"
    DefaultStyleNames(13)   = "GMenu.gSTY2ServerBrowserGrid"
    DefaultStyleNames(14)   = "GMenu.gSTY2NoBackground"
    DefaultStyleNames(15)   = "GMenu.gSTY2ServerBrowserGridHeader"
    DefaultStyleNames(16)   = "GMenu.gSTY2SliderCaption"
    DefaultStyleNames(17)   = "GMenu.gSTY2LadderButton"
    DefaultStyleNames(18)   = "GMenu.gSTY2LadderButtonHi"
    DefaultStyleNames(19)   = "GMenu.gSTY2LadderButtonActive"
    DefaultStyleNames(20)   = "GMenu.gSTY2BindBox"
    DefaultStyleNames(21)   = "GMenu.gSTY2SquareBar"
    DefaultStyleNames(22)   = "GMenu.gSTY2MidGameButton"
    DefaultStyleNames(23)   = "GMenu.gSTY2TextLabel"
    DefaultStyleNames(24)   = "GMenu.gSTY2ComboListBox"
    DefaultStyleNames(25)   = "GMenu.gSTY2SquareMenuButton"
    DefaultStyleNames(26)   = "GMenu.gSTY2IRCText"
    DefaultStyleNames(27)   = "GMenu.gSTY2IRCEntry"
    DefaultStyleNames(28)   = "GMenu.gSTY2BrowserButton"
    DefaultStyleNames(29)   = "GMenu.gSTY2ContextMenu"
    DefaultStyleNames(30)   = "GMenu.gSTY2ServerListContextMenu"
    DefaultStyleNames(31)   = "GMenu.gSTY2ListSelection"
    DefaultStyleNames(32)   = "GMenu.gSTY2TabBackground"
    DefaultStyleNames(33)   = "GMenu.gSTY2BrowserListSel"
    DefaultStyleNames(34)   = "GMenu.gSTY2EditBox"
    DefaultStyleNames(35)   = "GMenu.gSTY2CheckBox
    DefaultStyleNames(36)   = "GMenu.gSTY2CheckBoxCheck"
    DefaultStyleNames(37)   = "GMenu.gSTY2SliderKnob"
    DefaultStyleNames(38)   = "GMenu.gSTY2BottomTabButton"
    DefaultStyleNames(39)   = "GMenu.gSTY2ListSectionHeader"
    DefaultStyleNames(40)   = "GMenu.gSTY2ItemOutline"
    DefaultStyleNames(41)   = "GMenu.gSTY2ListHighlight"
    DefaultStyleNames(42)   = "GMenu.gSTY2MouseOverLabel"
    DefaultStyleNames(43)   = "GMenu.gSTY2SliderBar"
    DefaultStyleNames(44)   = "GMenu.gSTY2DarkTextLabel"
    DefaultStyleNames(45)   = "GMenu.gSTY2TextButtonEffect"
    DefaultStyleNames(46)   = "GMenu.gSTY2ArrowRightDbl"
    DefaultStyleNames(47)   = "GMenu.gSTY2ArrowLeftDbl"
    DefaultStyleNames(48)   = "GMenu.gSTY2FooterButton"
    DefaultStyleNames(49)   = "GMenu.gSTY2SectionHeaderText"
    DefaultStyleNames(50)   = "GMenu.gSTY2ComboButton"
    DefaultStyleNames(51)   = "GMenu.gSTY2VertUpButton"
    DefaultStyleNames(52)   = "GMenu.gSTY2VertDownButton"
    DefaultStyleNames(53)   = "GMenu.gSTY2VertGrip"
    DefaultStyleNames(54)   = "GMenu.gSTY2Spinner"
    DefaultStyleNames(55)   = "GMenu.gSTY2SectionHeaderTop"
    DefaultStyleNames(56)   = "GMenu.gSTY2SectionHeaderBar"
    DefaultStyleNames(57)   = "GMenu.gSTY2CloseButton"
    DefaultStyleNames(58)   = "GMenu.gSTY2CoolScroll"
    DefaultStyleNames(59)   = "GMenu.gSTY2AltComboButton"
    DefaultStyleNames(60)   = "GMenu.gSTYSlotButton"
    DefaultStyleNames(61)   = "GMenu.gSTYWeaponButton"
    DefaultStyleNames(62)   = "GMenu.gSTYFixedLabel"
    DefaultStyleNames(63)   = "GMenu.gSTYNoBackgroundFixed"
    DefaultStyleNames(64)   = "GMenu.gSTYShopButton"
    DefaultStyleNames(65)   = "GMenu.gSTYRegenBox"
    DefaultStyleNames(66)   = "GMenu.gSTYArmorBox"
    DefaultStyleNames(67)   = "GMenu.gSTYMoneyBox"
    DefaultStyleNames(68)   = "GMenu.gSTYShieldBox"
    DefaultStyleNames(69)   = "GMenu.gSTYHelpButton"
    DefaultStyleNames(70)   = "GMenu.gSTYGiveButton"
    DefaultStyleNames(71)   = "GMenu.gSTYOptionsButton"
    DefaultStyleNames(72)   = "GMenu.gSTYFixedCheckbox"
    DefaultStyleNames(73)   = "GMenu.gSTYFixedCombo"
    DefaultStyleNames(74)   = "GMenu.gSTYFixedOptionLabel"
    DefaultStyleNames(75)   = "GMenu.gSTYFixedComboListBox"
    DefaultStyleNames(76)   = "GMenu.gSTYFixedEditBox"
    DefaultStyleNames(77)   = "GMenu.gSTYFixedListSelection"
    DefaultStyleNames(78)   = "GMenu.gSTYMainMenuTextButton"
    DefaultStyleNames(79)   = "GMenu.gSTYWeaponButtonDisabled"
    DefaultStyleNames(80)   = "GMenu.gSTYAmmoButton"
    DefaultStyleNames(81)   = "GMenu.gSTYNoMoneyForYouButton"
    DefaultStyleNames(82)   = "GMenu.gSTY2TabButtonFixed"

    STYLE_NUM               = 83

    Begin Object Class=gShopButtonFont Name=ogShopButtonFont
    End Object
    FontStack(11)           = ogShopButtonFont

    Begin Object Class=gMainMenuFont Name=ogMainMenuFont
    End Object
    FontStack(12)           = ogMainMenuFont

    FONT_NUM                = 13

    MouseOverSound          = Sound'G_Sounds.tic_d1'
    //ClickSound            = Sound'G_Sounds.tic_c1'
    ClickSound              = Sound'G_Sounds.tic_a1'
    EditSound               = Sound'2K4MenuSounds.msfxEdit'
    UpSound                 = Sound'2K4MenuSounds.msfxUp'
    DownSound               = Sound'2K4MenuSounds.msfxDown'
    DragSound               = Sound'2K4MenuSounds.msfxDrag'
    FadeSound               = Sound'2K4MenuSounds.msfxFade'

    // Preload these menus to avoid hitches
    MainMenuOptions(0)="GMenu.g2K4SP_Main"    // This must match the value for GameEngine.SinglePlayerMenuClass
    MainMenuOptions(1)="GMenu.g2K4ServerBrowser"
    MainMenuOptions(2)="GMenu.g2K4GamePageMP"
    MainMenuOptions(3)="GMenu.g2K4GamePageSP"
    MainMenuOptions(4)="GUI2K4.UT2K4ModsAndDemos"
    MainMenuOptions(5)="GMenu.g2K4SettingsPage"
    MainMenuOptions(6)="GUI2K4.UT2K4QuitPage"
}