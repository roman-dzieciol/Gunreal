// ============================================================================
//  gPrecacheScanMerged.uc :: cmd = summon GWeapons.gPrecacheScanMerged
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPrecacheScanMerged extends gPrecacheScanImpl;

function ScanActors()
{
    local int i;
    local array< class<Object> > WeaponList, GameList, MergedList;

    ClearLog();

    WeaponList = class'gPrecacheWeaponsList'.static.GetObjectClasses();
    GameList = class'gPrecacheGameList'.static.GetObjectClasses();

    for( i=0; i!=WeaponList.Length; ++i )
        MergedList[MergedList.Length] = WeaponList[i];

    for( i=0; i!=GameList.Length; ++i )
        MergedList[MergedList.Length] = GameList[i];

    for( i=0; i!=MergedList.Length; ++i )
    {
        PrecacheObject(MergedList[i]);
    }

    WriteLog("Merged");
}

DefaultProperties
{
    FileName="PrecacheMerged"
}