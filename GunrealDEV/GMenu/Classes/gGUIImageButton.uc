// ============================================================================
//  gGUIImageButton.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGUIImageButton extends GUIImage;

var() Material FocusImage;
var() Material WarrantyMaterial;
var() Material WarrantyGMaterial;

var() intbox WarrantyCoords;
var() intbox WarrantyGCoords;
var() byte bWarranty;
var() int Ammo;
var() int Cost;

var Sound ActivateSound;
var font CaptionFont;
var float CaptionMargin;
var float CaptionPadding;
var color CaptionColor;
var color CaptionBGColor;
var() bool bFocusImages;
var array<gGUISlotImage> Slots;

var() bool bDarkenUnloaded;

function AddSlot(gGUISlotImage img)
{
    Slots[Slots.Length] = img;
}

function ClearSlots()
{
    Slots.Length = 0;
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

    CaptionFont = class'GUI2K4.fntUT2k4Default'.static.LoadFontStatic(0);
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
    if( (key==0x0D || Key == 0x20) && State==1 ) // ENTER or Space Pressed
    {
        OnClick(self);
        return True;
    }

    return False;
}

function InternalOnActivate()
{
    //Log("InternalOnActivate",name);
    if( bFocusImages )
    {
        default.Image = Image;
        Image = FocusImage;
        OnChange(self);
    }

    if( ActivateSound != None )
        PlayerOwner().ClientPlaySound(ActivateSound,,,SLOT_Interface);
}

function InternalOnDeActivate()
{
    //Log("InternalOnDeActivate",name);
    if( bFocusImages )
    {
        if( Image == FocusImage )
            Image = default.Image;
    }
}


event Free()
{
    OnTimer = None;
    OnKeyEvent = None;
    OnActivate = None;
    OnDeActivate = None;
    ClearSlots();

    Super.Free();
}

function InternalOnRendered(Canvas C)
{
    local float X,Y,W,H,XL,YL;
    local string S;

    if( !bVisible )
        return;

    if( bWarranty == 1 )
    {
        W = WarrantyCoords.X2;
        H = WarrantyCoords.Y2;
        X = ActualLeft() + ActualWidth() - 4 - W;
        Y = ActualTop() + ActualHeight() - 4 - H;

        C.Style = 5;
        C.SetDrawColor(255,255,255,255);
        C.SetPos(X,Y);

        C.DrawTile(WarrantyMaterial, W, H, WarrantyCoords.X1, WarrantyCoords.Y1, WarrantyCoords.X2, WarrantyCoords.Y2 );
    }
    else if( bWarranty == 2 )
    {
        W = WarrantyGCoords.X2;
        H = WarrantyGCoords.Y2;
        X = ActualLeft() + ActualWidth() - 4 - W;
        Y = ActualTop() + ActualHeight() - 4 - H;

        C.Style = 5;
        C.SetDrawColor(255,255,255,255);
        C.SetPos(X,Y);

        C.DrawTile(WarrantyGMaterial, W, H, WarrantyGCoords.X1, WarrantyGCoords.Y1, WarrantyGCoords.X2, WarrantyGCoords.Y2 );
    }


    if( Ammo > 0 )
    {
        S = string(Ammo);
        C.Font = CaptionFont;
        if( C.Font == None )
            C.Font = C.default.Font;

        C.StrLen( S, XL,YL );
        W = XL + CaptionPadding*2;
        H = YL + CaptionPadding*2;
        X = ActualLeft() + CaptionMargin;
        Y = ActualTop() + CaptionMargin;

        C.Style = 5;

        C.DrawColor = CaptionBGColor;
        C.SetPos(X,Y);
        C.DrawTile(texture'Engine.WhiteTexture', W, H, 0,0,1,1 );

        C.DrawColor = CaptionColor;
        C.SetPos(X+CaptionPadding,Y+CaptionPadding);
        C.DrawTextClipped( S );
    }

    if( Cost > 0 )
    {
        S = "$" $Cost;
        C.Font = CaptionFont;
        if( C.Font == None )
            C.Font = C.default.Font;

        C.StrLen( S, XL,YL );
        W = XL + CaptionPadding*2;
        H = YL + CaptionPadding*2;
        X = ActualLeft() + (ActualWidth() - W - CaptionMargin*2) * 0.5;
        Y = ActualTop() + ActualHeight() - H - CaptionMargin;

        C.Style = 5;

        C.DrawColor = CaptionBGColor;
        C.SetPos(X,Y);
        C.DrawTile(texture'Engine.WhiteTexture', W, H, 0,0,1,1 );

        C.DrawColor = CaptionColor;
        C.SetPos(X+CaptionPadding,Y+CaptionPadding);
        C.DrawTextClipped( S );
    }
}

function bool InternalOnPreDraw(canvas C)
{
    if( bDarkenUnloaded )
    {
        if( Ammo <= 0 )
            ImageColor = class'gPawnHUD'.default.NoAmmoColor;
        else
            ImageColor = default.ImageColor;
    }

    return False;
}

function InitFromWeapon( int Idx, class<gWeapon> GWC, optional int NewAmmo, optional byte bNewWarranty )
{
    Tag = Idx;
    Ammo = NewAmmo;
    bWarranty = bNewWarranty;

    if( GWC != None )
    {
        FocusImage = GWC.default.IconFlashMaterial;
        Image = GWC.default.IconMaterial;
        X1 = GWC.default.IconCoords.X1;
        Y1 = GWC.default.IconCoords.Y1;
        X2 = GWC.default.IconCoords.X2;
        Y2 = GWC.default.IconCoords.Y2;

        bDarkenUnloaded = GWC.default.CostAmmo > 0;
    }

    if( FocusImage == None )
        FocusImage = Material'Engine.WhiteTexture';

    if( Image == None )
        Image = Material'Engine.DefaultTexture';
}


DefaultProperties
{
    RenderWeight                = 0.5
    CaptionMargin               = 4
    CaptionPadding              = 2
    CaptionColor                = (R=255,G=255,B=255,A=224)
    CaptionBGColor              = (R=0,G=0,B=0,A=96)

    bBoundToParent              = True
    bScaleToParent              = True
    bTabStop                    = True
    bAcceptsInput               = True
    bCaptureMouse               = True
    bMouseOverSound             = False
    bFocusOnWatch               = True
    ActivateSound               = Sound'G_Sounds.tic_e1'
    bFocusImages                = True
    bRequireReleaseClick        = True
    ImageStyle                  = ISTY_Scaled

    WarrantyMaterial            = Material'G_FX.Interface.fb_iconsheet0_pulse'
    WarrantyCoords              = (X1=800,Y1=108,X2=24,Y2=24);

    WarrantyGMaterial           = Material'G_FX.Interface.fb_iconsheet0_pulse'
    WarrantyGCoords             = (X1=823,Y1=108,X2=24,Y2=24);

    OnClickSound                = CS_None
    StandardHeight              = 0.040000
    OnKeyEvent                  = InternalOnKeyEvent
    OnActivate                  = InternalOnActivate
    OnDeActivate                = InternalOnDeActivate
    OnRendered                  = InternalOnRendered
    OnPreDraw               = InternalOnPreDraw

    Begin Object Class=GUIToolTip Name=gGUIImageButtonToolTip
    End Object
    ToolTip=gGUIImageButtonToolTip
}
