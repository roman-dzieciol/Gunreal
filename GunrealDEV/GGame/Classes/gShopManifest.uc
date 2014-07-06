// ============================================================================
//  gShopManifest.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopManifest extends Object;

// Manifest items
var() array<string> Weapons;
var() array<string> Gloves;


static simulated function array< class<gWeapon> > GetWeaponClasses()
{
    local class<gWeapon> W;
    local int i;
    local array< class<gWeapon> > L;

    for( i = 0; i != default.Weapons.Length; ++i )
    {
        if( default.Weapons[i] != "" )
            W = class<gWeapon>(DynamicLoadObject(default.Weapons[i], class'class', True));

        if( W != None )
            L[L.Length] = W;
    }

    return L;
}

static simulated function array< class<Weapon> > GetGloveClasses()
{
    local class<Weapon> W;
    local int i;
    local array< class<Weapon> > L;

    for( i = 0; i != default.Gloves.Length; ++i )
    {
        if( default.Gloves[i] != "" )
            W = class<Weapon>(DynamicLoadObject(default.Gloves[i], class'class', True));

        if( W != None )
            L[L.Length] = W;
    }

    return L;
}

static simulated function int FindWeaponIndexByName( string ClassName )
{
    local int i;
    if( ClassName != "" )
        for( i=0; i!=default.Weapons.Length; ++i )
            if( default.Weapons[i] ~= ClassName )
                return i;
    return -1;
}

static simulated function int FindGloveIndexByName( string ClassName )
{
    local int i;
    if( ClassName != "" )
        for( i=0; i!=default.Gloves.Length; ++i )
            if( default.Gloves[i] ~= ClassName )
                return i;
    return -1;
}

static simulated function int FindWeaponIndexByClass( class<gWeapon> ItemClass )
{
    if( ItemClass != None )
        return FindWeaponIndexByName( Caps(string(ItemClass)) );
    return -1;
}

static simulated function int FindGloveIndexByClass( class<Weapon> ItemClass )
{
    if( ItemClass != None )
        return FindGloveIndexByName( Caps(string(ItemClass)) );
    return -1;
}

DefaultProperties
{

}