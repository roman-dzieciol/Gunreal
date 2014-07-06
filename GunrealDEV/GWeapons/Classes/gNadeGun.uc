// ============================================================================
//  gNadeGun.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gNadeGun extends gGloveWeapon;


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
        else if( Anim == class'gNadeFire'.default.ReloadAnim )
        {
		    PlayAnim(SelectAnim, 1, 0);
        }
        else if( (FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) )
        {
            PlayIdle();
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

    // range
    if( !gWeaponFire(FireMode[1]).IsInTossRange(Target) )
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

    Target = GetBotTarget();

    if( Target != None )
    {
        if( !gWeaponFire(FireMode[1]).IsInTossRange(Target) )
            return 1.0;

        Dist = VSize(Target.Location - Instigator.Location);

        if( Dist < 384 )
            return -1.5;
        else if( Dist < 512 )
            return -0.7;
        else if( Dist < 768 )
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
    return 1;
}

function bool CanAttack(Actor Other)
{
    return Super.CanAttack(Other) && gWeaponFire(FireMode[1]).IsInTossRange(Other);
}



// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gGloveWeapon
    SelectAnimPiston        = "normal-to-grenade"
    SelectAnimTrans         = "teleporter-to-grenade"
    SelectAnimTele          = "normal-to-grenade"
    SelectAnimNade          = "grenade-idle"
    SelectAnimMine          = "landmine-to-grenade"


    // gWeapon
    CostAmmo                = 25


    // Weapon
    FireModeClass(0)        = class'gNadeFire'
    FireModeClass(1)        = class'gNadeFireAlt'
    AttachmentClass         = class'gNadeAttachment'

    IdleAnim                = "grenade-idle"
    SelectAnim              = "grenade-select"
    PutDownAnim             = "grenade-down"

    AIRating                = 2.3
    CurrentRating           = 2.3

    ItemName                = "Grenade"
    Description             = ""

    HudColor                = (R=255,G=0,B=0,A=255)
    IconMaterial            = Material'G_FX.cg_belt_nade'
    IconCoords              = (X1=0,Y1=0,X2=64,Y2=64)

}