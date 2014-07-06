// ============================================================================
//  gMinigunAP.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunAP extends gMinigun;


// ============================================================================
//  AI
// ============================================================================

function float GetAIRating()
{
    local Bot B;
    local float Dist, Rating, ZDiff;
    local vector Delta;
    local Actor Target;

    B = Bot(Instigator.Controller);
    if( B == None )
        return AIRating;

    Target = GetBotTarget();
    if( Target == None )
        return AIRating;

    Delta = Target.Location - Instigator.Location;
    Dist = VSize(Delta);
    ZDiff = Delta.Z;
    Rating = AIRating;

    // antivehicle
    if( Vehicle(Target) != None )
        Rating += 1;
    else if( gPawn(Target) != None )
        Rating -= 0.1;

    return Rating;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gRotaryWeapon
    SpinUpTime              = 0.66
    SpinDownTime            = 0.66

    WindDownSound           = None

    SpinBone                = "barrel_b"
    SpinSound               = Sound'G_Sounds.mini_w_spin'
    SpinSoundPitch          = 56


    // gWeapon
    CostWeapon              = 650
    CostAmmo                = 150
    BotPurchaseProbMod      = 3


    // Weapon
    FireModeClass(0)        = class'gMinigunFireAP'
    FireModeClass(1)        = class'gMinigunFireAlt'
    AttachmentClass         = class'gMinigunAttachmentAP'
    PickupClass             = class'gMinigunPickupAP'

    ItemName                = "Minigun (Anti-Armor)"

    AIRating                = 2.6
    CurrentRating           = 2.6
    GroupOffset             = 1

    IconCoords              = (X1=0,Y1=63,X2=255,Y2=125)


    // Actor
    Mesh                    = Mesh'G_Anims.minigun_b'
}