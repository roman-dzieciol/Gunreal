// ============================================================================
//  gPlasmaBoostAmbient.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaBoostAmbient extends gBasedActor;


var() Sound   BoostEndSound;
var() float   BoostEndVolume;
var() float   BoostEndRadius;


static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.BoostEndSound);
}

event Destroyed()
{
    // Play end boost sound
    if( Owner != None && !Owner.bDeleteMe )
        Owner.PlaySound( BoostEndSound, SLOT_None, BoostEndVolume,, BoostEndRadius, 1.0 );

    Super.Destroyed();
}

final static function gPlasmaBoostAmbient GetActor( Actor BasedOn, optional bool bSpawn )
{
    local int i;

    if( BasedOn != None )
    {
        for( i=0; i!=BasedOn.Attached.Length; ++i )
            if( gPlasmaBoostAmbient(BasedOn.Attached[i]) != None )
                return gPlasmaBoostAmbient(BasedOn.Attached[i]);

        if( bSpawn )
            return BasedOn.Spawn(default.class, BasedOn);
    }
    return None;
}

DefaultProperties
{

    BoostEndSound       = Sound'G_Sounds.pl_boostend'
    BoostEndVolume      = 1.0
    BoostEndRadius      = 1000


    // Actor
    AmbientSound        = Sound'G_Sounds.pl_boostloop'
    SoundVolume         = 320
    SoundRadius         = 255
    SoundPitch          = 64
}