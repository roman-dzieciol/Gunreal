// ============================================================================
//  gInteractionDebug.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gInteractionDebug extends Interaction;


var() gInteractionDebug     StaticInstance;
var() bool              bFreeze;


function Initialized()
{
    Log( "Initialized", name );
    if( default.StaticInstance == None )
        default.StaticInstance = self;
}

exec function gdFreeze()
{
    default.bFreeze = !default.bFreeze;
}

exec function gdToggle()
{
    default.bActive = !default.bActive;
    bActive = default.bActive;
}

exec function gdToggleVis()
{
    default.bVisible = !default.bVisible;
    bVisible = default.bVisible;
}

exec function gdShow()
{
    default.bVisible = True;
    bVisible = True;
}

exec function gdHide()
{
    default.bVisible = False;
    bVisible = False;
}

function NotifyLevelChange()
{
    Log( "NotifyLevelChange", name );

    StaticInstance = None;
    default.StaticInstance = None;

    Master.RemoveInteraction(self);
}

DefaultProperties
{
    bActive             = True
    bVisible            = True
    bRequiresTick       = False
    bNativeEvents       = False

}
