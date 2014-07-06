// ============================================================================
//  gMessageMoneyBonus.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageMoneyBonus extends gMessageMoney;

var localized string MsgMinus;
var localized string MsgPlus;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    if( Switch >= 0 )
        return Repl(default.MsgPlus, "%m", Switch, True);
    else
        return Repl(default.MsgMinus, "%m", Switch, True);
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    MsgMinus        = "$%m removed for MoneyBoost."
    MsgPlus         = "$%m added for MoneyBoost."
}