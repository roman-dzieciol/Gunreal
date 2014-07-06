// ============================================================================
//  gPlasmaProjectileMine.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasmaProjectileMine extends gPlasmaProjectileBase;


simulated event PreBeginPlay()
{
    // Disable collision on client and temporarily on server
    SetCollision(False);
    SetCollisionSize(0, 0);
    bProjTarget = False;

    // Play anim
    LoopAnim('Wobble');

    Super.PreBeginPlay();
}

simulated event PostNetReceive()
{
    //gLog( "PostNetReceive" );

    if( Role != ROLE_Authority )
    {
        // Rebase using accurate offset
        if( Base != None )
        {
            SetHardBase(Base, BaseOffset);
            bNetNotify = False;
        }
    }
}

simulated function InitMine(gProjectile Spawner, Actor NewBase)
{
    if( Role == ROLE_Authority )
    {
        // Boost DamageAtten
        Damage *= Spawner.Damage / Spawner.Default.Damage;

        // Attach
        if( NewBase != None )
        {
            BaseOffset = (Location - NewBase.Location) << NewBase.Rotation;
            SetHardBase(NewBase, BaseOffset);
        }

        // Create fear spot for AI
        if( Level.Game.NumBots > 0 && Base != None && Base.bWorldGeometry )
            Spawn(class'gPlasmaAvoidMarker', Self,,, rot(0,0,0));

        // Enable collision
        SetCollision(True);
        SetCollisionSize(default.collisionRadius, default.CollisionHeight);
        bProjTarget = True;
        IgnoreActor = None;
    }
}

simulated function TouchTarget(Actor Other, vector HitLocation, vector HitNormal)
{
    //gLog( "TouchTarget" #GON(Other) #HitLocation #HitNormal );

    // Ignore projectiles
    if( Projectile(Other) != None )
        return;

    // Ignore world
    if( Other.bWorldGeometry )
        return;

    Super.TouchTarget(Other, HitLocation, HitNormal);
}

event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    //gLog( "TakeDamage" #Damage #GON(InstigatedBy) #GON(DamageType) );

    if( Role == ROLE_Authority && Damage > 0 && Health > 0 && !bDeleteMe )
    {
        // Play take damage effects
        PlaySound(Sound'G_Sounds.pl_slap', SLOT_None);
        Spawn(class'gPlasmaProjectile'.default.HitEffectClass,,, HitLocation, rotator(Location-HitLocation));

        Super.TakeDamage(Damage, InstigatedBy, HitLocation, Momentum, DamageType);
    }
}

function HitEffects(Actor HitActor, vector HitLocation, vector HitNormal)
{
    local vector X,Y,Z;

    // Explode away from surface
    GetAxes(Rotation, X,Y,Z);
    Super.HitEffects(HitActor, HitLocation, Z);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    // gPlasmaProjectile
    BoostEffectClass                = Class'GEffects.gPlasmaBoostEmitterBig'
    HealEffectClass                 = Class'GEffects.gPlasmaBoostEmitterBig'
    HealSound                       = Sound'G_Sounds.pl_boost_mech'
    BoostSound                      = Sound'G_Sounds.pl_boost_mech'


    // gProjectile
    ExtraDamage                       = 28
    Health                          = 50
    DamageCurve                     = 3.0
    MomentumCurve                   = 0.33
    DetonateDelay                   = (Min=0.075,Max=0.2)

    bRegisterProjectile             = True
    bIgnoreTeamMates                = True
    bHitProjTarget                  = False

    AttachmentClass                 = Class'GEffects.gPlasmaEmitterMine'
    HitEffectClass                  = Class'GEffects.gPlasmaExplosionMine'


    // Projectile
    Damage                          = 150
    DamageRadius                    = 512
    MomentumTransfer                = 75000
    MyDamageType                    = Class'gDamTypePlasmaMine'

    SpawnSound                      = Sound'G_Proc.pl_p_altslap'

    ImpactSound                     = Sound'G_Proc.pl_p_altmine'
    ImpactSoundVolume               = 2.0
    ImpactSoundRadius               = 500

    ExplosionDecal                  = class'GEffects.gPlasmaScorchMine'
    ExploWallOut                    = 2
    MaxEffectDistance               = 8000


    // Actor
    CollisionRadius                 = 44
    CollisionHeight                 = 44
    bCanBeDamaged                   = True
    bProjTarget                     = True
    bCollideWorld                   = False
    Physics                         = PHYS_None
    bNetNotify                      = True

    Mesh                            = Mesh'GResources.pmine'
    Skins(0)                        = Material'G_FX.Plasmafx.plasmamine_test1'
    DrawType                        = DT_Mesh
    DrawScale                       = 0.4
    bUnlit                          = False

    AmbientSound                    = Sound'G_Sounds.pl_mine_hum'
}
