//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gMessageMoneyExcess extends gMessageMoney;

var localized string Msg;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{

   return Repl( Repl( default.Msg, "%m", Switch, True ), "%p", RelatedPRI_1.PlayerName, True );
}

DefaultProperties
{
    Msg = "Received $%m from [%p] excess funds."
}