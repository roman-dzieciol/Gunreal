// ============================================================================
//  gLadderInfo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gLadderInfo extends UT2K4LadderInfo;

static function string MakeURLFor(GameProfile G) {
    local string x;
    x = super.MakeURLFor(G);
    return x$"?mutator=GGame.gMutator";
}

DefaultProperties
{

}