// ============================================================================
//  gMinigunHE.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMinigunHE extends gMinigun;


// ============================================================================
//  AI
// ============================================================================

function byte BestMode()
{
    local Bot B;

    B = Bot(Instigator.Controller);
    if( B == None )
        return 0;

    // wall hit
    if( !B.CheckFutureSight(0.1) )
        return 1;

    return 0;
}

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

    // distance
    if( Dist < 384 )
        return RATING_Poor;

    // target
    if( Vehicle(Target) != None )
        Rating += 1;
    else if( gProjectile(Target) != None )
        Rating += 1;

    return Rating;
}

function float SuggestAttackStyle()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target != None )
    {
        Dist = VSize(Target.Location - Instigator.Location);
        if( Dist < 500 )
            return -1.5;
        else if( Dist < 750 )
            return -0.7;
        else if( Dist < 1600 )
            return -0.1;
    }
    return 0.5;
}

function float SuggestDefenseStyle()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target != None )
    {
        Dist = VSize(Target.Location - Instigator.Location);
        if( Dist < 1024 )
            return -0.6;
    }
    return 0.0;
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

    SpinBone                = "barrel_c"
    SpinSound               = Sound'G_Sounds.mini_w_spin'
    SpinSoundPitch          = 48


    // gWeapon
    CostWeapon              = 800
    CostAmmo                = 200
    BotPurchaseProbMod      = 3


    // Weapon
    ItemName                = "Minigun (Explosive)"
    GroupOffset             = 2

    FireModeClass(0)        = class'gMinigunFireHE'
    FireModeClass(1)        = class'gMinigunFireAlt'
    AttachmentClass         = class'gMinigunAttachmentHE'
    PickupClass             = class'gMinigunPickupHE'

    IconCoords              = (X1=0,Y1=189,X2=255,Y2=251)

    AIRating                = 2.7
    CurrentRating           = 2.7


    // Actor
    Mesh                    = Mesh'G_Anims.minigun_c'
}