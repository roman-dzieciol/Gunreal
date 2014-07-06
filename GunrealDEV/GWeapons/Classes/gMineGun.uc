// ============================================================================
//  gMineGun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineGun extends gGloveWeapon;



var   array<gProjectile>    Mines;
var() byte                  MaxMines;
var   byte                  CurrentMines;


replication
{
    reliable if( bNetDirty && Role == ROLE_Authority )
        CurrentMines;
}


// ============================================================================
//  Weapon
// ============================================================================

simulated function RegisterProjectile( gProjectile P )
{
    //gLog( "RegisterProjectile" #GON(P) );

    // Take ownership
    P.ServerOwner = self;

    // Add to projectile list
    CurrentMines++;
    Mines[Mines.Length] = P;
}

simulated function UnRegisterProjectile( gProjectile P )
{
    local int i;

    //gLog( "UnRegisterProjectile" #GON(P) );

    // Remove from projectile list
    for( i=0; i<Mines.Length; ++i )
    {
        if( Mines[i] == P )
        {
            CurrentMines--;
            Mines.remove(i--,1);
            break;
        }
    }
}

function DetonateLastMine()
{
    //gLog( "DetonateLastMine" #Mines.Length );
    if( Mines.Length > 0 )
    {
        //gLog( "DetonateLastMine -" #GON(Mines[Mines.Length-1]) );
        if( Mines[Mines.Length-1] != None )
        {
            Mines[Mines.Length-1].BlowUp(Mines[Mines.Length-1].Location);
        }
        else
        {
            // This shouldn't ever happen, but just in case
            Mines.remove(Mines.Length-1,1);
            CurrentMines--;
        }
    }
}

function GiveToEx(Pawn Other, optional Pickup Pickup, optional bool bGiveEmpty)
{
    local gMineProjectileBase P;

    Super.GiveToEx(Other,Pickup,bGiveEmpty);
    if( bDeleteMe )
        return;

    foreach DynamicActors(class'gMineProjectileBase', P)
    {
        if( P.InstigatorController != None && P.InstigatorController == Instigator.Controller
        && !P.bDeleteMe && P.bRegisterProjectile )
        {
            RegisterProjectile(P);
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

    // wall hit
    if( !B.CheckFutureSight(0.1) )
        return RATING_Skip;

    // minefield
    if( gProjectile(Target) != None )
        return RATING_Skip;

    // range
    if( !gWeaponFire(FireMode[0]).IsInTossRange(Target) )
        return RATING_Avoid;

    // distance
    if( Dist < 192 )
        return RATING_Avoid;

    // flying pawns
    if( Pawn(Target) != None && Pawn(Target).bCanFly )
        return RATING_Avoid;

    // height
    if( ZDiff > 160 )
        Rating -= 0.5;

    if( VSize(Target.Velocity) > 200 )
        Rating -= 0.5;

    // target
    if( Vehicle(Target) != None )
        Rating += 1;

    return Rating;
}

function float SuggestAttackStyle()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target != None )
    {
        if( !gWeaponFire(FireMode[0]).IsInTossRange(Target) )
            return 1.0;

        Dist = VSize(Target.Location - Instigator.Location);
        if( Dist < 192 )
            return -1.5;
        else if( Dist < 320 )
            return -0.7;
        else if( Dist < 384 )
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
        if( Dist < 256 )
            return -0.6;
    }
    return 0.0;
}

function byte BestMode()
{
    return 0;
}

function bool CanAttack(Actor Other)
{
    return Super.CanAttack(Other) && gWeaponFire(FireMode[0]).IsInTossRange(Other);
}


// ============================================================================
//  Rendering
// ============================================================================

simulated function NewDrawWeaponInfo(Canvas C, float YPos)
{
    local float X, Y, TX, TY, TW, TH;
    local float SW, SH, RX, RY;
    local Material M;
    local int i;

    // sizes
    RX = C.ClipX / 1024.0;
    RY = C.ClipY / 768.0;
    SW = (HUDAmmoWidth/float(MaxMines)) * RX;
    SH = (HUDAmmoWidth/float(MaxMines)) * RY;
    Y = C.ClipY - HUDAmmoHeight*RY - SH;

    // draw slots
    C.Style = ERenderStyle.STY_Alpha;
    C.DrawColor = class'gPawnHUD'.default.SlotColor;
    M = class'gPawnHUD'.default.SlotMaterial;
    TX = 0;
    TY = 0;
    TW = M.MaterialUSize();
    TH = M.MaterialVSize();

    for( i=0; i<MaxMines; ++i )
    {
        X = C.ClipX - SW*float(i+1);
        C.SetPos(X, Y);
        C.DrawTile(M, SW, SH, TX, TY, TW, TH);
    }

    // draw icons
    if( CurrentMines > 0 )
    {
        C.DrawColor = class'HUD'.default.WhiteColor;
        M = IconMaterial;
        TX = IconCoords.X1;
        TY = IconCoords.Y1;
        TW = IconCoords.X2 - TX;
        TH = IconCoords.Y2 - TY;

        for( i=0; i<CurrentMines; ++i )
        {
            X = C.ClipX - SW*float(i+1);
            C.SetPos(X, Y);
            C.DrawTile(M, SW, SH, TX, TY, TW, TH);
        }
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    MaxMines                = 5


    // gGloveWeapon
    SelectAnimPiston        = "normal-to-landmine"
    SelectAnimTrans         = "normal-to-landmine"
    SelectAnimTele          = "teleport-to-landmine"
    SelectAnimNade          = "grenade-to-landmine"
    SelectAnimMine          = "landmine-idle"


    // gWeapon
    CostAmmo                = 50


    // Weapon
    FireModeClass(0)        = class'gMineFire'
    FireModeClass(1)        = class'gMineFireAlt'
    AttachmentClass         = class'gPistonAttachment'

    IdleAnim                = "landmine-idle"
    SelectAnim              = "landmine-select"
    PutDownAnim             = "landmine-down"

    AIRating                = 2.1
    CurrentRating           = 2.1

    ItemName                = "Land mines"
    Description             = ""

    HudColor                = (R=255,G=0,B=0,A=255)
    IconMaterial            = Material'G_FX.cg_belt_mine'
    IconCoords              = (X1=0,Y1=0,X2=64,Y2=64)

}