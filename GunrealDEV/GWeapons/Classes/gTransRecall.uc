// ============================================================================
//  gTransRecall.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTransRecall extends gNoFire;

var() Sound                 TransFailedSound;

var   bool                  bGibMe;

var   Material              TransMaterials[2];

// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);

    S.PrecacheObject(default.TransFailedSound);

    S.PrecacheObject(default.TransMaterials[0]);
    S.PrecacheObject(default.TransMaterials[1]);
}

simulated function PlayFiring()
{
    if( TransLauncher(Weapon).bBeaconDeployed )
        Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
}

simulated function bool AllowFire()
{
    local bool success;

    success = (TransLauncher(Weapon).AmmoChargeF >= 1.0);

    if( !success && Weapon.Role == ROLE_Authority && TransLauncher(Weapon).TransBeacon != None )
    {
        if( PlayerController(Instigator.Controller) != None )
            PlayerController(Instigator.Controller).ClientPlaySound(TransFailedSound);
    }

    return success;
}

function bool AttemptTranslocation(vector dest, TransBeacon TransBeacon)
{
    local vector OldLocation, HitLocation, HitNormal;
    local Actor HitActor;

    OldLocation = Instigator.Location;

    if( !TranslocSucceeded(dest, TransBeacon) )
        return False;

    HitActor = Weapon.Trace(HitLocation,HitNormal,Instigator.Location, dest, False);

    if( HitActor == None || !HitActor.bBlockActors || !HitActor.bBlockNonZeroExtentTraces )
        return True;

    Instigator.SetLocation(OldLocation);

    return False;
}

function bool TranslocSucceeded(vector dest, TransBeacon TransBeacon)
{
    local vector newdest;

    if( Instigator.SetLocation(dest) || BotTranslocation() )
        return True;

    if( TransBeacon.Physics != PHYS_None )
    {
        newdest = TransBeacon.Location - Instigator.CollisionRadius * Normal(TransBeacon.Velocity);

        if( Instigator.SetLocation(newdest) )
            return True;
    }

    if( dest != Transbeacon.Location && Instigator.SetLocation(TransBeacon.Location) )
        return True;

    newdest = dest + Instigator.CollisionRadius * vect(1,1,0);

    if( Instigator.SetLocation(newdest) )
        return True;

    newdest = dest + Instigator.CollisionRadius * vect(1,-1,0);

    if( Instigator.SetLocation(newdest) )
        return True;

    newdest = dest + Instigator.CollisionRadius * vect(-1,1,0);

    if( Instigator.SetLocation(newdest) )
        return True;

    newdest = dest + Instigator.CollisionRadius * vect(-1,-1,0);

    if( Instigator.SetLocation(newdest) )
        return True;

    return False;
}

function Translocate()
{
    local TransBeacon TransBeacon;
    local Actor HitActor;
    local vector HitNormal,HitLocation,dest,Vel2D;
    local vector PrevLocation,Diff, NewDest;
    local xPawn XP;
    local controller C;
    local bool bFailedTransloc;
    local int EffectNum;
    local float DiffZ;

    if( Instigator == None || Translauncher(Weapon) == None )
        return;

    TransBeacon = TransLauncher(Weapon).TransBeacon;

    // gib if the translocator is disrupted
    if( TransBeacon.Disrupted() )
    {
        UnrealMPGameInfo(Level.Game).SpecialEvent(Instigator.PlayerReplicationInfo, "translocate_gib");
        bGibMe = True; // delay gib to avoid destroying player and weapons right away in the middle of all this
        return;
    }

    dest = TransBeacon.Location;

    if( TransBeacon.Physics == PHYS_None )
        dest += vect(0,0,1) * Instigator.CollisionHeight;
    else
        dest += vect(0,0,0.5) * Instigator.CollisionHeight;

    HitActor = Weapon.Trace(HitLocation, HitNormal, dest, TransBeacon.Location, True);

    if( HitActor != None )
        dest = TransBeacon.Location;

    TransBeacon.SetCollision(False, False, False);

    if( Instigator.PlayerReplicationInfo.HasFlag != None )
        Instigator.PlayerReplicationInfo.HasFlag.Drop(0.5 * Instigator.Velocity);

    PrevLocation = Instigator.Location;

    // verify won't telefrag teammate or recently spawned player
    for( C = Level.ControllerList; C != None; C = C.NextController )
    {
        if( C.Pawn != None && C.Pawn != Instigator )
        {
            Diff = Dest - C.Pawn.Location;
            DiffZ = Diff.Z;
            Diff.Z = 0;

            if( (Abs(DiffZ) < C.Pawn.CollisionHeight + 2 * Instigator.CollisionHeight )
                && (VSize(Diff) < C.Pawn.CollisionRadius + Instigator.CollisionRadius + 8))
            {
                if( C.SameTeamAs(Instigator.Controller) || (Level.TimeSeconds - C.Pawn.SpawnTime < Max(1, DeathMatch(Level.Game).SpawnProtectionTime)) )
                {
                    bFailedTransloc = True;
                    break;
                }
                else
                {
                    if( DiffZ > 1.5 * C.Pawn.CollisionHeight )
                    {
                        NewDest = Dest;
                        NewDest.Z += 0.7 * C.Pawn.CollisionHeight;
                    }
                    else
                    {
                        NewDest = Dest + 0.5 * C.Pawn.CollisionRadius * Normal(Diff);
                    }

                    if( Weapon.FastTrace(NewDest ,dest) )
                        Dest = NewDest;
                }
            }
        }
    }

    if( !bFailedTransloc && AttemptTranslocation(dest, TransBeacon) )
    {
        TransLauncher(Weapon).ReduceAmmo();

        // spawn out
        XP = xPawn(Instigator);

        if( XP != None )
            XP.DoTranslocateOut(PrevLocation);

        // bound XY velocity to prevent cheats
        Vel2D = Instigator.Velocity;
        Vel2D.Z = 0;
        Vel2D = Normal(Vel2D) * FMin(Instigator.GroundSpeed, VSize(Vel2D));
        Vel2D.Z = Instigator.Velocity.Z;
        Instigator.Velocity = Vel2D;

        if( Instigator.PlayerReplicationInfo.Team != None )
            EffectNum = Instigator.PlayerReplicationInfo.Team.TeamIndex;

        Instigator.SetOverlayMaterial(TransMaterials[EffectNum], 1.0, False);
        Instigator.PlayTeleportEffect(False, False);

        Instigator.HurtRadius(75, 450, class'gDamTypeTelefragged', 0, Instigator.Location);

        if( !Instigator.PhysicsVolume.bWaterVolume )
        {
            if( Bot(Instigator.Controller) != None )
            {
                Instigator.Velocity.X = 0;
                Instigator.Velocity.Y = 0;
                Instigator.Velocity.Z = -150;
                Instigator.Acceleration = vect(0,0,0);
            }

            Instigator.SetPhysics(PHYS_Falling);
        }

        if( UnrealTeamInfo(Instigator.PlayerReplicationInfo.Team)!= None )
            UnrealTeamInfo(Instigator.PlayerReplicationInfo.Team).AI.CallForBall(Instigator);  // for bombing run

    }
    else if( PlayerController(Instigator.Controller) != None )
    {
        PlayerController(Instigator.Controller).ClientPlaySound(TransFailedSound);
    }

    TransBeacon.Destroy();
    TransLauncher(Weapon).TransBeacon = None;
    TransLauncher(Weapon).ViewPlayer();
    TransLauncher(Weapon).bBeaconDeployed = False;
}

function ModeDoFire()
{
    local TransBeacon TransBeacon;

    Super.ModeDoFire();

    if( Weapon.Role == ROLE_Authority && bGibMe )
    {
        TransBeacon = TransLauncher(Weapon).TransBeacon;
        TransLauncher(Weapon).TransBeacon = None;
        TransLauncher(Weapon).ViewPlayer();
        Instigator.GibbedBy(TransBeacon.Disruptor);
        TransBeacon.Destroy();
        bGibMe = False;
    }
}

function DoFireEffect()
{
    if( TransLauncher(Weapon).TransBeacon != None )
        Translocate();
}

// AI Interface
function bool BotTranslocation()
{
    local Bot B;

    B = Bot(Instigator.Controller);

    if( B == None || !B.bPreparingMove || B.RealTranslocationTarget == None )
        return False;

    // if bot failed to translocate, event though beacon was in target cylinder,
    // try at center of cylinder
    return (Instigator.SetLocation(B.RealTranslocationTarget.Location));
}
// END AI interface

// ============================================================================
// DefaultProperties
// ============================================================================
defaultproperties
{
    AmmoClass                       = None
    AmmoPerFire                     = 0

    FireAnim                        = "trans-recall"
    FireRate                        = 0.25

    BotRefireRate                   = 0.3

    bWaitForRelease                 = False
    bModeExclusive                  = False

    TransMaterials(0)               = Material'PlayerTransRed'
    TransMaterials(1)               = Material'PlayerTrans'

    TransFailedSound                = Sound'WeaponSounds.BSeekLost1'
}