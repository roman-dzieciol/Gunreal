// ============================================================================
//  gWeaponsList.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWeaponsList extends gClassList;

static simulated function array<string> GetWeapons()
{
    return default.ClassNames;
}

static simulated function array< class<gWeapon> > GetGWeaponClasses()
{
    local class<gWeapon> W;
    local int i;
    local array< class<gWeapon> > L;

    for( i = 0; i != default.ClassNames.Length; ++i )
    {
        if( default.ClassNames[i] != "" )
            W = class<gWeapon>(DynamicLoadObject(default.ClassNames[i], class'class', True));

        if( W != None )
            L[L.Length] = W;
    }

    return L;
}
static simulated function array< class<Weapon> > GetWeaponClasses()
{
    local class<Weapon> W;
    local int i;
    local array< class<Weapon> > L;

    for( i = 0; i != default.ClassNames.Length; ++i )
    {
        if( default.ClassNames[i] != "" )
            W = class<Weapon>(DynamicLoadObject(default.ClassNames[i], class'class', True));

        if( W != None )
            L[L.Length] = W;
    }

    return L;
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
}