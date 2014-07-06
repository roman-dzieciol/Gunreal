// ============================================================================
//  gMessageRank.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMessageRank extends LocalMessage;

var localized string RankMessage;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    return default.RankMessage;
}

static function GetPos(int Switch, out EDrawPivot OutDrawPivot, out EStackMode OutStackMode, out float OutPosX, out float OutPosY)
{
    Super.GetPos(Switch, OutDrawPivot, OutStackMode, OutPosX, OutPosY);
    OutPosY = 0.35;
}

DefaultProperties
{
    bIsSpecial=True
    bFadeMessage=True
    LifeTime=1
}