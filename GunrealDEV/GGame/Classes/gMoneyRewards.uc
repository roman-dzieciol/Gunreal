// ============================================================================
//  gMoneyRewards.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMoneyRewards extends gObject;

struct SRewards
{
    var() float Amount;
    var() class<LocalMessage> Message;
};

var() array<SRewards>           SpreeRewards;
var() array<SRewards>           MultiKillRewards;

var() gKillReward               PlayerReward;
var() gKillReward               VehicleReward;

var() int                       DropCashLimit;
var() int                       DropCashPerAmmount;
var() int                       DropCashSize;
var() class<Pickup>             DropCashClass;
var() float                     DropCashMinVel;



final static function CashKill(Controller Killer, Controller Killed, Pawn KilledPawn)
{
    local gDamageCounter DC;
    local float Cash;
    local Controller DamageInstigator;
    local gPRI GPRI;
    local int i;
    local Vehicle KilledVehicle;
    local gKillReward Reward;

    //gLog( "CashPlayerKill" #GON(Killer) #GON(Other) #GON(P) );

    Reward = default.PlayerReward;

    if( KilledPawn != None )
    {
        // If it's a turret, get base vehicle, otherwise get vehicle ref
        if( Vehicle(KilledPawn) != None )
        {
            Reward = default.VehicleReward;
            KilledVehicle = KilledPawn.GetVehicleBase();
            if( KilledVehicle != None )
                KilledPawn = KilledVehicle;
            else
                KilledVehicle = Vehicle(KilledPawn);
        }

        // Damage reward
        DC = class'gDamageCounter'.static.GetCounter(KilledPawn);
        if( DC != None )
        {
            for( i=0; i!=DC.Damages.Length; ++i )
            {
                DamageInstigator = DC.Damages[i].Instigator;

                // Skip suicide damage if player was killed
                if( DamageInstigator != None && (KilledVehicle != None || DamageInstigator != Killed) )
                {
                    GPRI = class'gPRI'.static.GetGPRI(DamageInstigator.PlayerReplicationInfo);
                    if( GPRI != None )
                    {
                        // Limit the cash received
                        if( KilledVehicle != None )
                            Cash = FClamp( DC.Damages[i].Damage, 0, KilledPawn.HealthMax ) * Reward.DamageCash;
                        else
                            Cash = FClamp(DC.Damages[i].Damage * Reward.DamageCash, 0, Reward.DamageCashLimit);

                        // make reward negative if teamkill
                        if( KilledPawn.Level.Game.bTeamGame && DamageInstigator.GetTeamNum() == Killed.GetTeamNum() )
                            Cash = -Cash;

                        // Give reward
                        GPRI.UpdateMoney(Cash, Reward.DamageMsgClass, Killed.PlayerReplicationInfo);
                    }
                }
            }
            DC.Destroy();
        }
    }

    // Reward kill, if it wasn't a player suicide
    if( Killer != None && (KilledVehicle != None || Killer != Killed) )
    {
        GPRI = class'gPRI'.static.GetGPRI(Killer.PlayerReplicationInfo);
        if( GPRI != None )
        {
            if( !Killer.Level.Game.bTeamGame || Killer.GetTeamNum() != Killed.GetTeamNum() )
                Cash = Reward.KillCash;
            else
                Cash = Reward.TeamKillCash;

            GPRI.UpdateMoney(Cash, Reward.KillMsgClass, Killed.PlayerReplicationInfo);
        }
    }

    // Driver damage reward
    if( KilledVehicle != None && KilledVehicle.Driver != None )
        CashKill(Killer, Killed, KilledVehicle.Driver);
}

final static function DropCash(Controller Killed)
{
    local gPRI GPRI;
    local int Amount;
    local Pickup K;

    if( Killed.Pawn != None )
    {
        GPRI = class'gPRI'.static.GetGPRI(Killed.PlayerReplicationInfo);
        if( GPRI == None )
        {
            DropMonsterCash(Killed);
        }
        else if( GPRI.GetMoney() > default.DropCashLimit )
        {
            Amount = (GPRI.GetMoney() - default.DropCashLimit) / default.DropCashPerAmmount;
            GPRI.UpdateMoney(-(Amount * default.DropCashSize), class'gMessageMoneyDropCash',,,, True);

            while( Amount-- > 0 )
            {
                K = Killed.Pawn.Spawn(default.DropCashClass, Killed,,, rot(0, 2, 0)*Rand(32768) + rot(1, 0, 0)*Rand(16384));
                if( K != None )
                {
                    K.InitDroppedPickupFor(None);
                    K.Velocity = vector(K.Rotation) * FMax(VSize(Killed.Pawn.Velocity), default.DropCashMinVel);
                }
            }
        }
    }
}

final static function DropMonsterCash(Controller Killed)
{
    local int Amount;
    local Pickup K;

    Amount = Min(Killed.Pawn.default.Health / 100, 1);
    while( Amount-- > 0 )
    {
        K = Killed.Pawn.Spawn(default.DropCashClass, Killed,,, rot(0, 2, 0)*Rand(32768) + rot(1, 0, 0)*Rand(16384));
        if( K != None )
        {
            K.InitDroppedPickupFor(None);
            K.Velocity = vector(K.Rotation) * FMax(VSize(Killed.Pawn.Velocity), default.DropCashMinVel);
        }
    }
}

final static function SpreeReward( Controller Killer, int SpreeNum )
{
    local int i;
    local gPRI GPRI;

    if( SpreeNum > 0 && SpreeNum % 5 == 0 )
    {
        GPRI = class'gPRI'.static.GetGPRI(Killer.PlayerReplicationInfo);
        if( GPRI != None )
        {
            i = Clamp((SpreeNum / 5) - 1, 0, default.SpreeRewards.Length-1);
            GPRI.UpdateMoney(default.SpreeRewards[i].Amount, default.SpreeRewards[i].Message, Killer.PlayerReplicationInfo);
        }
    }
}

final static function MultiKillReward( Controller Killer, int MultiKillLevel )
{
    local int i;
    local gPRI GPRI;

    if( MultiKillLevel > 0 )
    {
        GPRI = class'gPRI'.static.GetGPRI(Killer.PlayerReplicationInfo);
        if( GPRI != None )
        {
            i = Clamp(MultiKillLevel - 1, 0, default.MultiKillRewards.Length-1);
            GPRI.UpdateMoney(default.MultiKillRewards[i].Amount, default.MultiKillRewards[i].Message, Killer.PlayerReplicationInfo);
        }
    }
}


DefaultProperties
{
    SpreeRewards(0)         = (Amount=500,Message=class'gMessageMoneyKillingSpree')
    SpreeRewards(1)         = (Amount=500,Message=class'gMessageMoneyRampage')
    SpreeRewards(2)         = (Amount=500,Message=class'gMessageMoneyDominating')
    SpreeRewards(3)         = (Amount=500,Message=class'gMessageMoneyUnstoppable')
    SpreeRewards(4)         = (Amount=500,Message=class'gMessageMoneyGodLike')
    SpreeRewards(5)         = (Amount=500,Message=class'gMessageMoneyWickedSick')

    MultiKillRewards(0)     = (Amount=200,Message=class'gMessageMoneyDoubleKill')
    MultiKillRewards(1)     = (Amount=200,Message=class'gMessageMoneyMultiKill')
    MultiKillRewards(2)     = (Amount=200,Message=class'gMessageMoneyMegaKill')
    MultiKillRewards(3)     = (Amount=200,Message=class'gMessageMoneyUltraKill')
    MultiKillRewards(4)     = (Amount=200,Message=class'gMessageMoneyMonsterKill')
    MultiKillRewards(5)     = (Amount=200,Message=class'gMessageMoneyLudicrousKill')

    DropCashLimit           = 2000
    DropCashPerAmmount      = 500
    DropCashSize            = 100
    DropCashClass           = class'gCashPickup'
    DropCashMinVel          = 400

    Begin Object Class=gKillReward Name=oPlayerReward
        KillMsgClass            = class'gMessageMoneyKill'
        DamageMsgClass          = class'gMessageMoneyDamage'
        TeamKillCash            = -300
        KillCash                = 200
        DamageCash              = 1
        DamageCashLimit         = 100
    End Object
    PlayerReward=oPlayerReward

    Begin Object Class=gKillReward Name=oVehicleReward
        KillMsgClass         = class'gMessageMoneyVehicleKill'
        DamageMsgClass       = class'gMessageMoneyVehicleDamage'
        TeamKillCash         = -300
        KillCash             = 200
        DamageCash           = 2
        DamageCashLimit      = 1000000 // no limit
    End Object
    VehicleReward=oVehicleReward
}