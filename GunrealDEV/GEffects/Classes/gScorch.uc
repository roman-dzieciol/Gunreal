// ============================================================================
//  gScorch.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gScorch extends XScorch;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
}


// ============================================================================
//  Scorch
// ============================================================================

simulated event PostBeginPlay()
{
    local vector RX, RY, RZ;
    local rotator R;

    //Log( "PostBeginPlay", name );

    if( PhysicsVolume.bNoDecals )
    {
        Destroy();
        return;
    }

    if( RandomOrient )
    {
        R.Yaw = 0;
        R.Pitch = 0;
        R.Roll = Rand(36)*1820;
        GetAxes(R,RX,RY,RZ);
        RX = RX >> Rotation;
        RY = RY >> Rotation;
        RZ = RZ >> Rotation;
        R = OrthoRotation(RX,RY,RZ);
        SetRotation(R);
    }

    SetLocation( Location - vector(Rotation)*PushBack );

    Super.PostBeginPlay();

    Lifespan = FMax(0.5, LifeSpan + (Rand(4) - 2));
    if( Level.bDropDetail )
        LifeSpan *= 0.5;

    AbandonProjector(LifeSpan*Level.DecalStayScale);
    Destroy();
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

}
