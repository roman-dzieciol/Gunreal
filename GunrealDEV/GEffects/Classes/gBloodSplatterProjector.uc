//-----------------------------------------------------------
// $DATETIME: 09/04/2008 3:35:14 AM$
// Eric Blade
// Use this for the gib explosion splat, and sub it for:
//   headshot blood: Drawscale 0.5 - G_FX.Gibs.blood_splat2,5,6,7 (notice commas)
//  gib blood: Drawscale 0.5 (1.0 for G_Meshes.Gibs.headshot_a) - G_FX.Gibs.blood_splat2,5,6,7
//  trajectory blood splat: Drawscale 0.5 - G_FX.Gibs.blood_splat1,2,5,6,7 (notice begins at 1, not 2 this time)
//  gib explosion blood splat:
// Drawscale 2.0 - G_FX.Gibs.blood_splat4,
// MaxTraceDistance 100,
// Project BSP/StaticMesh/Terrain
//-----------------------------------------------------------
class gBloodSplatterProjector extends BloodSplatter;

var Array<Material> gSplats;
var Range SplatLife;
// Using our own multi-dimensional array because I hate predefined arrays

// this eventually inherits from xScorch which is not designed to be used on servers, so here we go
event PreBeginPlay() {
    super(Actor).PreBeginPlay();
}

simulated event PostBeginPlay() {
    local vector RX, RY, RZ;
    local rotator R;

	if( class'GameInfo'.static.NoBlood() )
	{
		Destroy();
		return;
	}
    ProjTexture = gSplats[Rand(gSplats.Length)];
    LifeTime = FClamp(Rand(SplatLife.Max+SplatLife.Min), SplatLife.Min, SplatLife.Max);

    //Log(self@"Created");
    if( PhysicsVolume.bNoDecals )
    {
        log(self@"Destroyed, nodecal volume");
        Destroy();
        return;
    }
    if( RandomOrient )
    {
        R.Yaw = 0;
        R.Pitch = 0;
        R.Roll = Rand(65535);
        GetAxes(R,RX,RY,RZ);
        RX = RX >> Rotation;
        RY = RY >> Rotation;
        RZ = RZ >> Rotation;
        R = OrthoRotation(RX,RY,RZ);
        SetRotation(R);
    }
    SetLocation( Location - vector(Rotation)*PushBack );
    super(Projector).PostBeginPlay();

    if(Owner != None && Owner.IsA('gGib')) {
        LifeSpan = 0;
    } else {
        if(Level.bDropDetail) LifeTime *= 0.5;
        Lifespan = LifeTime * Level.DecalStayScale;
        AbandonProjector(LifeTime * Level.DecalStayScale);
        if(Level.NetMode == NM_Standalone) Destroy();
    }

    //if( Level.bDropDetail )
    //  LifeSpan *= 0.5;
    //log(self@"blood splat projector lifespan="@lifespan@"lifetime="@lifetime);
    //AbandonProjector(LifeTime*Level.DecalStayScale);
    //AbandonProjector(180);
    //Destroy();
}

DefaultProperties
{
    gSplats(0)              = Texture'G_FX.Gibs.blood_splat4'
    DrawScale               = 2
    MaxTraceDistance        = 100
    bProjectBSP             = True
    bProjectStaticMesh      = True
    bProjectTerrain         = True
    FOV                     = 1
    SplatLife               = (Min=80,Max=100) //(Min=15,Max=25)
    FrameBufferBlendingOp   = PB_AlphaBlend
    MaterialBlendingOp      = PB_None
    LifeSpan                = 180
    CullDistance            = 8000

    DrawType                = DT_None
    bHidden                 = False
    bNetTemporary           = True
    RemoteRole              = ROLE_SimulatedProxy
}