// ============================================================================
//  gCoordsEmitterNet.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCoordsEmitterNet extends gCoordsEmitter;

DefaultProperties
{
    RemoteRole      = ROLE_SimulatedProxy
    bNetTemporary   = True
    LifeSpan        = 1

}