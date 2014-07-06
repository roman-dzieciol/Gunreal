// ============================================================================
//  gInstantFire.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gInstantFire extends gWeaponFIre;

var() class<DamageType> DamageType;

var() int               DamageMin;
var() int               DamageMax;
var() float             DamageRadius;
var() bool              bDamageRadius;

var() bool              bHeadShots;
var() float             DamageAttenHeadShot;
var() class<DamageType> DamageTypeHeadShot;

var() float             TraceRange;
var() float             Momentum;
var() bool              bBeamEffect;

var() float             ObjectiveDamageScaling;


// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.DamageType);
    S.PrecacheObject(default.DamageTypeHeadShot);
}

// ============================================================================
// Firing
// ============================================================================
simulated function vector GetFireStart(vector X, vector Y, vector Z)
{
    local vector V;

    V = Instigator.Location + Instigator.EyePosition();

    return V;
}

function DoFireEffect()
{
    local vector X,Y,Z, StartTrace;
    local rotator AimRot;
    local float Alpha;

    Instigator.MakeNoise(1.0);

    // The to-hit trace always starts right in front of the eye
    Weapon.GetViewAxes(X, Y, Z);
    StartTrace = GetFireStart(X, Y, Z);
    AimRot = AdjustAim(StartTrace, AimError);

    // Weapon accuracy cone
    if( bAccuracyBase )
        Alpha += 1;

    if( bAccuracyRecoil )
        Alpha += AccuracyRecoil * AccuracyMultRecoil;

    if( bAccuracyStance && gPawn(Instigator) != None )
        Alpha += gPawn(Instigator).InaccuracyXhairStance * AccuracyMultStance;

    if( Alpha != 0 )
    {
        if( bAccuracyCentered )
            AimRot = rotator(vector(AimRot) + AccuracyBase*Alpha*VRand()*FRand());
        else
            AimRot = rotator(vector(AimRot) + AccuracyBase*Alpha*VRand());
    }

    // Fire
    DoTrace(StartTrace, AimRot);

    // Add recoil
    AccuracyRecoil = FMin(1, AccuracyRecoil + (1/AccuracyRecoilShots) ) + (FireRate / AccuracyRecoilRegen);
}

function DoTrace(vector Start, rotator Dir)
{
    local vector X, End, HitLocation, HitNormal, RefNormal;
    local Actor Other;
    local int Damage, ReflectNum;
    local bool bDoReflect;
    local gTracingAttachment Attachment;
    local Material HitMaterial;

    MaxRange();
    ReflectNum = 0;
    Attachment = gTracingAttachment(Weapon.ThirdPersonActor);

    //Spawn(class'gDummy',,,Start);

    while( True )
    {
        bDoReflect = False;
        X = vector(Dir);
        End = Start + TraceRange * X;
        Other = Weapon.Trace(HitLocation, HitNormal, End, Start, True,, HitMaterial);

        if( Other != None && (Other != Instigator || ReflectNum > 0) )
        {
            if( bReflective && Other.IsA('xPawn') && xPawn(Other).CheckReflect(HitLocation, RefNormal, DamageMin*0.25) )
            {
                bDoReflect = True;
                HitNormal = vect(0,0,0);
            }
            else if( !Other.bWorldGeometry )
            {
                // Calc damage
                if( DamageMin != DamageMax && FRand() > 0.5 )
                    Damage = (DamageMin + Rand(1 + DamageMax - DamageMin)) * DamageAtten;
                else
                    Damage = DamageMin * DamageAtten;

                if( GameObjective(Other) != None )
                    Damage *= ObjectiveDamageScaling;

                // Update hit effect
                if( !Other.IsA('HitScanBlockingVolume') )
                    Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);

                // Apply damage
                if(bHeadShots
                    && ((Vehicle(Other) != None && Vehicle(Other).CheckForHeadShot(HitLocation, X, 1.0) != None)
                    || (Pawn(Other) != None && Pawn(Other).IsHeadShot(HitLocation, X, 1.0))))
                    Other.TakeDamage(Damage*DamageAttenHeadShot, Instigator, HitLocation, Momentum*X, DamageTypeHeadShot);
                else
                    Other.TakeDamage(Damage, Instigator, HitLocation, Momentum*X, DamageType);

                HitNormal = vect(0,0,0);
            }
            else
            {
                 if( Attachment != None )
                    Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);
            }

            // see if hit should set off some projectiles
            CheckSetOff(HitLocation);

            // If pawn's dead, stop tracing
            if( Weapon == None )
                return;
        }
        else
        {
            HitLocation = End;
            HitNormal = vect(0,0,0);

             if( Attachment != None )
                Attachment.SetHitData(Other, HitLocation, HitNormal, HitMaterial);
        }

        if( bBeamEffect )
            SpawnBeamEffect(Start, Dir, HitLocation, HitNormal, ReflectNum);

        if( bDoReflect && ++ReflectNum < 4 )
        {
            //Log("reflecting off"@Other@Start@HitLocation);
            Start = HitLocation;
            Dir = rotator(RefNormal); //rotator( X - 2.0*RefNormal*(X dot RefNormal) );
        }
        else
        {
            break;
        }
    }
}

function CheckSetOff(vector HitLocation)
{
    local gProjectile P;

    if( Weapon == None )
        return;

    foreach Weapon.CollidingActors(class'gProjectile', P, class'gProjectile'.default.SetOffDistance, HitLocation)
    {
        //gLog("CheckSetOff -" #GON(P) #P.bDeleteMe #GON(Weapon) #Weapon.bDeleteMe );
        if( P.bProximitySetOff && P.SetOffDistance > VSize(HitLocation - P.Location) - P.CollisionRadius )
        {
            P.ProximitySetOff(Instigator, DamageType);
            if( Weapon == None )
                break;
        }
    }
}

function float MaxRange()
{
    if( Instigator.Region.Zone.bDistanceFog && Instigator.Region.Zone.DistanceFogEnd > 8000 )
        TraceRange = FMin(default.TraceRange, Instigator.Region.Zone.DistanceFogEnd);
    else
        TraceRange = default.TraceRange;

    return TraceRange;
}

function SpawnBeamEffect(vector Start, rotator Dir, vector HitLocation, vector HitNormal, int ReflectNum);

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    ObjectiveDamageScaling  = 1.0
    Momentum                = 10000
    TraceRange              = 16384
    DamageAttenHeadShot     = 1
    NoAmmoSound             = Sound'WeaponSounds.P1Reload5'
    bInstantHit             = True
    WarnTargetPct           = 0.66
}
