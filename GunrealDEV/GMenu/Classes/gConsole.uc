// ============================================================================
//  gConsole.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gConsole extends ExtendedConsole;

event ViewportInitialized()
{
    Super.ViewportInitialized();

    // Adjust near clipping plane
    DelayedConsoleCommand("NEARCLIP 1");
}

DefaultProperties
{

}
