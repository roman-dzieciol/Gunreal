// ============================================================================
//  g2K4Tab_MutatorMP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4Tab_MutatorMP extends UT2K4Tab_MutatorMP;

function string BuildActiveMutatorString()
{
    local string Result;

    Result = Super.BuildActiveMutatorString();
    if( Result != "" )
        Result $= ",";

    return Result $ "GGame.gMutator";
}

DefaultProperties
{

}