// ============================================================================
//  gLightEffect.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gLightEffect extends gEmitterBase;

var()   bool        bFlash;
var()   float       FlashBrightness;
var()   float       FlashRadius;
var()   float       FlashTimeIn;
var()   float       FlashTimeIdle;
var()   float       FlashTimeOut;
var()   float       FlashCurveIn;
var()   float       FlashCurveOut;
var()   ELightType  FlashTypeIdle;
var()   ELightType  FlashTypeOut;
var     float       FlashTime;

simulated event PostBeginPlay()
{
    //Log( "PostBeginPlay" @bDisableOnStart );

    if( bFlash && Level.NetMode != NM_DedicatedServer )
    {
        FlashTime = FlashTimeIn + FlashTimeIdle + FlashTimeOut;
        LifeSpan = FlashTime;
    }
}

simulated event SetInitialState()
{
    //gLog("SetInitialState" );

    Super.SetInitialState();

    if( !bFlash || Level.NetMode == NM_DedicatedServer )
        Disable('Tick');
}

simulated event Tick( float DeltaTime )
{
    local float Alpha;

    // Flash fade in
    if( FlashTimeIn > 0 )
    {
        FlashTimeIn = FMax(FlashTimeIn-DeltaTime,0);
        Alpha = 1 - ((FlashTimeIn/default.FlashTimeIn)**FlashCurveIn);
        LightBrightness = default.LightBrightness + (FlashBrightness-default.LightBrightness)*Alpha;
        LightRadius = default.LightRadius + (FlashRadius-default.LightRadius)*Alpha;
        //Log("FlashTimeIn" @Alpha @FlashTimeIn @FlashTimeOut @LightBrightness @LightRadius );
    }

    // Flash idle
    else if( FlashTimeIdle > 0 )
    {
        LightType = FlashTypeIdle;
        FlashTimeIdle = FMax(FlashTimeIdle-DeltaTime,0);
    }

    // Flash fade out
    else if( FlashTimeOut > 0 )
    {
        LightType = FlashTypeOut;
        FlashTimeOut = FMax(FlashTimeOut-DeltaTime,0);
        Alpha = ((FlashTimeOut/default.FlashTimeOut)**FlashCurveOut);
        LightBrightness = FlashBrightness*Alpha;
        LightRadius = FlashRadius*Alpha;
        //Log("FlashTimeOut" @Alpha @FlashTimeIn @FlashTimeOut @LightBrightness @LightRadius );
    }

    // Disable flash
    else
    {
        LightType = LT_None;
        bFlash = False;
        Disable('Tick');
    }
}

DefaultProperties
{
    AutoDestroy     = False
    bUnlit          = True
    AutoReset       = False
    bNoDelete       = False
    RemoteRole      = ROLE_None
    LifeSpan        = 0.2
    Physics         = PHYS_Trailer
}