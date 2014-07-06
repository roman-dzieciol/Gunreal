// ============================================================================
//  gGUIGloveIcon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGUIGloveIcon extends gGUIImageButton;


function InternalOnRendered(Canvas C)
{
    local int i;
    local bool bHover;

    Super.InternalOnRendered(C);

    if( !bVisible )
        return;

    bHover = IsInBounds();
    for( i=0; i!=Slots.Length; ++i )
    {
        if( bHover )
            Slots[i].SetFocusedImage();
        else
            Slots[i].SetNormalImage();
    }
}


function InitFromGlove( int Idx, class<Weapon> WC )
{
    Tag = Idx;

    if( WC != None )
    {
        Image = WC.default.IconMaterial;
        X1 = WC.default.IconCoords.X1;
        Y1 = WC.default.IconCoords.Y1;
        X2 = WC.default.IconCoords.X2;
        Y2 = WC.default.IconCoords.Y2;

        if( Image == None )
        {
            Image = Material'Engine.DefaultTexture';
            X1 = default.X1;
            Y1 = default.Y1;
            X2 = default.X2;
            Y2 = default.Y2;
        }
    }
    else
    {
        Image = None;
    }

    FocusImage = Image;
}

DefaultProperties
{
    ActivateSound               = Sound'G_Sounds.tic_b1'
    bFocusImages                = False
}