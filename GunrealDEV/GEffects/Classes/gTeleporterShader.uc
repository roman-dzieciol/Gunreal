// ============================================================================
//  gTeleporterShader.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterShader extends Shader;

DefaultProperties
{
    ModulateSpecular2X          = False

    Diffuse                     = None
    Opacity                     = None
    //Specular                    = TexEnvMap'CubeMaps.Kretzig.Kretzig2TexENV'
    //SpecularityMask             = Material'DanFX.teleportergrad'
    SelfIllumination            = None // procedural
    SelfIlluminationMask        = Material'DanFX.teleportergrad'
//
    FallbackMaterial            = Material'Engine.DefaultTexture'
}
