// ============================================================================
//  gMessageMultiKill.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageMultiKill extends gMessageMoney;

var localized string Msg;
var localized string MultiKillName;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{

   return Repl( Repl( default.Msg, "%n", default.MultiKillName, True ), "%m", Switch, True );
}

DefaultProperties
{
    Msg = "Received $%m from an %n."
}