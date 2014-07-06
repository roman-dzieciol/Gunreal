// ============================================================================
//  gDestroyerFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerFireAlt extends gNoFire;


simulated function bool AllowFire()
{
    return (Weapon.AmmoAmount(ThisModeNum) > 0);
}

function DoFireEffect()
{
    GotoState('');
    if( Weapon.AmmoAmount(ThisModeNum) <= 0 )
        Weapon.OutOfAmmo();
}

event ModeHoldFire()
{
    if( Weapon.AmmoAmount(ThisModeNum) > 0 )
    {
        super.ModeHoldFire();
        GotoState('Hold');
    }
}

simulated function PlayFiring()
{
    Super.PlayFiring();
    Weapon.OutOfAmmo();
}

simulated function GetFireCoords( out vector AimLoc, out rotator AimRot )
{
    local vector X,Y,Z;

    Weapon.GetViewAxes(X, Y, Z);
    AimLoc = GetFireStart(X, Y, Z);
    AimRot = AdjustAim(AimLoc, AimError);
}

state Hold
{
    simulated event BeginState()
    {

        // don't even spawn on server
        if( Level.NetMode != NM_DedicatedServer && gPlayer(Instigator.Controller) != None )
        {
            if(FlashEffectClass != None )
            {
                FlashEffect = Spawn(FlashEffectClass);
                if( FlashEffect != None && FlashBone != '' )
                {
                    Weapon.AttachToBone(FlashEffect, FlashBone);
                    if( FlashBoneRotator != rot(0,0,0) )
                        Weapon.SetBoneRotation( FlashBone, FlashBoneRotator, 0, 1 );
                }
            }
        }

        gDestroyer(Weapon).BeamBegin();
        Weapon.PlayAnim(PreFireAnim);
        SetTimer(FireRate, True);
        Timer();
    }

    simulated event Timer()
    {
        if( Weapon.AmmoAmount(ThisModeNum) == 0 )
        {
            SetTimer(0.0, False);
        }
        else
        {
            // Add recoil
            if( bAccuracyRecoil )
                AccuracyRecoil = FMin(1, AccuracyRecoil + (1/AccuracyRecoilShots) ) + (FireRate / AccuracyRecoilRegen);

            Weapon.ConsumeAmmo(ThisModeNum, 1);
            if( Weapon.AmmoAmount(ThisModeNum) <= 0 )
            {
                GotoState('');
                Weapon.OutOfAmmo();
            }
        }
    }

    simulated event EndState()
    {
        gDestroyer(Weapon).BeamEnd();
        PlayFireEnd();
        if( FlashEffect != None )
        {
            FlashEffect.Kill();
            FlashEffect = None;
        }
    }

    function StopFiring()
    {
        Super.StopFiring();
        GotoState('');
    }
}

simulated function InitEffects()
{
}


event ModeTick( float DT )
{
    Super(gWeaponFire).ModeTick(DT);
}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    AccuracyBase                = 0.02
    AccuracyMultStance          = 1.0
    AccuracyMultRecoil          = 2.0
    AccuracyRecoilRegen         = 0.33
    AccuracyRecoilShots         = 6
    bAccuracyBase               = True
    bAccuracyRecoil             = True
    bAccuracyStance             = True
    bAccuracyCentered           = True


    FireRate                = 0.06
    bFireOnRelease          = True
    bWaitForRelease         = True
    bModeExclusive          = True

    AmmoClass               = class'gDestroyerAmmo'
    AmmoPerFire             = 0

    StartOffset             = (X=40,Z=-16)

    FlashEffectClass        = None //class'GEffects.gDestroyerAltMuzzle'
    FlashBone               = "Muzzle"
    FlashBoneRotator        = (Pitch=0,Yaw=16384,Roll=16384)

    PreFireSound            = Sound'G_Sounds.de_altfire_begin'
    FireLoopSound           = Sound'G_Sounds.de_altfire_loop'
    FireEndSound            = Sound'G_Sounds.de_altfire_end'

    PreFireAnim             = "alt_begin"
    FireLoopAnim            = "alt_loop"
    FireEndAnim             = "alt_end"
}