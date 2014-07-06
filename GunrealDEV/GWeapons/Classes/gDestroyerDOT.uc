// ============================================================================
//  gDestroyerDOT.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDestroyerDOT extends gBasedActor;


//var() float                         AcidVolume;
//var() Sound                         AcidEndSound;
//var() class<gOverlayTemplate>       AcidOverlayClass;

var   bool                          bIdle;

var   float                         DamagePerSecond;
var   float                         DamageTotal;
var   float                         DamageTimer;
var   class<DamageType>             DamageType;

var   Controller                    InstigatorController;

var() float ObjectiveDamageScaling;

var float NextDamageTime;


simulated event PreBeginPlay()
{
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
//        gPawn(Owner).bAcidFX = True;
//        if( gPlayer(gPawn(Owner).Controller) != None )
//            gPlayer(gPawn(Owner).Controller).ClientAmbientOverlay(AcidOverlayClass);
    }
}

event Destroyed()
{
    //gLog( "Destroyed" );

    if( gPawn(Owner) != None )
    {
//        gPawn(Owner).bAcidFX = False;
//        Owner.PlaySound(AcidEndSound,SLOT_None,AcidVolume,,SoundRadius);
//        if( gPlayer(gPawn(Owner).Controller) != None )
//            gPlayer(gPawn(Owner).Controller).ClientFadeAmbientOverlay(AcidOverlayClass);
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

        if( GameObjective(Owner) != None )
            Damage *= ObjectiveDamageScaling;

        Owner.TakeDamage(Damage, Instigator, Owner.Location, vector(Owner.Rotation), DamageType);

        // Schedule another event
        if( DamageTotal >= 0 )
        {
            // Update timer if neccesary
            if( TimerRate != DamageTimer )
                SetTimer(DamageTimer, True);

            return;
        }
        else if( DamageTotal <= 0 )
        {
            // If this one was last stay around for a bit to let more updates come
            bIdle = True;
            SetTimer(1.0, True);
            return;
        }
    }

    // Otherwise die
    Destroy();
}


function Update( float Seconds, class<DamageType> NewDamageType, float NewDamagePerSecond, float NewTimer, Pawn NewInstigator )
{
    // Allow updates only if idle
    if( !bIdle )
        return;

    //gLog( "Update" #Seconds #GON(NewDamageType) #NewDamagePerSecond #NewTimer #GON(NewInstigator) );


    DamagePerSecond = NewDamagePerSecond;
    DamageTotal += DamagePerSecond * Seconds;
    DamageTimer = NewTimer;
    DamageType = NewDamageType;

    Instigator = NewInstigator;
    if( Instigator != None )
    {
        InstigatorController = Instigator.Controller;
    }

//    if( gPawn(Owner) != None && gPlayer(gPawn(Owner).Controller) != None )
//        gPlayer(gPawn(Owner).Controller).ClientAmbientOverlay(AcidOverlayClass);

    // Init timer if neccesary
    if( bIdle )
    {
        bIdle = False;
        SetTimer(DamageTimer, True);

        // Hit immediately
        Timer();
    }
}

final static function gDestroyerDOT GetDestroyerTimer( Actor A, optional bool bSpawn )
{
    local int i;

    if( A != None )
    {
        for( i=0; i!=A.Attached.Length; ++i )
            if( gDestroyerDOT(A.Attached[i]) != None )
                return gDestroyerDOT(A.Attached[i]);

        if( bSpawn )
            return A.Spawn(default.class, A);
    }
    return None;
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
    bIdle                       = True
    ObjectiveDamageScaling      = 1.0

    AmbientSound                = Sound'G_Proc.acd_p_tss'
    SoundVolume                 = 255
    SoundRadius                 = 64
    SoundPitch                  = 64

    bDynamicLight               = True
    LightType                   = LT_Steady
    LightEffect                 = LE_NonIncidence
    LightPeriod                 = 0
    LightBrightness             = 127
    LightHue                    = 30
    LightSaturation             = 0
    LightRadius                 = 8

    RemoteRole                  = ROLE_None
}
