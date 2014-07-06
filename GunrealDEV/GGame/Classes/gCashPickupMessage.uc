// ============================================================================
//  gCashPickupMessage.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCashPickupMessage extends PickupMessagePlus;


var() float MessageDuration;
var() localized string PickupMessage;
var float MessageTimeout;
var int CumulativeAmount;


static function ClientReceive(
    PlayerController P,
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    if( class<gCashPickup>(OptionalObject) != None )
    {
        if( default.MessageTimeout < P.Level.TimeSeconds )
        {
            default.CumulativeAmount = 0;
        }

        default.MessageTimeout = P.Level.TimeSeconds + default.MessageDuration;
        default.CumulativeAmount += class'gCashPickup'.default.CashAmount;
    }

    Super.ClientReceive(P,Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject);
}

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    return Repl(Default.PickupMessage, "%m", default.CumulativeAmount, True);
}


DefaultProperties
{
    MessageDuration     = 4
    PickupMessage       = "You picked up: $%m"
    PosY                = 0.8
}
