// ============================================================================
//  gGloveWeapon.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGloveWeapon extends gWeapon
    Abstract
    HideDropDown
    CacheExempt;


var() name                  SelectAnimPiston;
var() name                  SelectAnimTrans;
var() name                  SelectAnimTele;
var() name                  SelectAnimNade;
var() name                  SelectAnimMine;

var() Sound                 TransitionSelectSound;

var() name                  BoredAnimName;
var() float                 BoredAnimTime;

var() name                  IdleNoAmmoAnim;
var() name                  SelectNoAmmoAnim;
var() name                  PutDownNoAmmoAnim;


// ============================================================================
//  Weapon
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.TransitionSelectSound);
}

//simulated function bool PutDown()
//{
//    local int Mode;
//
//    if( Instigator.PendingWeapon != None )
//    {
//        if( gGloveWeapon(Instigator.PendingWeapon) != None
//        ||  Instigator.PendingWeapon.IsA('gTransLauncher') )
//        {
//            ClientState = WS_Hidden;
//            Instigator.ChangedWeapon();
//
//            for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
//            {
//                FireMode[Mode].DestroyEffects();
//            }
//
//            return True;
//        }
//    }
//
//    return Super.PutDown();
//}

//simulated function BringUp(optional Weapon PrevWeapon)
//{
//    BoredAnimTime = Level.TimeSeconds;
//
//    SelectAnim = default.SelectAnim;
//    SelectSound = default.SelectSound;
//
//    if( PrevWeapon != None && PrevWeapon.class != class )
//    {
//        switch( PrevWeapon.class.name )
//        {
//            case 'gPistonGun':      SelectAnim = SelectAnimPiston;      break;
//            case 'gTransLauncher':  SelectAnim = SelectAnimTele;        break;
//            case 'gTeleporterGun':  SelectAnim = SelectAnimTrans;       break;
//            case 'gNadeGun':        SelectAnim = SelectAnimNade;        break;
//            case 'gMineGun':        SelectAnim = SelectAnimMine;        break;
//        }
//
//        if( SelectAnim != default.SelectAnim )
//            SelectSound = TransitionSelectSound;
//    }
//
//    Super.BringUp(PrevWeapon);
//}


simulated function bool PutDown()
{
    if( HasMoreAmmo() )
        PutDownAnim = default.PutDownAnim;
    else
        PutDownAnim = PutDownNoAmmoAnim;

    return Super.PutDown();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
    BoredAnimTime = Level.TimeSeconds;

    if( HasMoreAmmo() )
        SelectAnim = default.SelectAnim;
    else
        SelectAnim = SelectNoAmmoAnim;

    Super.BringUp(PrevWeapon);
}

// ============================================================================
//  Anim
// ============================================================================


simulated event AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    //gLog( "AnimEnd" #channel #anim #frame #rate #(Level.TimeSeconds - BoredAnimTime) );

    if( BoredAnimName != '' && (anim != IdleAnim || Pawn(Owner).Acceleration != vect(0,0,0)) )
        BoredAnimTime = Level.TimeSeconds;

    if( ClientState == WS_ReadyToFire )
    {
        if( anim == FireMode[0].FireAnim && gWeaponFire(FireMode[0]) != None && gWeaponFire(FireMode[0]).PlayReload() )
        {
        }
        else if( anim == FireMode[1].FireAnim && gWeaponFire(FireMode[1]) != None && gWeaponFire(FireMode[1]).PlayReload() )
        {
        }
        else if( (FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) )
        {
            PlayIdle();
        }
    }
}

simulated function PlayIdle()
{
    local name anim;
    local float frame, rate;

    //gLog( "PlayIdle" #(Level.TimeSeconds - BoredAnimTime) #default.BoredAnimTime );

    GetAnimParams(0, anim, frame, rate);
    if( anim == SelectAnim && rate > 0 )
        return;

    // Play bored anim only if initiated in AnimEnd and enough time passed
    if( BoredAnimName != '' && Level.TimeSeconds - BoredAnimTime > default.BoredAnimTime )
    {
        if( Pawn(Owner).Acceleration != vect(0,0,0) )
            BoredAnimTime = Level.TimeSeconds;
        else
            PlayAnim(BoredAnimName);
    }
    else
    {
        if( HasMoreAmmo() )
            LoopAnim(IdleAnim, IdleAnimRate, IdleAnimTween);
        else
            LoopAnim(IdleNoAmmoAnim, IdleAnimRate, IdleAnimTween);
    }
}

simulated function bool HasMoreAmmo()
{
    return HasAmmo();
}



// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gGloveWeapon
    SelectAnimPiston            = ""
    SelectAnimTrans             = ""
    SelectAnimTele              = ""
    SelectAnimNade              = ""
    SelectAnimMine              = ""

    TransitionSelectSound       = Sound'G_Sounds.cg_selectalt_a'

    IdleNoAmmoAnim              = "normal-idle"
    SelectNoAmmoAnim            = "normal-select"
    PutDownNoAmmoAnim           = "normal-down"


    // gWeapon
    CostWeapon                  = 0
    ItemSize                    = 0


    // Weapon
    bCanThrow                   = False
    InventoryGroup              = 8

    SelectSound                 = Sound'G_Sounds.cg_select_grp'


    DisplayFOV                  = 70
    PlayerViewOffset            = (X=12,Y=3.5,Z=-6)
    PlayerViewPivot             = (Pitch=0,Yaw=32768,Roll=0)
    SmallEffectOffset           = (X=0.0,Y=0.0,Z=0.0)
    SmallViewOffset             = (X=8,Y=6.5,Z=-10)
    EffectOffset                = (X=50.0,Y=1.0,Z=10.0)
    CenteredOffsetY             = -5
    CenteredRoll                = 0
    CenteredYaw                 = -500


    // Actor
    DrawScale                   = 0.25
    Mesh                        = Mesh'G_Anims.cglove'
}