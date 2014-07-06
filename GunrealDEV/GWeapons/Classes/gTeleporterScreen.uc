// ============================================================================
//  gTeleporterScreen.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterScreen extends gActor;

//
// Requirements:
//
// * Draw portal only when local player is close enough and pointing at beacon
// * Fade in and out
// * Fade out when camera is destroyed
// * Don't update screen when fading out but keep the rotation correct
//

var() float                 FOV;
var() float                 RefreshRate;

var   Actor                 Camera;
var   PlayerController      Player;
var   float                 Alpha;
var   Pawn                  LocalPawn;

var   ScriptedTexture       ScreenTex;
var   TexScaler             ScreenScaler;
var   gTeleporterShader     ScreenShader;
var   gTeleporterFader      ScreenFader;
var   gTeleporterBlend      ScreenBlend;

var   float                 FadeInSpeed;
var   float                 FadeOutSpeed;
var   float                 DrawAngle;
var   float                 YawOffset;
var   float                 MinCameraDist;

// ============================================================================
// Lifespan
// ============================================================================
event PostBeginPlay()
{
    local Pawn P;

    //gLog( "PostBeginPlay" );
    SetTimer(0.3, True);

    Player = Level.GetLocalPlayerController();

    foreach TouchingActors(class'Pawn', P)
        Touch(P);

    Super.PostBeginPlay();
}

event Destroyed()
{
    //gLog( "Destroyed" );
    if( ScreenTex != None )
    {
        ScreenTex.Client = None;
        Level.ObjectPool.FreeObject(ScreenTex);
        ScreenTex = None;
    }

    if( ScreenScaler != None )
    {
        ScreenScaler.Material = None;
        Level.ObjectPool.FreeObject(ScreenScaler);
        ScreenScaler = None;
    }

    if( ScreenShader != None )
    {
        ScreenShader.Diffuse = None;
        ScreenShader.SelfIllumination = None;
        Level.ObjectPool.FreeObject(ScreenShader);
        ScreenShader = None;
    }

    if( ScreenFader != None )
    {
        ScreenFader.Material = None;
        Level.ObjectPool.FreeObject(ScreenFader);
        ScreenFader = None;
    }

    if( ScreenBlend != None )
    {
        ScreenBlend.Material = None;
        Level.ObjectPool.FreeObject(ScreenBlend);
        ScreenBlend = None;
    }

    Skins.Length = 0;

    Super.Destroyed();
}

event Timer()
{
    //gLog( "Timer" );
    if( gTeleporterPod(Owner) != None && Camera != gTeleporterPod(Owner).OtherPod )
        Trigger(gTeleporterPod(Owner).OtherPod, None);
}

event Trigger(Actor Other, Pawn EventInstigator)
{
    //gLog( "Trigger" #GON(Other) );

    Camera = Other;
    if( Camera == None )
        return;

    if( Skins.Length == 0 )
    {
        ScreenTex = ScriptedTexture(Level.ObjectPool.AllocateObject(class'ScriptedTexture'));
        ScreenTex.SetSize(512,512);
        ScreenTex.FallBackMaterial = Texture'Engine.DefaultTexture';
        ScreenTex.Client = Self;

        ScreenScaler = TexScaler(Level.ObjectPool.AllocateObject(class'TexScaler'));
        ScreenScaler.Material = ScreenTex;
        ScreenScaler.UScale = -0.5;

        ScreenShader = gTeleporterShader(Level.ObjectPool.AllocateObject(class'GEffects.gTeleporterShader'));
        ScreenShader.Diffuse = ScreenScaler;
        ScreenShader.SelfIllumination = ScreenScaler;

        ScreenFader = gTeleporterFader(Level.ObjectPool.AllocateObject(class'GEffects.gTeleporterFader'));
        ScreenFader.Material = ScreenShader;
        ScreenFader.Color.A = 0;

        ScreenBlend = gTeleporterBlend(Level.ObjectPool.AllocateObject(class'GEffects.gTeleporterBlend'));
        ScreenBlend.Material = ScreenFader;

        Skins[0] = ScreenBlend;
    }

    if(LocalPawn != None
        && Owner != None
        && Owner.Base != None
        && VSize(Location - PrePivot - Player.CalcViewLocation) > MinCameraDist
        && vector(Player.CalcViewRotation) dot Normal(Location - PrePivot - Player.CalcViewLocation) < DrawAngle)
    {
        GotoState('Active');
    }
    else
    {
        GotoState('StandBy');
    }
}

event RenderTexture(ScriptedTexture Tex)
{
    local rotator R;

    //gLog( "RenderTexture" #Screen.Revision #Tex );

    if( Player != None && Camera != None )
    {
        // Rotate actor so no seams are visible
        R.Yaw = rotator(Location - PrePivot - Player.CalcViewLocation).Yaw;
        SetRotation(R + rot(0, 1, 0) * YawOffset);

        // Render to texture
        Tex.DrawPortal(0, 0, Tex.USize, Tex.VSize, Self, Camera.Location - PrePivot, R, FOV, True);
    }
}

event Touch(Actor Other)
{
    if( Other != None && Player != None && Player.Pawn == Other )
    {
        //gLog( "Touch" #Other );
        LocalPawn = Pawn(Other);
    }
}

event UnTouch(Actor Other)
{
    if( Other != None && Player != None && Player.Pawn == Other )
    {
        //gLog( "UnTouch" #Other );
        LocalPawn = None;
    }
}

function Teleported(Actor Other)
{
    // If this screen will be visible after teleporting it needs proper rotation
    if( Player != None )
        SetRotation(rot(0, 1, 0) * (rotator(Location - PrePivot - Player.CalcViewLocation).Yaw  + YawOffset));
}

// ============================================================================
// StandBy
// ============================================================================
state StandBy
{
    event BeginState()
    {
        //gLog( "BeginState" );
        SetTimer( 0.3, True );

        if( Alpha != 0 )
            Enable('Tick');
        else
            bHidden = True;
    }

    event Timer()
    {
        Global.Timer();

        if(Camera != None
        && Owner != None
        && Owner.Base != None
        && LocalPawn != None
        && VSize(Location - PrePivot - Player.CalcViewLocation) > MinCameraDist
        && vector(Player.CalcViewRotation) dot Normal(Location - PrePivot - Player.CalcViewLocation) > DrawAngle)
        {
            GotoState('Active');
        }
    }

    event Tick(float DT)
    {
        Alpha = FMax( 0, Alpha - DT * FadeOutSpeed );
        ScreenFader.Color.A = Alpha * float(255);

        if( Alpha == 0 )
        {
            Disable('Tick');
            bHidden = True;
        }
        else if( Player != None )
        {
            SetRotation(rot(0,1,0) * (rotator(Location - PrePivot - Player.CalcViewLocation).Yaw  + YawOffset));
        }
    }
}

// ============================================================================
// Active
// ============================================================================
state Active
{
    event BeginState()
    {
        //gLog( "BeginState" );
        SetTimer(1.0 / RefreshRate, True);

        bHidden = False;
        if( Alpha != 1 )
            Enable('Tick');

        if( gTeleporterPod(Owner) != None )
            gTeleporterPod(Owner).Activate();
    }

    event EndState()
    {
        if( gTeleporterPod(Owner) != None )
            gTeleporterPod(Owner).Deactivate();
    }

    event Timer()
    {
        //gLog( "Timer" );
        Global.Timer();

        if(Camera == None
            || LocalPawn == None
            || VSize(Location - PrePivot - Player.CalcViewLocation) < MinCameraDist
            || vector(Player.CalcViewRotation) dot Normal(Location - PrePivot - Player.CalcViewLocation) < DrawAngle)
        {
            GotoState('Standby');
        }
        else
        {
            ScreenTex.Revision++;
        }
    }

    event Tick(float DT)
    {
        //gLog( "Tick" #Alpha );
        Alpha = FMin(1, Alpha + DT * FadeInSpeed);
        ScreenFader.Color.A = Alpha * float(255);

        if( Alpha == 1 )
            Disable('Tick');
    }
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    FadeInSpeed                     = 3
    FadeOutSpeed                    = 5

    FOV                             = 90.0
    RefreshRate                     = 42.5
    DrawAngle                       = 0.86
    MinCameraDist                   = 64

    YawOffset                       = 16384

    CollisionRadius                 = 384
    CollisionHeight                 = 192

    DrawScale                       = 1.25
    DrawType                        = DT_StaticMesh
    StaticMesh                      = StaticMesh'XGame_StaticMeshes.teleporter-proc'

    bProjTarget                     = False
    bCollideActors                  = True
    bCollideWorld                   = False
    bBlockActors                    = False
    bBlockZeroExtentTraces          = True
    bBlockNonZeroExtentTraces       = True
    bUseCylinderCollision           = True
    bUseCollisionStaticMesh         = False
    bHardAttach                     = False
    bOnlyAffectPawns                = True
    bCollideWhenPlacing             = False
    Physics                         = PHYS_Trailer
    bTrailerAllowRotation           = True
    bTrailerPrePivot                = True
    PrePivot                        = (Z=-80)

    RemoteRole                      = ROLE_None
}