// ============================================================================
//  gMinigunJHP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunJHP extends gMinigun;




// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // gRotaryWeapon
    SpinUpTime              = 1.0
    SpinDownTime            = 1.0
    SpinBone                = "barrel_a"
    SpinSound               = Sound'G_Sounds.mini_w_spin'


    // gWeapon
    CostWeapon              = 550
    CostAmmo                = 150
    BotPurchaseProbMod      = 5


    // Weapon
    AIRating                = 2.6
    CurrentRating           = 2.6
    IconCoords              = (X1=0,Y1=126,X2=225,Y2=189)

    ItemName                = "Minigun"

    FireModeClass(0)        = class'gMinigunFireJHP'
    FireModeClass(1)        = class'gMinigunFireAlt'
    AttachmentClass         = class'gMinigunAttachmentJHP'
    PickupClass             = class'gMinigunPickupJHP'


    // Actor
    Mesh                    = Mesh'G_Anims.minigun_a'
}