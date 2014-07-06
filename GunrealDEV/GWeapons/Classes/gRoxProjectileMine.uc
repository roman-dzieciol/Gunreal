// ============================================================================
//  gRoxProjectileMine.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gRoxProjectileMine extends gRoxProjectileBase;


var() float         StickPawnTime;
var() float         StickWallTime;


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
        // Set time fuze
        if( Pawn(Base) != None )
            SetTimer( StickPawnTime, False );
        else
            SetTimer( StickWallTime, False );

        // Attach
        if( NewBase != None )
        {
            BaseOffset = (Location - NewBase.Location) << NewBase.Rotation;
            SetHardBase(NewBase, BaseOffset);
        }

        // Create proximity fuse
        Spawn(class'gRoxFuse', Self,,, rot(0,0,0));

        // Create fear spot for AI
        if( Level.Game.NumBots > 0 && Base != None && Base.bWorldGeometry )
            Spawn(class'gRoxAvoidMarker', Self,,, rot(0,0,0));

        // Enable collision
        SetCollision(True);
        SetCollisionSize(default.collisionRadius, default.CollisionHeight);
        bProjTarget = True;
    }
}

event Timer()
{
    // Time fuse
    Hit(Base, Location, vector(Rotation));
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    StickPawnTime           = 4
    StickWallTime           = 28


    // gProjectile
    bIgnoreTeamMates        = True
    bIgnoreController       = True
    bHitProjTarget          = False
    Health                  = 1


    // Projectile
    Speed                   = 0

    SpawnSound              = Sound'G_Sounds.rl_prox_stick1'
    SpawnSoundRadius        = 192


    // Actor
    CollisionRadius         = 12
    CollisionHeight         = 12
    bCanBeDamaged           = True
    bProjTarget             = True
    bCollideWorld           = False
    Physics                 = PHYS_None
    bNetNotify              = True

    StaticMesh              = StaticMesh'G_Meshes.Projectiles.rl_proj_prox'
    bUnlit                  = False
}
