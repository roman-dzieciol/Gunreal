// ============================================================================
//  gPickupProjector.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
//  NOTES:
//  * Pickup base is not static so projecting on it would be very slow (4x)
// ============================================================================
class gPickupProjector extends gProjector;


var gPickupProjectorRotator TexRot;
var bool bShouldHide;


// ============================================================================
//  Projector
// ============================================================================

simulated event PostBeginPlay()
{
    TexRot = gPickupProjectorRotator(Level.ObjectPool.AllocateObject(class'gPickupProjectorRotator'));
    TexRot.Material = ProjTexture;
    TexRot.UOffset = ProjTexture.MaterialUSize()*0.5;
    TexRot.VOffset = ProjTexture.MaterialVSize()*0.5;
    ProjTexture = TexRot;

    SetRotation(rot(-16384,0,0));
    SetLocation(Owner.Location);
    DetachProjector(True);
}

simulated event Destroyed()
{
    //gLog( "Destroyed" );

    DetachProjector(True);
    if( TexRot != None )
    {
        ProjTexture = TexRot.Material;
        TexRot.Material = None;
        Level.ObjectPool.FreeObject(TexRot);
        TexRot = None;
    }

    Super.Destroyed();
}

simulated event Tick(float DeltaTime)
{
    if( Owner != None )
    {
        if( bShouldHide != Owner.bHidden )
        {
            bShouldHide = Owner.bHidden;
            if( bShouldHide )
            {
                //Log( bShouldHide, name );
                DetachProjector(True);
            }
            else
            {
                //Log( bShouldHide, name );
                DetachProjector(True);
                AttachProjector();
            }
        }
        else if( !bShouldHide )
        {
            TexRot.Rotation.Yaw = -Owner.Rotation.Yaw;
        }
    }
}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    bNotOnDedServer             = True
    bGameRelevant               = True
    bStatic                     = False

    bProjectBSP                 = True
    bProjectTerrain             = True
    bProjectStaticMesh          = True
    bProjectParticles           = False
    bProjectActor               = False
    bLevelStatic                = False
    bClipBSP                    = True
    bClipStaticMesh             = True
    bProjectOnUnlit             = True
    bGradient                   = False
    bProjectOnBackfaces         = False
    bProjectOnAlpha             = True
    bProjectOnParallelBSP       = True
    ProjectTag                  = ""
    bDynamicAttach              = False
    bNoProjectOnOwner           = True

    Texture                     = None
    ProjTexture                 = None
    DrawScale                   = 1.0
    FOV                         = 140

    MaxTraceDistance            = 90
    FrameBufferBlendingOp       = PB_Add
}