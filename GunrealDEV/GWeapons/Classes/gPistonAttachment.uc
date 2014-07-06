// ============================================================================
//  gPistonAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistonAttachment extends gTracingAttachment;


var() class<Emitter>    HealFlashClass;


simulated function ShowMuzzleFlash()
{
    //gLog("ShowMuzzleFlash");

    if( HealFlashClass != None && FlashBone != '' )
    {
        if( FlashBoneRotator != rot(0,0,0) )
            SetBoneRotation( FlashBone, FlashBoneRotator, 0, 1 );

        FlashEffect = Spawn(HealFlashClass, Instigator,, GetBoneCoords(FlashBone).Origin, GetBoneRotation(FlashBone));
        if( FlashEffect != None )
            AttachToBone(FlashEffect, FlashBone);
    }
}

DefaultProperties
{
    HitGroupClass           = class'GEffects.gHitGroupPiston'
    bTracer                 = False

    bHeavy                  = True
    bRapidFire              = True
    bAltRapidFire           = True

    Mesh                    = Mesh'G_Anims3rd.cglove'
    DrawScale               = 0.3
    RelativeLocation        = (X=30,Y=0,Z=-15)
    RelativeRotation        = (Pitch=0,Yaw=0,Roll=32768)

    HealFlashClass          = class'GEffects.gPistonHealFlash'
    FlashBone               = "Muzzle"
    FlashBoneRotator        = (Pitch=0,Yaw=0,Roll=0)
}
