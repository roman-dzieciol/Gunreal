// ============================================================================
//  gTurretArmor.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurretArmor extends gActor;

DefaultProperties
{
    DrawScale   = 0.33
    bHidden     = False
    DrawType    = DT_StaticMesh
    //StaticMesh  = StaticMesh'G_Meshes.turret_arms_1'
    StaticMesh  = StaticMesh'G_Meshes.turret_shield_arms'
    AmbientGlow                 = 0
     bUseDynamicLights=true
}