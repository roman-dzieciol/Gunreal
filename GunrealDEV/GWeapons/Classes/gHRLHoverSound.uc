// ============================================================================
//  gHRLHoverSound.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLHoverSound extends gBasedActor;


var   float Alpha;
var   float TargetAlpha;
var() float TimerDelta;


simulated event PostBeginPlay()
{
    //gLog( "PostBeginPlay" );

    Super.PostBeginPlay();
    if( bDeleteMe )
        return;

    SetTimer(TimerDelta,True);
    SoundPitch = 0;
}

function TearOff()
{
    //gLog( "TearOff" );
    TargetAlpha = 0;
    bTearOff = True;
    bSkipActorPropertyReplication = False;
}

simulated event TornOff()
{
    //gLog( "TornOff" );
    TargetAlpha = 0;
}

simulated event Timer()
{
    //gLog( "Timer" #bNetInitial );

    if( TargetAlpha < Alpha )
    {
        Alpha = FMax(0,Alpha-TimerDelta);
    }
    else if( TargetAlpha > Alpha )
    {
        Alpha = FMin(TargetAlpha,Alpha+TimerDelta);
    }

    //gLog( "Timer" #Alpha #SoundPitch #SoundVolume );

    SoundPitch = default.SoundPitch * Alpha;
    SoundVolume = default.SoundVolume * Alpha;

    if( TargetAlpha == 0 && Alpha == 0 )
    {
        Destroy();
    }
}

DefaultProperties
{
    TargetAlpha                         = 1
    TimerDelta                          = 0.1


    // Actor
    RemoteRole                          = ROLE_SimulatedProxy
    bSkipActorPropertyReplication       = True

    AmbientSound                        = Sound'G_Sounds.hrl_hover_idle'
    SoundRadius                         = 320
    SoundVolume                         = 255
    SoundPitch                          = 64
}
