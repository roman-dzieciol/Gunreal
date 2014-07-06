// ============================================================================
//  gG60Gun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60Gun extends gZoomingWeapon;


var() float                 BarrelDist;
var   int                   ShotsFired;


// ============================================================================
//  Firing
// ============================================================================

simulated function vector GetEffectStart()
{
    if( ShotsFired % 2 == 0 )
        return Super.GetEffectStart();
    else
        return Super.GetEffectStart() + Get2ndBarrelOffset();
}

final simulated function vector Get2ndBarrelOffset()
{
    local vector X,Y,Z;
    GetViewAxes(X, Y, Z);
    return Z * BarrelDist;
}


// ============================================================================
//  HUD
// ============================================================================

simulated function bool WantsZoomFade()
{
    return True;
}

simulated event RenderOverlays(Canvas C)
{
    local float CX, CY, Scale, CHScale;
    local gPlayer P;

    if( Instigator != None )
        P = gPlayer(Instigator.Controller);

    if( P == None || !P.bZooming )
    {
        Super.RenderOverlays(C);
        AmbientSound = None;
        OverrideCrosshair = None;
        return;
    }

    // scope adjustment effects
    if( P.ZoomLevel != P.DesiredZoomLevel )
    {
        AmbientSound = ZoomLoopSound;
    }
    else
    {
        AmbientSound = None;
    }

    // screenwash
    if( gPlayer(Instigator.Controller) != None )
        gPlayer(Instigator.Controller).OnWeaponRendered(C);

    OverrideCrosshair = ZoomCrosshair;

    CX = C.ClipX / 2;
    CY = C.ClipY / 2;
    Scale = C.ClipX / 1024;
    CHScale *= Scale;

    C.Style = ERenderStyle.STY_Alpha;
    C.SetDrawColor(255, 255, 255, 255);
    C.ColorModulate = C.default.ColorModulate;
    C.SetPos(0, 0);
    C.DrawRect(ZoomScope, C.ClipX, C.ClipY);

    bSwayReset = True;
}


// ============================================================================
//  Muzzle Flash
// ============================================================================

simulated function IncrementFlashCount(int Mode)
{
    if( gWeaponAttachment(ThirdPersonActor) != None )
    {
        if( Mode == 0 )
        {
            gWeaponAttachment(ThirdPersonActor).FlashCountIncrement(ShotsFired % 2);
            ++ShotsFired;
        }
        else
            gWeaponAttachment(ThirdPersonActor).FlashCountIncrement(2);
    }
}

simulated function ZeroFlashCount(int Mode)
{
    if( gWeaponAttachment(ThirdPersonActor) != None )
    {
        if( Mode == 0 )
            gWeaponAttachment(ThirdPersonActor).FlashCountZero(ShotsFired % 2);
        else
            gWeaponAttachment(ThirdPersonActor).FlashCountZero(2);
    }
}


// ============================================================================
//  AI
// ============================================================================

function float GetAIRating()
{
    return AIRating;
}

function byte BestMode()
{
    return 0;
}

function bool RecommendRangedAttack()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target == None )
        return False;

    Dist = VSize(Target.Location - Instigator.Location);
    return (Dist > 2000 * (1 + FRand()));
}

function bool RecommendLongRangedAttack()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target == None )
        return False;

    Dist = VSize(Target.Location - Instigator.Location);
    return (Dist > 2000 * (1 + FRand()));
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    BarrelDist                  = -20


    // gWeapon
    ZoomBeginSound              = Sound'G_Sounds.g60_zoom_begin'
    ZoomEndSound                = Sound'G_Sounds.g60_zoom_end'
    ZoomLoopSound               = Sound'G_Sounds.g60_zoom_loop'
    ZoomScope                   = Texture'G_FX.Interface.scope_g601'
    ZoomEndAnim                 = "scope_out"

    ZoomRange                   = (Min=0.6,Max=0.6)
    ZoomSpeed                   = 2
    ZoomStep                    = 1.0

    CostWeapon                  = 500
    CostAmmo                    = 100
    ItemSize                    = 3
    BotPurchaseProbMod          = 5


    // Weapon
    ItemName                    = "G-60"
    Description                 = "The G-60 is a dual-barreled SMG that fires two shells simultaneously out of the top and bottom barrel, reducing vertical recoil by 80%, and making it the most accurate automatic weapon on the battlefield. Unlike it's predecessor - the G-40 - the G-60 has been fitted with a fast-action combat scope, allowing soldiers to become medium/long range snipers on the fly, and even while moving."

    CenteredOffsetY             = 10
    CenteredYaw                 = 888
    CenteredRoll                = 444

    DisplayFOV                  = 65
    PlayerViewOffset            = (x=85,y=19,z=-34)
    PlayerViewPivot             = (Pitch=1024,Roll=0,Yaw=32768)
    EffectOffset                = (X=0,Y=0,Z=0)
    SmallViewOffset             = (x=85,y=19,z=-34)
    SmallEffectOffset           = (X=0,Y=0,Z=0)


    FireModeClass(0)            = class'gG60Fire'
    FireModeClass(1)            = class'gG60FireAlt'
    AttachmentClass             = class'gG60Attachment'
    PickupClass                 = class'gG60Pickup'

    SelectSound                 = sound'G_Sounds.grp_select_med'
    

    AIRating                    = 2.5
    CurrentRating               = 2.5

    bSniping                    = True

    HudColor                    = (r=185,g=170,b=255,a=255)
    IconCoords                  = (X1=510,Y1=189,X2=702,Y2=251)


    // Actor
    bDynamicLight               = False
    LightType                   = LT_Steady
    LightEffect                 = LE_NonIncidence
    LightPeriod                 = 3
    LightBrightness             = 128
    LightHue                    = 30
    LightSaturation             = 170
    LightRadius                 = 10

    Mesh                        = Mesh'G_Anims.G60'
    bUseCollisionStaticMesh     = False
}
