// ============================================================================
//  gDestroyerScout.uc :: Collision point proxy for destroyer beam
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerScout extends gActor;



simulated event PreBeginPlay()
{
}

DefaultProperties
{
    CollisionHeight             = 0
    CollisionRadius             = 0
    bCollideActors              = False
    bCollideWorld               = False
    bProjTarget                 = False
    bIgnoreOutOfWorld           = True
    bIgnoreEncroachers          = True
    bUseCollisionStaticMesh     = False

    RemoteRole                  = ROLE_None

    bAcceptsProjectors          = False
}