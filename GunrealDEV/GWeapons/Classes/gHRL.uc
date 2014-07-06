// ============================================================================
//  gHRL.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRL extends gWeapon
    config(user);

// - Target Locking -----------------------------------------------------------

var   Actor                     HRLTarget;
var   bool                      bTarget;

var   bool                      bCanEngage;

var   float                     LockTime;
var   float                     UnLockTime;
var   float                     SeekCheckTime;
var   bool                      bBreakLock;

var() float                     SeekCheckFreq;
var() float                     SeekRange;
var() float                     LockRequiredTime;
var() float                     UnLockRequiredTime;
var() float                     LockAim;

// - Beacon Locking -----------------------------------------------------------

var   gHRLBeacon                BeaconLock;
var   float                     BeaconLockAngle;

// - Projectile Tracking ------------------------------------------------------

var   array<gHRLProjectile>     Rockets;
var   array<gHRLBeacon>         Beacons;
var() int                       MaxBeacons;

// - Crosshair ----------------------------------------------------------------

var() Color                     CrosshairColor;
var() float                     CrosshairX;
var() float                     CrosshairY;
var() Texture                   CrosshairTexture;

var   Texture                   BackupCrossHairTexture;

// - Shield -------------------------------------------------------------------

var() Sound                     ShieldHitSound;
var() float                     ShieldHitSoundVolume;
var() float                     ShieldHitSoundRadius;
var() ESoundSlot                ShieldHitSoundSlot;

var() Sound                     ShieldDeploySound;
var() float                     ShieldDeploySoundVolume;
var() float                     ShieldDeploySoundRadius;
var() ESoundSlot                ShieldDeploySoundSlot;

var() Sound                     ShieldBeginSound;
var() float                     ShieldBeginSoundVolume;
var() float                     ShieldBeginSoundRadius;
var() ESoundSlot                ShieldBeginSoundSlot;

var() Sound                     ShieldEndSound;
var() float                     ShieldEndSoundVolume;
var() float                     ShieldEndSoundRadius;
var() ESoundSlot                ShieldEndSoundSlot;

var() Sound                     ShieldUndeploySound;
var() float                     ShieldUndeploySoundVolume;
var() float                     ShieldUndeploySoundRadius;
var() ESoundSlot                ShieldUndeploySoundSlot;

var   class<Emitter>            ShieldClass;
var   Emitter                   Shield;
var   name                      ShieldBone;

var   float                     ShieldCharge;

var   class<Actor>              ShieldHitClass;
var   class<Actor>              ShieldHitProjectileClass;

// ----------------------------------------------------------------------------

var() Material                  HudIcon;
var() float                     HudIconScale;
var() Color                     HudIconColor;

var() Material                  HudIconLock;
var() float                     HudIconScaleLock;
var() Color                     HudIconColorLock;

var   Sound                     BeaconLockSound;

var   Material                  LockCrosshair;
var   Color                     LockCrosshairColor;

var() Sound                     EngageSound;
var() float                     EngageSoundVolume;
var() float                     EngageSoundRadius;
var() ESoundSlot                EngageSoundSlot;

var() Sound                     TriggerSound[2];
var() Sound                     TriggerNoAmmoSound[2];
var() float                     TriggerSoundVolume[2];
var() float                     TriggerSoundRadius[2];
var() Actor.ESoundSlot          TriggerSoundSlot[2];

var() float                     TriggerTime[2];
var() byte                      bTriggerPlayed[2];

//
//var() Sound               ReloadAltSound;
//var() Sound               ReloadAltNoAmmoSound;
//var() float               ReloadAltSoundVolume;
//var() float               ReloadAltSoundRadius;
//var() Actor.ESoundSlot    ReloadAltSoundSlot;

var() class<gHRLHoverSound>     HoverSoundClass;
var   gHRLHoverSound            HoverSound;

var int                         ShieldState;

var() Sound                     FirstReloadSound;
var() float                     FirstReloadSoundVolume;
var() float                     FirstReloadSoundRadius;
var() ESoundSlot                FirstReloadSoundSlot;

var   int                       ForceMode;
var   gHRLBeacon                LastBeacon;



// ============================================================================
//  Precache
// ============================================================================
static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.CrosshairTexture);
    S.PrecacheObject(default.BackupCrossHairTexture);
    S.PrecacheObject(default.HudIcon);
    S.PrecacheObject(default.HudIconLock);
    S.PrecacheObject(default.LockCrosshair);

    S.PrecacheObject(default.ShieldHitSound);
    S.PrecacheObject(default.BeaconLockSound);
    S.PrecacheObject(default.EngageSound);
    S.PrecacheObject(default.TriggerSound[0]);
    S.PrecacheObject(default.TriggerSound[1]);
    S.PrecacheObject(default.TriggerNoAmmoSound[0]);
    S.PrecacheObject(default.TriggerNoAmmoSound[1]);
    S.PrecacheObject(default.FirstReloadSound);

    S.PrecacheObject(default.ShieldClass);
    S.PrecacheObject(default.ShieldHitClass);
    S.PrecacheObject(default.ShieldHitProjectileClass);
    S.PrecacheObject(default.HoverSoundClass);
}

// ============================================================================
//  Replication
// ============================================================================
replication
{
    reliable if( Role < ROLE_Authority )
        ServerBeaconEngage, ServerTargetEngage;

    reliable if( Role == ROLE_Authority )
        bCanEngage, ShieldCharge;
}

// ============================================================================
//  Lifetime
// ============================================================================
simulated function RegisterProjectile( gProjectile P )
{
    local int i;

    //gLog( "RegisterProjectile" #GON(P) );

    // Take ownership
    P.ServerOwner = self;

    if( gHRLBeacon(P) != None )
    {
        // if too many beacons, kill first unused or oldest
        if( Beacons.Length >= MaxBeacons )
        {
            // remove first unused
            for( i=0; i<Beacons.Length; ++i )
            {
                if( Beacons[i] != None && Vehicle(Beacons[i].Base) == None )
                {
                    Beacons[i].Destroy();
                    break;
                }
            }

            // if none found then oldest
            if( Beacons.Length >= MaxBeacons )
            {
                if( Beacons[0] != None )
                    Beacons[0].Destroy();
                else
                    Beacons.Remove(0,1);
            }
        }

        // add to beacon list
        Beacons[Beacons.Length] = gHRLBeacon(P);

        // Track
        TrackBeacon(gHRLBeacon(P));
    }
    else if( gHRLProjectile(P) != None )
    {
        Rockets[Rockets.Length] = gHRLProjectile(P);
        bCanEngage = True;
    }
}

simulated function UnRegisterProjectile( gProjectile P )
{
    local int i;

    //gLog( "UnRegisterProjectile" #GON(P) );

    if( gHRLBeacon(P) != None )
    {
        for( i=0; i<Beacons.Length; ++i )
        {
            if( Beacons[i] == P )
            {
                Beacons.remove(i--,1);
                break;
            }
        }
    }
    else if( gHRLProjectile(P) != None )
    {
        for( i=0; i<Rockets.Length; ++i )
        {
            if( Rockets[i] == P )
            {
                Rockets.Remove(i--,1);
                break;
            }
        }

        if( Rockets.Length == 0 )
            bCanEngage = False;
    }
}

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( ShieldClass != None && Level.NetMode != NM_DedicatedServer )
        Shield = Spawn(ShieldClass, Self);

    if( Shield != None )
    {
        Shield.SetLocation(GetBoneCoords(ShieldBone).Origin);
        AttachToBone(Shield, ShieldBone);
    }
}


function GiveAmmo(int m, WeaponPickup WP, bool bJustSpawned)
{
    local bool bJustSpawnedAmmo;
    local int addAmount, InitialAmount;

    if( FireMode[m] != None && FireMode[m].AmmoClass != None )
    {
        Ammo[m] = Ammunition(Instigator.FindInventoryType(FireMode[m].AmmoClass));
        bJustSpawnedAmmo = False;

        if( bNoAmmoInstances )
        {
            if( (FireMode[m].AmmoClass == None) || ((m != 0) && (FireMode[m].AmmoClass == FireMode[0].AmmoClass)) )
                return;

            InitialAmount = FireMode[m].AmmoClass.Default.InitialAmount;
            if( WP != None )
            {
                InitialAmount = WP.AmmoAmount[m];
            }

            if( Ammo[m] != None )
            {
                addamount = InitialAmount + Ammo[m].AmmoAmount;
                Ammo[m].Destroy();
            }
            else
                addAmount = InitialAmount;

            AddAmmo(addAmount,m);

            // if empty add 2 seconds delay and play reload sound
            if( !bJustSpawned && m == 0 &&  AmmoCharge[m] == 0 &&  addAmount > 0 )
            {
                FireMode[m].NextFireTime = Level.TimeSeconds + 2;
                Instigator.PlaySound(FirstReloadSound, FirstReloadSoundSlot, FirstReloadSoundVolume,, FirstReloadSoundRadius);
            }
        }
        else
        {
            if( (Ammo[m] == None) && (FireMode[m].AmmoClass != None) )
            {
                Ammo[m] = Spawn(FireMode[m].AmmoClass, Instigator);
                Instigator.AddInventory(Ammo[m]);
                bJustSpawnedAmmo = True;
            }
            else if( (m == 0) || (FireMode[m].AmmoClass != FireMode[0].AmmoClass) )
                bJustSpawnedAmmo = ( bJustSpawned || ((WP != None) && !WP.bWeaponStay) );

            if((WP != None) && ((WP.AmmoAmount[0] > 0) || (WP.AmmoAmount[1] > 0)) )
            {
                addAmount = WP.AmmoAmount[m];
            }
            else if( bJustSpawnedAmmo )
            {
                addAmount = Ammo[m].InitialAmount;
            }

            Ammo[m].AddAmmo(addAmount);
            Ammo[m].GotoState('');
        }
    }
}

simulated event AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    if( ClientState == WS_ReadyToFire )
    {
        GetAnimParams(channel, anim, frame, rate);
        if( channel == 0 )
        {
            if( anim == 'deploy' && ShieldState == 1 )
            {
                LoopAnim('deployidle', 1.0, 0.2, 1);
                IdleAnim = 'deployidle';
                PlayIdle();
                if( Shield != None )
                    Shield.bHidden = ShieldCharge == 0;;

                Instigator.PlaySound(ShieldBeginSound, ShieldBeginSoundSlot, ShieldBeginSoundVolume,, ShieldBeginSoundRadius);
            }
            else if( (FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring) )
            {
                PlayIdle();
            }
        }
        else if( channel == 1 )
        {
            if( anim == 'retract' )
            {
                AnimBlendParams( 1, 0.0, 0.0, 0.0, 'HShield' );
            }
        }
    }
}

simulated event WeaponTick(float DT)
{
    local gHRLBeacon B, BestBeacon;
    local float Angle, BestAngle;
    local byte bAltFire, bFire, bTemp;
    local vector TS,TE;
    local Actor Other;
    local vector StartTrace;
    local rotator Aim;
    local float BestDist, BestAim, Dist;
    local Vehicle V;
    local int TeamCheck;

    if( Instigator == None )
        return;

    if( Instigator.IsLocallyControlled() && PlayerController(Instigator.Controller) != None )
    {
        if( Instigator.bWantsToCrouch )
        {
            if( ShieldState == 0 )
            {
                ShieldState = 1;
                PlayAnim('deploy', 1.0, 0.2);

                AnimBlendParams( 1, 1.0, 0.0, 0.0, 'HShield' );
                PlayAnim('deploy', 1.0, 0.2, 1);

                Instigator.PlaySound(ShieldDeploySound, ShieldDeploySoundSlot, ShieldDeploySoundVolume,, ShieldDeploySoundRadius);
            }

            if( Shield != None && ShieldCharge == 0 )
                Shield.bHidden = True;
        }
        else
        {
            if( ShieldState == 1 )
            {
                ShieldState = 0;
                PlayAnim('retract', 1.0, 0.2);

                PlayAnim('retract', 1.0, 0.2, 1);

                IdleAnim = default.IdleAnim;
                if( Shield != None )
                {
                    if(!Shield.bHidden)
                    {
                        Instigator.PlaySound(ShieldUndeploySound, ShieldUndeploySoundSlot, ShieldUndeploySoundVolume,, ShieldUndeploySoundRadius);
                        Instigator.PlaySound(ShieldEndSound, ShieldEndSoundSlot, ShieldEndSoundVolume,, ShieldEndSoundRadius);
                    }
                    Shield.bHidden = True;
                }
            }
        }

        // Beacon lock for Missiles
        BestAngle = BeaconLockAngle;
        for( B=class'gHRLBeacon'.default.BeaconList; B!=None; B=B.BeaconList )
        {
            TE = B.Location;
            TS = Instigator.Location + Instigator.EyePosition();
            if( FastTrace( TE, TS ) )
            {
                Angle = Normal(TE-TS) dot vector(Instigator.GetViewRotation());
                if( Angle > BestAngle )
                {
                    BestAngle = Angle;
                    BestBeacon = B;
                }
            }
        }

        if( BestBeacon != None )
        {
            if( BestBeacon != BeaconLock )
            {
                BeaconLock = BestBeacon;
                Instigator.AmbientSound = BeaconLockSound;
                //BackupCrossHairTexture = CustomCrossHairTexture;
                //CustomCrossHairTexture = CrosshairTexture;
            }
        }
        else
        {
            BeaconLock = None;
            Instigator.AmbientSound = None;
            //CustomCrossHairTexture = BackupCrossHairTexture;
        }

        // Trigger pull sounds logic
        if( ClientState == WS_ReadyToFire )
        {
            bAltFire = Instigator.Controller.bAltFire;
            bFire = Instigator.Controller.bFire;

            if( ExchangeFireModes == 1 )
            {
                bTemp = bFire;
                bFire = bAltFire;
                bAltFire = bTemp;
            }

            if( bTriggerPlayed[0] == 1 && bFire == 0 )
            {
               bTriggerPlayed[0] = 0;
            }

            if( bTriggerPlayed[1] == 1 && bAltFire == 0 )
            {
               bTriggerPlayed[1] = 0;
            }
        }

        // Target locking for Beacons
        if( Level.TimeSeconds > SeekCheckTime && PlayerController(Instigator.Controller) != None )
        {
            if( bBreakLock )
            {
                bBreakLock = False;
                bTarget = False;
                HRLTarget = None;
            }

            StartTrace = Instigator.Location + Instigator.EyePosition();
            Aim = Instigator.GetViewRotation();

            // TODO: Figure out why this doesn't work clientside
            //BestAim = LockAim;
            //Other = Instigator.Controller.PickTarget(BestAim, BestDist, vector(Aim), StartTrace, SeekRange);

            if( Level.GRI == None
            || !Level.GRI.bTeamGame)
            {
                TeamCheck = -1;
            }
            else
            {
                TeamCheck = Instigator.GetTeamNum();
            }

            BestAim = LockAim;
            foreach DynamicActors( class'Vehicle', V )
            {
                if( FastTrace( V.Location, StartTrace ) )
                {
                    Angle = vector(Aim) dot Normal(V.Location-StartTrace);
                    if( Angle > LockAim
                    &&  TeamCheck != int(V.Team)
                    &&  V.bDriving )
                    {
                        Dist = VSize(StartTrace-V.Location);
                        if( Dist > BestDist )
                        {
                            BestDist = Dist;
                            Other = V;
                        }
                    }
                }
            }

            if( Other != None )
            {
                if( Other == HRLTarget )
                {
                    LockTime += SeekCheckFreq;
                    if( !bTarget && LockTime >= LockRequiredTime )
                    {
                        bTarget = True;
                        PlayerController(Instigator.Controller).PlaySound(Sound'WeaponSounds.LockOn');
                     }
                }
                else
                {
                    HRLTarget = Other;
                    LockTime = 0.0;
                }
                UnLockTime = 0.0;
            }
            else
            {
                if( HRLTarget != None )
                {
                    UnLockTime += SeekCheckFreq;
                    if( UnLockTime >= UnLockRequiredTime )
                    {
                        HRLTarget = None;
                        if( bTarget )
                        {
                            bTarget = False;
                            PlayerController(Instigator.Controller).PlaySound(Sound'WeaponSounds.SeekLost');
                        }
                    }
                }
                else
                    bTarget = False;
             }

            SeekCheckTime = Level.TimeSeconds + SeekCheckFreq;
        }
    }

    if( Role == ROLE_Authority )
    {
        if( Instigator.bWantsToCrouch )
        {
            ShieldCharge = FMax(0,ShieldCharge-DT*5);
        }
        else
        {
            ShieldCharge = FMin(default.ShieldCharge,ShieldCharge+DT*5);
        }
    }
}

simulated event Destroyed()
{
    if( Role == ROLE_Authority )
    {
        if( HoverSound != None )
        {
            HoverSound.TearOff();
            HoverSound = None;
        }
    }

    if( Shield != None )
        Shield.Destroy();

    Super.Destroyed();
}


// ============================================================================
//  Firing
// ============================================================================

simulated event ClientStartFire(int Mode)
{
    if( Pawn(Owner).Controller.IsInState('GameEnded') ||  Pawn(Owner).Controller.IsInState('RoundEnded') )
        return;

    if( Mode == 1 )
    {
        if( BeaconLock != None && bCanEngage )
        {
            FireMode[1].bIsFiring = True;
            FireMode[1].bNowWaiting = True;

            ServerBeaconEngage(BeaconLock);
        }
        else if( Role < ROLE_Authority )
        {
            if( StartFire(Mode) )
                ServerTargetEngage(HRLTarget);
        }
        else
        {
            StartFire(Mode);
        }
    }
    else if( Role < ROLE_Authority )
    {
        if( StartFire(Mode) )
            ServerStartFire(Mode);
    }
    else
    {
        StartFire(Mode);
    }

    if( bTriggerPlayed[Mode] == 0 && Level.TimeSeconds > TriggerTime[Mode] )
    {
        Instigator.PlaySound(TriggerSound[Mode], TriggerSoundSlot[Mode], TriggerSoundVolume[Mode],, TriggerSoundRadius[Mode]);
        bTriggerPlayed[Mode] = 1;
        TriggerTime[Mode] = Level.TimeSeconds + default.TriggerTime[Mode];

        if( Mode == 0 && AmmoAmount(Mode) < FireMode[Mode].AmmoPerFire )
            Instigator.PlaySound(TriggerNoAmmoSound[Mode], TriggerSoundSlot[Mode], TriggerSoundVolume[Mode],, TriggerSoundRadius[Mode]);
    }
}

function ServerTargetEngage(Actor NewTarget)
{
    if(Vehicle(NewTarget) == None || !Vehicle(NewTarget).bDriving
        || (Level.Game.bTeamGame && Vehicle(NewTarget).GetTeamNum() != Instigator.GetTeamNum()))
        NewTarget = None;

    HRLTarget = NewTarget;
    bTarget = HRLTarget != None;

    ServerStartFire(1);
}

function ServerBeaconEngage(gHRLBeacon P)
{
    local int i;

    if( P != None )
    {
        if( Bot(Instigator.Controller) == None )
        {
            FireMode[1].bIsFiring = True;
            FireMode[1].bNowWaiting = True;
        }

        for( i=0; i!=Rockets.Length; ++i )
        {
            if( Rockets[i] != None )
            {
                Rockets[i].Engage(P);
            }
            else
            {
                Rockets.Remove(i--,1);
            }
        }

        if( Rockets.Length > 0 )
        {
            Instigator.PlaySound( EngageSound, EngageSoundSlot, EngageSoundVolume,, EngageSoundRadius );
        }
    }
}


// ============================================================================
//  Projectiles
// ============================================================================

function TrackBeacon(gHRLBeacon P)
{
    local Bot B;

    if( P != None )
    {
        // decide if bot should be locked on
        B = Bot(Instigator.Controller);
        if( B != None
        &&  B.Skill > 2 + 5 * FRand()
        &&  FRand() < 0.6
        &&  gPawn(B.Target) == None
        &&  B.Target != None
        &&  B.Target == B.Enemy
        &&  VSize(B.Enemy.Location - B.Pawn.Location) > 2000 + 2000 * FRand()
        &&  Level.TimeSeconds - B.LastSeenTime < 0.4
        &&  Level.TimeSeconds - B.AcquireTime > 1.5 )
        {
            bTarget = True;
            HRLTarget = B.Enemy;
        }

        if( bTarget && HRLTarget != None )
            P.Target = HRLTarget;
    }
}


// ============================================================================
//  Shield
// ============================================================================

function bool CheckReflect(vector HitLocation, out vector RefNormal, int AmmoDrain)
{
    local vector HitDir;
    local vector FaceDir;

    if( !Instigator.bWantsToCrouch || ShieldCharge == 0 )
        return False;

    FaceDir = vector(Instigator.Controller.Rotation);
    HitDir = Normal(Instigator.Location - HitLocation + Vect(0,0,8));
    //Log(self@"HitDir"@(FaceDir dot HitDir));

    RefNormal = FaceDir;

    if( FaceDir dot HitDir < -0.37 ) // 68 degree protection arc
    {
        if( AmmoDrain > 0 )
            ShieldCharge = FMax(0,ShieldCharge-AmmoDrain);

        return True;
    }

    return False;
}

function ReflectEffects(class<DamageType> DamageType)
{
    local vector FXLocation;
    local rotator FXRotation;

    Instigator.PlaySound(ShieldHitSound, ShieldHitSoundSlot, ShieldHitSoundVolume,, ShieldHitSoundRadius);

    FXRotation = Instigator.GetViewRotation();

    if( Instigator.IsFirstPerson() )
        FXLocation = GetBoneCoords(ShieldBone).Origin;
    else if( ThirdPersonActor != None )
        FXLocation = ThirdPersonActor.GetBoneCoords(ShieldBone).Origin;
    else
        FXLocation = Instigator.Location + Instigator.EyePosition();

    if( DamageType.default.bDelayedDamage )
        Spawn(ShieldHitClass,,, FXLocation, FXRotation);
    else
        Spawn(ShieldHitProjectileClass,,, FXLocation, FXRotation);
}

function AdjustPlayerDamage(out int Damage, Pawn InstigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType)
{
    local float Drain;
    local vector Reflect;
    local vector HitNormal;
    local float DamageMax;

    //gLog( "AdjustPlayerDamage" #Damage );

    DamageMax = 100.0;

    if( DamageType == class'Fell' )
        DamageMax = 20.0;

    if( !DamageType.default.bArmorStops || !DamageType.default.bLocationalHit /*|| (DamageType == class'DamTypeShieldImpact' && InstigatedBy == Instigator)*/ )
        return;

    if( CheckReflect(HitLocation, HitNormal, 0) )
    {
        Drain = Min(ShieldCharge, Damage);
        Drain = Min(Drain, DamageMax);
        Reflect = MirrorVectorByNormal(Normal(Location - HitLocation), vector(Instigator.Rotation));
        Damage -= Drain;
        Momentum *= 1.25;
        ShieldCharge = FMax(0, ShieldCharge-Drain);
        ReflectEffects(DamageType);
    }
}

// ============================================================================
//  Pickup
// ============================================================================

function GiveToEx(Pawn Other, optional Pickup Pickup, optional bool bGiveEmpty)
{
    Super.GiveToEx(Other,Pickup,bGiveEmpty);
    if( bDeleteMe )
        return;

    if( Role == ROLE_Authority )
    {
        if( HoverSound == None )
            HoverSound = Other.Spawn(HoverSoundClass, Other);
    }
}


// ============================================================================
//  Drawing
// ============================================================================

simulated event RenderOverlays(Canvas C)
{
    local PlayerController PC;
    local gHRLBeacon B;
    local vector Screen;
    local float X,Y;

    Super.RenderOverlays(C);

    PC = Level.GetLocalPlayerController();

    C.Style = ERenderStyle.STY_Normal;
    C.DrawColor = HudIconColor;
    //C.ColorModulate = C.default.ColorModulate;

    if( PC != None && PC.Pawn != None /*&& PC.Pawn.GetTeamNum() == InstigatorTeam*/ )
    {
        for( B = class'gHRLBeacon'.default.BeaconList; B != None; B = B.BeaconList )
        {
            Screen = C.WorldToScreen(B.Location);

            if( Screen.Z > 1 )
                continue;

            //gLog( "" #Screen.X #Screen.Y #Screen.Z  );

            if( FastTrace(B.Location, PC.CalcViewLocation) )
            {
                if( B == BeaconLock )
                {
                    X = Screen.X - HudIcon.MaterialUSize() * HudIconScaleLock * 0.5;
                    Y = Screen.Y - HudIcon.MaterialUSize() * HudIconScaleLock * 0.5;

                    C.SetPos(X,Y);
                    C.DrawColor = HudIconColorLock;
                    C.DrawTileScaled(HudIconLock, HudIconScaleLock, HudIconScaleLock);
                    C.DrawColor = HudIconColor;
                }
                else
                {
                    X = Screen.X - HudIcon.MaterialUSize() * HudIconScale * 0.5;
                    Y = Screen.Y - HudIcon.MaterialUSize() * HudIconScale * 0.5;

                    C.SetPos(X,Y);
                    C.DrawTileScaled(HudIcon, HudIconScale, HudIconScale);
                }
            }
        }
    }

    if( BeaconLock != None /*&& bCanEngage*/ )
    {
        C.DrawColor = LockCrosshairColor;
        C.SetPos((C.ClipX-LockCrosshair.MaterialUSize())*0.5,(C.ClipY-LockCrosshair.MaterialVSize())*0.5);
        C.DrawTileScaled(LockCrosshair, 1, 1);
    }

    if( bTarget )
    {
        C.DrawColor = CrosshairColor;
        C.DrawColor.A = 255;
        C.Style = ERenderStyle.STY_Alpha;

        CrosshairX = CrosshairTexture.USize;
        CrosshairY = CrosshairTexture.VSize;

        C.SetPos(C.SizeX*0.5-CrosshairX*1/2, C.SizeY*0.5-CrosshairY*1/2);
        C.DrawTile(CrosshairTexture, CrosshairX*1, CrosshairY*1, 0.0, 0.0, CrosshairX, CrosshairY);
    }
}

simulated function DrawWeaponInfo(Canvas Canvas)
{
    NewDrawWeaponInfo(Canvas, 0.705*Canvas.ClipY);
}

simulated function NewDrawWeaponInfo(Canvas Canvas, float YPos)
{
    local int i,Count,BeaconCount;
    local float ScaleFactor,ScaleFactorY;

    ScaleFactor = 99 * Canvas.ClipX/3200;
    ScaleFactorY = 99 * Canvas.ClipX/3200;
    Canvas.Style = ERenderStyle.STY_Alpha;
    Canvas.DrawColor = class'HUD'.Default.WhiteColor;

    BeaconCount = AmmoAmount(1);

    Count = Min(8,BeaconCount);

    for( i = 0; i < Count; i++ )
    {
        Canvas.SetPos(Canvas.ClipX - (0.5*i+1) * ScaleFactor, YPos);
        Canvas.DrawTile(Material'G_FX.Interface.IconSheet0', ScaleFactor, ScaleFactorY, 174, 259, 46, 45);
    }

    if( BeaconCount > 8 )
    {
        Count = Min(16,BeaconCount);

        for( i = 8; i<Count; i++ )
        {
            Canvas.SetPos(Canvas.ClipX - (0.5*(i-8)+1) * ScaleFactor, YPos - ScaleFactorY);
            Canvas.DrawTile(Material'G_FX.Interface.IconSheet0', ScaleFactor, ScaleFactorY, 174, 259, 46, 45);
        }
    }
}

simulated function float ChargeBar()
{
    return FClamp(ShieldCharge*0.01, 0, BarFullSteady);
}


// ============================================================================
//  AI
// ============================================================================


function float GetAIRating()
{
    local Bot B;
    local float Dist, Rating, ZDiff;
    local vector Delta;
    local Actor Target;

    B = Bot(Instigator.Controller);
    if( B == None )
        return AIRating;

    Target = GetBotTarget();
    if( Target == None )
        return AIRating;

    Delta = Target.Location - Instigator.Location;
    Dist = VSize(Delta);
    ZDiff = Delta.Z;
    Rating = AIRating;

    // minefield
    if( gProjectile(Target) != None )
        return RATING_Skip;

    // distance
    if( Dist < 384 )
        Rating -= 0.5;

    // minefield
    if( Vehicle(Target) != None )
        Rating += 5.0;
    else if( Pawn(Target) != None )
        Rating -= 0.5;

    return Rating;
}

function float SuggestAttackStyle()
{
    return -0.4;
}

function float SuggestDefenseStyle()
{
    return 0.5;
}

function bool RecommendRangedAttack()
{
    local float Dist;
    local Actor Target;

    Target = GetBotTarget();
    if( Target == None )
        return False;

    Dist = VSize(Target.Location - Instigator.Location);
    return (Dist > 2000 * (1 + FRand()) );
}

function bool RecommendLongRangedAttack()
{
    return RecommendRangedAttack();
}

function byte BestMode()
{
    return 1;
}

function bool CanAttack(Actor Other)
{
    //gLog( "CanAttack" #BotMode #Other #Super.CanAttack(Other) #gWeaponFire(FireMode[1]).IsInTossRange(Other) );

    if( Projectile(Other) != None )
        return False;

    if( !Super.CanAttack(Other) )
        return False;

    // check that target is within range
    if( !gWeaponFire(FireMode[1]).IsInTossRange(Other) )
        return False;

    return True;
}

function bool BotFire(bool bFinished, optional name FiringMode)
{
    //gLog( "BotFire" #BotMode #bFinished #FiringMode );

    if( bFinished )
        return True;

    if( ClientState != WS_ReadyToFire )
        return False;

    if( FireMode[0].IsFiring() )
        StopFire(0);

    if( FireMode[1].IsFiring() )
        StopFire(1);

    GotoState('BotFiring');
    return True;
}

function bool IsComboFiring()
{
    return False;
}

function NotifyProjectileSpawned( int mode, Projectile P )
{
}

state BotFiring
{
    function bool BotFire(bool bFinished, optional name FiringMode)
    {
        //gLog( "BotFire in BotFiring" #BotMode #bFinished #FiringMode );
        return True;
    }

    function bool IsComboFiring()
    {
        return True;
    }

    function NotifyProjectileSpawned( int mode, Projectile P )
    {
        if( mode == 1 )
        {
            //gLog( "Notify" #mode );
            StopFire(1);
            BotMode = 0;
            StartFire(0);
            LastBeacon = gHRLBeacon(P);
        }
        else if( mode == 0 )
        {
            //gLog( "Notify" #mode );
            StopFire(0);
            BotMode = 1;

            if( LastBeacon != None && bCanEngage )
            {
                ServerBeaconEngage(LastBeacon);
            }
            else
            {
                //gLog( "FAIL ENGAGE" #BotMode );
            }
        }
    }

Begin:
    //gLog( "BotFiring" #BotMode );

    BotMode = 1;
    StartFire(1);
    Sleep(FireMode[0].FireRate+0.5);
    GotoState('');
}

simulated function bool CanThrow()
{
    local int Mode;

    for( Mode = 0; Mode < NUM_FIRE_MODES; Mode++ )
    {
        if( FireMode[Mode].bFireOnRelease && FireMode[Mode].bIsFiring )
            return False;
    }

    if( bCanThrow )
    {
        if( Level.NetMode == NM_DedicatedServer || Level.NetMode == NM_ListenServer )
            return True;

        else if( ClientState == WS_ReadyToFire || ClientState == WS_Hidden || ClientState == WS_None )
            return True;
    }
}





// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    MaxBeacons                      = 5

    ForceMode                       = -1
    BeaconLockAngle                 = 0.995

    SeekCheckFreq                   = 0.1
    SeekRange                       = 32768
    LockRequiredTime                = 0.3
    UnLockRequiredTime              = 1.0
    LockAim                         = 0.965 // 15 deg

    CrosshairColor                  = (R=250,G=0,B=0,A=255)
    CrosshairX                      = 16
    CrosshairY                      = 16
    CrosshairTexture                = Texture'SniperArrows'

    ShieldCharge                    = 100

    TriggerSound(0)                 = Sound'G_Sounds.hrl_trigger_pull_a'
    TriggerSound(1)                 = Sound'G_Sounds.hrl_trigger_pull_b'

    TriggerNoAmmoSound(0)           = Sound'G_Sounds.hrl_fire_noammo'
    TriggerNoAmmoSound(1)           = Sound'G_Sounds.hrl_fire_noammo'

    TriggerSoundVolume(0)           = 1.0
    TriggerSoundVolume(1)           = 1.0

    TriggerSoundRadius(0)           = 256
    TriggerSoundRadius(1)           = 256

    TriggerSoundSlot(0)             = SLOT_None
    TriggerSoundSlot(1)             = SLOT_None

    TriggerTime(0)                  = 1
    TriggerTime(1)                  = 0.5

    HoverSoundClass                 = class'gHRLHoverSound'

    ShieldHitClass                  = class'GEffects.gShieldHit'
    ShieldHitProjectileClass        = class'GEffects.gShieldHitProjectile'

    HudIcon                         = TexOscillator'HUDContent.Generic.GlowCirclePulse'
    HudIconColor                    = (R=255,G=0,B=0,A=255)
    HudIconScale                    = 0.2

    HudIconLock                     = TexOscillator'HUDContent.Generic.GlowCirclePulse'
    HudIconColorLock                = (R=0,G=255,B=0,A=255)
    HudIconScaleLock                = 0.4

    EngageSound                     = Sound'G_Sounds.hrl_alt_beep'
    EngageSoundVolume               = 2.0
    EngageSoundRadius               = 255
    EngageSoundSlot                 = SLOT_Interact

    ShieldHitSound                  = Sound'G_Proc.hrl_shieldhit_grp'
    ShieldHitSoundVolume            = 2.0
    ShieldHitSoundRadius            = 255
    ShieldHitSoundSlot              = SLOT_None

    FirstReloadSound                = Sound'G_Sounds.hrl_reload2'
    FirstReloadSoundVolume          = 2.0
    FirstReloadSoundRadius          = 255
    FirstReloadSoundSlot            = SLOT_None

    ShieldDeploySound               = Sound'G_Sounds.hrl_deploy'
    ShieldDeploySoundVolume         = 1.0
    ShieldDeploySoundRadius         = 255
    ShieldDeploySoundSlot           = SLOT_None

    ShieldBeginSound                = Sound'G_Sounds.hrl_shield_begin'
    ShieldBeginSoundVolume          = 1.0
    ShieldBeginSoundRadius          = 255
    ShieldBeginSoundSlot            = SLOT_None

    ShieldEndSound                  = Sound'G_Sounds.hrl_shield_end'
    ShieldEndSoundVolume            = 1.0
    ShieldEndSoundRadius            = 255
    ShieldEndSoundSlot              = SLOT_None

    ShieldUndeploySound             = Sound'G_Sounds.hrl_deploy_end'
    ShieldUndeploySoundVolume       = 1.0
    ShieldUndeploySoundRadius       = 255
    ShieldUndeploySoundSlot         = SLOT_None

    ShieldBone                      = "Shieldemit"
    //ShieldClass                   = class'gEffects.gHRLShield'
    ShieldClass                     = class'gEffects.gHRLShieldEmitter'

    BeaconLockSound                 = Sound'G_Sounds.hrl_lock'

    LockCrosshair                   = Material'G_FX.Interface.crosshair_s1'
    LockCrosshairColor              = (R=255,G=255,B=255,A=255)


    // gWeapon
    bForceViewUpdate                = False
    BotPurchaseProbMod              = 3
    ItemSize                        = 5
    AmmoShopping                    = (1,0)
    CostWeapon                      = 950
    CostAmmo                        = 250


    // Weapon
    FireModeClass(0)                = class'gHRLFire'
    FireModeClass(1)                = class'gHRLFireAlt'
    PickupClass                     = class'gHRLPickup'
    AttachmentClass                 = class'gHRLAttachment'

    SelectSound                     = Sound'G_Sounds.hrl_reload2'
    SelectSoundVolume               = 1.4


    AIRating                        = 2.5
    CurrentRating                   = 2.5

    bShowChargingBar                = True

    ItemName                        = "Heavy Rocket Launcher"
    Description                     = "An Anti-Tank RL. Primary Fire blows up armor. Alt-Fire blows up fast-movers. Both can lock onto Homing Beacons, or whatever entity the homing beacon is attached to."

    DisplayFOV                      = 65
    PlayerViewOffset                = (x=15,y=7,z=-12)
    PlayerViewPivot                 = (Pitch=0,Yaw=32768,Roll=0)
    SmallViewOffset                 = (x=15,y=7,z=-12)
    SmallEffectOffset               = (X=0.0,Y=0.0,Z=0.0)
    EffectOffset                    = (X=0.0,Y=0.0,Z=0.0)
    CenteredOffsetY                 = -5
    CenteredRoll                    = 0
    CenteredYaw                     = -500

    HudColor                        = (r=255,g=0,b=0,a=255)
    IconCoords                      = (X1=255,Y1=125,X2=574,Y2=189)


    // Actor
    DrawScale                       = 0.5
    Mesh                            = Mesh'G_Anims.HRL'
}