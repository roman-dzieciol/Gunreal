// ============================================================================
//  gTurretBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurretBase extends gActor;

DefaultProperties
{

    DrawScale   = 0.33
    bHidden     = False
    DrawType    = DT_StaticMesh
    StaticMesh  = StaticMesh'G_Meshes.turret_foot'
    //PrePivot    = (Z=38)
    AmbientGlow                 = 0
     bUseDynamicLights=true
}