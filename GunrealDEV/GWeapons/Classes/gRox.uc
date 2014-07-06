// ============================================================================
//  gRox.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRox extends gWeapon
    config(user);


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

    // distance
    if( Dist < 350 )
        Rating -= 0.15;

    // height
    if( ZDiff < -120 )
        Rating += 0.25;
    else if( ZDiff > 160 )
        Rating -= 0.35;
    else if( ZDiff > 80 )
        Rating -= 0.05;

    // minefield
    if( gProjectile(Target) != None )
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

function byte BestMode()
{
    local Bot B;
    local Actor Target;
    local float Dist;

    //gLog( "BestMode" );

    B = Bot(Instigator.Controller);
    if( B == None )
        return 0;

    // wall hit
    if( !B.CheckFutureSight(0.1) )
        return 1;

    Target = GetBotTarget();
    if( Target == None )
        return 0;

    Dist = VSize(Target.Location - Instigator.Location);
    if( Dist < 360 && gWeaponFire(FireMode[1]).IsInTossRange(Target) )
        return 1;

    return 0;
}




// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gWeapon
    bSpecialDrawWeapon      = False
    bForceViewUpdate        = False
    BotPurchaseProbMod      = 4
    CostWeapon              = 650
    CostAmmo                = 150
    ItemSize                = 4


    // Weapon
    FireModeClass(0)        = class'gRoxFire'
    FireModeClass(1)        = class'gRoxFireAlt'
    PickupClass             = class'gRoxPickup'
    AttachmentClass         = class'gRoxAttachment'

    SelectSound             = Sound'G_Sounds.grp_select_heavy'

    AIRating                = 2.5
    CurrentRating           = 2.5

    bShowChargingBar        = True

    ItemName                = "Rocket Launcher"
    Description             = "A Rocket-Launching killing machine. Can fire rockets and alt-fire sticky prox mines."

    DisplayFOV              = 65
    PlayerViewOffset        = (x=12,y=3.5,z=-6)
    PlayerViewPivot         = (Pitch=0,Yaw=32768,Roll=0)
    SmallViewOffset         = (x=12,y=3.5,z=-6)
    SmallEffectOffset       = (X=0.0,Y=0.0,Z=0.0)
    EffectOffset            = (X=50.0,Y=1.0,Z=10.0)

    CenteredOffsetY         = -5
    CenteredRoll            = 0
    CenteredYaw             = -500

    BobDamping              = 0.8
    HudColor                = (R=255,G=0,B=0,A=255)
    IconCoords              = (X1=255,Y1=189,X2=510,Y2=251)


    // Actor
    DrawScale               = 0.25
    Mesh                    = Mesh'G_Anims.Rox'
}
