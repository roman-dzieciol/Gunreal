// ============================================================================
//  gMachinegunSpinSound.uc ::
// ============================================================================
class gMachinegunSpinEffect extends gSpinEffect;


var   gMachineGunAttachment       MachinegunAttachment;


function Initialize(gWeaponAttachment Other)
{
    Super.Initialize(Other);
    MachinegunAttachment = gMachineGunAttachment(Other);
}

event Tick( float DeltaTime )
{
    local float SpinTarget, PerceivedAlpha;

    SpinTarget = float(MachinegunAttachment.SpinTargetByte) / 255.0;
    if( SpinTarget != 0 )
    {
        if( SpinAlpha < SpinTarget )
        {
            SpinAlpha = FMin( SpinTarget, SpinAlpha + (DeltaTime/SpinUpTime) );
        }
        else if( SpinAlpha > SpinTarget )
        {
            SpinAlpha = FMax( SpinTarget, SpinAlpha - (DeltaTime/SpinUpTime) );
        }
    }
    else
    {
        if( SpinAlpha != 0 )
            SpinAlpha = FMax( 0, SpinAlpha - (DeltaTime/SpinDownTime) );
    }


    PerceivedAlpha = FMax(0,(SpinAlpha-0.1)+(SpinAlpha*0.1));

    SoundPitch = PerceivedAlpha**0.25 * RotaryClass.default.SpinSoundPitch;
    SoundVolume = PerceivedAlpha**0.25 * RotaryClass.default.SpinSoundVolume * AmbientDownscale;

    RollCounter += DeltaTime * PerceivedAlpha * RollSpeed;
    RollCounter = RollCounter % 65536.0;

    Attachment.SetBoneRotation( SpinBone, SpinBoneAxis * RollCounter, 0, 1 );
}



// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
}
