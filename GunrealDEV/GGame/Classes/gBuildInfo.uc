// ============================================================================
//  gBuildInfo.uc ::
// ============================================================================
class gBuildInfo extends gObject;


final static function int GetVersion()
{
    return int(Localize("GunrealVersion", "GunrealVersion", "BuildVersion"));
}


DefaultProperties
{
}