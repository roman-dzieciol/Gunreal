// ============================================================================
//  gMessageMoneyGlobal.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageMoneyGlobal extends gMessageMoney;


var localized string Msg;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{

   return Repl( default.Msg, "%m", Switch, True );
}

DefaultProperties
{
    Msg = "Received $%m from global income."
}
