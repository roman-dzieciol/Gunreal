// ============================================================================
//  gFadingScorch.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gFadingScorch extends gScorch;

var()   array<Texture>  ProjTextures;
var()   Combiner        BlackCombiner;
var()   FadeColor       BlackFader;
var()   color           Color1;
var()   color           Color2;
var()   float           FadePeriod;


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    local int i;
    Super.PrecacheScan(S);
    for( i=0; i!=default.ProjTextures.Length; ++i )
        S.PrecacheObject(default.ProjTextures[i]);
}


// ============================================================================
//  Scorch
// ============================================================================

simulated event PreBeginPlay()
{
    if( Level.NetMode == NM_DedicatedServer )
    {
        GotoState('NoProjection');
    }
    else
    {
        Super(XScorch).PreBeginPlay();
    }
}


simulated event PostBeginPlay()
{
    local vector RX, RY, RZ;
    local rotator R;

    //Log( "PostBeginPlay", name );

    if( RandomOrient )
    {
        R.Yaw = 0;
        R.Pitch = 0;
        R.Roll = Rand(36)*1820;
        GetAxes(R,RX,RY,RZ);
        RX = RX >> Rotation;
        RY = RY >> Rotation;
        RZ = RZ >> Rotation;
        R = OrthoRotation(RX,RY,RZ);
        SetRotation(R);
    }

    SetLocation( Location - vector(Rotation)*PushBack );

    Lifespan = FMax(0.5, LifeSpan + (Rand(4) - 2))*Level.DecalStayScale;
    if( Level.bDropDetail )
        LifeSpan *= 0.5;

    if( Level.NetMode == NM_DedicatedServer )
    {
        GotoState('NoProjection');
        return;
    }

    BlackCombiner = Combiner(Level.ObjectPool.AllocateObject(class'Combiner'));
    BlackFader = FadeColor(Level.ObjectPool.AllocateObject(class'FadeColor'));

    BlackCombiner.CombineOperation = CO_Multiply;
    BlackCombiner.AlphaOperation = AO_Use_Alpha_From_Material1;
    BlackCombiner.Material1 = ProjTextures[Rand(ProjTextures.Length)];
    BlackCombiner.Material2 = BlackFader;

    BlackFader.FadePeriod = LifeSpan*FadePeriod;
    BlackFader.FadePhase = -Level.TimeSeconds;
    BlackFader.Color1 = Color1;
    BlackFader.Color2 = Color2;

    ProjTexture = BlackCombiner;
    SetTimer(BlackFader.FadePeriod,False);

    AttachProjector( FadeInTime );
    if( bProjectActor )
        SetCollision(True, False, False);

    AbandonProjector(LifeSpan);

    //log( level.timeseconds @BlackFader.FadePeriod @BlackFader.FadePhase @BlackCombiner.Material1 @ProjTexture );
}

simulated event Timer()
{
    //Log( "Timer", name );
    BlackFader.FadePeriod = 0;
}

simulated event Destroyed()
{
    //Log( "Destroyed", name );

    if( BlackFader != None )
    {
        Level.ObjectPool.FreeObject(BlackFader);
        BlackFader = None;
    }

    if( BlackCombiner != None )
    {
        Level.ObjectPool.FreeObject(BlackCombiner);
        BlackCombiner = None;
    }

    Super.Destroyed();
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    RemoteRole                  = ROLE_SimulatedProxy
    bNetTemporary               = True
    bNetInitialRotation         = True

    Color1                      = (R=255,G=255,B=255,A=255)
    Color2                      = (R=0,G=0,B=0,A=255)

    FrameBufferBlendingOp       = PB_AlphaBlend
    DrawScale                   = 0.8
    CullDistance                = 7000.0
    LifeSpan                    = 10
    ProjTextures(0)             = Texture'G_FX.Plasmafx.Psplat_1'
    ProjTexture                 = Texture'Editor.Bad'
    FadePeriod                  = 0.375

    MaxTraceDistance            = 128
    bProjectBSP                 = True
    bProjectTerrain             = True
    bProjectStaticMesh          = True
    bProjectParticles           = False
    bProjectActor               = False
    bLevelStatic                = False
    bClipBSP                    = True
    bClipStaticMesh             = True
    bGradient                   = False
    bProjectOnUnlit             = True
    bProjectOnBackfaces         = False
    bProjectOnAlpha             = True
    bProjectOnParallelBSP       = True
    bDynamicAttach              = False
    bNoProjectOnOwner           = True
    FadeInTime                  = 0.1
}
