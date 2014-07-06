// ============================================================================
//  gG60Attachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gG60Attachment extends gTracingAttachment;


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
                Spawn(ShellActorClass,,,GetBoneCoords(ShellBone).Origin,GetBoneRotation(ShellBone, 0));

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
                Spawn(ShellActorClass,,, GetBoneCoords(ShellBone2nd).Origin, GetBoneRotation(ShellBone2nd,0));

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
        if( !Instigator.IsFirstPerson() )
        {
            if( Mesh != None )
            {
                if( LocalMode == 0 )
                    return GetBoneCoords(FlashBone).Origin;
                else
                    return GetBoneCoords(FlashBone2nd).Origin;
            }
        }
    }

    return Super.GetTipLocation();
}

// =============================================================================
// DefaultProperties
// =============================================================================
DefaultProperties
{
    bHeavy                  = True
    bRapidFire              = False
    bAltRapidFire           = False

    Mesh                    = Mesh'G_Anims3rd.g60'

    bDynamicLight           = False
    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 3
    LightBrightness         = 127
    LightHue                = 30
    LightSaturation         = 170
    LightRadius             = 10

    DrawScale               = 0.3
    RelativeLocation        = (X=-20,Y=0,Z=-15)

    IgnoredMode             = 2 //special case

    TracerClass             = class'GEffects.gG60Tracer'

    HitGroupClass           = class'GEffects.gG60HitGroup'

    FlashEffectClass        = class'GEffects.gG60Flash'
    FlashBone               = "Muzzle_top"
    FlashBone2nd            = "Muzzle_bot"

    ShellActorClass         = None
    ShellBone               = "Shells_top"
    ShellBone2nd            = "Shells_bot"

    FlashBoneRotator        = (Pitch=0,Yaw=32768,Roll=0)
    FlashBoneRotator2nd     = (Pitch=0,Yaw=32768,Roll=0)
}