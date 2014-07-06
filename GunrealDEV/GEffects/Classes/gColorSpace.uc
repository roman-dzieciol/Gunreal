// ============================================================================
//  gColorSpace.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gColorSpace extends Object;

final static function color HSLToRGB(float H, float S, float L)
{
    local color C;
    local float V1, V2;

    C.A = 255;

    if( L == 0 )
    {
        return C;
    }
    else if( S == 0 )
    {
        C.R = L;
        C.G = L;
        C.B = L;
    }
    else
    {
        H /= 255.0;
        S /= 255.0;
        L /= 255.0;

        if( L < 0.5 )
            V2 = L * (1.0 + S);
        else
            V2 = (L + S) - (S * L);

        V1 = 2.0 * L - V2;
        C.R = Round(255.0 * HSLHueToRGB( V1, V2, H + (1.0 / 3.0) ));
        C.G = Round(255.0 * HSLHueToRGB( V1, V2, H ));
        C.B = Round(255.0 * HSLHueToRGB( V1, V2, H - (1.0 / 3.0) ));
    }

    return C;
}

final static function float HSLHueToRGB(float V1, float V2, float VH)
{
    if     ( VH < 0.0 )     VH += 1.0;
    else if( VH > 1.0 )     VH -= 1.0;

    if     ( 6.0 * VH < 1.0 )   return V1 + (V2 - V1) * 6.0 * VH;
    else if( 2.0 * VH < 1.0 )   return V2;
    else if( 3.0 * VH < 2.0 )   return V1 + (V2 - V1) * ((2.0 / 3.0) - VH) * 6.0;
    else                        return V1;
}

DefaultProperties
{

}