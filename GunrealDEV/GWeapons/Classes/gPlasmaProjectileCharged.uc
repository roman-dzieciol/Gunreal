// ============================================================================
//  gPlasmaProjectileCharged.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaProjectileCharged extends gPlasmaProjectileBase;


var()   float                   StickyTime;


simulated event PreBeginPlay()
{
    if( Role == ROLE_Authority )
    {
        // Stick timeout
        StickyTime = Level.TimeSeconds + default.StickyTime;
    }
    else
    {
        // Disable collision on client
        SetCollision(False);
        bProjTarget = False;
        bCollideWorld = False;
    }

    Super.PreBeginPlay();
}

simulated singular event HitWall(vector HitNormal, Actor Other)
{
    //gLog( "HitWall" #GON(Other) #HitNormal );

    if( Role == ROLE_Authority )
    {
        // Explode on vehicles or if can't stick anymore
        if( Vehicle(Other) != None || StickyTime < Level.TimeSeconds )
            Hit(Other, Location, HitNormal);

        // Stick on everything else
        else
            Stick(Other, Location, HitNormal);
    }
}

simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "TouchTarget" #GON(Other) #HitLocation #HitNormal );

    if( Role == ROLE_Authority )
    {
        // Ignore gibs
        //if( Gib(Other) != None )
        //    return;

        // Reflect off some things
        if( CheckReflect(Other, HitLocation, HitNormal) )
            return;

        // Explode on touch
        Hit(Other, HitLocation, HitNormal);
    }
}

simulated function Hit( Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "Hit" #GON(Other) #bDeleteMe #bHitting );

    if( Role == ROLE_Authority && !bDeleteMe && !bHitting )
    {
        bHitting = True;
        bCanBeDamaged = False;

        // If actor can be healed, don't damage it
        if( !HealActor(Other, Damage, HitLocation, HitNormal) )
        {
            // Fly through Pawns
            if( Pawn(Other) != None )
            {
                // Don't touch this pawn again
                IgnoreActor = Other;

                // Deal only direct damage
                DamageRadius = 0;
                DealDamage( Other, HitLocation, HitNormal );

                // Continue flying if pawn was killed
                if( Pawn(Other) == None || Pawn(Other).Health <= 0 )
                {
                    bHitting = default.bHitting;
                    bCanBeDamaged = default.bCanBeDamaged;
                    DamageRadius = default.DamageRadius;
                    return;
                }
                else
                    HitEffects( Other, HitLocation, HitNormal );
            }
            else
            {
                HitEffects( Other, HitLocation, HitNormal );
                DealDamage( Other, HitLocation, HitNormal );
            }
        }
        Destroy();
    }
}

simulated function AlignTo(Actor Other, out vector HitLocation, out vector HitNormal, out rotator HitRotation)
{
    local vector X,Y,Z;
    local vector HL, HN, Offset;

    //gLog( "AlignTo" #Other #HitLocation #HitNormal #HitRotation #VSize(Velocity) );

    // Align to mover
    if( Mover(Other) != None )
    {
        Offset = FMax(VSize(Other.Velocity), VSize(Velocity)) * 2.0 * Normal(Velocity-Other.Velocity);
        if( !Other.TraceThisActor(HL, HN, HitLocation+Offset, HitLocation-Offset, GetCollisionExtent()) )
        {
            HitLocation = HL;
            HitNormal = HN;
        }
    }

    // Offset by collision radius distance extended to AABB bounds.
    if( TerrainInfo(Other) == None )
        HitLocation -= HitNormal * CollisionRadius * FMin(Abs(1.0/HitNormal.X), FMin(Abs(1.0/HitNormal.Y), Abs(1.0/HitNormal.Z)));

    // Get "forward" rotation from "up" normal
    if( Abs(HitNormal dot vect(0,0,1)) > 0.999 )
    {
        HitRotation = rot(0,0,0);
    }
    else
    {
        Z = HitNormal;
        Y = Normal(vect(0,0,1) Cross Z);
        X = Normal(Y Cross Z);
        HitRotation = OrthoRotation(X,Y,Z);
    }
}

DefaultProperties
{
    StickyTime                  = 0.33


    // gPlasmaProjectileBase
    BoostEffectClass            = Class'GEffects.gPlasmaBoostEmitterBig'
    HealEffectClass             = Class'GEffects.gPlasmaBoostEmitterBig'

    HealSound                   = Sound'G_Sounds.pl_boost_mech'
    BoostSound                  = Sound'G_Sounds.pl_boost_mech'



    // gProjectile
    ExtraDamage                 = 28

    AttachmentClass             = Class'GEffects.gPlasmaEmitterCharged'
    HitEffectClass              = Class'GEffects.gPlasmaExplosionCharged'
    MineClass                   = class'gPlasmaProjectileMine'
    ReflectSound                = Sound'G_Sounds.hrl_plasma_deflect2'


    // Projectile
    Speed                       = 2048
    Damage                      = 90
    DamageRadius                = 256
    MomentumTransfer            = 75000
    MyDamageType                = Class'gDamTypePlasmaBallCharged'

    ImpactSound                 = Sound'G_Proc.pl_p_alt_explode'
    ImpactSoundVolume           = 2.0
    ImpactSoundRadius           = 500

    ExplosionDecal              = class'GEffects.gPlasmaScorchCharged'
    ExploWallOut                = 5
    MaxEffectDistance           = 8000


    // Actor
    CollisionRadius             = 8
    CollisionHeight             = 8
    bSwitchToZeroCollision      = True

    SoundRadius                 = 192
    AmbientSound                = Sound'G_Sounds.pl_ballfly'
    TransientSoundRadius        = 300.0
}
