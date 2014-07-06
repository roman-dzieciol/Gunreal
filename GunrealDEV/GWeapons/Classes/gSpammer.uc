// ============================================================================
//  gSpammer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammer extends gRotaryWeapon
    config(user);

var   int                   CurrentMines;
var() int                   MaxMines;
var   array<Projectile>     Mines;

var() Color                 MineFontColor;
var() Font                  MineFontFont;
var() localized String      MineFontName;


var() Sound                 TriggerSound;
var() Sound                 TriggerEmptySound;
var() float                 TriggerSoundVolume;
var() float                 TriggerSoundRadius;
var() ESoundSlot            TriggerSoundSlot;
var() Sound                 NoMinesSound;

var() float                 BotDetonationDelay;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.TriggerSound);
    S.PrecacheObject(default.TriggerEmptySound);
    S.PrecacheObject(default.NoMinesSound);
}

// ============================================================================
// Replication
// ============================================================================
replication
{
    Reliable if( Role == ROLE_Authority )
        CurrentMines;
}

simulated function RegisterProjectile( gProjectile P )
{
    // Take ownership
    P.ServerOwner = self;

    Mines[Mines.Length] = P;
    CurrentMines++;
}

simulated function UnRegisterProjectile( gProjectile P )
{
    if( CurrentMines > 0 )
        CurrentMines--;
}

simulated function bool HasAmmo()
{
    if( CurrentMines > 0 )
        return True;

    return Super.HasAmmo();
}

simulated function OutOfAmmo()
{
    if( Instigator == None || !Instigator.IsLocallyControlled() || HasAmmo() )
        return;

    Instigator.AmbientSound = None;
    Instigator.SoundVolume = Instigator.default.SoundVolume;
}

simulated singular function ClientStopFire(int Mode)
{
    if( Mode == 1 && !HasAmmo() )
        DoAutoSwitch();

    Super.ClientStopFire(Mode);
}

function GiveToEx(Pawn Other, optional Pickup Pickup, optional bool bGiveEmpty)
{
    local gSpammerProjectile P;

    Super.GiveToEx(Other,Pickup,bGiveEmpty);
    if( bDeleteMe )
        return;

    foreach DynamicActors(class'gSpammerProjectile', P)
    {
        if( P.InstigatorController != None && P.InstigatorController == Instigator.Controller )
        {
            RegisterProjectile(P);
        }
    }
}

simulated function NewDrawWeaponInfo(Canvas Canvas, float YPos)
{
    local int i,Count;
    local float ScaleFactor,ScaleFactorY;

    ScaleFactor = 99 * Canvas.ClipX/8000;
    ScaleFactorY = 99 * Canvas.ClipX/3200;
    Canvas.Style = ERenderStyle.STY_Alpha;
    Canvas.DrawColor = class'HUD'.Default.WhiteColor;
    Count = Min(20,CurrentMines);
    for( i=0; i<Count; i++ )
    {
        Canvas.SetPos(Canvas.ClipX - (0.5*i+1) * ScaleFactor, YPos);
        Canvas.DrawTile( Material'G_FX.Interface.IconSheet0', ScaleFactor, ScaleFactorY, 174, 259, 46, 45);
    }
    if( CurrentMines > 20 )
    {
        Count = Min(40,CurrentMines);
        for( i=20; i<Count; i++ )
        {
            Canvas.SetPos(Canvas.ClipX - (0.5*(i-20)+1) * ScaleFactor, YPos - ScaleFactorY);
            Canvas.DrawTile( Material'G_FX.Interface.IconSheet0', ScaleFactor, ScaleFactorY, 174, 259, 46, 45);
        }
    }
}

simulated function font LoadMineFont()
{
    if( MineFontFont == None )
    {
        MineFontFont = Font(DynamicLoadObject(MineFontName, class'Font', True));
        if( MineFontFont == None )
            Log("Warning: "$Self$" Couldn't dynamically load font "$MineFontName);
    }
    return MineFontFont;
}

function TriggerMines( Actor Other )
{
    local int i;

    if( Role == ROLE_Authority )
    {
        if( CurrentMines > 0 )
            PlaySound( TriggerSound, TriggerSoundSlot, TriggerSoundVolume,, TriggerSoundRadius );
        else
            PlaySound( NoMinesSound, TriggerSoundSlot, TriggerSoundVolume,, TriggerSoundRadius );


        for( i=0; i!=Mines.Length; ++i )
            if( Mines[i] != None )
                Mines[i].Trigger(Other,Instigator);
    }

    Mines.Length = 0;
    CurrentMines = 0;
}

simulated event Destroyed()
{
    Mines.Length = 0;

    Super.Destroyed();
}

// ============================================================================
// Debug
// ============================================================================

exec function EditMine( Actor Other )
{
    local Actor A;
    local int i;

    if( Role == ROLE_Authority )
    {
        for( i=0; i!=Mines.Length; ++i )
            if( Mines[i] != None )
                A = Mines[i];

        if( A != None )
            ConsoleCommand( "editobj" @A.name );
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

    if( Projectile(Target) != None )
        return RATING_Skip;

    // range
    if( !gWeaponFire(FireMode[0]).IsInTossRange(Target) )
        return RATING_Avoid;

    // distance
    if( Dist < 256 )
        return RATING_Avoid;

    // height
    if( ZDiff > 160 )
        Rating -= 0.35;

    if( VSize(Target.Velocity) > 200 )
        Rating -= 0.35;

    // minefield
    if( gProjectile(Target) != None )
        Rating += 1;

    return Rating;
}

function float SuggestAttackStyle()
{
    local float Dist;
    local Actor Target;

    if( CurrentMines >= MaxMines )
        return -2;

    Target = GetBotTarget();
    if( Target != None )
    {
        Dist = VSize(Target.Location - Instigator.Location);

        if( !gWeaponFire(FireMode[0]).IsInTossRange(Target) )
            return 1.0;

        if( Dist < 384 )
            return -1.5;
        else if( Dist < 512 )
            return -0.7;
        else if( Dist < 1024 )
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
        if( Dist < 768 )
            return -0.6;
    }
    return 0.0;
}

function byte BestMode()
{
    local Bot B;
    local Actor Target;

    //gLog( "BestMode" );

    B = Bot(Instigator.Controller);
    if( B != None )
    {
        Target = GetBotTarget();
        if( Target != None
        &&  CurrentMines >= MaxMines
        &&  Level.TimeSeconds - FireMode[0].NextFireTime > BotDetonationDelay )
        {
            return 1;
        }
    }
    return 0;
}

function bool CanAttack(Actor Other)
{
    //gLog( "CanAttack" #BotMode #Other );

    if( CurrentMines >= MaxMines )
        return True;

    if( Projectile(Other) != None )
        return False;

    if( !Super.CanAttack(Other) )
        return False;

    // check that target is within range
    if( !gWeaponFire(FireMode[0]).IsInTossRange(Other) )
        return False;

    return True;
}



// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    // gSpammer
    MineFontColor               = (R=200,G=200,B=200,A=255)
    MineFontName                = "UT2003Fonts.jFontMedium1024x768"

    NoMinesSound                = Sound'G_Sounds.sp_beep'

    TriggerSound                = Sound'G_Sounds.sp_beep'
    TriggerSoundVolume          = 1.0
    TriggerSoundRadius          = 192
    TriggerSoundSlot            = SLOT_Misc

    MaxMines                    = 15
    BotDetonationDelay          = 1.0


    // gRotaryWeapon
    SpinBone                    = "rotator"
    SpinBoneAxis                = (Pitch=-1,Yaw=0,Roll=0)
    SpinMode                    = 0
    SpinModeAlt                 = 0
    SpinUpTime                  = 0.65
    SpinDownTime                = 1.2
    RoundsPerRotation           = 2

    SpinSound                   = Sound'G_Sounds.sp_w_spin'
    SpinSoundVolume             = 255
    SpinSoundPitch              = 64

    WindUpSound                 = None
    WindDownSound               = Sound'G_Sounds.sp_w_winddown'

    WindSoundSlot               = SLOT_Misc
    WindSoundVolume             = 1
    WindSoundRadius             = 256

    bPlayPartialSpinDown        = False


    // gWeapon
    bSpecialDrawWeapon          = False
    bForceViewUpdate            = False

    BotPurchaseProbMod          = 5
    ItemSize                    = 2
    CostWeapon                  = 240
    CostAmmo                    = 60


    // Weapon
    bShowChargingBar            = True

    FireModeClass(0)            = class'gSpammerFire'
    FireModeClass(1)            = class'gSpammerFireAlt'
    PickupClass                 = class'gSpammerPickup'
    AttachmentClass             = class'gSpammerAttachment'

    IdleAnim                    = "idlebob"

    SelectSound                 = Sound'G_Sounds.grp_select_med'


    AIRating                    = 2.4
    CurrentRating               = 2.4

    ItemName                    = "Proximity Spammer"
    Description                 = "A hockey-puck dispenser that spins and hurls explosives. The charges attach to ANY non-player, non-vehicle surface and bounce up and explode when a player or vehicle gets near. This includes Invasion monsters and other pawns."

    DisplayFOV                  = 65
    PlayerViewOffset            = (X=14,Y=9,Z=-10.5)
    PlayerViewPivot             = (Pitch=0,Yaw=32768,Roll=0)
    SmallViewOffset             = (X=14,Y=9,Z=-10.5)
    SmallEffectOffset           = (X=0.0,Y=0.0,Z=0.0)
    EffectOffset                = (X=50.0,Y=1.0,Z=10.0)
    CenteredOffsetY             = -5
    CenteredRoll                = 0
    CenteredYaw                 = -500

    HudColor                    = (R=255,G=0,B=0,A=255)
    IconCoords                  = (X1=382,Y1=0,X2=510,Y2=63)


    // Actor
    DrawScale                   = 0.4
    Mesh                        = Mesh'G_Anims.Spammer'
}
