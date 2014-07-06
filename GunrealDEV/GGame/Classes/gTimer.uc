// ============================================================================
//  gTimer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTimer extends gActor;

simulated event Timer()
{
    OnTimer();
}

simulated event Destroyed()
{
    OnTimer = None;
    Super.Destroyed();
}

simulated delegate OnTimer();

DefaultProperties
{
    RemoteRole      = ROLE_None
}
