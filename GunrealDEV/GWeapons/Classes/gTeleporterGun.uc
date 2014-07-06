// ============================================================================
//  gTeleporterGun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterGun extends gGloveWeapon;


var   gTeleporterPod    PodA;
var   gTeleporterPod    PodB;
var   gTeleporterPod    PodLast;

var   class<Emitter>    ReclaimEmitterClass;

var() Sound             ReclaimSound;
var() float             ReclaimSoundVolume;
var() float             ReclaimSoundRadius;
var() Actor.ESoundSlot  ReclaimSoundSlot;

var() name              ReclaimAnim;
var() name              ReclaimEmptyAnim;


replication
{
    reliable if( bNetDirty && Role == ROLE_Authority )
        PodA, PodB;
}

static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.ReclaimEmitterClass);
    S.PrecacheObject(default.ReclaimSound);
}

simulated function AddPod( gTeleporterPod P )
{
    //gLog( "AddPod" #PodA #PodB #PodA.OtherPod #PodB.OtherPod );

    PodLast = P;
    if( PodA == None )
    {
        PodA = P;
    }
    else if( PodB == None )
    {
        PodB = P;
    }

    if( PodA != None )
        PodA.OtherPod = PodB;

    if( PodB != None )
        PodB.OtherPod = PodA;
}

function GiveToEx(Pawn Other, optional Pickup Pickup, optional bool bGiveEmpty)
{
    local gTeleporterPod P;

    Super.GiveToEx(Other,Pickup,bGiveEmpty);
    if( bDeleteMe )
        return;

    foreach DynamicActors(class'gTeleporterPod', P)
    {
        if( P.InstigatorController != None && P.InstigatorController == Instigator.Controller )
        {
            AddPod(P);
        }
    }
}

simulated function bool HasAmmo()
{
    return True;
}

simulated function bool HasMoreAmmo()
{
    return PodA == None || PodB == None;
}

function ReclaimLastPod()
{
    if( PodLast != None )
        ReclaimPod(PodLast);
    else if( PodA != None )
        ReclaimPod(PodA);
    else if( PodB != None )
        ReclaimPod(PodB);
}

function ResetPods()
{
    //gLog( "ResetPods" );
    ReclaimPod(PodA);
    ReclaimPod(PodB);
}

function ReclaimPod( gTeleporterPod P )
{
    //gLog( "ReclaimPod" #P );
    if( P != None )
    {
        if( ReclaimEmitterClass != None )
            Spawn(ReclaimEmitterClass,,, P.Location, P.Rotation);
        
        if( ReclaimSound != None )
            P.PlaySound(ReclaimSound, ReclaimSoundSlot, ReclaimSoundVolume, False, ReclaimSoundRadius);

        PlayReclaim();
        P.Destroy();
    }
}

simulated function PlayReclaim()
{   
    if( Mesh != None )
    {
        if( HasMoreAmmo() )
            PlayAnim(ReclaimAnim, 1.0, 0.1);
        else
            PlayAnim(ReclaimEmptyAnim, 1.0, 0.1);
    }
}


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
        else if( anim == ReclaimEmptyAnim && gWeaponFire(FireMode[0]) != None && gWeaponFire(FireMode[0]).PlayReload() )
        {
        }
        else if( (FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) )
        {
            PlayIdle();
        }
    }
}

simulated function string gDebugString()
{
    local string S;

    S = "" #GON(PodA) #GON(PodB);

    return S;
}

function bool BotFire(bool bFinished, optional name FiringMode)
{
    return False;
}

function bool CanAttack(Actor Other)
{
    return False;
}

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
    local float X, Y, TX, TY, TW, TH;
    local float SW, SH, RX, RY;
    local Material M;

    // Screen scale
    RX = C.ClipX / 1024;
    RY = C.ClipY / 768;

    SW = 60 * RX; // 0.05859375 60/1024
    SH = 60 * RY;// 0.078125 60/768

    M = class'gPawnHUD'.default.SlotMaterial;
    X = C.ClipX - SW;
    Y = C.ClipY - SH*2;
    TX = 0;
    TY = 0;
    TW = M.MaterialUSize();
    TH = M.MaterialVSize();

    C.SetPos(X, Y);
    C.DrawColor = class'gPawnHUD'.default.SlotColor;
    C.Style = ERenderStyle.STY_Alpha;
    C.DrawTile(M, SW, SH, TX, TY, TW, TH);

    X = C.ClipX - SW*2;
    C.SetPos(X, Y);
    C.DrawTile(M, SW, SH, TX, TY, TW, TH);

    M = IconMaterial;
    TX = IconCoords.X1;
    TY = IconCoords.Y1;
    TW = IconCoords.X2 - TX;
    TH = IconCoords.Y2 - TY;

    if( PodA != None )
    {
        X = C.ClipX - SW;
        C.SetPos(X, Y);
        C.DrawTile(M, SW, SH, TX, TY, TW, TH);
    }

    if( PodB != None )
    {
        X = C.ClipX - SW*2;
        C.SetPos(X, Y);
        C.DrawTile(M, SW, SH, TX, TY, TW, TH);
    }
}



// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ReclaimEmitterClass     = None//class'GEffects.gPlaceholderEmitter'

    ReclaimSound            = Sound'G_Sounds.cg_telepod_reclaim'
    ReclaimSoundVolume      = 1.0
    ReclaimSoundRadius      = 255
    ReclaimSoundSlot        = SLOT_Misc

    ReclaimAnim             = "teleporter-loaded-recall"
    ReclaimEmptyAnim        = "trans-recall"

    // gGloveWeapon
    SelectAnimPiston        = "normal-to-teleporter"
    SelectAnimTrans         = "normal-to-teleporter"
    SelectAnimTele          = "teleporter-idle"
    SelectAnimNade          = "grenade-to-teleporter"
    SelectAnimMine          = "landmine-to-teleporter"


    // gWeapon
    AmmoShopping            = (0,0)
    CostAmmo                = 0


    // Weapon
    FireModeClass(0)        = class'gTeleporterFire'
    FireModeClass(1)        = class'gTeleporterFireAlt'
    AttachmentClass         = class'GWeapons.gTeleporterAttachment'

    IdleAnim                = "teleporter-idle"
    SelectAnim              = "teleporter-select"
    PutDownAnim             = "teleporter-down"

    AIRating                = -1.0
    CurrentRating           = -1.0

    ItemName                = "Teleporter"
    Description             = ""

    HudColor                = (R=255,G=255,B=255,A=255)
    IconMaterial            = Material'G_FX.cg_belt_tele'
    IconCoords              = (X1=0,Y1=0,X2=64,Y2=64)

}