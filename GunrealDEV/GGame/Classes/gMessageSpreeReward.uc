// ============================================================================
//  gMessageSpreeReward.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageSpreeReward extends gMessageMoney;

var localized string Msg;
var localized string SpreeName;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{

   return Repl( Repl( default.Msg, "%n", default.SpreeName, True ), "%m", Switch, True );
}

DefaultProperties
{
    Msg = "Received $%m from an %n."
}