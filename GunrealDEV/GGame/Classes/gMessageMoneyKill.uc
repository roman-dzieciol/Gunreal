// ============================================================================
//  gMessageMoneyKill.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageMoneyKill extends gMessageDualMode;

static function string GetString(
    optional int idx,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    if( idx >= 0 )
    {
        if( RelatedPRI_2 != None )
            return Repl(Repl(default.PlusMsg, "%m", idx, True), "%p", RelatedPRI_2.PlayerName, True);
        else
            return Repl(default.PlusMsgUnknown, "%m", idx, True);
    }
    else
    {
        idx = -idx;

        if( RelatedPRI_2 != None )
            return Repl(Repl(default.MinusMsg, "%m", idx, True), "%p", RelatedPRI_2.PlayerName, True);
        else
            return Repl(default.MinusMsgUnknown, "%m", idx, True);
    }
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    PlusMsg             = "$%m awarded for killing %p."
    PlusMsgUnknown      = "$%m awarded for kill."

    MinusMsg            = "$%m lost for teamkilling %p."
    MinusMsgUnknown     = "$%m lost for teamkilling."
}