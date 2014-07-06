// ============================================================================
//  gMutator.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gMutator extends Mutator
    HideDropDown
    CacheExempt;


enum EBonusMode
{
    BM_Money,
    BM_Armor,
    BM_Regen,
    BM_Shield
};


var()               string              PlayerControllerClassName;
var()               string              PawnClassName;

var()               float               KarmaGravScale;
var()               float               ArmorBonus;

var() config bool bForceVehicles;

var() IntBox BallLauncherIconCoords;
var() Material BallLauncherIconMaterial;

var   bool bUseShopping;

// ============================================================================
//  LifeSpan
// ============================================================================

event PreBeginPlay()
{
    if( InstagibCTF(Level.Game) == None )
    {
        bUseShopping = True;
    }

    if( Role == ROLE_Authority )
    {
        if( DeathMatch(Level.Game) != None )
            DeathMatch(Level.Game).bOverrideTranslocator = True;

        if( bForceVehicles )
            Level.Game.bAllowVehicles = True;

        // Set default PlayerController class
        Level.Game.DefaultPlayerClassName = PawnClassName;
        Level.Game.PlayerControllerClassName = PlayerControllerClassName;
        class'xPawn'.default.ControllerClass = class'gPawn'.default.ControllerClass;
        
        if( Level.Game.Class.Name == 'xDeathmatch')
        	xDeathmatch(Level.Game).DMSquadClass = class'GGame.gDMSquad';
        
        if( Level.Game.Class.Name == 'xMutantGame')
        	xMutantGame(Level.Game).DMSquadClass = class'GGame.gMutSquadAI';
        

        // Add GameRules
        Level.Game.AddGameModifier(Spawn(class'GGame.gGameRules'));
    }
}

simulated event BeginPlay()
{
    // Karma grav scale
    Level.KarmaGravScale = KarmaGravScale;

    // Disable static actors
    DisableStaticActors();

    // Fix BR on client & server
    FixBombingRun(false);

    // Fix raptor missile sound
    class'ONSAvrilSmokeTrail'.default.SoundVolume = 64;
    class'ONSAttackCraftMissle'.default.SoundVolume = 64;

    Super.BeginPlay();
}

function MatchStarting()
{
    FixGametype();

    // Fix BR on server
    FixBombingRun(true);
}


// ============================================================================
// Player
// ============================================================================
function ModifyPlayer(Pawn P)
{
    //gLog( "ModifyPlayer" #GON(P) );

    if( bUseShopping && gPawn(P) != None )
    {
        switch( gPawn(P).BonusMode )
        {
            case BM_Regen:
                class'gRegenTimer'.static.GetActor(P,True);
                break;

            case BM_Armor:
                P.ShieldStrength = ArmorBonus;
                break;
        }
    }

    Super.ModifyPlayer(P);
}

function NotifyLogout(Controller Exiting)
{
    local gTurret T;

    Super.NotifyLogout(Exiting);

    //gLog("NotifyLogout" #Exiting);

    if( Exiting != None )
    {
        if( bUseShopping && Exiting.PlayerReplicationInfo != None )
        {
            class'GPRI'.static.DestroyGPRI(Exiting.PlayerReplicationInfo);
        }

        if( gBot(Exiting) != None )
            T = gBot(Exiting).Turret;
        else if( gPlayer(Exiting) != None )
            T = gPlayer(Exiting).Turret;

        if( T != None )
            T.TakeDamage(T.Health * 10, T, T.Location, vect(0,0,1), class'Suicided');
    }
}


// ============================================================================
// Replacement
// ============================================================================
function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
    if( bUseShopping )
    {
        // Add custom GPRI's
        if( Other.IsA('PlayerReplicationInfo') )
        {
            class'gPRI'.static.SpawnGPRI(PlayerReplicationInfo(Other));
            return True;
        }

        else if( Other.IsA('xPickUpBase') )
        {
            // Relace weapon bases with terminals
            if( Other.IsA('xWeaponBase') )
                return ReplaceTerminal(Other);

            // Replace health pickups
            else if( Other.IsA('HealthCharger') )
                return ReplacePickupBase(Other, class'GGame.gHealthPickupBase');

            // Replace super health pickups
            else if( Other.IsA('SuperHealthCharger') )
                return ReplacePickupBase(Other, class'GGame.gSuperHealthPickupBase');

            // Replace shield pickups
            else if( Other.IsA('ShieldCharger') )
                return ReplacePickupBase(Other, class'GGame.gShieldPickupBase');

            // Replace super shield pickups
            else if( Other.IsA('SuperShieldCharger') )
                return ReplacePickupBase(Other, class'GGame.gSuperShieldPickupBase');

            // Replace double damage pickups
            else if( Other.IsA('UDamageCharger') )
                return ReplacePickupBase(Other, class'GGame.gUDamagePickupBase');

            // Replace wildcard bases
            else if( Other.IsA('WildcardBase') )
                return ReplacePickupBase(Other, class'GGame.gWildcardBase');
        }

        else if( Other.IsA('Pickup') )
        {
            // Replace weapon lockers with terminals
            if( Other.IsA('WeaponLocker') )
                return ReplaceTerminal(Other);

            // Replace health pickups
            else if( Other.IsA('TournamentHealth') )
            {
                // Replace mini health pickups
                if( Other.IsA('HealthPack') )
                    return !ReplaceWith(Other, "GGame.gHealthPickup");

                // Replace health pickups
                else if( Other.IsA('MiniHealthPack') )
                    return !ReplaceWith(Other, "GGame.gMiniHealthPickup");

                // Replace super health pickups
                else if( Other.IsA('SuperHealthPack') )
                    return !ReplaceWith(Other, "GGame.gSuperHealthPickup");
            }

            // Replace shield pickups
            else if( Other.IsA('ShieldPickup') )
            {
                // Replace mini health pickups
                if( Other.IsA('ShieldPack') )
                    return !ReplaceWith(Other, "GGame.gShieldPickup");

                // Replace super health pickups
                else if( Other.IsA('SuperShieldPack') )
                    return !ReplaceWith(Other, "GGame.gSuperShieldPickup");
            }

            // Replace udamage
            else if( Other.IsA('UDamagePack') )
                return !ReplaceWith(Other, "GGame.gUDamagePickup");

            // Replace adrenaline pickups
            else if( Other.IsA('AdrenalinePickup') && !Other.IsA('gDarkMatterPickup') )
                return !ReplaceWith(Other, "GGame.gDarkMatterPickup");

            // Remove ammo pickups
            else if( Other.IsA('Ammo') )
                return False;
        }
    }

    // Disable Invasion bots
    if( Other.class == class'InvasionBot' )
    {
        DisableBots();
        return False;
    }

    // Unlock all vehicles in debug mode
    else if( bForceVehicles && Vehicle(Other) != None )
    {
        Vehicle(Other).bTeamLocked = False;
        return True;
    }

    return True;
}

function string GetInventoryClassOverride(string InventoryClassName)
{
    //gLog( "GetInventoryClassOverride" #InventoryClassName );

    // trans is handled by shopping system
    if( Caps(InventoryClassName) == Caps("XWeapons.TransLauncher") )
        InventoryClassName = "GWeapons.gPistonGun";
    else if( NextMutator != None )
    {
        return NextMutator.GetInventoryClassOverride(InventoryClassName);
    }

    return InventoryClassName;
}

function string NewRecommendCombo(string ComboName, AIController C)
{
    return "";
}


// ============================================================================
//  Disabling/Replacing helper functions
// ============================================================================

final function FixGametype()
{
    if( DeathMatch(Level.Game) != None )
    {
        DeathMatch(Level.Game).bWeaponStay = False;
    }
}

final simulated function FixBombingRun(bool bMatchStarting)
{
    local xBombDelivery BD;
    local xBombDeliveryHole BH;
    local HUDCBombingRun BRHUD;

    // Adjust replicated actors
    if( bMatchStarting )
    {
        // Adjust Delivery Frames
        foreach AllActors(class'xBombDelivery', BD)
            BD.SetDrawScale(BD.DrawScale * 2.25);
    }

    // Adjust non-replicated actors
    if( bMatchStarting || Level.NetMode == NM_Client )
    {
        // Adjust Delivery Holes
        foreach AllActors(class'xBombDeliveryHole', BH)
            BH.SetDrawScale(BH.DrawScale * 2.25);
    }

    // Make ball launcher use a ball icon
    class'BallLauncher'.default.IconMaterial = BallLauncherIconMaterial;
    class'BallLauncher'.default.IconCoords = BallLauncherIconCoords;

    // fix BR HUD bomb indicator
    class'HUDCBombingRun'.default.LocationDot = Material'HudContent.Generic.HUDPulseOld';
    foreach AllActors(class'HUDCBombingRun',BRHUD)
    {
        BRHUD.LocationDot = Material'HudContent.Generic.HUDPulseOld';
    }
}

final function DisableBots()
{
    local DeathMatch DM;

    DM = DeathMatch(Level.Game);
    if( DM != None )
    {
        DM.bKillBots = True;
        DM.bAutoNumBots = False;
        DM.bPlayersVsBots = False;
        DM.InitialBots = 0;
        DM.MinPlayers = 0;
        DM.RemainingBots = 0;
    }
}

final simulated function DisableStaticActors()
{
    local xWeaponBase WB;
    local WeaponLocker WL;
    local gPathDisabler PathDisabler;

    foreach AllActors(class'xWeaponBase', WB)
    {
        WB.bHidden = True;
        if( WB.myEmitter != None )
            WB.myEmitter.Destroy();
    }

    foreach AllActors(class'WeaponLocker', WL)
    {
        WL.GotoState('Disabled');
    }

    // Diable certain paths
    PathDisabler = new(None) class'gPathDisabler';
    PathDisabler.Execute(Level);
}

final function bool ReplacePickupBase(Actor Other, class<gPickupBase> NewClass)
{
    local gPickupBase PB;

    PB = Spawn(NewClass, Other.Owner, Other.Tag, Other.Location, Other.Rotation);
    if( PB != None )
        PB.SetReplaced(Other);

    return False;
}

final function bool ReplaceTerminal(Actor Other)
{
    local gTerminal T;

    T = Spawn(class'GGame.gTerminal', Other.Owner, Other.Tag, Other.Location, Other.Rotation);
    if( T != None )
        T.SetReplaced(Other);

    return False;
}


// ============================================================================
// Debug
// ============================================================================

// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog( coerce string S ){
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
    // gMutator
    KarmaGravScale                  = 2
    ArmorBonus                      = 75

    PlayerControllerClassName       = "GGame.gPlayer"
    PawnClassName                   = "GGame.gPawn"

    BallLauncherIconCoords          = (X1=79,Y1=223,X2=116,Y2=264)
    BallLauncherIconMaterial        = Material'HudContent.Generic.HUD'


    // Mutator
    IconMaterialName                = "MutatorArt.nosym"
    ConfigMenuClassName             = ""
    GroupName                       = "Gunreal"
    FriendlyName                    = "Gunreal"
    Description                     = "Gunreal Mutator"


    // Actor
    RemoteRole                      = ROLE_SimulatedProxy
    bAlwaysRelevant                 = True
    bOnlyDirtyReplication           = True
}
