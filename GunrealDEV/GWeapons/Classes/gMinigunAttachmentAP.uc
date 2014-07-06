// ============================================================================
//  gMinigunAttachmentAP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAttachmentAP extends gMinigunAttachment;

DefaultProperties
{
    ShellActorClass     = class'gEffects.gShellMinigunAP'
    SpinBone            = "Barrel_b"
    Mesh                = Mesh'G_Anims3rd.minigun_b'
    RotaryClass         = class'gMinigunAP'
    HitGroupClass       = class'GEffects.gHitGroupAP'
}