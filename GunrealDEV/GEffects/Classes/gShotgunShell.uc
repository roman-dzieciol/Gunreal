// ============================================================================
//  gShotgunShell.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotgunShell extends gShell;

DefaultProperties
{
    StaticMesh          = StaticMesh'G_Meshes.Projectiles.shotgun_shell1'
    InitialVelocity     = (X=(Min=240.000000,Max=320.000000),Y=(Min=180.000000,Max=350.000000))
    Lifespan            = 12
    InitialSpin         = 24576
    DrawScale           = 0.65
}