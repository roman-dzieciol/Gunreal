// ============================================================================
//  gWeaponPickupProjector.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWeaponPickupProjector extends gDynamicProjector;

DefaultProperties
{
    // Projector
    MaterialBlendingOp          = PB_Modulate
    FrameBufferBlendingOp       = PB_AlphaBlend

    ProjTexture                 = Texture'G_FX.Gibs.weapon_blood_splat1'
    FOV                         = 45
    MaxTraceDistance            = 256
    bProjectBSP                 = False
    bProjectTerrain             = False
    bProjectStaticMesh          = True
    bProjectParticles           = False
    bProjectActor               = False
    bLevelStatic                = False
    bClipBSP                    = False
    bClipStaticMesh             = True
    bProjectOnUnlit             = True
    bGradient                   = False
    bProjectOnBackfaces         = False
    bProjectOnAlpha             = True
    bProjectOnParallelBSP       = False
    ProjectTag                  = ""
    bDynamicAttach              = False
    bNoProjectOnOwner           = False
    FadeInTime                  = 0.1
    GradientTexture             = GRADIENT_Fade

    // Actor
    DrawScale                   = 0.3
    bStatic                     = False
    RemoteRole                  = ROLE_None
    Physics                     = PHYS_Trailer
    bHidden                     = True
    Rotation                    = (Pitch=-16384)
    bTrailerPrePivot            = True
    PrePivot                    = (X=0,Y=0,Z=128)
    bTrailerAllowRotation       = False
    bTrailerSameRotation        = False
}
