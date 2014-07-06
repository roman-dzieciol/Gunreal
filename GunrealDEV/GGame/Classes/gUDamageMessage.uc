// ============================================================================
//  gUDamageMessage.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gUDamageMessage extends LocalMessage;

var() Sound         UDamageSounds[3];

//* When the UDamage respawns (not when it is dropped), play this sound for all players: G_Sounds.g_udamage_spawn_1
//* When the UDamage is dropped, play this sound for all players: G_Sounds.g_udamage_dropped_1
//* When the UDamage is picked up by anyone, play this sound for all players: G_Sounds.g_udamage_notif_1

static function ClientReceive(
    PlayerController P,
    optional int Switch,
    optional PlayerReplicationInfo PRI1,
    optional PlayerReplicationInfo PRI2,
    optional Object OptionalObject
    )
{
    if( Switch <= 3 )
        P.PlayAnnouncement(default.UDamageSounds[Switch], 1, True);
}

//=============================================================================
// DefaultProperties
//=============================================================================
defaultproperties
{
    DrawColor               = (R=255,G=255,B=255,A=255)
    bIsSpecial              = False
    bIsConsoleMessage       = True
    LifeTime                = 6

    UDamageSounds(0)        = Sound'G_Sounds.g_udamage_spawn_1'
    UDamageSounds(1)        = Sound'G_Sounds.g_udamage_notif_1'
    UDamageSounds(2)        = Sound'G_Sounds.g_udamage_dropped_1'
}