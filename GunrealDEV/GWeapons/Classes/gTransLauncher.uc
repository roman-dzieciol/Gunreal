// ============================================================================
//  gTransLauncher.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTransLauncher extends gTransLauncherGlove;

/*  REFS
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\Engine\Classes\CheatManager.uc' :
D:\games\UT2004\Engine\Classes\CheatManager.uc/590:  Pawn.GiveWeapon("XWeapons.TransLauncher");
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\Engine\Classes\Pawn.uc' :
D:\games\UT2004\Engine\Classes\Pawn.uc/1738:  if( (Vehicle(Other) != None) && (Weapon != None) && Weapon.IsA('Translauncher') )
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\GUI2K4\Classes\UT2K4Tab_WeaponPref.uc' :
D:\games\UT2004\GUI2K4\Classes\UT2K4Tab_WeaponPref.uc/923:    if( string(WeaponsList[WeaponIndex].WeapClass) == "XWeapons.Translauncher" )
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\UnrealGame\Classes\Bot.uc' :
D:\games\UT2004\UnrealGame\Classes\Bot.uc/1206:    if( Pawn.Weapon.IsA('TransLauncher') )
D:\games\UT2004\UnrealGame\Classes\Bot.uc/3108:    if( (Dist < MinDist) || ((Dist < MinDist + 150) && !Pawn.Weapon.IsA('TransLauncher')) )
D:\games\UT2004\UnrealGame\Classes\Bot.uc/5615:      Pawn.PendingWeapon = Weapon(Pawn.FindInventoryType(class<Inventory>(DynamicLoadObject("XWeapons.Translauncher",class'class'))));
Found 'TransLauncher' 3 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\UnrealGame\Classes\DeathMatch.uc' :
D:\games\UT2004\UnrealGame\Classes\DeathMatch.uc/295:         p.CreateInventory("XWeapons.TransLauncher");
D:\games\UT2004\UnrealGame\Classes\DeathMatch.uc/1639:     p.GiveWeapon("XWeapons.TransLauncher");
Found 'TransLauncher' 2 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\UnrealGame\Classes\JumpSpot.uc' :
D:\games\UT2004\UnrealGame\Classes\JumpSpot.uc/291:   if( Other.Weapon.IsA('TransLauncher') )
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\UnrealGame\Classes\UnrealPawn.uc' :
D:\games\UT2004\UnrealGame\Classes\UnrealPawn.uc/60:   if( (Pawn(Other).Weapon != None) && Pawn(Other).Weapon.IsA('Translauncher') )
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc' :
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/8:     if( TransLauncher(Weapon).TransBeacon == None )
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/16:         TransLauncher(Weapon).TransBeacon = TransBeacon;
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/21:         TransLauncher(Weapon).ViewPlayer();
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/22:         TransLauncher(Weapon).TransBeacon.Destroy();
D:\games\UT2004\UTClassic\classes\ClassicTransFire.uc/23:         TransLauncher(Weapon).TransBeacon = None;
Found 'TransLauncher' 5 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\UTClassic\classes\ClassicTranslauncher.uc' :
D:\games\UT2004\UTClassic\classes\ClassicTranslauncher.uc/1: class ClassicTranslauncher extends Translauncher
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\UTClassic\classes\MutUTClassic.uc' :
D:\games\UT2004\UTClassic\classes\MutUTClassic.uc/60:  else if( bClassicTranslocator && (Translauncher(Other) != None) )
D:\games\UT2004\UTClassic\classes\MutUTClassic.uc/116:     OriginalClasses(6)=class'Translauncher'
Found 'TransLauncher' 2 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XGame\Classes\MutInstaGib.uc' :
D:\games\UT2004\XGame\Classes\MutInstaGib.uc/97:   if( Other.IsA('TransLauncher') && bAllowTranslocator )
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XGame\Classes\xBombingRun.uc' :
D:\games\UT2004\XGame\Classes\xBombingRun.uc/325:         if( Inv.IsA('TransLauncher') )
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XWeapons\Classes\BallShoot.uc' :
D:\games\UT2004\XWeapons\Classes\BallShoot.uc/11:     local Translauncher T;
D:\games\UT2004\XWeapons\Classes\BallShoot.uc/16:   T = Translauncher(Instigator.FindInventoryType(class'Translauncher'));
Found 'TransLauncher' 3 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XWeapons\Classes\DamTypeTeleFrag.uc' :
D:\games\UT2004\XWeapons\Classes\DamTypeTeleFrag.uc/10:     WeaponClass=class'TransLauncher'
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XWeapons\Classes\TransAmmo.uc' :
D:\games\UT2004\XWeapons\Classes\TransAmmo.uc/13:     ItemName="TransLauncher"
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XWeapons\Classes\TransBeacon.uc' :
D:\games\UT2004\XWeapons\Classes\TransBeacon.uc/285:   if( TransLauncher(Instigator.Weapon) != None )
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XWeapons\Classes\TransFire.uc' :
D:\games\UT2004\XWeapons\Classes\TransFire.uc/10:     if( !TransLauncher(Weapon).bBeaconDeployed )
D:\games\UT2004\XWeapons\Classes\TransFire.uc/24:     return ( TransLauncher(Weapon).AmmoChargeF >= 1.0 );
D:\games\UT2004\XWeapons\Classes\TransFire.uc/31:     if( TransLauncher(Weapon).TransBeacon == None )
D:\games\UT2004\XWeapons\Classes\TransFire.uc/39:         TransLauncher(Weapon).TransBeacon = TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransFire.uc/44:         TransLauncher(Weapon).ViewPlayer();
D:\games\UT2004\XWeapons\Classes\TransFire.uc/45:         if( TransLauncher(Weapon).TransBeacon.Disrupted() )
D:\games\UT2004\XWeapons\Classes\TransFire.uc/52:    TransLauncher(Weapon).TransBeacon.Destroy();
D:\games\UT2004\XWeapons\Classes\TransFire.uc/53:    TransLauncher(Weapon).TransBeacon = None;
Found 'TransLauncher' 8 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XWeapons\Classes\TransLauncher.uc' :
D:\games\UT2004\XWeapons\Classes\TransLauncher.uc/4: class TransLauncher extends Weapon
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XWeapons\Classes\Transpickup.uc' :
D:\games\UT2004\XWeapons\Classes\Transpickup.uc/6:     InventoryType=class'Translauncher'
Found 'TransLauncher' 1 time(s).
----------------------------------------
Find 'TransLauncher' in 'D:\games\UT2004\XWeapons\Classes\TransRecall.uc' :
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/8:     D:\games\UT2004\XWeapons\Classes\TransLauncher.uc(433:22):        FireModeClass(1)=TransRecall
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/13:     if( TransLauncher(Weapon).bBeaconDeployed )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/23:     success = ( TransLauncher(Weapon).AmmoChargeF >= 1.0 );
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/25:     if( !success && (Weapon.Role == ROLE_Authority) && (TransLauncher(Weapon).TransBeacon != None) )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/92:     if( (Instigator == None) || (Translauncher(Weapon) == None) )
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/94:     TransBeacon = TransLauncher(Weapon).TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/154:         TransLauncher(Weapon).ReduceAmmo();
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/193:     TransLauncher(Weapon).TransBeacon = None;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/194:     TransLauncher(Weapon).ViewPlayer();
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/205:         TransBeacon = TransLauncher(Weapon).TransBeacon;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/206:         TransLauncher(Weapon).TransBeacon = None;
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/207:         TransLauncher(Weapon).ViewPlayer();
D:\games\UT2004\XWeapons\Classes\TransRecall.uc/216:     if( TransLauncher(Weapon).TransBeacon != None )
Found 'TransLauncher' 13 time(s).
Search complete, found 'TransLauncher' 82 time(s). (31 files.)
*/


var() name                  ClawEmitterBone;
var() rotator               ClawEmitterRotator;
var() class<Emitter>        ClawEmitterClass;
var   Emitter               ClawEmitter;


// ============================================================================
//  Weapon
// ============================================================================

simulated event Destroyed()
{
    if( ClawEmitter != None )
        ClawEmitter.Destroy();

    Super.Destroyed();
}

function GiveToEx(Pawn Other, optional Pickup Pickup, optional bool bGiveEmpty)
{
    Super.GiveToEx(Other,Pickup,bGiveEmpty);
    if( bDeleteMe )
        return;

    if( Bot(Other.Controller) != None )
        Bot(Other.Controller).bHasTranslocator = True;
}

simulated function bool PutDown()
{
    if( ClawEmitter != None )
        ClawEmitter.Destroy();

    return Super.PutDown();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
    if( ClawEmitterRotator != rot(0,0,0) )
        SetBoneRotation( ClawEmitterBone, ClawEmitterRotator, 0, 1 );

    ClawEmitter = Spawn(ClawEmitterClass,self);
    AttachToBone(ClawEmitter,ClawEmitterBone);
    
    if( PrevWeapon != None && PrevWeapon.class != class )
    {
        switch( PrevWeapon.class.name )
        {
            case 'gPistonGun':  
                Instigator.PlayOwnedSound(Sound'G_Sounds.notif_tone_2', SLOT_None, 2,, 64,, false);
                break;
        }
    }

    Super.Bringup(PrevWeapon);
}

simulated event PreBeginPlay()
{
    Skins.Length = 0;
    default.Skins = Skins;

    Super.PreBeginPlay();
}

function FireHack(byte Mode)
{
    local Actor TTarget;
    local vector TTargetLoc;

    if( Mode == 0 )
    {
        if( TransBeacon != None )
        {
            // this shouldn't happen
            TransBeacon.bNoAI = True;
            TransBeacon.Destroy();
            TransBeacon = None;
        }

        TTarget = Bot(Instigator.Controller).TranslocationTarget;

        if( TTarget == None )
            return;

        // hack in translocator firing here
        FireMode[0].PlayFiring();
        FireMode[0].FlashMuzzleFlash();
        FireMode[0].StartMuzzleSmoke();
        IncrementFlashCount(0);
        gProjectileFire(FireMode[0]).SpawnProjectile(Instigator.Location,Rot(0,0,0));
        // find correct initial velocity
        TTargetLoc = TTarget.Location;

        if( JumpSpot(TTarget) != None )
        {
            TTargetLoc.Z += JumpSpot(TTarget).TranslocZOffset;

            if( Instigator.Anchor != None && Instigator.ReachedDestination(Instigator.Anchor) )
            {
                // start from same point as in test
                Transbeacon.SetLocation(TransBeacon.Location + Instigator.Anchor.Location + (Instigator.CollisionHeight - Instigator.Anchor.CollisionHeight) * vect(0,0,1)- Instigator.Location);
            }
        }
        else if( TTarget.Velocity != vect(0,0,0) )
        {
            TTargetLoc += 0.3 * TTarget.Velocity;
            TTargetLoc.Z = 0.5 * (TTargetLoc.Z + TTarget.Location.Z);
        }
        else if(Instigator.Physics == PHYS_Falling && Instigator.Location.Z < TTarget.Location.Z
                && Instigator.PhysicsVolume.Gravity.Z > -800)
        {
            TTargetLoc.Z += 128;
        }

        TransBeacon.Velocity = Bot(Instigator.Controller).AdjustToss(TransBeacon.Speed, TransBeacon.Location, TTargetLoc,False);
        TransBeacon.SetTranslocationTarget(Bot(Instigator.Controller).RealTranslocationTarget);
    }
}

function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
    Super.GiveAmmo(m, WP,bJustSpawned);
    AmmoChargeF = Default.AmmoChargeF;
    RepAmmo = int(AmmoChargeF);
}

simulated function bool HasMoreAmmo()
{
    return TransBeacon == None;
}


// ============================================================================
//  HUD
// ============================================================================
simulated event RenderOverlays(Canvas C)
{
    local coords CR;

    Super.RenderOverlays(C);

    if( Instigator.Controller != None )
        Hand = Instigator.Controller.Handedness;

    if( (Hand < -1.0) || (Hand > 1.0) )
        return;

    if( ClawEmitter != None )
    {
        CR = GetBoneCoords(ClawEmitterBone);
        ClawEmitter.SetLocation(CR.Origin);
        ClawEmitter.SetRotation(OrthoRotation(CR.XAxis, CR.YAxis, CR.ZAxis));
        C.DrawActor(ClawEmitter, False, False, DisplayFOV);
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ClawEmitterClass        = class'GEffects.gTransClawEmitter'
    ClawEmitterBone         = "Translight"
    ClawEmitterRotator      = (Pitch=32768,Yaw=16384,Roll=17000)


    // gGloveWeapon
    SelectAnimPiston        = "trans=select"
    SelectAnimTrans         = "trans=select"
    SelectAnimTele          = "teleporter-to-normal"
    SelectAnimNade          = "grenade-to-normal"
    SelectAnimMine          = "landmine-to-normal"

    BoredAnimName           = "normal-idle-egg"
    BoredAnimTime           = 15


    // gWeapon
    bSpecialDrawWeapon      = False
    bForceViewUpdate        = False

    AmmoShopping            = (0,0)
    CostAmmo                = 0


    // Weapon
    FireModeClass(0)        = class'GWeapons.gTransFire'
    FireModeClass(1)        = class'GWeapons.gTransRecall'
    AttachmentClass         = class'GWeapons.gTransAttachment'

    IdleAnim                = "normal-idle"
    SelectAnim              = "normal-select"
    PutDownAnim             = "normal-down"

    AIRating                = 0.5
    CurrentRating           = 0.5

    bShowChargingBar        = True

    ItemName                = "Translocator"
    Description             = ""

    HudColor                = (R=255,G=0,B=0,A=255)
    IconMaterial            = Material'G_FX.cg_belt_trans'
    IconCoords              = (X1=0,Y1=0,X2=64,Y2=64)
}