// ============================================================================
//  gBloodEmmiter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gBloodEmmiter extends gGoreEmitter;

var() bool bAttatchToPlayer;
var() name attatchToBone;

var pawn hitPawn;

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( AttatchToBone != '' )
    {
        //SetLocation(hitPawn.GetBoneCoords(attatchToBone));
        AttachToBone(hitPawn, attatchToBone);
    }
    else if( bAttatchToPlayer )
    {
        Attach(hitPawn);
    }
}

defaultproperties
{
    bAttatchToPlayer        = False
}
