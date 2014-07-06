// ============================================================================
//  gGibGroup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGibGroup extends xpawngibgroup;


DefaultProperties
{
    BloodHitClass               = None
    LowGoreBloodHitClass        = None
    BloodGibClass               = None
    LowGoreBloodGibClass        = None
    LowGoreBloodEmitClass       = None
    BloodEmitClass              = None
    NoBloodEmitClass            = None
    NoBloodHitClass             = None

    Gibs(0)                     = class'GGame.gGibCalf'
    Gibs(1)                     = class'GGame.gGibForearm'
    Gibs(2)                     = class'GGame.gGibForearm'
    Gibs(3)                     = class'GGame.gGibHead'
    Gibs(4)                     = class'GGame.gGibTorso'
    Gibs(5)                     = class'GGame.gGibUpperArm'

    GibSounds(0)                = Sound'G_Proc.gore_gib_explosion'
    GibSounds(1)                = Sound'G_Proc.gore_gib_explosion'
    GibSounds(2)                = sound'G_Proc.gore_gib_explosion'
}
