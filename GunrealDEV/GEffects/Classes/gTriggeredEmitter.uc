// ============================================================================
//  gTriggeredEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTriggeredEmitter extends gEmitter
    abstract;

simulated event PostBeginPlay()
{
    local int i;

    //Log( "PostBeginPlay" );
    Super.PostBeginPlay();

    for( i=0; i!=Emitters.Length; ++i )
    {
        if( Emitters[i] != None )
        {
            Emitters[i].Disabled = True;
            Emitters[i].AllParticlesDead = True;
        }
    }
}

simulated event Trigger( Actor Other, Pawn EventInstigator )
{
    local int i;

    Super.Trigger( Other, EventInstigator );

    for( i=0; i!=Emitters.Length; ++i )
    {
        if( Emitters[i] != None && !Emitters[i].Backup_Disabled )
        {
            Emitters[i].AllParticlesDead = False;
            Emitters[i].Disabled = False;
            Emitters[i].Reset();
        }
    }
}

DefaultProperties
{
    AutoDestroy = False
}
