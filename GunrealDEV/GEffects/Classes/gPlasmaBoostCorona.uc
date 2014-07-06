// ============================================================================
//  gPlasmaBoostCorona.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaBoostCorona extends gEmitterBase;


var() float             FadeTimeIn;
var() float             FadeTimeIdle;
var() float             FadeTimeOut;
var   float             FadeTimeLimit;
var() float             FadeCurveIn;
var() float             FadeCurveOut;
var   float             FadeAlpha;

var   ParticleEmitter   CachedEmitter;
var   float             CachedOpacity;
var   bool              bStayOn;


simulated event SetInitialState()
{
    //gLog("SetInitialState" );

    Super.SetInitialState();

    // Setup cache
    CachedEmitter = Emitters[0];
    CachedOpacity = CachedEmitter.Opacity;

    // Disable on spawn
    CachedEmitter.Opacity = 0;
    FadeTimeIn = 0;
    FadeTimeOut = 0;
    Disable('Tick');
}

final simulated function BeginCharging()
{
    //gLog("BeginCharging" );

    bStayOn = True;
    AddTime(default.FadeTimeIn);
}

final simulated function EndCharging( float TimeLeft )
{
    //gLog("EndCharging" #TimeLeft );

    bStayOn = False;
    if( TimeLeft > 0 )
    {
        // Continue fading
        AddTime( TimeLeft );
    }
    else
    {
        // Fade out from FadeAlpha
        FadeTimeIn = 0;
        FadeTimeIdle = 0;
        FadeTimeOut = (FadeAlpha ** (1.0/FadeCurveOut)) * default.FadeTimeOut;
        Enable('Tick');
    }
}

final simulated function AddTime( float TimeLeft )
{
    local float Alpha;

    //gLog("AddTime >>" #TimeLeft );

    // Limit fade-in if not enough time
    FadeTimeLimit = FMax(0, (default.FadeTimeIn - FadeTimeIn) - TimeLeft);

    // Calc FadeTimeIn from FadeAlpha
    FadeTimeIn = (1.0 - (FadeAlpha ** (1.0/FadeCurveIn))) * default.FadeTimeIn;

    // FadeTimeIn is inclusive
    FadeTimeIdle = FMax(0, TimeLeft - (default.FadeTimeIn - FadeTimeIn));

    // Calc FadeTimeOut from FadeAlpha at FadeTimeLimit
    Alpha = (1.0 - (FadeTimeLimit / default.FadeTimeIn)) ** FadeCurveIn;
    FadeTimeOut = (Alpha ** (1.0/FadeCurveOut)) * default.FadeTimeOut;

    Enable('Tick');

    //gLog("AddTime <<" #TimeLeft  );
}

simulated event Tick( float DeltaTime )
{
    //gLog("Tick >>" );

    // Update Timers
    if( FadeTimeIn > FadeTimeLimit )
    {
        FadeAlpha = (1.0 - (FadeTimeIn / default.FadeTimeIn)) ** FadeCurveIn;
        FadeTimeIn -= DeltaTime;
    }
    else if( FadeTimeIdle > 0 || bStayOn )
    {
        FadeAlpha = 1.0;
        FadeTimeIdle -= DeltaTime;
    }
    else if( FadeTimeOut > 0 )
    {
        FadeAlpha = (FadeTimeOut / default.FadeTimeOut) ** FadeCurveOut;
        FadeTimeOut -= DeltaTime;
    }
    else
    {
        FadeAlpha = 0;
        Disable('Tick');
    }

    // Update emitter
    CachedEmitter.Opacity = CachedOpacity * FadeAlpha;

    //gLog("Tick <<" );
}

simulated function string gDebugString()
{
    local string S;
    S = "" #bStayOn #FadeTimeLimit #FadeTimeIn #FadeTimeIdle #FadeTimeOut #FadeAlpha;
    return S;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    FadeTimeIn          = 2.0
    FadeTimeOut         = 0.33
    FadeCurveIn         = 2.0
    FadeCurveOut        = 1.0

    AutoDestroy         = False
    AutoReset           = False

    bNoDelete           = False
    bStatic             = False
    bHidden             = True
    bUnlit              = True
    RemoteRole          = ROLE_None

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseColorScale=True
        ZTest=False
        UniformSize=True
        ColorScale(0)=(Color=(B=250,G=133,R=191,A=255))
        ColorScale(1)=(RelativeTime=0.200000,Color=(B=218,G=165,R=218,A=127))
        ColorScale(2)=(RelativeTime=0.500000,Color=(B=250,G=133,R=191,A=160))
        ColorScale(3)=(RelativeTime=0.750000,Color=(B=218,G=165,R=218,A=192))
        ColorScale(4)=(RelativeTime=1.000000,Color=(B=250,G=133,R=191,A=255))
        MaxParticles=1
        StartSizeRange=(X=(Min=32.000000,Max=32.000000),Y=(Min=32.000000,Max=32.000000),Z=(Min=32.000000,Max=32.000000))
        Texture=Texture'G_FX.Smokes.spot1'
        LifetimeRange=(Max=1000000.000000)
        WarmupTicksPerSecond=1.000000
        RelativeWarmupTime=1.000000
        CoordinateSystem=PTCS_Relative
        Opacity=0.5
        //DrawStyle=PTDS_Brighten
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter1'

}