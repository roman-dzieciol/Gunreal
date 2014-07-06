// ============================================================================
//  gInteraction.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gInteraction extends Interaction;

var() gInteraction     StaticInstance;

/*    STY_None,
    STY_Normal,
    STY_Masked,
    STY_Translucent,
    STY_Modulated,
    STY_Alpha,
    STY_Additive,
    STY_Subtractive,
    STY_Particle,
    STY_AlphaZ,*/

function Initialized()
{
    //Log( "Initialized", name );
    if( default.StaticInstance == None )
        default.StaticInstance = Self;
}

function NotifyLevelChange()
{
    //Log( "NotifyLevelChange", name );

    StaticInstance = None;
    default.StaticInstance = None;

    Master.RemoveInteraction(Self);
}

DefaultProperties
{
    bActive             = True
    bVisible            = True
    bRequiresTick       = False
    bNativeEvents       = False
}