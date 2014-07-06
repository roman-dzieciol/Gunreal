// ============================================================================
//  gPistol.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistol extends gWeapon;


var int ShotsFired;


simulated function bool ReadyToFire(int Mode)
{
    local int alt;

    if( Mode == 0 )
        alt = 1;
    else
        alt = 0;

    if(((FireMode[alt] != FireMode[Mode]) && FireMode[alt].bModeExclusive && FireMode[alt].bIsFiring )
    || !FireMode[Mode].AllowFire()
    || (FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].PreFireTime && (Mode == 1 || ShotsFired % 2 == 0)))
    {
        return False;
    }

    return True;
}

simulated event AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if( ClientState == WS_ReadyToFire )
    {
        if( !IsFiring() )
        {
            if( anim == FireMode[1].FireLoopAnim )
                PlayAnim('altend', 1.0, 0.0, 0);
            else
                PlayIdle();
        }
    }
}


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

    return Rating;
}

function byte BestMode()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target == None )
        return 0;

    Dist = VSize(Target.Location - Instigator.Location);

    if( Dist > 1024 )
        return 0;

    return 1;
}

function bool RecommendRangedAttack()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();

    if( Target == None )
        return False;

    Dist = VSize(Target.Location - Instigator.Location);
    return (Dist > 2000 * (1 + FRand()) );
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

    // gWeapon
    bSpecialDrawWeapon      = False
    bForceViewUpdate        = False
    IdleAnimTween           = 0

    CostWeapon              = 175
    CostAmmo                = 25
    ItemSize                = 2
    BotPurchaseProbMod      = 5


    // Weapon
    FireModeClass(0)        = class'gPistolFire'
    FireModeClass(1)        = class'gPistolFireAlt'
    PickupClass             = class'gPistolPickup'
    AttachmentClass         = class'gPistolAttachment'

    SelectSound             = Sound'G_Sounds.grp_select_small'

    AIRating                = 2.3
    CurrentRating           = 2.3

    ItemName                = "Acid Pistol"
    Description             = "NA"

    DisplayFOV              = 65
    PlayerViewOffset        = (x=45,y=9,z=-17)
    PlayerViewPivot         = (Pitch=0,Yaw=32768,Roll=0)
    SmallViewOffset         = (x=45,y=9,z=-17)
    SmallEffectOffset       = (X=0.0,Y=0.0,Z=0.0)
    EffectOffset            = (X=0.0,Y=0.0,Z=0.0)
    CenteredOffsetY         = -5
    CenteredRoll            = 0
    CenteredYaw             = -500

    HudColor                = (R=255,G=0,B=0,A=255)
    IconCoords              = (X1=126,Y1=0,X2=255,Y2=63)


    // Actor
    DrawScale               = 0.5
    Mesh                    = Mesh'G_Anims.apistol'

    bDynamicLight           = False
    LightType               = LT_Pulse
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10
}