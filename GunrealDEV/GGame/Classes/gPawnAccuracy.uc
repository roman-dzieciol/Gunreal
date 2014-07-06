// ============================================================================
//  gPawnAccuracy.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPawnAccuracy extends gObject
    within gPawn;


var() float                 InaccuracyAir;          // in air
var() float                 InaccuracySprint;       // on ground, sprinting
var() float                 InaccuracyWalk;         // on ground, walking
var() float                 InaccuracyStand;        // on ground, not moving
var() float                 InaccuracyCrouch;       // on ground, crouching
var() float                 InaccuracyCrouchIdle;   // on ground, crouching but not moving
var() float                 InaccuracySwim;         // in water
var() float                 InaccuracySwimIdle;     // in water but not moving


simulated function Free()
{
    //gLog( "Free" );

    ClearOuter();
}

final simulated function float GetStanceSpread()
{
    local bool bIdle;

    bIdle = Acceleration == vect(0,0,0) && VSize(Velocity) < 20;

    if( Physics == PHYS_Walking )
    {
        if( bIdle )
        {
            if( bIsCrouched )   return InaccuracyCrouchIdle;
            else                return InaccuracyStand;
        }
        else if( bIsCrouched )  return InaccuracyCrouch;
        else if( bIsWalking )   return InaccuracyWalk;
        else                    return InaccuracySprint;
    }
    else if( Physics == PHYS_Falling )
    {
        return InaccuracyAir;// FMax(InaccuracySprint, InaccuracyAir*FMin(1,(Abs(Velocity.Z) / JumpZ)) );
    }
    else if( Physics == PHYS_Swimming )
    {
        if( bIdle ) return InaccuracySwimIdle;
        else        return InaccuracySwim;
    }

    return 0;
}


DefaultProperties
{

    InaccuracyAir                       = 2.0
    InaccuracySprint                    = 1.0
    InaccuracyWalk                      = 0.5
    InaccuracyStand                     = 0.05
    InaccuracySwim                      = 0.25
    InaccuracySwimIdle                  = 0.1
    InaccuracyCrouch                    = 0.05
    InaccuracyCrouchIdle                = 0.0

}