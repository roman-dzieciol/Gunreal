// ============================================================================
//  gDynObjList.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDynObjList extends gInteractionDebug;


function Initialized()
{
    Super.Initialized();
}

function NotifyLevelChange()
{
    DumpObjects();
    Super.NotifyLevelChange();
}

event Tick( float DeltaTime )
{
    DumpObjects();
    bRequiresTick = False;
}

function DumpObjects()
{
    ConsoleCommand("obj list");

//    local Actor A;
//    local int i;
//
//    ForEach DynamicActors(class'Actor',A)
//    {
//        i++;
//        log(i@A);
//    }
//    log("Num dynamic actors: "$i);
}

DefaultProperties
{
    bActive         = True
    bRequiresTick   = True
}
