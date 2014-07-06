// ============================================================================
//  gMessageMoneyVehicleSteal.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageMoneyVehicleSteal extends gMessageMoney;

var localized string Msg;
var localized string MsgUnknown;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    if( Vehicle(OptionalObject) != None )
            return Repl( Repl( default.Msg, "%m", Switch, True ), "%p", Vehicle(OptionalObject).VehicleNameString, True );
    else    return Repl( default.MsgUnknown, "%m", Switch, True );
}

DefaultProperties
{
    Msg = "$%m awarded for damaging %p."
    MsgUnknown = "$%m awarded for damaging vehicle."
}
