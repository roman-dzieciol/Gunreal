// ============================================================================
//  gCashPickupDetector.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCashPickupDetector extends gBasedActor;


function CheckTouching()
{
    local Pawn P;

    //gLog( "gCashPickupDetector CheckTouching" );

    foreach TouchingActors(class'Pawn', P)
        Touch(P);
}

event Touch(Actor Other)
{
    //gLog( "gCashPickupDetector Touch" #GON(Other) #GON(Owner) #GON(Base) #TimerRate #Touching.Length );

    if( Owner != None && Pawn(Other) != None && Pawn(Other).Health > 0 )
    {
        Owner.Touch(Other);
        if( TimerRate == 0 )
            SetTimer(0.5+FRand()*0.5,True);
    }
}

event UnTouch( Actor Other )
{
    //gLog( "gCashPickupDetector UnTouch" #GON(Other) #GON(Owner) #GON(Base) #TimerRate #Touching.Length );

    if( Touching.Length == 1 )
        SetTimer(0,False);
}

event Timer()
{
    CheckTouching();
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    CollisionRadius             = 400
    CollisionHeight             = 400
    bCollideActors              = True
    bUseCylinderCollision       = True
    bOnlyAffectPawns            = True
    RemoteRole                  = ROLE_None
}
