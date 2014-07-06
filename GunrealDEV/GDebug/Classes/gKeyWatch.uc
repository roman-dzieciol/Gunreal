// ============================================================================
//  gKeyWatch.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gKeyWatch extends gInteractionDebug;

function bool KeyType( out EInputKey Key, optional string Unicode )
{
    Log( Key @GetEnum(enum'EInputKey',Key) @Unicode,'KeyType');
    return False;
}


function bool KeyEvent( out EInputKey Key, out EInputAction Action, FLOAT Delta )
{
    Log( Key @GetEnum(enum'EInputKey',Key) @Action @GetEnum(enum'EInputAction',Action) @Delta,'KeyEvent');
    return False;
}


function bool OnNeedRawKeyPress(byte NewKey)
{
    Log(NewKey,'OnNeedRawKeyPress');
    return False;
}

DefaultProperties
{
    bActive         = True

}
