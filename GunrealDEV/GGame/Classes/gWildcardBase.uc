// ============================================================================
//  gWildcardBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWildcardBase extends gPickUpBase
    placeable;


var() class<Pickup>             PickupClasses[8];
var() bool                      bSequential;
var   int                       NumClasses;
var   int                       CurrentClass;


// ============================================================================
//  PickupBase
// ============================================================================

simulated function SetReplaced(Actor A)
{
    local int i;

    //Log("SetReplaced" @A);
    Super.SetReplaced(A);

    if( A != None )
    {
        if( WildcardBase(A) != None )
        {
            bSequential = WildcardBase(A).bSequential;

            for( i=0; i<ArrayCount(WildcardBase(A).PickupClasses); ++i )
            {
                PickupClasses[i] = WildcardBase(A).PickupClasses[i];
                WildcardBase(A).PickupClasses[i] = None;
            }
        }
    }

    if( Role == ROLE_Authority )
    {
        NumClasses = 0;
        while( NumClasses < ArrayCount(PickupClasses) && PickupClasses[NumClasses] != None )
            NumClasses++;

        if( bSequential )
            CurrentClass = 0;
        else
            CurrentClass = Rand(NumClasses);

        PowerUp = PickupClasses[CurrentClass];
    }
}

function TurnOn()
{
    if( bSequential )
        CurrentClass = (CurrentClass + 1) % NumClasses;
    else
        CurrentClass = Rand(NumClasses);

    PowerUp = PickupClasses[CurrentClass];
    if( myPickup != None )
        myPickup = myPickup.Transmogrify(PowerUp);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
}