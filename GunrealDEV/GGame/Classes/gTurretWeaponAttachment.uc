// ============================================================================
//  gTurretWeaponAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTurretWeaponAttachment extends gWeaponAttachment;

// - MuzzleFlash --------------------------------------------------------------

// LocalMode 1 is 2nd barrel
// LocalMode 2 is the AltFire

var() name              FlashBone2nd;
var() rotator           FlashBoneRotator2nd;

var() name              ShellBone2nd;
var() rotator           ShellBoneRotator2nd;

var   Emitter           FlashEffect2nd;
var   Emitter           ShellEffect2nd;
var   Emitter           TracerEffect2nd;


simulated function Actor SpawnAttached(class<Actor> C, name Bone, rotator BoneRot)
{
    local Actor A;

    if( C != None )
    {
        A = Spawn(C, Self);
        if( A != None && Bone != '' )
        {
            Instigator.AttachToBone(A, Bone);
            if( BoneRot != rot(0, 0, 0) )
                Instigator.SetBoneRotation(Bone, BoneRot, 0, 1);
        }
    }

    return A;
}

// =============================================================================
// Lifespan
// =============================================================================
simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( Level.Netmode == NM_DedicatedServer )
        return;

    if( FlashEffectClass != None )
        FlashEffect2nd = Emitter(SpawnAttached(FlashEffectClass,FlashBone2nd,FlashBoneRotator2nd));

    if( ShellEffectClass != None )
        ShellEffect2nd = Emitter(SpawnAttached(ShellEffectClass,ShellBone2nd,ShellBoneRotator2nd));
}

simulated event Destroyed()
{
    if( FlashEffect2nd != None )
        FlashEffect2nd.Destroy();

    if( ShellEffect2nd != None )
        ShellEffect2nd.Destroy();

    if( TracerEffect2nd != None )
        TracerEffect2nd.Destroy();

    Super.Destroyed();
}

// =============================================================================
// Effects
// =============================================================================
simulated function ShowMuzzleFlash()
{
    if( LocalMode == 0 )
    {
        // Muzzle Flash
        if( FlashEffect != None )
            FlashEffect.Trigger(Self, Instigator);

        if( Level.DetailMode >= ShellDetailMode )
        {
            // Shell spawner
            if( ShellActorClass != None )
                Spawn(ShellActorClass,,,Instigator.GetBoneCoords(ShellBone).Origin,Instigator.GetBoneRotation(ShellBone, 0));

            // Shell spawner
            if( ShellEffect != None )
                ShellEffect.Trigger(Self, Instigator);
        }
    }
    else
    {
        // Muzzle Flash
        if( FlashEffect2nd != None )
            FlashEffect2nd.Trigger(Self, Instigator);

        if( Level.DetailMode >= ShellDetailMode )
        {
            // Shell spawner
            if( ShellActorClass != None )
                Spawn(ShellActorClass,,, Instigator.GetBoneCoords(ShellBone2nd).Origin, Instigator.GetBoneRotation(ShellBone2nd,0));

            // Shell spawner
            if( ShellEffect2nd != None )
                ShellEffect2nd.Trigger(Self, Instigator);
        }
    }
}

simulated function vector GetTipLocation()
{
    if( Instigator != None )
    {
        if( LocalMode == 0 )
            return Instigator.GetBoneCoords(FlashBone).Origin;
        else
            return Instigator.GetBoneCoords(FlashBone2nd).Origin;
    }

    return Super.GetTipLocation();
}


// ============================================================================
//  Hit
// ============================================================================
simulated event ThirdPersonEffects()
{
    LocalCount = FlashCount & 0x7F;
    LocalMode = FlashCount >> 7;

    //gLog("TPE" #FlashCount #LocalCount #LocalMode);

    if( Level.NetMode == NM_DedicatedServer || LocalMode == IgnoredMode || Instigator == None )
        return;

    //gLog("TPE 2" #FlashCount #LocalCount #LocalMode);

    if( LocalCount != 0 )
    {
        if( !Instigator.IsFirstPerson() )
            ShowMuzzleFlash();

        // Light
        if( bWeaponLight )
            WeaponLight();
    }
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    bDynamicLight           = False
    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10

    IgnoredMode             = 2 //special case

    FlashEffectClass        = class'GEffects.gTurretFlash'
    FlashBone               = "left_muzzle"
    FlashBone2nd            = "right_muzzle"

    ShellActorClass         = None
    ShellBone               = "left_muzzle"
    ShellBone2nd            = "right_muzzle"

    FlashBoneRotator        = (Pitch=0,Yaw=0,Roll=0)
    FlashBoneRotator2nd     = (Pitch=0,Yaw=0,Roll=0)
}