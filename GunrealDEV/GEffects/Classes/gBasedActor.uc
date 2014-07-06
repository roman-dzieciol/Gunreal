// ============================================================================
//  gBasedActor.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gBasedActor extends gActor;


event PostBeginPlay()
{
    //gLog( "PostBeginPlay" );

    if( Role == ROLE_Authority )
    {
        // Attach to owner
        if( Owner != None )
        {
            SetRotation(Owner.Rotation);
            SetLocation(Owner.Location);
            SetBase(Owner);
        }
        else
            Destroy();
    }
}

event BaseChange()
{
    //gLog("BaseChange" #GON(Base));

    if( Role == ROLE_Authority )
    {
        // Die with pawn base
        if( Base == None && !bDeleteMe )
            Destroy();
    }
}

function PawnBaseDied()
{
    //gLog("PawnBaseDied" #bDeleteMe);

    if( Role == ROLE_Authority )
    {
        // Die with pawn base
        if( !bDeleteMe )
            Destroy();
    }
}

final static function gBasedActor GetBasedActor( Actor BasedOn, class<gBasedActor> ActorClass, optional bool bSpawn )
{
    local int i;

    if( BasedOn != None )
    {
        for( i=0; i!=BasedOn.Attached.Length; ++i )
            if( BasedOn.Attached[i].class == ActorClass )
                return gBasedActor(BasedOn.Attached[i]);

        if( bSpawn )
            return BasedOn.Spawn(ActorClass, BasedOn);
    }
    return None;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // Actor
    bHardAttach                         = False
    RemoteRole                          = ROLE_DumbProxy
    bSkipActorPropertyReplication       = True
}