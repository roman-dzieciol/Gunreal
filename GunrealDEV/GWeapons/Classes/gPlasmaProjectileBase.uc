// ============================================================================
//  gPlasmaProjectileBase.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaProjectileBase extends gProjectile;


var()   float               HealMultiplier;

var()   class<Actor>        BoostEffectClass;
var()   class<Actor>        HealEffectClass;

var()   Sound               HealSound;
var()   float               HealSoundVolume;
var()   float               HealSoundRadius;
var()   ESoundSlot          HealSoundSlot;

var()   Sound               BoostSound;
var()   float               BoostSoundVolume;
var()   float               BoostSoundRadius;
var()   ESoundSlot          BoostSoundSlot;

var()   Sound               ReflectSound;
var()   float               ReflectSoundVolume;
var()   float               ReflectSoundRadius;
var()   ESoundSlot          ReflectSoundSlot;


static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.BoostEffectClass);
    S.PrecacheObject(default.HealEffectClass);

    S.PrecacheObject(default.HealSound);
    S.PrecacheObject(default.BoostSound);
    S.PrecacheObject(default.ReflectSound);

}

simulated function Hit( Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "Hit" #GON(Other) #bDeleteMe #bHitting );
    if( Role == ROLE_Authority && !bDeleteMe && !bHitting )
    {
        bHitting = True;
        if( !HealActor(Other, Damage, HitLocation, HitNormal) )
        {
            HitEffects(Other, HitLocation, HitNormal);
            DealDamage(Other, HitLocation, HitNormal);
        }
        Destroy();
    }
}

final function bool HealActor(Actor Other, float HealAmount, vector HitLocation, vector HitNormal)
{
    local Pawn P;
    local Actor HealTarget;

    //gLog( "HealActor" @Other.Name @DamageAmount @Other.TeamLink(InstigatorTeam) );

    if( Other != None )
    {
    	if( Level.Game.bTeamGame )
    	{
	        // Team
	        if( InstigatorTeam != None && Other.TeamLink(InstigatorTeam.TeamIndex) )
	        {
	            // Heal Destroyable Objectives
	            if( DestroyableObjective(Other) != None )
	                HealTarget = Other;
	
	            // Heal Vehicles
	            else if( Vehicle(Other) != None && Other.bProjTarget )
	                HealTarget = Other;
	
	            // Heal Power Node Shields
	            else if( DestroyableObjective(Other.Owner) != None )
	                HealTarget = Other.Owner;
	
	            // Do healing
	            if( HealTarget != None )
	            {
	                // Get healing amount
	                if( Instigator != None )
	                {
	                    HealAmount *= Instigator.DamageScaling;
	                    if( Instigator.HasUDamage() )
	                        HealAmount *= 2;
	                }
	                HealAmount *= HealMultiplier;
	
	                // Heal
	                HealTarget.HealDamage(HealAmount, InstigatorController, MyDamageType);
	                HealEffects(HealTarget, HitLocation, HitNormal);
	                return True;
	            }
	        }
	
	        // Boost team mates
	        P = Pawn(Other);
	        if( P != None
	        //&&  P != Instigator
	        &&  P.GetTeam() == InstigatorTeam
	        &&  gPlasmaGun(P.Weapon) != None )
	        {
	            gPlasmaGun(P.Weapon).AddBoost(HealAmount);
	            BoostEffects(Other, HitLocation, HitNormal);
	            return True;
	        }
        }
        
        if( gTurret(Other) != None 
		&& (gTurret(Other).Deployer == InstigatorController 
		|| (Level.Game.bTeamGame && InstigatorTeam != None && Other.TeamLink(InstigatorTeam.TeamIndex))) )
        {
        	// Deployer or teammates can heal with plasma
        	HealTarget = Other;
        	
            // Get healing amount
            if( Instigator != None )
            {
                HealAmount *= Instigator.DamageScaling;
                if( Instigator.HasUDamage() )
                    HealAmount *= 2;
            }
            HealAmount *= HealMultiplier;

            // Heal
            HealTarget.HealDamage(HealAmount, InstigatorController, MyDamageType);
            HealEffects(HealTarget, HitLocation, HitNormal);
            return True;
        }
    }

    return False;
}


final function bool CheckReflect(Actor Other, vector HitLocation, vector HitNormal)
{
    local vector X, RefNormal, RefDir;

    if( Role == ROLE_Authority && xPawn(Other) != None && xPawn(Other).CheckReflect(HitLocation, RefNormal, Damage*0.25) )
    {
        X = Normal(Velocity);
        RefDir = X - 2.0*RefNormal*(X dot RefNormal);
        RefDir = RefNormal;
        SetupInstigator(Pawn(Other));
        Spawn(Class,,, HitLocation+RefDir*20, rotator(RefDir));

        if( ReflectSound != None )
            PlaySound( ReflectSound, ReflectSoundSlot, ReflectSoundVolume, False, ReflectSoundRadius );

        Destroy();
        return True;
    }
    return False;
}

final function HealEffects(Actor HitActor, vector HitLocation, vector HitNormal)
{
    local Actor A;

    if( HealEffectClass != None )
    {
        A = Spawn(HealEffectClass, HitActor,, HitLocation, rotator(-HitNormal));
        if( A != None )
            A.SetBase(HitActor);
    }

    if( HealSound != None )
        PlaySound(HealSound, HealSoundSlot, HealSoundVolume, False, HealSoundRadius);
}

final function BoostEffects(Actor HitActor, vector HitLocation, vector HitNormal)
{
    local Actor A;

    if( BoostEffectClass != None )
    {
        A = Spawn(BoostEffectClass, HitActor,, HitLocation, rotator(-HitNormal));
        if( A != None )
            A.SetBase(HitActor);
    }

    if( BoostSound != None )
        PlaySound(BoostSound, BoostSoundSlot, BoostSoundVolume, False, BoostSoundRadius);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

    ReflectSound                = None
    ReflectSoundVolume          = 2.0
    ReflectSoundRadius          = 128
    ReflectSoundSlot            = SLOT_None

    BoostEffectClass        = None
    BoostSound              = Sound'G_Sounds.pl_boost'
    BoostSoundVolume        = 1.0
    BoostSoundRadius        = 400
    BoostSoundSlot          = SLOT_None

    HealMultiplier          = 2.0

    HealEffectClass         = None
    HealSound               = Sound'G_Sounds.pl_boost'
    HealSoundVolume         = 1.0
    HealSoundRadius         = 400
    HealSoundSlot           = SLOT_None


    // gProjectile
    ImpactSoundRadius       = 350

    ExtraDamageType         = Class'gDamTypePlasmaBall'


    // Actor
    bDynamicLight           = True
    LightType               = LT_Steady
    LightEffect             = LE_QuadraticNonIncidence
    LightPeriod             = 32
    LightBrightness         = 128
    LightHue                = 189
    LightSaturation         = 102
    LightRadius             = 16
}