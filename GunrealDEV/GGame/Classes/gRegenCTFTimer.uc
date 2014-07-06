//-----------------------------------------------------------
//
//-----------------------------------------------------------
class gRegenCTFTimer extends gRegenTimer;

event Timer()
{
	Super.Timer();
	
	if( Pawn(Owner).PlayerReplicationInfo != None && Pawn(Owner).PlayerReplicationInfo.HasFlag == None )
		Destroy();
}

final static function gRegenCTFTimer GetRegenCTFTimer( Pawn P, optional bool bSpawn )
{
    local int i;

    if( P != None )
    {
        for( i=0; i!=P.Attached.Length; ++i )
            if( gRegenCTFTimer(P.Attached[i]) != None )
                return gRegenCTFTimer(P.Attached[i]);

        if( bSpawn )
            return P.Spawn(default.class, P);
    }
    return None;
}

DefaultProperties
{
    HealAmount			= 20
    RegenEmitterClass	= class'GEffects.gRegenCTFEmitter'
}