// ============================================================================
//  gDynamicProjector.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDynamicProjector extends gProjector;


var vector  PrevLocation;
var rotator PrevRotation;


simulated event Tick(float DeltaTime)
{
    if( Location != PrevLocation || PrevRotation != Rotation )
    {
        DetachProjector(True);
        AttachProjector();
        PrevLocation = Location;
        PrevRotation = Rotation;
    }
}


DefaultProperties
{
    // Actor
    bStatic             = False
}
