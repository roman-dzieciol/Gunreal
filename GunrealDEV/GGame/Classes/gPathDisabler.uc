// ============================================================================
//  gPathDisabler.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPathDisabler extends gObject
    config;

struct PathList
{
    var() config name Map;
    var() config array<name> Nav;
};

var() config array<PathList> Maps;

var NavigationPoint NavTemp;

final simulated function Execute(LevelInfo L)
{
    local int i,j;
    for( i=0; i<Maps.Length; ++i )
    {
        //gLog("Execute -" #Maps[i].Map #L.outer.name);
        if( Maps[i].Map == L.outer.name )
        {
            for( j=0; j<Maps[i].Nav.Length; ++j )
            {
                gLog("Block -" #Maps[i].Nav[j]);
                SetPropertyText("NavTemp", Maps[i].Map$"."$Maps[i].Nav[j] );
                NavTemp.bBlocked = True;
            }
            break;
        }
    }

    NavTemp = None;
}



function HackReachSpecs()
{
//    local int i;
//    local ReachSpec R;
//    local NavigationPoint N;
//    local float DeltaHeight, DeltaRadius, RCrouchHeight, RStandHeight;
//    local SortedStringArray SH,SR;
//
//    DeltaHeight = class'gPawn'.default.CollisionHeight - class'xPawn'.default.CollisionHeight;
//    DeltaRadius = class'gPawn'.default.CollisionRadius - class'xPawn'.default.CollisionRadius;
//    RCrouchHeight = class'gPawn'.default.CrouchHeight;
//    RStandHeight = class'gPawn'.default.CollisionHeight;
//
//    gLog( "BendOverReachSpecs" #GON(N) #GON(R) #DeltaHeight #DeltaRadius #RCrouchHeight );
//
//    SH = new(none) class'SortedStringArray';
//    SR = new(none) class'SortedStringArray';
//
//    Foreach AllActors(class'NavigationPoint',N)
//    {
//        for( i=0; i<N.PathList.Length; ++i )
//        {
//            R = N.PathList[i];
//
//            SH.Add(R.CollisionHeight,R.CollisionHeight,True);
//            SR.Add(R.CollisionRadius,R.CollisionRadius,True);
//
//            if( R.CollisionHeight < RCrouchHeight )
//                R.CollisionHeight = RCrouchHeight + 1;
//
//            //R.CollisionHeight += DeltaHeight;
//            //R.CollisionRadius += DeltaRadius;
//            /*if( R.CollisionHeight + DeltaHeight >= RStandHeight )
//            {
//                R.CollisionHeight += DeltaHeight;
//            }
//            else
//            {
//                //gLog( "Reachspec too small!!" #GON(N) #GON(R) #R.CollisionHeight #R.default.CollisionHeight );
//            }*/
//        }
//    }
//
//   /*
//Gunreal: [57:37:093]gMutator0 :: [420][M] BendOverReachSpecs [None] [None] [17.60] [10.00] [40.60]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SH [0]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SH [100]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SH [120]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SH [44]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SH [80]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SR [0]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SR [120]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SR [26]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SR [48]
//Gunreal: [57:37:093]gMutator0 :: [420][M] SR [72]
//   */
//
//    for( i=0; i<SH.Count(); ++i )
//    {
//        gLog( "SH" #SH.GetItem(i));
//    }
//
//    for( i=0; i<SR.Count(); ++i )
//    {
//        gLog( "SR" #SR.GetItem(i));
//    }
}



DefaultProperties
{

}