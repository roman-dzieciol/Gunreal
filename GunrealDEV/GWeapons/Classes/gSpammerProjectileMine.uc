// ============================================================================
//  gSpammerProjectileMine.uc ::
// ============================================================================
class gSpammerProjectileMine extends gSpammerProjectileBase;


var() rotator           JumpRotRand;

var   float             ChainReactionTime;
var() float             DisturbChance;


simulated event PreBeginPlay()
{
    // Disable collision on client and temporarily on server
    SetCollision(False);
    SetCollisionSize(0, 0);
    bProjTarget = False;

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
        // Attach
        if( NewBase != None )
        {
            BaseOffset = (Location - NewBase.Location) << NewBase.Rotation;
            SetHardBase(NewBase, BaseOffset);
        }

        // Create proximity fuse
        Spawn(class'gSpammerFuse', Self,,, rot(0,0,0));

        // Create fear spot for AI
        if( Level.Game.NumBots > 0 && Base != None && Base.bWorldGeometry )
            Spawn(class'gSpammerAvoidMarker', Self,,, rot(0,0,0));

        // Enable collision
        SetCollision(True);
        SetCollisionSize(default.collisionRadius, default.CollisionHeight);
        bProjTarget = True;
    }
}

event TakeDamage(int Damage, Pawn InstigatedBy, vector HitLocation, vector Momentum, class<DamageType> DamageType)
{
    if( Role == ROLE_Authority && Damage > 0 && !bDeleteMe )
    {
        if( DamageType == MyDamageType )
        {
            // Damage caused by other spam mines may cause this one to jump
            if( Level.TimeSeconds > ChainReactionTime )
            {
                if( FRand() < DisturbChance )
                {
                    SetupInstigator(InstigatedBy);
                    DelayedDetonate();
                }
                else
                    ChainReactionTime = Level.TimeSeconds + default.ChainReactionTime;
            }
        }
        else if( Damage >= Health )
        {
            // Explode when hit hard enough
            SetupInstigator(InstigatedBy);
            Hit(Base, Location, vector(Rotation));
        }
        else
        {
            // Jump when hit lightly
            SetupInstigator(InstigatedBy);
            DelayedDetonate();
        }
    }
}

singular function ProximitySetOff( Pawn InstigatedBy, class<DamageType> DamageType )
{
    // Detonate on proximity damage
    if( bCanBeDamaged )
        DelayedDetonate();
}


event Trigger( Actor Other, Pawn EventInstigator )
{
    // Detonate on trigger
    DelayedDetonate();
}

final function rotator GetJumperRotation()
{
    local rotator R;
    local vector X,Y,Z;

    // Create random rotation in local space
    R.Pitch = RandRange( -JumpRotRand.Pitch, JumpRotRand.Pitch );
    R.Yaw = RandRange( -JumpRotRand.Yaw, JumpRotRand.Yaw );
    R.Roll = RandRange( -JumpRotRand.Roll, JumpRotRand.Roll );

    // Return randomized rotation
    GetAxes(R,X,Y,Z);
    X = X >> Rotation;
    Y = Y >> Rotation;
    Z = Z >> Rotation;
    return OrthoRotation(X,Y,Z);
}

state DelayedDetonating
{
    ignores TakeDamage, Touch, HitWall, Landed, EncroachedBy, BaseChange, Trigger;

Begin:
    //gLog("Begin");
    bCanBeDamaged = False;
    Sleep( RandRange(DetonateDelay.Min, DetonateDelay.Max) );
    Stick(Base, Location, vector(Rotation));
}

simulated function AlignTo(Actor Other, out vector HitLocation, out vector HitNormal, out rotator HitRotation)
{
    local rotator R;
    local vector X,Y,Z;

    // Create random rotation in local space
    R.Pitch = RandRange( -JumpRotRand.Pitch, JumpRotRand.Pitch );
    R.Yaw = RandRange( -JumpRotRand.Yaw, JumpRotRand.Yaw );
    R.Roll = RandRange( -JumpRotRand.Roll, JumpRotRand.Roll );

    // Calc randomized rotation
    GetAxes(R,X,Y,Z);
    X = X >> Rotation;
    Y = Y >> Rotation;
    Z = Z >> Rotation;
    HitRotation = OrthoRotation(X,Y,Z);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    ChainReactionTime               = 1.0
    DisturbChance                   = 0.12
    JumpRotRand                     = (Pitch=2048,Yaw=2048,Roll=0)


    // gProjectile
    bProximitySetOff                = True
    Health                          = 40
    DetonateDelay                   = (Min=0.05,Max=0.25)

    SpawnSound                      = Sound'G_Proc.sp_p_stick'
    SpawnSoundVolume                = 1.0
    SpawnSoundRadius                = 192
    SpawnSoundSlot                  = SLOT_Interact

    AttachmentClass                 = class'GEffects.gSpamEmitterGreen'
    MineClass                       = class'gSpammerProjectileExtra'


    // Projectile
    bNoFX                           = True
    Speed                           = 0


    // Actor
    bCanBeDamaged                   = True
    bProjTarget                     = True
    Physics                         = PHYS_None
    bCollideWorld                   = False
    LifeSpan                        = 0
    bNetNotify                      = True

    StaticMesh                      = StaticMesh'G_Meshes.Projectiles.spam_chargenew1'
    PrePivot                        = (X=48)
}