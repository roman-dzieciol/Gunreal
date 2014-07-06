// ============================================================================
//  gDestroyer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyer extends gWeapon;

var() gDestroyerBeamInfo Beam;

function BeamBegin()
{
    if( Role == ROLE_Authority )
    {
        if( Beam != None )
        {
            gLog("ERROR: Beam in BeamBegin()");
            BeamEnd();
        }

        Beam = Spawn(class'gDestroyerBeamInfo',Instigator, , GetBoneCoords('muzzle').Origin);

        ThirdPersonActor.AmbientSound = gWeaponFire(FireMode[1]).FireLoopSound;
    }
}

exec function DumpBeam()
{
    if( Beam != None )
        Beam.DumpBeam();
}

function BeamEnd()
{
    if( Role == ROLE_Authority )
    {
        if( Beam != None )
        {
            Beam.Release();
        }

        Beam = None;
    }
    ThirdPersonActor.AmbientSound = None;
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

    // height
    if( ZDiff < -120 )
        Rating += 0.25;
    else if( ZDiff > 160 )
        Rating -= 0.35;
    else if( ZDiff > 80 )
        Rating -= 0.05;

    // minefield
    if( gProjectile(Target) != None )
        Rating += 1;

    return Rating;
}

function float SuggestAttackStyle()
{
    return 0.8;
}

function float SuggestDefenseStyle()
{
    return 0.0;
}

function byte BestMode()
{
    local Bot B;
    local Actor Target;
    local float Dist;

    //gLog( "BestMode" );

    B = Bot(Instigator.Controller);
    if( B == None )
        return 0;

    Target = GetBotTarget();
    if( Target == None )
        return 0;

    // wall hit
    if( !B.CheckFutureSight(0.1) )
        return 1;

    Dist = VSize(Target.Location - Instigator.Location);
    if( Dist < class'gDestroyerBeamInfo'.default.LifeDist * 0.66 )
        return 1;

    return 0;
}




// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gWeapon
    ItemSize                = 4
    CostWeapon              = 1200
    CostAmmo                = 300
    BotPurchaseProbMod      = 1


    // Weapon
    FireModeClass(0)        = class'GWeapons.gDestroyerFire'
    FireModeClass(1)        = class'GWeapons.gDestroyerFireAlt'
    PickupClass             = class'GWeapons.gDestroyerPickup'
    AttachmentClass         = class'GWeapons.gDestroyerAttachment'

    SelectSound             = Sound'G_Sounds.grp_select_big'

    AIRating                = 2.9
    CurrentRating           = 2.9

    ItemName                = "The Destroyer"
    Description             = "A fire/lava-based burnination machine that makes the BFG reach for a fresh pair of underwear."

    DisplayFOV              = 80
    PlayerViewOffset        = (X=55,Y=12,Z=-33)
    PlayerViewPivot         = (Pitch=0,Yaw=32768,Roll=0)
    SmallViewOffset         = (X=47,Y=12,Z=-35)
    SmallEffectOffset       = (X=0.0,Y=0.0,Z=0.0)
    EffectOffset            = (X=0.0,Y=0.0,Z=0.0)
    CenteredOffsetY         = -5
    CenteredRoll            = 0
    CenteredYaw             = -500

    HudColor                = (R=255,G=0,B=0,A=255)
    IconCoords              = (X1=510,Y1=0,X2=765,Y2=63)


    // Actor
    Mesh                    = Mesh'G_Anims.FireGun'

    SoundRadius             = 256
}