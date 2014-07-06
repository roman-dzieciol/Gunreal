// ============================================================================
//  gSTYMainMenuTextButton.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSTYMainMenuTextButton extends GUI2Styles;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    KeyName         = "gMainMenuTextButton"

    Images(0)       = None
    Images(1)       = Material'G_Menu.Menu.G-Menu-button-hover'
    Images(2)       = Material'G_Menu.Menu.G-Menu-button-idle'
    Images(3)       = Material'G_Menu.Menu.G-Menu-button-pressed'
    Images(4)       = None

    ImgStyle(0)     = ISTY_Scaled
    ImgStyle(1)     = ISTY_Scaled
    ImgStyle(2)     = ISTY_Scaled
    ImgStyle(3)     = ISTY_Scaled
    ImgStyle(4)     = ISTY_Scaled

    FontNames(0)    = "gMainMenuFont"
    FontNames(1)    = "gMainMenuFont"
    FontNames(2)    = "gMainMenuFont"
    FontNames(3)    = "gMainMenuFont"
    FontNames(4)    = "gMainMenuFont"

    FontColors(0)   = (R=255,G=255,B=255,A=255) // normal
    FontColors(1)   = (R=255,G=255,B=255,A=255)
    FontColors(2)   = (R=255,G=255,B=255,A=255) // hover
    FontColors(3)   = (R=255,G=255,B=255,A=255) // pressed
    FontColors(4)   = (R=255,G=255,B=255,A=255)
}