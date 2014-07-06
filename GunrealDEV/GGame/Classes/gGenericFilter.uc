// ============================================================================
//  gGenericFilter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGenericFilter extends gObject
    config
    abstract;

enum EGunrealFilter
{
    F_Yes,
    F_Maybe,
    F_No
};

struct SGunrealFilter
{
    var() config EGunrealFilter Compatible;
    var() config string ClassName;
};

var() config array<SGunrealFilter> Filter;
var() config EGunrealFilter DefaultFilter;

final simulated function EGunrealFilter GetFilter( string ClassName )
{
    local int i;
    //gLog("GetFilter" #ClassName);
    for( i=0; i<Filter.Length; ++i )
    {
        //gLog("GetFilter -" #Filter[i].Compatible #Filter[i].ClassName);
        if( Filter[i].ClassName ~= ClassName )
        {
            return Filter[i].Compatible;
        }
    }
    return DefaultFilter;
}

DefaultProperties
{
    DefaultFilter       = F_Maybe
}