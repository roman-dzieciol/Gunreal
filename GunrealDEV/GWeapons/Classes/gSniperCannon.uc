// ============================================================================
//  gSniperCannon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSniperCannon extends gZoomingWeapon;


var() Sound                 TargetSound;
var() ESoundSlot            TargetSoundSlot;
var() float                 TargetSoundVolume;
var() float                 TargetSoundRadius;

var() Material              ZoomScreenwash;
var() Material              ZoomScopeTarget;

var   Actor                 LastTarget;


// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.TargetSound);
    S.PrecacheObject(default.ZoomScreenwash);
    S.PrecacheObject(default.ZoomScopeTarget);
}


// ============================================================================
// Zoom
// ============================================================================

simulated function bool WantsZoomFade()
{
    return True;
}

// ============================================================================
// HUD
// ============================================================================
simulated event RenderOverlays(Canvas C)
{
    local float CX, CY, Scale, CHScale;
    local gPlayer P;
    local Material M;
    local vector X,Y,Z, StartTrace;
    local rotator AimRot;
    local vector HitLocation, HitNormal;
    local Actor Other;

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

    CHScale = 1 + gPawn(Instigator).InaccuracyXhairScale;
    CX = C.ClipX / 2;
    CY = C.ClipY / 2;
    Scale = C.ClipX / 1024;
    CHScale *= Scale;

    C.Reset();
    C.SetDrawColor(255,255,255);

    // targetting
    GetViewAxes(X, Y, Z);
    StartTrace = FireMode[0].GetFireStart(X, Y, Z);
    AimRot = FireMode[0].AdjustAim(StartTrace, 0);
    Other = Instigator.Trace(HitLocation, HitNormal, StartTrace+vector(AimRot)*65535, StartTrace, True);
    if( Pawn(Other) != None )
    {
        M = ZoomScopeTarget;
        if( Other != LastTarget )
        {
            Instigator.PlaySound(TargetSound, TargetSoundSlot, TargetSoundVolume,, TargetSoundRadius,, False);
        }
    }
    else
    {
        M = ZoomScope;
    }

    LastTarget = Other;


    // Draw the sniper screenwash
    C.SetPos(0, 0);
    C.Style = ERenderStyle.STY_Normal;
    C.DrawTile(ZoomScreenwash, C.ClipX, C.ClipY, 0,0, ZoomScreenwash.MaterialUSize(),ZoomScreenwash.MaterialVSize()*(3.0/4.0));

    // Draw the scope screen
    C.SetPos(0, 0);
    C.Style = ERenderStyle.STY_Alpha;
    C.DrawTile(M, C.ClipX, C.ClipY, 0,0, M.MaterialUSize(),M.MaterialVSize()*(3.0/4.0));

    bSwayReset = True;
}

simulated function float ChargeBar()
{
    if( FireMode[0].NextFireTime <= Level.TimeSeconds )
        return 0.99;
    else
        return 0.99 - ((FireMode[0].NextFireTime-Level.TimeSeconds) / FireMode[0].FireRate);
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

    if( Dist < 1024 )
        Rating -= 1.0;
    else if( Dist > 4096 )
        Rating += 0.5;

    if( B.Stopped() )
        Rating += 0.2;

    return Rating;
}

function float SuggestAttackStyle()
{
    return -0.4;
}

function float SuggestDefenseStyle()
{
    return 0.2;
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



// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gSniperCannon
    TargetSound                 = Sound'G_Sounds.sc_targeted1'
    TargetSoundSlot             = SLOT_None
    TargetSoundVolume           = 1.0
    TargetSoundRadius           = 256

    ZoomScreenwash              = Material'G_FX.sniper_screenwash_a'
    ZoomScopeTarget             = Material'G_FX.sniper_scope_a2'


    // gWeapon
    CostWeapon                  = 700
    CostAmmo                    = 200
    ItemSize                    = 4
    BotPurchaseProbMod          = 5

    ZoomBeginSound              = Sound'G_Sounds.sc_zoom_begin1'
    ZoomBeginSoundSlot          = SLOT_Misc
    ZoomBeginSoundVolume        = 0.5
    ZoomBeginSoundRadius        = 256

    ZoomEndSound                = Sound'G_Sounds.sc_zoom_end1'
    ZoomEndSoundSlot            = SLOT_Misc
    ZoomEndSoundVolume          = 0.5
    ZoomEndSoundRadius          = 256

    ZoomLoopSound               = Sound'G_Sounds.sc_zoom_loop1'
    ZoomLoopSoundSlot           = SLOT_Misc
    ZoomLoopSoundVolume         = 1.0
    ZoomLoopSoundRadius         = 256

    ZoomCrosshair               = Texture'G_FX.crosshair_sniper_a1'
    ZoomScope                   = Material'G_FX.sniper_scope_a1'

    ZoomRange                   = (Min=0.5,Max=0.9)
    ZoomSpeed                   = 1.5
    ZoomStep                    = 0.2


    // Weapon
    FireModeClass(0)            = class'gSniperFire'
    FireModeClass(1)            = class'gSniperZoom'
    PickupClass                 = class'gSniperPickup'
    AttachmentClass             = class'gSniperAttachment'

    SelectSound                 = Sound'G_Sounds.grp_select_light'


    AIRating                    = 2.5
    CurrentRating               = 2.5

    bSniping                    = True
    bShowChargingBar            = True

    ItemName                    = "Sniper Cannon"
    Description                 = "NA"

    DisplayFOV                  = 60 //70
    PlayerViewOffset            = (X=22,Y=10,Z=-13)
    SmallViewOffset             = (X=22,Y=10,Z=-13)
    PlayerViewPivot             = (Pitch=0,Yaw=32200,Roll=0)
    EffectOffset                = (X=0.0,Y=0.0,Z=0.0)
    SmallEffectOffset           = (X=0.0,Y=0.0,Z=0.0)
    CenteredOffsetY             = 0
    CenteredRoll                = 0
    CenteredYaw                 = 0

    HudColor                    = (R=255,G=0,B=0,A=255)
    IconCoords                  = (X1=446,Y1=62,X2=702,Y2=125)


    // Actor
    DrawScale                   = 0.4
    Mesh                        = Mesh'G_Anims.Sniper'

    bUseCollisionStaticMesh     = True

    bDynamicLight               = False
    LightType                   = LT_Steady
    LightEffect                 = LE_NonIncidence
    LightPeriod                 = 3
    LightBrightness             = 128
    LightHue                    = 30
    LightSaturation             = 170
    LightRadius                 = 10
}