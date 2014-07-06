// ============================================================================
//  gDbg.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDbg extends Object;


// ============================================================================
//  Logging
// ============================================================================
simulated final static function aLog ( Actor A, LevelInfo L, coerce string S, coerce string DS )
{
    A.Log
    (   "[" $Left("00",2-Len(L.Minute)) $L.Minute $":"
            $Left("00",2-Len(L.Second)) $L.Second $":"
            $Left("000",3-Len(L.Millisecond)) $L.Millisecond $"]"
    $   A.name $" :: "
    $   "[" $A.Role $A.RemoteRole $L.NetMode $"]"
    $   "[" $StrShort(A.GetStateName()) $"]"
    $   Eval( DS != "", "<" $DS $">", "" )
    @   S
    ,   'Gunreal' );
}

simulated final static function oLog ( Object A, LevelInfo L, coerce string S, coerce string DS )
{
    local string R;

    if( L != None )
    {
        R $= "[" $Left("00",2-Len(L.Minute)) $L.Minute $":"
                $Left("00",2-Len(L.Second)) $L.Second $":"
                $Left("000",3-Len(L.Millisecond)) $L.Millisecond $"]";
    }

    R $= A.name $" :: ";
    R $= "[" $StrShort(A.GetStateName()) $"]";
    if( DS != "" )
        R $= "<" $DS $">";
    R @= S;

    A.Log( R, 'Gunreal' );
}

// ============================================================================
//  String
// ============================================================================
simulated final static function string StrShortOld( coerce string S )
{
    local string r,c;
    local int i,n;

    // gather uppercase letters

    c = Caps(S);
    n = Len(S);

    for( i=0; i!=n; ++i )
        if( Mid(s,i,1) == Mid(c,i,1) )
            r = r $ Mid(s,i,1);

    return r;
}

simulated final static function string StrShort( coerce string S )
{
    local string r,c;
    local int i,m,n;

    // gather uppercase letters, plus couple extra lowercase letters

    c = Caps(S);
    n = Len(S);

    for( i=0; i<n; ++i )
    {
        if( Mid(s,i,1) == Mid(c,i,1) )
        {
            r = r $ Mid(s,i,1);
            m = Min(i + 3, n);
            for( i=++i; i<m; ++i )
            {
                if( Mid(s,i,1) != Mid(c,i,1) )
                    r = r $ Mid(s,i,1);
                else
                    break;
            }
        }
    }

    return r;
}


simulated final static operator(112) string # ( coerce string A, coerce string B )
{
    return A @"[" $B $"]";
}

simulated final static function name GON( Object O )
{
    if( O != None ) return O.Name;
    else            return 'None';
}

simulated final static function string GPT( Object A, string S )
{
    return A.GetPropertyText(S);
}


// ============================================================================
//  Visual
// ============================================================================
simulated final static function DrawAxesRot( Actor A, vector Loc, rotator Rot, float Length, optional bool bStaying )
{
    local vector X,Y,Z;
    GetAxes( Rot, X, Y, Z );
    DrawAxesXYZ(A,Loc,X,Y,Z,Length,bStaying);
}

simulated final static function DrawAxesCoords( Actor A, Coords C, float Length, optional bool bStaying )
{
    DrawAxesXYZ(A,C.Origin,C.XAxis,C.YAxis,C.ZAxis,Length,bStaying);
}

simulated final static function DrawAxesXYZ( Actor A, vector Loc, vector X, vector Y, vector Z, float Length, optional bool bStaying )
{
    if( bStaying )
    {
        A.DrawStayingDebugLine(Loc,Loc+X*Length,255,0,0);
        A.DrawStayingDebugLine(Loc,Loc+Y*Length,0,255,0);
        A.DrawStayingDebugLine(Loc,Loc+Z*Length,0,0,255);
    }
    else
    {
        A.DrawDebugLine(Loc,Loc+X*Length,255,0,0);
        A.DrawDebugLine(Loc,Loc+Y*Length,0,255,0);
        A.DrawDebugLine(Loc,Loc+Z*Length,0,0,255);
    }
}

simulated final static function VarWatch( coerce string Desc, coerce string Value, optional bool bGraph )
{
    class'GDebug.gVarGraph'.static.Add( Desc, Value, bGraph );
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

}
