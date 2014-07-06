// ============================================================================
//  gDestroyerNodePool.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerNodePool extends gObject;

var() gDestroyerNode Pool;


final static function gDestroyerNode GetNode()
{
    local gDestroyerNode N;

    if( default.Pool != None )
    {
        N = default.Pool;
        default.Pool = default.Pool.Next;
        return N;
    }

    return new(None) class'gDestroyerNode';
}

final static function ReleaseNode( gDestroyerNode N )
{
    if( N != None )
    {
        N.Free();
        N.Next = default.Pool;
        default.Pool = N;
    }
}

final static function ReleaseNodeRange( gDestroyerNode From, gDestroyerNode To )
{
    local gDestroyerNode N;

    if( From != None )
    {
        N = From;
        while( N != None )
        {
            N.Free();
            N = N.Next;
        }

        if( To != None )
            To.Next = default.Pool;
        default.Pool = From;
    }
}

DefaultProperties
{

}