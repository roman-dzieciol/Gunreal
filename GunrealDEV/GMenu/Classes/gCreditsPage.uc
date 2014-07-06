// ============================================================================
//  gCreditsPage.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCreditsPage extends UT2K4GUIPage;


var automated GUIbutton b_Close;

var() class<gCreditsEmitter> LogoEmitterClass;
var() vector LogoEmitterOffset;
var gCreditsEmitter LogoEmitter;
var string CreditsSong;


function OnEmitterDestroyed()
{
    EndCredits();
}

function bool InternalOnDraw(Canvas C)
{
    if( LogoEmitter == None && PlayerOwner() != None )
    {
        LogoEmitter = PlayerOwner().Spawn(LogoEmitterClass);
        LogoEmitter.OnDestroyed = OnEmitterDestroyed;
        PlayerOwner().ClientSetMusic(CreditsSong, MTRAN_Fade);
        InternalOnRendered(C); // cause it to setup the Emitter
        return True; // skip one frame of drawing, to make sure the emitter is going
    }
    return LogoEmitter == None;
}

function InternalOnRendered(Canvas C)
{
    local vector CamPos, X, Y, Z;
    local rotator CamRot;

    if( LogoEmitter != None )
    {
        C.Reset();
        C.SetDrawColor(255,255,255,255);
        C.GetCameraLocation(CamPos, CamRot);
        GetAxes(CamRot, X, Y, Z);
        LogoEmitter.SetLocation(CamPos + X*LogoEmitterOffset.X + Y*LogoEmitterOffset.Y + Z*LogoEmitterOffset.Z);
        LogoEmitter.SetRotation(CamRot);
        C.DrawScreenActor(LogoEmitter, 30, False, True);
    }
}

function bool ButtonClicked( GUIComponent Sender )
{
    EndCredits();
    return True;
}

function OnClose(optional Bool bCancelled)
{
    FreeEmitter();
}

function bool NotifyLevelChange()
{
    FreeEmitter();
    return Super.NotifyLevelChange();
}

event Free()
{
    FreeEmitter();
    Super.Free();
}

function EndCredits()
{
    FreeEmitter();
    Controller.CloseMenu(False);
}

function FreeEmitter()
{
    if( LogoEmitter != None )
    {
        LogoEmitter.OnDestroyed = None;
        LogoEmitter.Destroy();
        LogoEmitter = None;
        OnDraw = None;
        OnRendered = None;
        PlayerOwner().ClientSetMusic(class'gMainMenu'.default.MenuSong, MTRAN_Fade);
    }
}

DefaultProperties
{
    CreditsSong             = "Credits_mix_1"

    bRequire640x480         = False
    bRenderWorld            = True
    bCaptureInput           = True
    bPersistent             = False

    WinWidth                = 1.0
    WinHeight               = 1.0
    WinTop                  = 0.0
    WinLeft                 = 0.0

    OnRendered              = InternalOnRendered
    OnDraw                  = InternalOnDraw
    LogoEmitterClass        = class'GEffects.gCreditsEmitter'
    LogoEmitterOffset       = (X=800,Y=0,Z=0)
    BackgroundRStyle        = MSTY_None
    InactiveFadeColor       = (R=255,G=255,B=255,A=255)

    Begin Object Class=GUIButton Name=OClose
        WinWidth=1.0
        WinHeight=1.0
        WinLeft=0.0
        WinTop=0.0
        bBoundToParent=True
        bScaleToParent=True
        OnClick=ButtonClicked
        OnRightClick=ButtonClicked
        StyleName="NoBackground"
    End Object
    b_Close=OClose
}