// ============================================================================
//  gProjector.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gProjector extends Projector;


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // Projector
    MaterialBlendingOp          = PB_None
    FrameBufferBlendingOp       = PB_Modulate

    FOV                         = 0
    MaxTraceDistance            = 1000
    bProjectBSP                 = True
    bProjectTerrain             = True
    bProjectStaticMesh          = True
    bProjectParticles           = False
    bProjectActor               = True
    bLevelStatic                = False
    bClipBSP                    = False
    bClipStaticMesh             = False
    bProjectOnUnlit             = False
    bGradient                   = False
    bProjectOnBackfaces         = False
    bProjectOnAlpha             = False
    bProjectOnParallelBSP       = False
    ProjectTag                  = ""
    bDynamicAttach              = False
    bNoProjectOnOwner           = False
    FadeInTime                  = 0.1
    GradientTexture             = GRADIENT_Fade

    // Actor
    bDirectional                = True
    Texture                     = Proj_Icon
    bHidden                     = True
    bStatic                     = True
    RemoteRole                  = ROLE_None
}