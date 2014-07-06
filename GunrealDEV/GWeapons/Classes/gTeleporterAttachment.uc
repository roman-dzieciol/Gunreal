// ============================================================================
//  gTeleporterAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterAttachment extends gWeaponAttachment;

DefaultProperties
{
    bHeavy                  = True
    bRapidFire              = True
    bAltRapidFire           = True
    Mesh                    = Mesh'G_Anims3rd.cglove'
    DrawScale               = 0.3
    RelativeLocation        = (X=30,Y=0,Z=-15)
    RelativeRotation        = (Pitch=0,Yaw=0,Roll=32768)

}
