//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gMutSquadAI extends MutSquadAI;

function bool SetEnemy( Bot B, Pawn NewEnemy )
{
	if( gPawn(B.Pawn) != None && gPawn(B.Pawn).Turret == NewEnemy )
		return false;
	
	return Super.SetEnemy(B,NewEnemy);
}

DefaultProperties
{

}