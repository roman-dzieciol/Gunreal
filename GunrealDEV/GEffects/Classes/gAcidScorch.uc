// ============================================================================
//  gAcidScorch.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gAcidScorch extends gFadingScorch;

DefaultProperties
{
    ProjTextures(0)     = Texture'G_FX.AcidSplash2'

    AmbientSound        = Sound'G_Proc.acd_p_tss'
    SoundVolume         = 64
    SoundRadius         = 16
    SoundPitch          = 64

    DrawScale           = 0.4
}