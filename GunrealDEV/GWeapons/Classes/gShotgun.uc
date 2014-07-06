// ============================================================================
//  gShotgun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotgun extends gWeapon
    config(user);


var() name                  ReloadAnim;
var() name                  UnloadAnim;

var() Sound                 ReloadSound;
var() float                 ReloadSoundVolume;
var() float                 ReloadSoundRadius;
var() ESoundSlot            ReloadSoundSlot;

var() Sound                 UnloadSound;
var() float                 UnloadSoundVolume;
var() float                 UnloadSoundRadius;
var() ESoundSlot            UnloadSoundSlot;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.ReloadSound);
    S.PrecacheObject(default.UnloadSound);
}


simulated function string gDebugString()
{
    return FireMode[0].Load
    @FireMode[0].AmmoPerFire
    @AmmoCharge[0]
    @FireMode[0].bServerDelayStartFire
    @FireMode[1].bServerDelayStartFire;
}

simulated function bool HasAmmo()
{
    return AmmoCharge[0] > 0;
}

simulated function bool LoadShell()
{
    //gLog( "LoadShell()" );

    if( FireMode[0].Load == 0 || FireMode[0].Load == 1 )
    {
        if( AmmoCharge[0] >= FireMode[0].Load + 1 )
        {
            FireMode[0].Load += 1;
            FireMode[0].AmmoPerFire = FireMode[0].Load;
            if( HasAnim(ReloadAnim) )
                PlayAnim(ReloadAnim, 1.0, 0.0);

            PlayOwnedSound(ReloadSound,ReloadSoundSlot,ReloadSoundVolume,,ReloadSoundRadius,1,False);
        }
        else
            return False;
    }
    else if( FireMode[0].Load == 2 )
    {
        FireMode[0].Load -= 1;
        FireMode[0].AmmoPerFire = FireMode[0].Load;
        if( HasAnim(UnloadAnim) )
            PlayAnim(UnloadAnim, 1.0, 0.0);
        PlayOwnedSound(UnloadSound,UnloadSoundSlot,UnloadSoundVolume,,UnloadSoundRadius,1,False);
    }
    else
    {
        Warn("FireMode[0].Load ="@FireMode[0].Load);
        return False;
    }
    return True;
}



simulated function DrawWeaponInfo(Canvas Canvas)
{
    NewDrawWeaponInfo(Canvas, 0.705*Canvas.ClipY);
}

simulated function NewDrawWeaponInfo(Canvas Canvas, float YPos)
{
    local int i;
    local float ScaleFactor;

    ScaleFactor = 99 * Canvas.ClipX/3200;
    Canvas.Style = ERenderStyle.STY_Alpha;
    Canvas.DrawColor = class'HUD'.Default.WhiteColor;
    for( i=0;i<FireMode[0].Load;i++ )
    {
        Canvas.SetPos(Canvas.ClipX - (0.5*i+1) * ScaleFactor, YPos);
        Canvas.DrawTile( Material'G_FX.Interface.IconSheet0', ScaleFactor, ScaleFactor, 174, 259, 46, 45);
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

    if( Dist > 4096 )
        Rating -= 1.0;
    else if( Dist < 1024 )
        Rating += 0.5;

    return Rating;
}

function float SuggestAttackStyle()
{
    return 0.8;
}

function byte BestMode()
{
    if( FireMode[0].Load == 0 )
    {
        return 1;
    }
    else if( FireMode[0].Load == 1 )
    {
        if( FRand() < 0.3 )
            return 1;
        else
            return 0;
    }
    else
    {
        return 0;
    }
}



// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ReloadAnim                  = "Reload"
    UnloadAnim                  = "Unload"

    ReloadSound                 = Sound'G_Sounds.sg_reload'
    ReloadSoundVolume           = 0.6
    ReloadSoundRadius           = 300
    ReloadSoundSlot             = SLOT_None

    UnloadSound                 = Sound'G_Sounds.sg_unload'
    UnloadSoundVolume           = 0.6
    UnloadSoundRadius           = 300
    UnloadSoundSlot             = SLOT_None


    // gWeapon
    CostWeapon                  = 320
    CostAmmo                    = 80
    ItemSize                    = 3

    BotPurchaseProbMod          = 5


    // Weapon
    FireModeClass(0)            = class'gShotgunFire'
    FireModeClass(1)            = class'gShotgunFireAlt'
    PickupClass                 = class'gShotgunPickup'
    AttachmentClass             = class'gShotgunAttachment'

    SelectSound                 = Sound'G_Sounds.grp_select_med'


    AIRating                    = 2.5
    CurrentRating               = 2.5

    ItemName                    = "Shotgun"
    Description                 = "A pump-action shotgun that must be manually pumped in order to fire. It can also be pumped twice to load a second shell... A third pump removes the 2nd shell."

    DisplayFOV                  = 60
    PlayerViewOffset            = (X=22,Y=5,Z=-12)
    PlayerViewPivot             = (Pitch=0,Yaw=32768,Roll=0)
    SmallViewOffset             = (X=22,Y=5,Z=-12)
    SmallEffectOffset           = (X=0.0,Y=0.0,Z=0.0)
    EffectOffset                = (X=50.0,Y=1.0,Z=10.0)
    CenteredOffsetY             = -5
    CenteredRoll                = 0
    CenteredYaw                 = -500

    HudColor                    = (R=255,G=0,B=0,A=255)
    IconCoords                  = (X1=574,Y1=126,X2=766,Y2=189)


    // Actor
    DrawScale                   = 0.4
    Mesh                        = Mesh'G_Anims.Shotgun'

    bUseCollisionStaticMesh     = False

    bDynamicLight               = False
    LightType                   = LT_Steady
    LightEffect                 = LE_NonIncidence
    LightPeriod                 = 3
    LightBrightness             = 128
    LightHue                    = 30
    LightSaturation             = 170
    LightRadius                 = 10
}
