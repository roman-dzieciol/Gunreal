// ============================================================================
//  gMinigunAttachmentJHP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAttachmentJHP extends gMinigunAttachment;

DefaultProperties
{
    ShellActorClass     = class'gEffects.gShellMinigunJHP'
    SpinBone            = "Barrel_a"
    Mesh                = Mesh'G_Anims3rd.minigun_a'
    RotaryClass         = class'gMinigunJHP'
    HitGroupClass       = class'GEffects.gHitGroupJHP'
    FlashEffectClass    = class'GEffects.gMinigunFlashJHP'
}