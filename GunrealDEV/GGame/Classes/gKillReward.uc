// ============================================================================
//  gKillReward.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gKillReward extends gObject;

var() class<LocalMessage>       KillMsgClass;
var() class<LocalMessage>       DamageMsgClass;

var() int                       TeamKillCash;
var() int                       KillCash;
var() int                       DamageCash;
var() int                       DamageCashLimit;

DefaultProperties
{

}