// ============================================================================
//  gSpinEffect.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpinEffect extends gBasedActor;


var   gWeaponAttachment         Attachment;

var   name                      SpinBone;
var   rotator                   SpinBoneAxis;
var   float                     RollSpeed;
var   float                     RollCounter;
var   float                     SpinUpTime;
var   float                     SpinDownTime;
var   float                     SpinAlpha;
var   float                     RoundsPerRotation;
var   float                     RotationsPerSecond;
var   class<gRotaryWeapon>      RotaryClass;
var   float                     AmbientDownscale;

event PostBeginPlay()
{
    Super.PostBeginPlay();
}

function Initialize(gWeaponAttachment Other)
{
    Attachment = Other;
    RotaryClass = Attachment.RotaryClass;
    SpinBone = Attachment.SpinBone;
    SpinBoneAxis = Attachment.SpinBoneAxis;

    AmbientSound = RotaryClass.default.SpinSound;
    SoundRadius = RotaryClass.default.SpinSoundRadius;

    SpinUpTime = RotaryClass.default.SpinUpTime;
    SpinDownTime = RotaryClass.default.SpinDownTime;
    RoundsPerRotation = RotaryClass.default.RoundsPerRotation;
    RotationsPerSecond = 1.0 / (RotaryClass.default.FireModeClass[RotaryClass.default.SpinMode].default.FireRate * RoundsPerRotation);
    RollSpeed = 65536.0 * RotationsPerSecond;
}

event Tick(float DeltaTime)
{
    if( Attachment.bSpin )
    {
        if( SpinAlpha != 1 )
            SpinAlpha = FMin(1,SpinAlpha+(DeltaTime/SpinUpTime));
    }
    else
    {
        if( SpinAlpha != 0 )
            SpinAlpha = FMax(0,SpinAlpha-(DeltaTime/SpinDownTime));
    }

    SoundPitch = SpinAlpha**0.25 * RotaryClass.default.SpinSoundPitch;
    SoundVolume = SpinAlpha**0.25 * RotaryClass.default.SpinSoundVolume * AmbientDownscale;

    RollCounter += DeltaTime * SpinAlpha * RollSpeed;
    RollCounter = RollCounter % 65536.0;

    Attachment.SetBoneRotation( SpinBone, SpinBoneAxis * RollCounter, 0, 1 );
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    RemoteRole      = ROLE_None
    SoundPitch      = 0
    SoundVolume     = 0
    AmbientDownscale = 0.33
}
