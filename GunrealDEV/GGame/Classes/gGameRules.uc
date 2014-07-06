// ============================================================================
//  gGameRules.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gGameRules extends GameRules;

var() class<Emitter>    VehicleKillEffect;
var   bool              bUseShopping;

// ============================================================================
//  gGameRules
// ============================================================================

event PreBeginPlay()
{
    Super.PreBeginPlay();
    if( bDeleteMe )
        return;

    if( InstagibCTF(Level.Game) == None )
    {
        bUseShopping = True;
    }
}

function int NetDamage(int OriginalDamage, int Damage, Pawn Injured, Pawn InstigatedBy, vector HitLocation, out vector Momentum, class<DamageType> DamageType)
{
    local gDamageCounter DC;
    local Controller InstigatorController;

    //gLog( "NetDamage" #OriginalDamage #Damage #GON(Injured) #GON(InstigatedBy) #VSize(Momentum) #GON(DamageType) );

    if( Damage > 0
    &&  Injured != None
    &&  InstigatedBy != Injured )
    {
        // Get InstigatorController
        if( InstigatedBy != None )
            InstigatorController = InstigatedBy.GetKillerController();
        if( InstigatorController == None && DamageType != None && DamageType.default.bDelayedDamage )
            InstigatorController = Injured.DelayedDamageInstigatorController;

        // Hit sounds
        if( gPlayer(InstigatorController) != None && gPlayer(InstigatorController).bHitSounds )
            gPlayer(InstigatorController).PlayDamageDing(Injured, DamageType);

        if( bUseShopping )
        {
            // Damage counter
            DC = class'gDamageCounter'.static.GetCounter(Injured, True);
            DC.AddDamage(Injured, Damage, InstigatorController);

            // Damaging players removes warranty
            if( xPawn(Injured) != None && InstigatedBy != None && class<gDamTypeWeapon>(DamageType) != None )
                class'gShopInfo'.static.DamageWarranty(Injured, InstigatedBy, Damage, class<gDamTypeWeapon>(DamageType));
        }
    }

    // Excessive vehicle kill effect
    if( Vehicle(Injured) != None && Injured.CollisionRadius >= 260 && Injured.Health > 0 && Injured.Health - Damage < -100 )
        Spawn(VehicleKillEffect,,,Injured.Location + vect(0,0,1)*Injured.CollisionHeight + vect(0,0,120), rot(0,0,0));

    return Super.NetDamage(OriginalDamage, Damage, Injured, InstigatedBy, HitLocation, Momentum, DamageType);
}

function ScoreKill(Controller Killer, Controller Killed)
{
    local gPRI KillerGPRI;
    local gPRI KilledGPRI;
    local bool bEnemyKill;

//    gLog( "ScoreKill" #Killed #Killer
//    #Killed.Pawn
//    #Killed.Pawn.Health );

    if( bUseShopping )
    {
        // Get Killer GPRI
        if( Killer != None )
            KillerGPRI = class'gPRI'.static.GetGPRI(Killer.PlayerReplicationInfo);

        // Get Killed GPRI
        if( Killed != None )
            KilledGPRI = class'gPRI'.static.GetGPRI(Killed.PlayerReplicationInfo);


        // No-Kill multiplier update
        if( KillerGPRI != None )
        {
            if( KillerGPRI != KilledGPRI )
                KillerGPRI.DeductNoKillMultiplier();
        }

        if( Killed != None )
        {
            // MultiKill tracking for bots
            if( gBot(Killer) != None && Killer.bIsPlayer && Killed.bIsPlayer )
            {
                bEnemyKill = ( !Level.Game.bTeamGame
                            || (Killer != Killed
                            &&  Killer.PlayerReplicationInfo != None
                            &&  Killed.PlayerReplicationInfo != None
                            &&  Killer.PlayerReplicationInfo.Team != Killed.PlayerReplicationInfo.Team) );

                gBot(Killer).LogMultiKills(Deathmatch(Level.Game).ADR_MajorKill, bEnemyKill);
            }

            // Money reward
            class'gMoneyRewards'.static.CashKill(Killer, Killed, Killed.Pawn);

            // Money drop
            class'gMoneyRewards'.static.DropCash(Killed);
        }
    }

    // UDamage drop
    if( Killed != None && Killer != None && gPawn(Killed.Pawn) != None && gPawn(Killed.Pawn).UDamageTime > Level.TimeSeconds + 3 )
        class'gUDamageReward'.static.ThrowUDamage(Killer, gPawn(Killed.Pawn));

    Super.ScoreKill(Killer, Killed);
}

function bool PreventDeath(Pawn Other, Controller Killer, class<DamageType> DamageType, vector HitLocation)
{
    //gLog( "PreventDeath" #GON(Other) #GON(Killer) #GON(DamageType) );

    if( bUseShopping )
    {
        // Killing someone removes warranty
        if( Killer != None
        &&  Other != None
        &&  Killer.Pawn != Other
        &&  class<gDamTypeWeapon>(DamageType) != None )
            class'gShopInfo'.static.KillWarranty(Killer.Pawn, class<gDamTypeWeapon>(DamageType));
    }

    // Kill sounds
    if( gPlayer(Killer) != None && gPlayer(Killer).bHitSounds )
        gPlayer(Killer).PlayKillDing(Other, DamageType);

    return Super.PreventDeath(Other, Killer, DamageType, HitLocation);
}

function bool OverridePickupQuery(Pawn Other, Pickup Item, out byte bAllowPickup)
{
    //gLog( "OverridePickupQuery" #Item );

    if( bUseShopping )
    {
        // Don't allow pickup if weapon won't fit into slot
        if( gPawn(Other) != None
        &&  class<gWeapon>(Item.InventoryType) != None
        && !gPawn(Other).PawnInventory.WillWeaponFit(class<gWeapon>(Item.InventoryType))
        &&  Other.FindInventoryType(Item.InventoryType) == None )
        {
            bAllowPickup = 0;
            return True;
        }
    }

    return Super.OverridePickupQuery(Other, Item, bAllowPickup);
}


// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog ( coerce string S ){
    class'GDebug.gDbg'.static.aLog( self, Level, S, gDebugString() );}

simulated function string gDebugString();

// ============================================================================
//  Debug String
// ============================================================================
simulated final static function string StrShort( coerce string S ){
    return class'GDebug.gDbg'.static.StrShort( S );}

simulated final static operator(112) string # ( coerce string A, coerce string B ){
    return class'GDebug.gDbg'.static.Pound_StrStr( A,B );}

simulated final static function name GON( Object O ){
    return class'GDebug.gDbg'.static.GON( O );}

simulated final function string GPT( string S ){
    return class'GDebug.gDbg'.static.GPT( self, S );}

// ============================================================================
//  Debug Visual
// ============================================================================
simulated final function DrawAxesRot( vector Loc, rotator Rot, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesRot( self, Loc, Rot, Length, bStaying );}

simulated final function DrawAxesCoords( Coords C, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesCoords( self, C, Length, bStaying );}

simulated final function DrawAxesXYZ( vector Loc, vector X, vector Y, vector Z, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesXYZ( self, Loc, X, Y, Z, Length, bStaying );}

simulated final static function VarWatch( coerce string Desc, coerce string Value, optional bool bGraph ){
    class'GDebug.gDbg'.static.VarWatch( Desc, Value, bGraph );}


// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    VehicleKillEffect=class'gVehicleKillEffect'
}