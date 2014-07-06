// ============================================================================
//  gRegenTimer.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRegenTimer extends gBasedActor;


var() float                 HealAmount;
var() float                 HealRate;
var() class<DamageType>     HealType;
var() float                 HealMax;
var() float                 DamagePause;
var() class<Emitter>        RegenEmitterClass;
var   gPawn                 PawnOwner;
var   float					SavedHealthMax;


// ============================================================================
//  Regen Timer
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.HealType);
    S.PrecacheObject(default.RegenEmitterClass);
}

event PostBeginPlay()
{
    Super.PostBeginPlay();
    if( bDeleteMe )
        return;

    PawnOwner = gPawn(Owner);
    SavedHealthMax = PawnOwner.HealthMax;
    PawnOwner.HealthMax = HealMax;
    PawnOwner.RegenPauseTime = -DamagePause;
    SetTimer(HealRate,True);
}

event Destroyed()
{
	if(	Pawn(Owner) != None )
	{
		Pawn(Owner).HealthMax = SavedHealthMax;
	}

	Super.Destroyed();
}

event Timer()
{
    local float Amount;

    if( PawnOwner.Health < HealMax )
    {
        // Don't heal over HealMax
        Amount = FMin( HealAmount, HealMax - PawnOwner.Health );

        // If regen isn't stopped
        if( PawnOwner.RegenPauseTime + DamagePause <= Level.TimeSeconds )
        {
            // Heal
            if( PawnOwner.HealDamage(Amount, PawnOwner.Controller, HealType) )
            {
                PawnOwner.Spawn(RegenEmitterClass, PawnOwner);
            }
        }

        // Otherwise wait until regen can be active
        else
        {
            GotoState('Waiting');
            SetTimer( (PawnOwner.RegenPauseTime + DamagePause) - Level.TimeSeconds, False );
        }
    }
}

state Waiting
{
    event Timer()
    {
        GotoState('');
        SetTimer(HealRate, True);
    }
}

final static function gRegenTimer GetActor( Pawn P, optional bool bSpawn )
{
    local int i;

    if( P != None )
    {
        for( i=0; i!=P.Attached.Length; ++i )
            if( gRegenTimer(P.Attached[i]) != None )
                return gRegenTimer(P.Attached[i]);

        if( bSpawn )
            return P.Spawn(default.class, P);
    }
    return None;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    DamagePause                 = 5
    HealMax                     = 150
    HealAmount                  = 15
    HealRate                    = 2.0
    HealType                    = Class'gDamTypeRegenHeal'
    RegenEmitterClass           = class'GEffects.gRegenEmitter'


    // Actor
    RemoteRole                  = ROLE_None
}
