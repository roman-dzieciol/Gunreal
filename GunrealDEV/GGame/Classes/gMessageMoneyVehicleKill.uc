// ============================================================================
//  gMessageMoneyVehicleKill.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageMoneyVehicleKill extends gMessageDualMode;


static function string GetString(
    optional int idx,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    if( idx >= 0 )
    {
        if( Vehicle(OptionalObject) != None )
                return Repl( Repl( default.PlusMsg, "%m", idx, True ), "%p", Vehicle(OptionalObject).VehicleNameString, True );
        else    return Repl( default.PlusMsgUnknown, "%m", idx, True );
    }
    else
    {
        idx = -idx;
        if( Vehicle(OptionalObject) != None )
                return Repl( Repl( default.MinusMsg, "%m", idx, True ), "%p", Vehicle(OptionalObject).VehicleNameString, True );
        else    return Repl( default.MinusMsgUnknown, "%m", idx, True );
    }
}

DefaultProperties
{
    PlusMsg = "$%m awarded for destroying %p."
    PlusMsgUnknown = "$%m awarded for destroying vehicle."

    MinusMsg = "$%m lost for destroying %p."
    MinusMsgUnknown = "$%m lost for destroying vehicle."
}
