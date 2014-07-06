// ============================================================================
//  gAcidTimer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gAcidTimer extends gBasedActor;


var() float                         AcidVolume;
var() Sound                         AcidEndSound;
var() class<gOverlayTemplate>       AcidOverlayClass;

var   float                         DamagePerSecond;
var   float                         DamageTotal;
var   float                         DamageTimer;
var   class<DamageType>             DamageType;

var   Controller                    InstigatorController;
var   bool                          bWillKill;


replication
{
    reliable if( bNetOwner && Role == ROLE_Authority )
        DamageTotal, bWillKill, DamagePerSecond;
}


// ============================================================================
//  Acid Timer
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.AcidEndSound);
    S.PrecacheObject(default.AcidOverlayClass);
}

event PostBeginPlay()
{
    //gLog( "PostBeginPlay" );

    Super.PostBeginPlay();
    if( bDeleteMe )
        return;

    // Attach to pawn
    if( gPawn(Owner) != None )
    {
        gPawn(Owner).bAcidFX = True;
        if( gPlayer(gPawn(Owner).Controller) != None )
            gPlayer(gPawn(Owner).Controller).ClientAmbientOverlay(AcidOverlayClass);
    }
}

event Destroyed()
{
    //gLog( "Destroyed" );

    if( gPawn(Owner) != None )
    {
        gPawn(Owner).bAcidFX = False;
        Owner.PlaySound(AcidEndSound,SLOT_None,AcidVolume,,SoundRadius);
        if( gPlayer(gPawn(Owner).Controller) != None )
            gPlayer(gPawn(Owner).Controller).ClientFadeAmbientOverlay(AcidOverlayClass);
    }

    Super.Destroyed();
}

event Timer()
{
    local int Damage;

    //gLog( "Timer" );

    if( Owner != None && DamageTotal > 0 )
    {
        // Delayed Instigator
        if( Instigator == None || Instigator.Controller == None )
            Owner.SetDelayedDamageInstigatorController(InstigatorController);

        // Deal damage
        Damage = DamagePerSecond * TimerRate;
        DamageTotal -= Damage;
        Owner.TakeDamage(Damage, Instigator, Owner.Location, vector(Owner.Rotation), DamageType);

        // Schedule another event
        if( DamageTotal > 0 )
        {
            // Update timer if neccesary
            if( TimerRate != DamageTimer )
                SetTimer(DamageTimer, True);

            // Update kill notification
            if( gPawn(Owner) != None )
                bWillKill = gPawn(Owner).Health < DamageTotal;

            return;
        }
    }

    // Otherwise die
    Destroy();
}

function Update( float Seconds, class<DamageType> NewDamageType, float NewDamage, float NewTimer, Pawn NewInstigator )
{
    //gLog( "Update" #Seconds #GON(NewDamageType) #NewDamage #NewTimer #GON(NewInstigator) );

    DamagePerSecond = NewDamage / NewTimer;
    DamageTotal += DamagePerSecond * Seconds;
    DamageTimer = NewTimer;
    DamageType = NewDamageType;

    if( TimerRate == 0.0 )
        SetTimer(DamageTimer, True);

    if( gPawn(Owner) != None )
        bWillKill = Pawn(Owner).Health < DamageTotal;

    Instigator = NewInstigator;
    if( Instigator != None )
        InstigatorController = Instigator.Controller;

    if( gPawn(Owner) != None && gPlayer(gPawn(Owner).Controller) != None )
        gPlayer(gPawn(Owner).Controller).ClientAmbientOverlay(AcidOverlayClass);
}

final static function gAcidTimer GetAcidTimer( Actor A, optional bool bSpawn )
{
    local int i;

    if( A != None )
    {
        for( i=0; i!=A.Attached.Length; ++i )
            if( gAcidTimer(A.Attached[i]) != None )
                return gAcidTimer(A.Attached[i]);

        if( bSpawn )
            return A.Spawn(default.class, A);
    }
    return None;
}

final static function DecreaseAcidTimer(Actor A, float Amount)
{
    local int i;
    local gAcidTimer T;

    if( Amount != 0 )
    {
        for( i=0; i!=A.Attached.Length; ++i )
        {
            T = gAcidTimer(A.Attached[i]);
            if( T != None )
            {
                if( Amount > 0 )
                    T.DamageTotal -= T.DamagePerSecond * Amount;
                else
                    T.Destroy();
                return;
            }
        }
    }
}

simulated function string gDebugString()
{
    local string S;

    S = "" #DamagePerSecond #DamageTotal #DamageTimer #GON(DamageType) #TimerRate #TimerCounter;
    return S;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    AcidVolume              = 2.0
    AcidEndSound            = Sound'G_Sounds.acid_fizz_end1'
    AcidOverlayClass        = class'GEffects.gOverlay_Acid'


    // Actor
    AmbientSound            = Sound'G_Sounds.acid_fizz_loop1'
    SoundVolume             = 255
    SoundRadius             = 384
    SoundPitch              = 64

    bDynamicLight           = True
    LightType               = LT_Steady
    LightEffect             = LE_NonIncidence
    LightPeriod             = 0
    LightBrightness         = 127
    LightHue                = 80
    LightSaturation         = 0
    LightRadius             = 8
}