// ============================================================================
//  gDarkMatterPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gDarkMatterPickup extends AdrenalinePickup;


var() Sound             SpawnSound;
var() class<gEmitter>   SpawnEmitterClass;
var() class<gEmitter>   PickupEmitterClass;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan(gPrecacheScan S)
{
    S.PrecacheObject(default.SpawnSound);
    S.PrecacheObject(default.SpawnEmitterClass);
    S.PrecacheObject(default.PickupEmitterClass);
}


// ============================================================================
//  Pickup
// ============================================================================

function RespawnEffect()
{
    Spawn(SpawnEmitterClass);
    PlaySound(SpawnSound, SLOT_None);
}

function SetRespawn()
{
    Spawn(PickupEmitterClass);
    Super.SetRespawn();
}

function AnnouncePickup(Pawn Receiver)
{
    Receiver.HandlePickup(Self);
    PlaySound(PickupSound, SLOT_None);
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    DrawScale                   = 0.25
    StaticMesh                  = StaticMesh'G_Meshes.Pickups.adrenaline_1'

    bUnlit                      = False
    bAmbientGlow                = False
    AmbientGlow                 = 0

    MessageClass                = class'GGame.gPickupMessage'
    PickupMessage               = "Dark Matter "

    PickupSound                 = Sound'G_Sounds.g_adren_pickup1'
    SpawnSound                  = Sound'G_Sounds.g_item_resp_a'
    TransientSoundVolume        = 1.0
    TransientSoundRadius        = 256.0

    SpawnEmitterClass           = class'GEffects.gAdrenalinePickupSpawnEmitter'
    PickupEmitterClass          = class'GEffects.gAdrenalinePickupPickupEmitter'
}