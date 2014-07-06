// ============================================================================
//  gShopWindow.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopWindow extends FloatingWindow;

function GameReplicationInfo GetGRI()
{
    return PlayerOwner().GameReplicationInfo;
}

function bool InternalOnPreDraw( Canvas C )
{
    // keep the window centered
    WinLeft = (C.ClipX-WinWidth)*0.5;
    WinTop = (C.ClipY-WinHeight)*0.5;

    return Super.InternalOnPreDraw(C);
}

function PlayOpenSound()
{
    PlayerOwner().ClientPlaySound(OpenSound,,,SLOT_None);
}

function PlayCloseSound()
{
    PlayerOwner().ClientPlaySound(CloseSound,,,SLOT_None);
}

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

DefaultProperties
{
    InactiveFadeColor=(R=60,G=60,B=60,A=255)

    bRenderWorld                = True
    bRequire640x480             = True
    bAllowedAsLast              = True
    bCaptureInput               = True
    bNeverScale                 = True
    bPersistent                 = False

    bResizeWidthAllowed         = False
    bResizeHeightAllowed        = False
    bMoveAllowed                = False

    DefaultWidth                = 0.95
    DefaultHeight               = 0.85
    DefaultLeft                 = 0.025
    DefaultTop                  = 0.06

    WinWidth                    = 600
    WinHeight                   = 480
    WinLeft                     = 0
    WinTop                      = 0

    OnPreDraw                   = InternalOnPreDraw

    Begin Object Class=FloatingImage Name=gFloatingFrameBackground
        Image=Texture'G_FX.Interface.window_corner_c1_64'
        DropShadow=None
        ImageStyle=ISTY_Stretched
        ImageRenderStyle=MSTY_Alpha
        WinTop=0.020000
        WinLeft=0.000000
        WinWidth=1.000000
        WinHeight=0.980000
        RenderWeight=0.000003
        ImageColor=(R=255,G=255,B=255,A=215)
    End Object
    i_FrameBG=gFloatingFrameBackground

    Begin Object Class=GUIHeader Name=OTitleBar
        WinWidth=1
        WinHeight=0.043750
        WinLeft=0
        WinTop=0
        RenderWeight=0.1
        FontScale=FNS_Small
        bUseTextHeight=True
        bAcceptsInput=False
        bNeverFocus=True
        bBoundToParent=True
        bScaleToParent=True
        OnMousePressed=FloatingMousePressed
        OnMouseRelease=FloatingMouseRelease
        ScalingType=SCALE_X
    End Object
    t_WindowTitle=OTitleBar
}
