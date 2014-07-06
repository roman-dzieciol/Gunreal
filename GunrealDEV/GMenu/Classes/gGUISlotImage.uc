// ============================================================================
//  gGUISlotImage.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGUISlotImage extends GUIImage;

var() Material NormalImage;
var() Material FocusedImage;

function SetNormalImage( optional Material M )
{
    if( M != None )
        NormalImage = M;

    if( NormalImage != None )
        Image = NormalImage;
}

function SetFocusedImage( optional Material M )
{
    if( M != None )
        FocusedImage = M;

    if( FocusedImage != None )
        Image = FocusedImage;
}

function InitFromStyle( class<GUIStyles> SC )
{
    Image = SC.default.Images[0];
    ImageRenderStyle = SC.default.RStyles[0];
    ImageColor = SC.default.ImgColors[0];
}


DefaultProperties
{
    NormalImage             = Material'G_FX.belt_square_a1'
    FocusedImage            = Material'G_FX.belt_square_a3'

    Image                   = Material'G_FX.belt_square_a1'
    ImageRenderStyle        = MSTY_Alpha
    ImageColor              = (R=255,G=255,B=255,A=255)
    ImageStyle              = ISTY_Scaled

    bBoundToParent = True
    bScaleToParent = True
    RenderWeight = 0.5
}