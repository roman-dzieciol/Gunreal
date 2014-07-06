// ============================================================================
//  gTerminalMessage.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTerminalMessage extends LocalMessage;

static simulated function ClientReceive(
    PlayerController P,
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

    if( class<gTerminal>(OptionalObject) == None )
        return;

    if( P.MyHUD != None )
        class<gTerminal>(OptionalObject).static.UpdateHUD(P.MyHUD);
}

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    return "You got weapons at terminal.";
}

defaultproperties
{
    bFadeMessage        = True
    bIsUnique           = True
    DrawColor           = (R=255,G=255,B=255,A=255)
    FontSize            = 0
    PosY                = 0.9
}
