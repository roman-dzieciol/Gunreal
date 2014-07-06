// ============================================================================
//  gAnnouncerQueueManager.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gAnnouncerQueueManager extends AnnouncerQueueManager;


function bool AddItemToQueue( Name ASound, optional EAPriority Priority, optional byte Switch )
{
    local QueueItem NewItem;

    log(self@"AddItemToQueue"@ASound@Priority@Switch);

    if( Receiver == None )
        return False;

    if( Priority == AP_InstantPlay && IsQueueing() )
        return False;

    if( Priority == AP_InstantOrQueueSwitch && !IsQueueingSwitch( Switch ) )
        return False;

    if( Priority == AP_NoDuplicates && CanFindSoundInQueue( ASound ) )
        return False;

    NewItem.Voice   = ASound;
    NewItem.Switch  = Switch;

    if( Priority == AP_InstantOrQueueSwitch )  // do not queue for these, but play instantly
        NewItem.Delay = 0.01;
    else if( ASound != '' && Receiver.StatusAnnouncer != None )
        NewItem.Delay = GetSoundDuration( Receiver.StatusAnnouncer.GetSound(ASound) ) + GapTime;
    else
        NewItem.Delay = GapTime;

    Queue[Queue.Length] = NewItem;

    return True;
}

function Timer()
{
	local float DeltaTime;

	DeltaTime =	(Level.TimeSeconds - LastTimerCheck) / Level.TimeDilation;

	if ( Queue.Length > 0 )
	{
		Queue[0].Delay -= DeltaTime;
		if ( Queue[0].Delay <= 0 )
		{
			if ( Queue.Length > 1 )
				ProcessQueueItem( Queue[1] );

			Queue.Remove(0, 1);
		}
	}

	LastTimerCheck = Level.TimeSeconds;
}



DefaultProperties
{
    GapTime = 0.4
}