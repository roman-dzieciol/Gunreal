// ============================================================================
//  gClassList.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gClassList extends Object;


var() array<string> ClassNames;


static simulated function array<string> GetClassNames()
{
    return default.ClassNames;
}

static simulated function array< class<Object> > GetObjectClasses()
{
    local array< class<Object> > L;
    local class<Object> C;
    local int i;

    for( i=0; i!=default.ClassNames.Length; ++i )
    {
        if( default.ClassNames[i] != "" )
        {
            C = class<Object>(DynamicLoadObject(default.ClassNames[i], class'class', True));
            if( C != None )
                L[L.Length] = C;
        }
    }

    return L;
}

static simulated function array< class<Actor> > GetActorClasses()
{
    local array< class<Actor> > L;
    local class<Actor> C;
    local int i;

    for( i=0; i!=default.ClassNames.Length; ++i )
    {
        if( default.ClassNames[i] != "" )
        {
            C = class<Actor>(DynamicLoadObject(default.ClassNames[i], class'class', True));
            if( C != None )
                L[L.Length] = C;
        }
    }

    return L;
}

DefaultProperties
{

}