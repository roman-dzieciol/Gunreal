// ============================================================================
//  gZoomingWeapon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gZoomingWeapon extends gWeapon
    Abstract
    HideDropDown
    CacheExempt;


var() Sound                 ZoomBeginSound;
var() ESoundSlot            ZoomBeginSoundSlot;
var() float                 ZoomBeginSoundVolume;
var() float                 ZoomBeginSoundRadius;

var() Sound                 ZoomEndSound;
var() ESoundSlot            ZoomEndSoundSlot;
var() float                 ZoomEndSoundVolume;
var() float                 ZoomEndSoundRadius;

var() Sound                 ZoomLoopSound;
var() ESoundSlot            ZoomLoopSoundSlot;
var() float                 ZoomLoopSoundVolume;
var() float                 ZoomLoopSoundRadius;

var() Texture               ZoomScope;
var() Texture               ZoomCrosshair;

var() Range                 ZoomRange;
var() float                 ZoomSpeed;
var() float                 ZoomStep;
var() config bool           bZoomScroll;

var() name                  ZoomEndAnim;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.ZoomBeginSound);
    S.PrecacheObject(default.ZoomEndSound);
    S.PrecacheObject(default.ZoomLoopSound);

    S.PrecacheObject(default.ZoomScope);
    S.PrecacheObject(default.ZoomCrosshair);
}


// ============================================================================
//  Weapon
// ============================================================================

simulated function ClientStartFire(int mode)
{
    if( mode == 1 )
    {
        FireMode[mode].bIsFiring = True;
        ToggleZoom();
    }
    else
        Super.ClientStartFire(mode);
}

simulated function ClientStopFire(int mode)
{
    if( mode == 1 )
    {
        FireMode[mode].bIsFiring = False;
        StopZoom();
    }
    else
        super.ClientStopFire(mode);
}

simulated function ClientWeaponThrown()
{
    EndZoom();
    Super.ClientWeaponThrown();
}

simulated function bool PutDown()
{
    EndZoom();
    return Super.PutDown();
}


// ============================================================================
//  Zoom
// ============================================================================


final simulated function ToggleZoom()
{
    //gLog( "ToggleZoom" #gPlayer(Instigator.Controller).bZooming );

    if( Instigator != None && gPlayer(Instigator.Controller) != None )
    {
        gPlayer(Instigator.Controller).ToggleZoomWithParams(ZoomRange.Max, ZoomSpeed, ZoomRange.Min);

        if( gPlayer(Instigator.Controller).bZooming )
        {
            PlaySound(ZoomBeginSound, ZoomBeginSoundSlot, ZoomBeginSoundVolume,, ZoomBeginSoundRadius,, False);
        }
        else
        {
            PlaySound(ZoomEndSound, ZoomEndSoundSlot, ZoomEndSoundVolume,, ZoomEndSoundRadius,, False);
            if( ZoomEndAnim != '' )
                PlayAnim(ZoomEndAnim, 1,, 0);
        }
    }
}

simulated function StopZoom()
{
    //gLog( "StopZoom" #gPlayer(Instigator.Controller).bZooming );

    if( Instigator != None && gPlayer(Instigator.Controller) != None )
    {
        gPlayer(Instigator.Controller).StopZoom();
    }
    AmbientSound = None;
}

simulated function EndZoom()
{
    //gLog( "EndZoom" #gPlayer(Instigator.Controller).bZooming );

    if( Instigator != None && gPlayer(Instigator.Controller) != None )
    {
        if( gPlayer(Instigator.Controller).bZooming )
        {
            PlaySound(ZoomEndSound, ZoomEndSoundSlot, ZoomEndSoundVolume,, ZoomEndSoundRadius,, False);
            if( ZoomEndAnim != '' )
                PlayAnim(ZoomEndAnim, 1,, 0);
        }

        gPlayer(Instigator.Controller).EndZoom();
    }
    AmbientSound = None;
    OverrideCrosshair = None;
}


// For adjusting the zoom level with the prev/next weapon buttons
simulated function bool CanAdjustZoom(float Dir)
{
    local gPlayer P;
    local float F;

    //gLog( "CanAdjustZoom" #gPlayer(Instigator.Controller).bZooming );

    if( bZoomScroll )
    {
        if( Instigator != None && gPlayer(Instigator.Controller) != None )
        {
            P = gPlayer(Instigator.Controller);
            if( P != None )
            {
                if( P.bZooming )
                {
                    if( (Dir > 0 && P.DesiredZoomLevel != ZoomRange.Max )
                    ||  (Dir < 0 && P.DesiredZoomLevel != ZoomRange.Min))
                    {
                        F = FClamp(P.DesiredZoomLevel, ZoomRange.Min, ZoomRange.Max);
                        F += (1.0-F) * ZoomStep * Dir;
                        //F = FClamp(P.DesiredZoomLevel+((ZoomRange.Max-ZoomRange.Min)*0.1)*Dir, ZoomRange.Min, ZoomRange.Max);
                        P.ContinueZoomWithParams(FClamp(F, ZoomRange.Min, ZoomRange.Max), ZoomSpeed);
                        AmbientSound = ZoomLoopSound;
                    }
                    return True;
                }
            }
        }
    }

    return False;
}



// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ZoomRange                   = (Min=0.6,Max=0.6)
    ZoomSpeed                   = 2
    ZoomStep                    = 1.0

    ZoomBeginSound              = None
    ZoomBeginSoundSlot          = SLOT_Misc
    ZoomBeginSoundVolume        = 1.0
    ZoomBeginSoundRadius        = 256

    ZoomEndSound                = None
    ZoomEndSoundSlot            = SLOT_Misc
    ZoomEndSoundVolume          = 1.0
    ZoomEndSoundRadius          = 256

    ZoomLoopSound               = None
    ZoomLoopSoundSlot           = SLOT_Misc
    ZoomLoopSoundVolume         = 1.0
    ZoomLoopSoundRadius         = 256

    ZoomEndAnim                 = ""

}