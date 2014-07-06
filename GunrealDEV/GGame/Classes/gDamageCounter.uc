// ============================================================================
//  gDamageCounter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDamageCounter extends gBasedActor;


struct DamageInfo
{
    var Controller Instigator;
    var int Damage;
};

var array<DamageInfo> Damages;


// ============================================================================
//  Damage Counter
// ============================================================================

event PostBeginPlay()
{
    //gLog( "PostBeginPlay" );

    Super.PostBeginPlay();
    if( bDeleteMe )
        return;

    // Schedule cleanup
    SetTimer(60,True);
}

function PawnBaseDied()
{
    // Don't self-destruct when pawn dies
}

final function AddDamage( Pawn Injured, int Damage, Controller InstigatorController )
{
    local int i;
    local DamageInfo DI;
    local Vehicle VehicleBase;

    //gLog( "AddDamage" #GON(Attacker) #Damage #GON(Owner) );

    if( Injured != None && InstigatorController != None && Damage > 0 )
    {
        // If it's a turret, get base vehicle
        if( Vehicle(Injured) != None )
        {
            VehicleBase = Vehicle(Injured).GetVehicleBase();
            if( VehicleBase != None )
                Injured = VehicleBase;
        }

        // Clamp damage to health left
        Damage = FClamp(Damage, 0, Injured.Health);

        // Update if exists
        for( i=Damages.Length-1; i>=0; --i )
        {
            if( Damages[i].Instigator == InstigatorController )
            {
                Damages[i].Damage += Damage;
                return;
            }
        }

        // Otherwise append new
        DI.Instigator = InstigatorController;
        DI.Damage = Damage;
        Damages[Damages.Length] = DI;
    }
}

event Timer()
{
    local int i;

    // Remove outdated entries
    for( i=0; i<Damages.Length; ++i )
        if( Damages[i].Instigator == None )
            Damages.Remove(i--,1);
}

function ResetDamage()
{
    Damages.Length = 0;
}

final static function gDamageCounter GetCounter( Pawn P, optional bool bSpawn )
{
    local int i;

    if( P != None )
    {
        for( i=0; i!=P.Attached.Length; ++i )
            if( gDamageCounter(P.Attached[i]) != None )
                return gDamageCounter(P.Attached[i]);

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
    RemoteRole      = ROLE_None
}
