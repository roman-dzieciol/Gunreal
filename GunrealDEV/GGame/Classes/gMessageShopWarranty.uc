// ============================================================================
//  gMessageShopWarranty.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageShopWarranty extends gMessageDualMode;

static function string GetString(
    optional int idx,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    if( idx >= 0 )
    {
        if( class<Inventory>(OptionalObject) != None )
            return Repl(Repl(default.PlusMsg, "%m", idx, True), "%i", class<Inventory>(OptionalObject).default.ItemName, True);
        else
            return Repl(default.PlusMsgUnknown, "%m", idx, True);
    }
    else
    {
        idx = -idx;

        if( class<Inventory>(OptionalObject) != None )
            return Repl(Repl(default.MinusMsg, "%m", idx, True), "%i", class<Inventory>(OptionalObject).default.ItemName, True);
        else
            return Repl(default.MinusMsgUnknown, "%m", idx, True);
    }
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    PlusMsg             = "$%m received for %i warranty."
    PlusMsgUnknown      = "$%m received for warranty"

    MinusMsg            = "$%m paid for %i warranty."
    MinusMsgUnknown     = "$%m paid for warranty."
}
