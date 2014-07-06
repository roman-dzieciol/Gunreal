// ============================================================================
//  gShakeView.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShakeView extends Object;

var float InitTime;

var() float Duration;       // how long the shake should last
var() vector OffsetMag;     // how far view should move
var() vector OffsetRand;    // which components should be mirrored randomly: 0 = keep, 1 = randomize
var() float OffsetFreq;     // how many time view should move back and forth
var() float OffsetDecay;    // how rapidly the effect should fade out: 0 = linear, 1 = exponential, 1+ = more exponential
var() rotator RotationMag;  // how far view should rotate
var() rotator RotationRand; // which components should be mirrored randomly: 0 = keep, 1 = randomize
var() float RotationFreq;   // how many time view should rotate back and forth
var() float RotationDecay;  // how rapidly the effect should fade out: 0 = linear, 1 = exponential, 1+ = more exponential

// Alpha properties are scaled by ie damage
var() float AlphaAmountMax;      // for translating AlphaAmount to 0-1 range
var() float AlphaDuration;       // how long the shake should last
var() vector AlphaOffsetMag;     // how far view should move
var() float AlphaOffsetFreq;     // how many time view should move back and forth
var() float AlphaOffsetDecay;    // how rapidly the effect should fade out: 0 = linear, 1 = exponential, 1+ = more exponential
var() rotator AlphaRotationMag;  // how far view should rotate
var() float AlphaRotationFreq;   // how many time view should rotate back and forth
var() float AlphaRotationDecay;  // how rapidly the effect should fade out: 0 = linear, 1 = exponential, 1+ = more exponential


static final operator(16) rotator * ( rotator A, rotator B )
{
    local rotator R;
    R.Pitch = A.Pitch * B.Pitch;
    R.Yaw = A.Yaw * B.Yaw;
    R.Roll = A.Roll * B.Roll;
    return R;
}

final function bool InitFrom( float Time, class<gShakeView> Template, optional float AlphaAmount )
{
    local float Alpha;

    if( Template == None )
        return False;

    if( Abs(AlphaAmount) > 0 )
    {
        Alpha = FClamp(Abs(AlphaAmount) / Template.default.AlphaAmountMax, 0,1);
        Duration = Template.default.Duration + Template.default.AlphaDuration * Alpha;
        OffsetMag = Template.default.OffsetMag + Template.default.AlphaOffsetMag * Alpha;
        OffsetRand = Template.default.OffsetRand;
        OffsetFreq = Template.default.OffsetFreq + Template.default.AlphaOffsetFreq * Alpha;
        OffsetDecay = Template.default.OffsetDecay + Template.default.AlphaOffsetDecay * Alpha;
        RotationMag = Template.default.RotationMag + Template.default.AlphaRotationMag * Alpha;
        RotationRand = Template.default.RotationRand;
        RotationFreq = Template.default.RotationFreq + Template.default.AlphaRotationFreq * Alpha;
        RotationDecay = Template.default.RotationDecay + Template.default.AlphaRotationDecay * Alpha;
    }
    else
    {
        Duration = Template.default.Duration;
        OffsetMag = Template.default.OffsetMag;
        OffsetRand = Template.default.OffsetRand;
        OffsetFreq = Template.default.OffsetFreq;
        OffsetDecay = Template.default.OffsetDecay;
        RotationMag = Template.default.RotationMag;
        RotationRand = Template.default.RotationRand;
        RotationFreq = Template.default.RotationFreq;
        RotationDecay = Template.default.RotationDecay;
    }

    if(OffsetRand.X != 0 && FRand() > 0.5) OffsetRand.X = -1; else OffsetRand.X = 1;
    if(OffsetRand.Y != 0 && FRand() > 0.5) OffsetRand.Y = -1; else OffsetRand.Y = 1;
    if(OffsetRand.Z != 0 && FRand() > 0.5) OffsetRand.Z = -1; else OffsetRand.Z = 1;

    if(RotationRand.Pitch != 0 && FRand() > 0.5) RotationRand.Pitch = -1; else RotationRand.Pitch = 1;
    if(RotationRand.Yaw != 0 && FRand() > 0.5) RotationRand.Yaw = -1; else RotationRand.Yaw = 1;
    if(RotationRand.Roll != 0 && FRand() > 0.5) RotationRand.Roll = -1; else RotationRand.Roll = 1;

    InitTime = Time;

    return True;
}

final function bool CalcShake( float TimeSeconds, out vector Offset, out rotator Rotation )
{
    local float TimeAlpha;

    TimeAlpha = TimeSeconds - InitTime;
    if( TimeAlpha < Duration )
    {
        TimeAlpha = TimeAlpha / Duration;
        Offset = OffsetMag * OffsetRand * sin(TimeAlpha*pi*OffsetFreq*2) * exp(-TimeAlpha*OffsetDecay) * (1-TimeAlpha);
        Rotation = RotationMag * RotationRand * sin(TimeAlpha*pi*RotationFreq*2) * exp(-TimeAlpha*RotationDecay) * (1-TimeAlpha);
        return True;
    }
    return False;
}

DefaultProperties
{
    AlphaAmountMax          = 100

    Duration                = 0.5
    OffsetMag               = (X=-1,Y=1,Z=1)
    OffsetRand              = (X=0,Y=1,Z=1)
    OffsetFreq              = 2
    OffsetDecay             = 1
    RotationMag             = (Pitch=-128,Yaw=32,Roll=32)
    RotationRand            = (Pitch=0,Yaw=1,Roll=1)
    RotationFreq            = 3
    RotationDecay           = 1

    AlphaDuration           = 0.5
    AlphaOffsetMag          = (X=-8,Y=1,Z=1)
    AlphaOffsetFreq         = 1
    AlphaOffsetDecay        = 0
    AlphaRotationMag        = (Pitch=-256,Yaw=32,Roll=32)
    AlphaRotationFreq       = 2
    AlphaRotationDecay      = 0
}