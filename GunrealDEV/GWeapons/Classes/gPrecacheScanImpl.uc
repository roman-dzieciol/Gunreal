// ============================================================================
//  gPrecacheScanImpl.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPrecacheScanImpl extends gPrecacheScan;


var array<Object> PrecacheMaterials;
var array<Object> PrecacheStaticMeshes;
var array<Object> PrecacheSounds;
var array<Object> PrecacheSkelMeshes;

var() string FileName;


final function InsertUniqueSorted( out array<Object> MyArray, Object Obj )
{
    local int i;

    for( i=0; i!=MyArray.Length; ++i )
    {
        if( MyArray[i] == Obj )
            return;
        else if( Caps(MyArray[i]) > Caps(Obj) )
            break;
    }

    MyArray.Insert(i,1);
    MyArray[i] = Obj;
}


event PostBeginPlay()
{
    Super.PostBeginPlay();

    ScanActors();
    Destroy();
}

event Destroyed()
{
    Super.Destroyed();

    Reset();
}

function ScanActors()
{
}

function PrecacheStaticMesh( StaticMesh Obj )
{
    if( Obj != None )
    {
        InsertUniqueSorted( PrecacheStaticMeshes, Obj );
    }
}

function PrecacheMaterial( Material Obj )
{
    if( Obj != None && (Obj.Outer == None || (Obj.Outer.Name != 'Engine' && Obj.Outer.Name != 'Editor')) )
    {
        InsertUniqueSorted( PrecacheMaterials, Obj );
    }
}

function PrecacheSound( Sound Obj )
{
    if( Obj != None )
    {
        InsertUniqueSorted( PrecacheSounds, Obj );
    }
}

function PrecacheSkelMesh( Mesh Obj )
{
    if( Obj != None )
    {
        InsertUniqueSorted( PrecacheSkelMeshes, Obj );
    }
}

function PrecacheClass( class C )
{
    local int i;
    local class<Emitter> CEM;
    local ParticleEmitter PE;

    if( class<Actor>(C) != None )
    {
        PrecacheObject( class<Actor>(C).default.Mesh );
        PrecacheObject( class<Actor>(C).default.StaticMesh );
        PrecacheObject( class<Actor>(C).default.Texture );
        PrecacheObject( class<Actor>(C).default.OverlayMaterial );
        PrecacheObject( class<Actor>(C).default.RepSkin );
        PrecacheObject( class<Actor>(C).default.UV2Texture );
        PrecacheObject( class<Actor>(C).default.HighDetailOverlay );

        if( class<Actor>(C).default.Skins.Length != 0 )
        {
            for( i=0; i<class<Actor>(C).default.Skins.Length; ++i )
            {
                PrecacheObject( class<Actor>(C).default.Skins[i] );
            }
        }

        if( class<Controller>(C) != None )
        {
            if( class<gPlayer>(C) != None )
                class<gPlayer>(C).static.PrecacheScan(self);

            else if( class<gBot>(C) != None )
                class<gBot>(C).static.PrecacheScan(self);

            else if( class<gTurretController>(C) != None )
                class<gTurretController>(C).static.PrecacheScan(self);
        }
        else if( class<Emitter>(C) != None )
        {
            CEM = class<Emitter>(C);
            if( CEM.default.Emitters.Length != 0 )
            {
                for( i=0; i<CEM.default.Emitters.Length; ++i )
                {
                    PE = CEM.default.Emitters[i];
                    if( PE != None )
                    {
                        PrecacheObject( PE.MeshSpawningStaticMesh );
                        PrecacheObject( PE.Texture );

                        if( MeshEmitter(PE) != None )
                        {
                            PrecacheObject( MeshEmitter(PE).StaticMesh );
                        }
                    }
                }
            }
            if( class<gEmitter>(C) != None )
                class<gEmitter>(C).static.PrecacheScan(self);
        }
        else if( class<DamageType>(C) != None )
        {
            PrecacheObject( class<DamageType>(C).default.DamageOverlayMaterial );
            PrecacheObject( class<DamageType>(C).default.DeathOverlayMaterial );
            if( class<gDamageType>(C) != None )
                class<gDamageType>(C).static.PrecacheScan(self);
            else if( class<gDamTypeWeapon>(C) != None )
                class<gDamTypeWeapon>(C).static.PrecacheScan(self);
        }
        else if( class<Inventory>(C) != None )
        {
            PrecacheObject( class<Inventory>(C).default.IconMaterial );
            PrecacheObject( class<Inventory>(C).default.PickupClass );
            PrecacheObject( class<Inventory>(C).default.AttachmentClass );

            if( class<Ammunition>(C) != None )
            {
                PrecacheObject( class<Ammunition>(C).default.IconFlashMaterial );
            }
            else if( class<Weapon>(C) != None )
            {
                PrecacheObject( class<Weapon>(C).default.FireModeClass[0] );
                PrecacheObject( class<Weapon>(C).default.FireModeClass[1] );
                PrecacheObject( class<Weapon>(C).default.CustomCrossHairTexture );
                PrecacheObject( LoadMaterial( class<Weapon>(C).default.CustomCrossHairTextureName ) );
                if( class<gWeaponBase>(C) != None )
                    class<gWeaponBase>(C).static.PrecacheScan(self);
                else if( class<gTransLauncherWeapon>(C) != None )
                    class<gTransLauncherWeapon>(C).static.PrecacheScan(self);
            }
        }
        else if( class<Pawn>(C) != None )
        {
            if( class<gPawn>(C) != None )
                class<gPawn>(C).static.PrecacheScan(self);
            else if( class<gTurret>(C) != None )
                class<gTurret>(C).static.PrecacheScan(self);
        }
        else if( class<Projector>(C) != None )
        {
            PrecacheObject( class<Projector>(C).default.ProjTexture );
            if( class<gScorch>(C) != None )
                class<gScorch>(C).static.PrecacheScan(self);
        }
        else if( class<Pickup>(C) != None )
        {
            PrecacheObject( class<Pickup>(C).default.PickupSound );
            if( class<gPickup>(C) != None )
                class<gPickup>(C).static.PrecacheScan(self);
            else if( class<gTerminal>(C) != None )
                     class<gTerminal>(C).static.PrecacheScan(self);
            else if( class<gVirtualPickup>(C) != None )
                     class<gVirtualPickup>(C).static.PrecacheScan(self);
            else if( class<gWeaponPickup>(C) != None )
                     class<gWeaponPickup>(C).static.PrecacheScan(self);
            else if( class<gDarkMatterPickup>(C) != None )
                     class<gDarkMatterPickup>(C).static.PrecacheScan(self);
        }
        else if( class<Projectile>(C) != None )
        {
            PrecacheObject( class<Projectile>(C).default.SpawnSound );
            PrecacheObject( class<Projectile>(C).default.ImpactSound );
            PrecacheObject( class<Projectile>(C).default.MyDamageType );
            PrecacheObject( class<Projectile>(C).default.ExplosionDecal );
            if( class<gProjectile>(C) != None )
                class<gProjectile>(C).static.PrecacheScan(self);
        }
        else if( class<WeaponAttachment>(C) != None )
        {
            PrecacheObject( class<WeaponAttachment>(C).default.SplashEffect );
            if( class<gWeaponAttachment>(C) != None )
                class<gWeaponAttachment>(C).static.PrecacheScan(self);
            else if( class<gTurretWeaponAttachment>(C) != None )
                class<gTurretWeaponAttachment>(C).static.PrecacheScan(self);
        }
        else if( class<xPickupBase>(C) != None )
        {
            PrecacheObject( class<xPickupBase>(C).default.PowerUp );
            PrecacheObject( class<xPickupBase>(C).default.SpiralEmitter );
            PrecacheObject( class<xPickupBase>(C).default.NewStaticMesh );
            if( class<gPickupBase>(C) != None )
                class<gPickupBase>(C).static.PrecacheScan(self);
        }
        else if( class<gActor>(C) != None )
                 class<gActor>(C).static.PrecacheScan(self);
        else if( class<gHitGroup>(C) != None )
                 class<gHitGroup>(C).static.PrecacheScan(self);
        else if( class<gGib>(C) != None )
                 class<gGib>(C).static.PrecacheScan(self);
    }
    else if( class<WeaponFire>(C) != None )
    {
        PrecacheObject( class<WeaponFire>(C).default.FireSound );
        PrecacheObject( class<WeaponFire>(C).default.ReloadSound );
        PrecacheObject( class<WeaponFire>(C).default.NoAmmoSound );
        PrecacheObject( class<WeaponFire>(C).default.AmmoClass );
        PrecacheObject( class<WeaponFire>(C).default.ProjectileClass );
        PrecacheObject( class<WeaponFire>(C).default.FlashEmitterClass );
        PrecacheObject( class<WeaponFire>(C).default.SmokeEmitterClass );
        if( class<gWeaponFire>(C) != None )
            class<gWeaponFire>(C).static.PrecacheScan(self);
    }
}

function Reset()
{
    PrecacheStaticMeshes.Length = 0;
    PrecacheMaterials.Length = 0;
    PrecacheSounds.Length = 0;
    PrecacheSkelMeshes.Length = 0;
}

function ClearLog()
{
    local FileLog FL;
    FL = Spawn(class'FileLog');
    FL.OpenLog(FileName,,True);
    FL.CloseLog();
    FL.Destroy();
}

function WriteLog( string caption )
{
    local int i;
    local FileLog FL;

    FL = Spawn(class'FileLog');
    FL.OpenLog(FileName,,False);

    FL.Logf( "" );
    FL.Logf( "" );
    FL.Logf( "// ============================================================================" );
    FL.Logf( "//  Precache" @caption );
    FL.Logf( "// ============================================================================" );

    // StaticPrecache
    FL.Logf( "" );
    FL.Logf( "static function StaticPrecache(LevelInfo L)" );
    FL.Logf( "{" );

    FL.Logf( Chr(9) $"StaticPrecacheMaterials(L);" );
    FL.Logf( Chr(9) $"StaticPrecacheStaticMeshes(L);" );
    FL.Logf( Chr(9) $"StaticPrecacheSounds(L);" );
    FL.Logf( Chr(9) $"StaticPrecacheSkelMeshes(L);" );

    FL.Logf( "}" );


    // StaticPrecacheMaterials
    FL.Logf( "" );
    FL.Logf( "static function StaticPrecacheMaterials(LevelInfo L)" );
    FL.Logf( "{" );
    FL.Logf( Chr(9) $"Log(default.class.name, 'GunrealPrecacheMAT');" );
    FL.Logf( Chr(9) $"stopwatch(False);" );

    for( i=0; i<PrecacheMaterials.Length; ++i )
        FL.Logf( Chr(9) $"L.AddPrecacheMaterial(Material'" $PrecacheMaterials[i] $"');" );

    FL.Logf( Chr(9) $"stopwatch(True);" );
    FL.Logf( "}" );


    // StaticPrecacheStaticMeshes
    FL.Logf( "" );
    FL.Logf( "static function StaticPrecacheStaticMeshes(LevelInfo L)" );
    FL.Logf( "{" );
    FL.Logf( Chr(9) $"Log(default.class.name, 'GunrealPrecacheSM');" );
    FL.Logf( Chr(9) $"stopwatch(False);" );

    for( i=0; i<PrecacheStaticMeshes.Length; ++i )
        FL.Logf( Chr(9) $"L.AddPrecacheStaticMesh(StaticMesh'" $PrecacheStaticMeshes[i] $"');" );

    FL.Logf( Chr(9) $"stopwatch(True);" );
    FL.Logf( "}" );


    // StaticPrecacheSounds
    FL.Logf( "" );
    FL.Logf( "static function StaticPrecacheSounds(LevelInfo L)" );
    FL.Logf( "{" );
    FL.Logf( Chr(9) $"Log(default.class.name, 'GunrealPrecacheSD');" );
    FL.Logf( Chr(9) $"stopwatch(False);" );

    for( i=0; i<PrecacheSounds.Length; ++i )
        FL.Logf( Chr(9) $"DynamicLoadObject(" $Chr(34) $PrecacheSounds[i] $Chr(34) $", class'Sound', True);" );

    FL.Logf( Chr(9) $"stopwatch(True);" );
    FL.Logf( "}" );


    // StaticPrecacheSkelMeshes
    FL.Logf( "" );
    FL.Logf( "static function StaticPrecacheSkelMeshes(LevelInfo L)" );
    FL.Logf( "{" );
    FL.Logf( Chr(9) $"Log(default.class.name, 'GunrealPrecacheSK');" );
    FL.Logf( Chr(9) $"stopwatch(False);" );

    for( i=0; i<PrecacheSkelMeshes.Length; ++i )
        FL.Logf( Chr(9) $"DynamicLoadObject(" $Chr(34) $PrecacheSkelMeshes[i] $Chr(34) $", class'Mesh', True);" );

    FL.Logf( Chr(9) $"stopwatch(True);" );
    FL.Logf( "}" );


    FL.CloseLog();
    FL.Destroy();
}


function Material LoadMaterial( string S )
{
    return Material(DynamicLoadObject( S, class'Material', True ));
}

function StaticMesh LoadStaticMesh( string S )
{
    return StaticMesh(DynamicLoadObject( S, class'StaticMesh', True ));
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    FileName="PrecacheScan"

}