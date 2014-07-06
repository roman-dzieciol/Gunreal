// ============================================================================
//  gDriverAdjust.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDriverAdjust extends gObject;


final static function GetAdjustment(Vehicle V, out vector NewOffset, out float NewScale)
{
    //gLog( "AdjustDriver" #GON(P) #GON(V) );

    switch( V.class.name )
    {
        case 'ONSRV':
            NewOffset = vect(0,0,45);           NewScale = 0.9;     break;

        case 'ONSPRV':
            NewOffset = vect(0,-30.0,65.0);                         break;

        case 'ONSPRVSideGunPawn':
            NewOffset = vect(-20,0,90);                             break;

        case 'ONSPRVRearGunPawn':
            NewOffset = vect(-20,0,90);                             break;

        case 'ONSHoverBike':
            NewOffset = vect(-18.438,0,67.5);                       break;

        case 'ONSGenericSD':
            NewOffset = vect(9.0,0.0,70.0);     NewScale = 0.72;    break;

        case 'ONSArtillery':
            NewOffset = vect(145,-30.0,80.0);                       break;

        case 'ONSArtillerySideGunPawn':
            NewOffset = vect(-5,8,-25);                             break;
    }

    //gLog( "AdjustDriver - " #NewOffset #NewScale );
}


DefaultProperties
{
}
