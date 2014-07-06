// ============================================================================
//  gTeleporterInfo.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gTeleporterInfo extends gInteraction;

var() float MinAngle;
var() float MaxDist;
var() localized string TeleporterText;
var() array<color> TeamColors;

var gTeleporterInfo StaticRef;

function PostRender( Canvas C )
{
    if( class'gTeleporterPod'.default.PodList != None
    &&  ViewportOwner.Actor != None
    &&  ViewportOwner.Actor.Pawn != None
    &&  gPlayer(ViewportOwner.Actor) != None )
    {
        DrawTeleporterName( C, gPlayer(ViewportOwner.Actor) );
    }
}

static final function StaticCreate( gPlayer PC )
{
    if( default.StaticRef == None )
    {
        default.StaticRef = gTeleporterInfo(PC.Player.InteractionMaster.AddInteraction(string(default.class), PC.Player));
    }
}

function DrawTeleporterName( Canvas C, gPlayer Player )
{
    local gTeleporterPod B, BestPod;
    local float Angle, BestAngle, XL, YL, Dist;
    local vector TE,TS,VR,SV,HL,HN;
    local string S;
    local Volume V, BestVolume;
    local int idx;

    BestAngle = MinAngle;
    TS = Player.Pawn.Location + Player.Pawn.EyePosition();
    VR = vector(Player.GetViewRotation());

    // find teleporter pod
    for( B=class'gTeleporterPod'.default.PodList; B!=None; B=B.PodList )
    {
        if( B.OtherPod != None && B.Physics == PHYS_None && B.OtherPod.Physics == PHYS_None )
        {
            TE = B.Location;
            Dist = VSize(TE-TS);

            if( Player.FastTrace( TE, TS )
            && !B.TraceThisActor(HL,HN,TS+VR*Dist,TS)  )
            {
                Angle = Normal(TE-TS) dot VR;
                if( Angle > BestAngle && Dist < MaxDist )
                {
                    BestAngle = Angle;
                    BestPod = B;
                }
            }
        }
    }
    if( BestPod == None )
        return;


    // construct string

    S = TeleporterText;

    if( BestPod.InstigatorPRI != None )
        S = Repl( S, "%p",  BestPod.InstigatorPRI.PlayerName, True );
    else
        S = Repl( S, "%p", class'gStrings'.default.UnknownPlayer, True );

    foreach BestPod.OtherPod.TouchingActors( class'Volume', V )
    {
        if( V.LocationName != ""
        &&  V.LocationName != class'Volume'.Default.LocationName
        && (BestVolume == None || V.LocationPriority <= BestVolume.LocationPriority )
        &&  V.Encompasses(BestPod.OtherPod) )
        {
            BestVolume = V;
        }
    }

    if( BestVolume != None )
    {
        S = Repl( S, "%w", BestVolume.LocationName, True );
    }
    else if( BestPod.OtherPod.Region.Zone.LocationName != "" )
    {
        S = Repl( S, "%w", BestPod.OtherPod.Region.Zone.LocationName, True );
    }
    else
    {
        S = Repl( S, "%w", class'gStrings'.default.UnknownLocation, True );
    }

    if( BestPod.InstigatorPRI != None
    &&  BestPod.InstigatorPRI.Team != None )
    {
        idx = Min(  BestPod.InstigatorPRI.Team.TeamIndex, TeamColors.Length );
        C.DrawColor = TeamColors[idx];
    }
    else
    {
        C.DrawColor = TeamColors[TeamColors.Length-1];
    }


    // draw string

    C.Style = 5;
    C.ColorModulate = C.default.ColorModulate;
    C.Font = Player.MyHUD.GetConsoleFont(C);
    C.TextSize( S, XL, YL );
    SV = C.WorldToScreen( BestPod.Location );
    C.SetPos( SV.X-XL*0.5, SV.Y-YL*0.5 );
    C.DrawText( S );
}

event NotifyLevelChange()
{
    Master.RemoveInteraction(self);
    default.StaticRef = None;
}

DefaultProperties
{
    TeleporterText      = "%w (%p)"
    MinAngle            = 0.995
    MaxDist             = 384
    TeamColors(0)       = (R=255,G=0,B=0,A=255)
    TeamColors(1)       = (R=0,G=0,B=255,A=255)
    TeamColors(2)       = (R=255,G=255,B=255,A=255)

    bActive             = True
    bVisible            = True
    bRequiresTick       = True
    bNativeEvents       = False
}
