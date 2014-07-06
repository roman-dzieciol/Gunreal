// ============================================================================
//  gPistonGun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPistonGun extends gGloveWeapon;



// ============================================================================
//  Weapon
// ============================================================================

simulated function DoAutoSwitch();

simulated event RenderOverlays(Canvas C)
{
    local int m;

    if( Hand < -1.0 || Hand > 1.0 )
    {
        for( m = 0; m < NUM_FIRE_MODES; m++ )
        {
            if( FireMode[m] != None )
                FireMode[m].DrawMuzzleFlash(C);
        }
    }

    Super.RenderOverlays(C);
}

// AI Interface
function GiveToEx(Pawn Other, optional Pickup Pickup, optional bool bGiveEmpty)
{
    Super.GiveToEx(Other, Pickup, bGiveEmpty);
    if( bDeleteMe )
        return;

    if( Bot(Other.Controller) != None )
        Bot(Other.Controller).bHasImpactHammer = True;
}

simulated function BringUp(optional Weapon PrevWeapon)
{
    Super.Bringup(PrevWeapon);

    if( !AmmoMaxed(1) )
    {
        while( FireMode[1].NextTimerPop < Level.TimeSeconds && FireMode[1].TimerInterval > 0.f )
        {
            FireMode[1].Timer();

            if( FireMode[1].bTimerLoop )
                FireMode[1].NextTimerPop = FireMode[1].NextTimerPop + FireMode[1].TimerInterval;
            else
                FireMode[1].TimerInterval = 0.f;
        }
    }
}

simulated event Timer()
{
    local Bot B;

    if( ClientState == WS_BringUp )
    {
        // check if owner is bot waiting to do impact jump
        B = Bot(Instigator.Controller);
        if( B != None && B.bPreparingMove && B.ImpactTarget != None )
        {
            B.ImpactJump();
            B = None;
        }
    }

    Super.Timer();

    if( B != None && B.Enemy != None )
        BotFire(False);
}

// ============================================================================
//  AI
// ============================================================================

// super desireable for bot waiting to impact jump
function float GetAIRating()
{
    local Bot B;
    local float Dist, Rating, ZDiff;
    local vector Delta;
    local Actor Target;

    B = Bot(Instigator.Controller);
    if( B == None )
        return AIRating;

    if( B.bPreparingMove && B.ImpactTarget != None )
        return 9;

    Target = GetBotTarget();
    if( Target == None )
        return AIRating;

    Delta = Target.Location - Instigator.Location;
    Dist = VSize(Delta);
    ZDiff = Delta.Z;
    Rating = AIRating;

    // minefield
    if( gProjectile(Target) != None )
        return RATING_Skip;

    // distance
    if( Dist > 384 )
        return RATING_Avoid;
    else if( Dist > 192 )
        return AIRating;
    else if( Instigator.Weapon == self )
        return 9;

    return Rating;
}

function float SuggestAttackStyle()
{
    return 1.0;
}

function float SuggestDefenseStyle()
{
    return 1.0;
}

function byte BestMode()
{
    return 0;
}

function bool CanAttack(Actor Other)
{
    return Super.CanAttack(Other);
}

function FireHack(byte Mode)
{
    if( Mode == 0 )
    {
        FireMode[0].PlayFiring();
        FireMode[0].FlashMuzzleFlash();
        FireMode[0].StartMuzzleSmoke();
        IncrementFlashCount(0);
    }
}

function bool BotFire(bool bFinished, optional name FiringMode)
{
    local int newmode;
    local Controller C;

    C = Instigator.Controller;
    newMode = BestMode();

    if( newMode == 0 )
    {
        C.bFire = 1;
        C.bAltFire = 0;
    }
    else
    {
        C.bFire = 0;
        C.bAltFire = 1;
    }

    if( bFinished )
        return True;

    if( FireMode[BotMode].IsFiring() )
    {
        if( BotMode == newMode )
            return True;
        else
            StopFire(BotMode);
    }

    if( !ReadyToFire(newMode) || ClientState != WS_ReadyToFire )
        return False;

    if( NewMode == 0 && !CanMelee() )
        return False;

    BotMode = NewMode;
    StartFire(NewMode);
    return True;
}

function bool CanMelee()
{
    local Bot B;
    local float Dist, Rating, ZDiff;
    local vector Delta, HL, HN;
    local Actor Target;
    local vector X,Y,Z, StartTrace;
    local rotator AimRot;

    B = Bot(Instigator.Controller);
    if( B == None )
        return False;

    if( B.bPreparingMove && B.ImpactTarget != None )
        return True;

    Target = GetBotTarget();
    if( Target == None )
        return False;

    Delta = Target.Location - Instigator.Location;
    Dist = VSize(Delta);
    ZDiff = Delta.Z;
    Rating = AIRating;

    // The to-hit trace always starts right in front of the eye
    GetViewAxes(X, Y, Z);
    StartTrace = FireMode[0].GetFireStart(X, Y, Z);
    AimRot = FireMode[0].AdjustAim(StartTrace, FireMode[0].AimError);

    if( Trace(HL,HN,Instigator.Location+Normal(Delta)*(96.0 + FClamp(B.Skill/7.0,0,1)*96.0*FRand()) ,Instigator.Location,True) == Target )
        return True;

    return False;
}

simulated function bool HasMoreAmmo()
{
    return True;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gGloveWeapon
    SelectAnimPiston        = "normal-idle"
    SelectAnimTrans         = "normal-idle"
    SelectAnimTele          = "teleporter-to-normal"
    SelectAnimNade          = "grenade-to-normal"
    SelectAnimMine          = "landmine-to-normal"


    // gWeapon
    bSpecialDrawWeapon      = False
    bForceViewUpdate        = False

    AmmoShopping            = (0,0)
    CostAmmo                = 0

    BoredAnimName           = "normal-idle-egg"
    BoredAnimTime           = 15


    // Weapon
    FireModeClass(0)        = class'gPistonFire'
    FireModeClass(1)        = class'gPistonFireAlt'
    AttachmentClass         = class'gPistonAttachment'

    IdleAnim                = "normal-idle"
    SelectAnim              = "normal-select"
    PutDownAnim             = "normal-down"

    AIRating                = 2.1
    CurrentRating           = 2.1

    bMeleeWeapon            = True

    ItemName                = "Melee Piston"
    Description             = ""

    HudColor                = (R=255,G=0,B=0,A=255)
    IconMaterial            = Material'G_FX.cg_belt_melee'
    IconCoords              = (X1=0,Y1=0,X2=64,Y2=64)

}