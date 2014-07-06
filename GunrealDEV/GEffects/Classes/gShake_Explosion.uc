// ============================================================================
//  gShake_Explosion.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShake_Explosion extends gShakeView;



DefaultProperties
{
    AlphaAmountMax          = 30

    AlphaDuration           = 1.0
    AlphaOffsetDecay        = 1
    AlphaOffsetFreq         = 1
    AlphaOffsetMag          = (X=-10,Y=2,Z=2)
    AlphaRotationDecay      = 1
    AlphaRotationFreq       = 2
    AlphaRotationMag        = (Pitch=-768,Yaw=512,Roll=512)

    Duration                = 0.5
    OffsetDecay             = 1
    OffsetFreq              = 2
    OffsetMag               = (X=-1,Y=1,Z=1)
    OffsetRand              = (X=0,Y=1,Z=1)
    RotationDecay           = 1
    RotationFreq            = 2
    RotationMag             = (Pitch=-256,Yaw=32,Roll=32)
    RotationRand            = (Pitch=1,Yaw=1,Roll=1)

}