// ============================================================================
//  gWorldOverlay.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWorldOverlay extends Object;

/*
enum EFrameBufferBlending
{
    0 FB_Overwrite,
    1 FB_Modulate,
    2 FB_AlphaBlend,
    3 FB_AlphaModulate_MightNotFogCorrectly,
    4 FB_Translucent,
    5 FB_Darken,
    6 FB_Brighten,
    7 FB_Invisible,
};

*/

var bool bActive;
var float OverlayTime;

var float OverlayDuration;
var float OverlayFadeInTime;
var float OverlayFadeOutTime;
var float OverlayFadeInCurve;
var float OverlayFadeOutCurve;
var color OverlayBaseColor;
var color OverlayFadeColor;
var color OverlayDrawColor;
var Texture OverlayDrawTexture;

var ColorModifier OverlayModifier;
var FinalBlend OverlayBlend;

var class<gOverlayTemplate> OverlayTemplate;

var CameraOverlay CamOverlay;

final function Init( PlayerController PC )
{
    //gLog( "Init" );

    OverlayModifier = new class'ColorModifier';
    OverlayModifier.RenderTwoSided = False;

    OverlayBlend = new class'FinalBlend';
    OverlayBlend.Material = OverlayModifier;
    OverlayBlend.FrameBufferBlending = FB_Invisible;
    OverlayBlend.ZWrite = False;

    CamOverlay = new class'gCamOverlay_World';
    PC.AddCameraEffect(CamOverlay);
}

final function Free( PlayerController PC )
{
    //gLog( "Free" );

    if( CamOverlay != None )
        PC.RemoveCameraEffect(CamOverlay);

    CamOverlay = None;
}

final event Tick( PlayerController PC, float DeltaTime )
{
    local float Alpha;

    //gLog( "Tick" #bActive #GON(PC) );

    if( bActive )
    {
        if( OverlayTime > OverlayFadeOutTime )
        {
            DisableOverlay();
        }
        else
        {
            if( OverlayTime < 0 )
            {
                if( OverlayTime < -OverlayDuration && OverlayFadeInTime > 0 )
                {
                    // fading in
                    Alpha = FClamp((Abs(OverlayTime) - OverlayDuration) / OverlayFadeInTime,0,1) ** OverlayFadeInCurve;
                    OverlayModifier.Color = LerpColor(Alpha, OverlayBaseColor, OverlayFadeColor);
                    OverlayTime += DeltaTime;

                    // always fade in to 100%, even if framerate too low
                    if( OverlayTime > -OverlayDuration )
                        OverlayTime = -OverlayDuration;
                }
                else
                {
                    // at 100%
                    OverlayModifier.Color = OverlayBaseColor;
                    OverlayTime += DeltaTime;
                }
            }
            else
            {
                if( OverlayFadeOutTime > 0 )
                {
                    // fading out
                    Alpha = FClamp(OverlayTime / OverlayFadeOutTime,0,1) ** OverlayFadeOutCurve;
                    OverlayModifier.Color = LerpColor(Alpha, OverlayBaseColor, OverlayFadeColor);
                }
                OverlayTime += DeltaTime;
            }

            //gLog( "Tick" #Alpha #(OverlayModifier.Color.R @OverlayModifier.Color.G @OverlayModifier.Color.B @OverlayModifier.Color.A));

            if( IsPostRenderSupported(PC) )
            {
                CamOverlay.Alpha = 0.0;
                CamOverlay.OverlayMaterial = None;
            }
            else
            {
                CamOverlay.Alpha = 1.0;
                CamOverlay.OverlayColor = OverlayDrawColor;
                CamOverlay.OverlayMaterial = OverlayBlend;
            }
        }
    }
}

final function bool IsPostRenderSupported( PlayerController PC )
{
    return PC.Pawn != None
        && PC.Pawn.Weapon != None
        &&(PC.Pawn.Weapon.IsA('gWeapon') || PC.Pawn.Weapon.IsA('gTransLauncher'));
}

// show overlay using template class
final function ShowOverlay( class<gOverlayTemplate> Template )
{
    //gLog( "ShowOverlay" #Template );

    bActive = True;
    OverlayTime = (Template.default.Duration + Template.default.FadeInTime) * -1.0;

    OverlayDuration = Template.default.Duration;
    OverlayFadeInTime = Template.default.FadeInTime;
    OverlayFadeOutTime = Template.default.FadeOutTime;
    OverlayFadeInCurve = Template.default.FadeInCurve;
    OverlayFadeOutCurve = Template.default.FadeOutCurve;
    OverlayBaseColor = Template.default.BaseColor;
    OverlayFadeColor = Template.default.FadeColor;
    OverlayDrawColor = Template.default.DrawColor;
    OverlayDrawTexture = Template.default.DrawTexture;

    if( OverlayFadeInTime > 0 )
        OverlayModifier.Color = OverlayFadeColor;
    else
        OverlayModifier.Color = OverlayBaseColor;

    OverlayModifier.Material = OverlayDrawTexture;

    OverlayBlend.FrameBufferBlending = Template.default.Blending;

    CamOverlay.OverlayColor = OverlayDrawColor;
    CamOverlay.OverlayMaterial = OverlayBlend;

    OverlayTemplate = Template;
}

// let the overlay fade out
final function FadeOverlay( optional class<gOverlayTemplate> Template )
{
    //gLog( "FadeOverlay" );
    if( bActive )
    {
        if( Template != None && OverlayTemplate != None && Template != OverlayTemplate )
            return;

        if( OverlayTime < 0 )
            OverlayTime = 0;
    }
}

// clear the overlay
final function ClearOverlay( optional class<gOverlayTemplate> Template )
{
    //gLog( "ClearOverlay" );
    if( bActive )
    {
        if( Template != None && OverlayTemplate != None && Template != OverlayTemplate )
            return;

        DisableOverlay();
    }
}

final function DisableOverlay()
{
    //gLog( "DisableOverlay" );
    bActive = False;
    OverlayTemplate = None;

    CamOverlay.Alpha = 0.0;
    CamOverlay.OverlayMaterial = None;
}

final function PostRender(Canvas C)
{
    if( bActive )
    {
        C.Reset();
        C.DrawColor = OverlayDrawColor;
        //C.Style = 5; // alpha
        C.DrawTile(OverlayBlend, C.SizeX, C.SizeY, 0, 0, 1, 1);
    }
}

final function NotifyDeath()
{
    if( bActive && OverlayTemplate != None )
    {
        switch( OverlayTemplate.default.OnDeath )
        {
            case OA_Fade:
                if( OverlayTime < 0 )
                    OverlayTime = 0;
                break;

            case OA_Clear:
                DisableOverlay();
                break;
        }
    }
}

final function NotifyRespawn()
{
    if( bActive && OverlayTemplate != None )
    {
        switch( OverlayTemplate.default.OnRespawn )
        {
            case OA_Fade:
                if( OverlayTime < 0 )
                    OverlayTime = 0;
                break;

            case OA_Clear:
                DisableOverlay();
                break;
        }
    }
}

final static function color LerpColor( float Alpha, color A, color B )
{
    local color C;
    C.R = Lerp(Alpha, A.R, B.R);
    C.G = Lerp(Alpha, A.G, B.G);
    C.B = Lerp(Alpha, A.B, B.B);
    C.A = Lerp(Alpha, A.A, B.A);
    return C;
}

// ============================================================================
//  Debug Log
// ============================================================================
simulated final function gLog ( coerce string S ){
    class'GDebug.gDbg'.static.oLog( self, GetDebugLevelRef(), S, gDebugString() );}

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
    class'GDebug.gDbg'.static.DrawAxesRot( GetDebugLevelRef(), Loc, Rot, Length, bStaying );}

simulated final function DrawAxesCoords( Coords C, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesCoords( GetDebugLevelRef(), C, Length, bStaying );}

simulated final function DrawAxesXYZ( vector Loc, vector X, vector Y, vector Z, float Length, optional bool bStaying ){
    class'GDebug.gDbg'.static.DrawAxesXYZ( GetDebugLevelRef(), Loc, X, Y, Z, Length, bStaying );}

simulated final static function VarWatch( coerce string Desc, coerce string Value, optional bool bGraph ){
    class'GDebug.gDbg'.static.VarWatch( Desc, Value, bGraph );}

// ============================================================================
//  Debug Misc
// ============================================================================
simulated final function LevelInfo GetDebugLevelRef(){
    return None;}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
}