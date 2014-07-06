// ============================================================================
//  gProjectileWhizzBy.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gProjectileWhizzBy extends gBasedActor;


var Sound WhizzBySound;
var float WhizzBySoundRadius;


event BaseChange()
{
    //gLog("BaseChange" #GON(Base));

    if( Role == ROLE_Authority )
    {
        // Die with pawn base
        if( Base == None && !bDeleteMe )
        {
            Lifespan = 0.3;
            Disable('Touch');
        }
    }
}

function PawnBaseDied()
{
    //gLog("PawnBaseDied" #bDeleteMe);

    if( Role == ROLE_Authority )
    {
        // Die with pawn base
        if( !bDeleteMe )
        {
            Lifespan = 0.3;
            Disable('Touch');
        }
    }
}

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.WhizzBySound);
}

event Touch( Actor Other )
{
    if( Owner != None
    &&  Other != Instigator
    &&  Pawn(Other) != None
    &&  gPlayer(Pawn(Other).Controller) != None )
    {
        //gLog( "Touch" @Other @Base );
        Owner.PlaySound(WhizzBySound,SLOT_None,2,,WhizzBySoundRadius);
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    WhizzBySound                    = Sound'G_Proc.g_bullet_whiz'
    WhizzBySoundRadius              = 160

    CollisionRadius                 = 192
    CollisionHeight                 = 192
    bCollideActors                  = True
    bUseCylinderCollision           = True
    bOnlyAffectPawns                = True
    RemoteRole                      = ROLE_None
}
