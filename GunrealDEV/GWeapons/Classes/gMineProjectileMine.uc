// ============================================================================
//  gMineProjectileMine.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMineProjectileMine extends gMineProjectileBase;


var() float                     DeployTime;

var() Sound                     ArmedSound;
var() float                     ArmedSoundVolume;
var() float                     ArmedSoundRadius;
var() ESoundSlot                ArmedSoundSlot;

var() localized string          FriendlyText;
var() localized string          EnemyText;

static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.ArmedSound);
}

simulated event PreBeginPlay()
{
    // Disable collision on client and temporarily on server
    SetCollision(False);
    SetCollisionSize(0, 0);

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
        Spawn(class'gMineFuse', Self,,, rot(0,0,0));

        // Create fear spot for AI
        if( Level.Game.NumBots > 0 && Base != None && Base.bWorldGeometry )
            Spawn(class'gMineAvoidMarker', Self,,, rot(0,0,0));

        // Enable collision
        SetCollision(True);
        SetCollisionSize(default.collisionRadius, default.CollisionHeight);
    }
}

singular function ProximitySetOff( Pawn InstigatedBy, class<DamageType> DamageType )
{
    //gLog( "ProximitySetOff" #GON(InstigatedBy) #GON(DamageType) );

    // Detonate on proximity damage
    if( bCanBeDamaged )
        DelayedDetonate();
}

auto simulated state Deploying
{
    final simulated function Deployed()
    {
        //gLog("Deployed");
        if( ArmedSound != None )
            PlaySound(ArmedSound, ArmedSoundSlot, ArmedSoundVolume,, ArmedSoundRadius);

        if( Attachment != None )
            Attachment.Trigger(Self,None);
    }

Begin:
    if( Level.NetMode != NM_DedicatedServer )
    {
        Sleep(DeployTime);
        Deployed();
    }
}

simulated event PostRender2D(Canvas C, float ScreenLocX, float ScreenLocY)
{
    local PlayerController PC;
    local string S;
    local float W,H;
    local vector TS;

    // Fast relevancy check
    PC = Level.GetLocalPlayerController();
    if( PC != None && PC.Pawn != None && VSize(Location - PC.Pawn.Location) < 384 && Instigator != None && PC.MyHUD != None )
    {
        // Draw if under crosshair
        TS = PC.Pawn.Location + PC.Pawn.EyePosition();
        if( vector(PC.GetViewRotation()) dot Normal(Location - TS) > 0.99 && FastTrace(Location, TS) )
        {
            // Get identification
            if( InstigatorController == PC )
            {
                // Friendly
                C.SetDrawColor(0,255,0,255);
                S = FriendlyText;
            }
            else if( Instigator.GetTeamNum() != PC.GetTeamNum()
                 ||( PC.GameReplicationInfo != None && !PC.GameReplicationInfo.bTeamGame))
            {
                // Other team or DM
                C.SetDrawColor(255,0,0,255);
                S = EnemyText;
            }
            else
            {
                // Same team
                C.SetDrawColor(255,255,255,255);
                S = FriendlyText;
            }

            // Draw
            C.Style = 5;
            C.ColorModulate = C.default.ColorModulate;
            C.Font = PC.MyHUD.GetConsoleFont(C);
            C.TextSize(S, W, H);
            C.SetPos(ScreenLocX - W * 0.5, ScreenLocY - H * 0.5);
            C.DrawText(S);
        }
    }
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    FriendlyText                    = "Friendly Mine"
    EnemyText                       = "Enemy Mine"

    DeployTime                      = 0.3

    ArmedSound                      = Sound'G_Sounds.cg_mine_armed'
    ArmedSoundVolume                = 0.6
    ArmedSoundRadius                = 230
    ArmedSoundSlot                  = SLOT_None


    // gProjectile
    AttachmentClass                 = class'GEffects.gMineBeepEmitterRed'
    bProximitySetOff                = True
    SetOffDistance                  = 32


    // Projectile
    bNoFx                           = True
    Speed                           = 0
    bScriptPostRender               = True


    // Actor
    bCanBeDamaged                   = True
    bProjTarget                     = True
    Physics                         = PHYS_None
    bCollideWorld                   = False
    LifeSpan                        = 0
    bOnlyDirtyReplication           = True
    bAlwaysRelevant                 = True
    bNetNotify                      = True
}