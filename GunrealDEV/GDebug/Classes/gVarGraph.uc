// ============================================================================
//  gVarGraph.uc :: FStatGraph says hi
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gVarGraph extends gInteractionDebug;


struct WatchItem
{
    var string  Desc;
    var string  Value;
    var float   Data;
};

var() array<WatchItem> Items;

var() bool          bCalcCoords;
var() float         ItemW, ItemH;
var() float         DescX, DescH, DescW;
var() float         ValueX, ValueH, ValueW;
var() float         MonitorX, MonitorY;
var() color         CBackground;
var() Texture       TBackground;
var() color         CText;
var() int           ItemMargin, TextMargin;
var() int           nGraph;
var() float         fGraphMax, fDataMax;
var class<gGraph>  GraphClass;


var(Graph) gGraph  Graph;
var(Graph) string   GraphCmd;
var(Graph) int      GraphMargin;
var(Graph) int      GraphX,GraphY,GraphW,GraphH;
var(Graph) byte     GraphAlpha;
var(Graph) byte     GraphRange;
var(Graph) string   GraphFilter;
var(Graph) Color    CGraph[6];
var(Graph) float    GraphRescaleThresh;
var(Graph) float    GraphRescaleTime;


simulated event NotifyLevelChange()
{
    if( default.Graph != None )
        default.Graph.Destroy();

    Graph = None;
    default.Graph = None;

    Super.NotifyLevelChange();
}

//var swSpriteEmitter MySpriteEmitter;
//var swEmitter MyEmitter;
//
//event Tick(float DeltaTime)
//{
//    if( ViewportOwner.Actor != None )
//    {
//        foreach ViewportOwner.Actor.DynamicActors(class'swEmitter',MyEmitter)
//        {
//            MySpriteEmitter = swSpriteEmitter(MyEmitter.Emitters[0]);
//            MySpriteEmitter.Update(ViewportOwner.Actor.Level.TimeSeconds);
//            //break;
//        }
//    }
//
////
////    if( MySpriteEmitter != None )
////    {
////        MySpriteEmitter.Update(DeltaTime);
////    }
////    else
////    {
////
////    }
//}

function PreRender( Canvas C )
{

}

function PostRender( Canvas C )
{
    local float YP;
    local int   i, nItem;

    nItem   = default.Items.Length;

    if( ViewportOwner.Actor != None && ViewportOwner.Actor.Pawn != None && nItem != 0 )
    {
        C.Font  = C.default.Font;
        C.Style = 5;

        if( default.Graph == None )
        {
            default.Graph = ViewportOwner.Actor.Spawn(GraphClass);
            Log( "Spawned" @ default.Graph, class.name );
            ResetGraph();
        }

        if( bCalcCoords )
        {
            //LogC( "bCalcCoords", class.name );

            C.StrLen( "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", DescW, DescH );
            C.StrLen( "XXXXXX.XX, XXXXXXX.XX, XXXXXXX.XX", ValueW, ValueH );

            ItemW       = TextMargin + DescW + ValueW + TextMargin;
            ItemH       = FMax(DescH,ValueH) + ItemMargin;
            MonitorX    = 0;
            MonitorY    = default.GraphH;
            DescX       = MonitorX + TextMargin;
            ValueX      = DescX + DescW;
            bCalcCoords = False;

            SetW(ItemW);
            SetX(MonitorX);
        }

        YP = MonitorY;

        for( i=0; i<nItem; ++i )
        {
            // Draw background
            C.DrawColor = CBackground;

            C.CurY = YP;
            C.CurX = MonitorX;
            C.DrawTileStretched( TBackground, ItemW, ItemH );

            // Draw text
            if( i < default.nGraph )
            {
                C.DrawColor = CGraph[i];
                fDataMax = FMax(fDataMax,default.Items[i].Data);
                default.Graph.GraphData( default.Items[i].Desc, default.Items[i].Data );
            }
            else
            {
                C.DrawColor = CText;
            }

            C.CurY = YP;
            C.CurX = DescX;
            C.DrawText( default.Items[i].Desc, False );

            C.DrawColor = CText;
            C.CurY = YP;
            C.CurX = ValueX;
            C.DrawText( default.Items[i].Value, False );

            YP += ItemH;
        }

        default.Items.Remove(0, nItem);
        default.nGraph = 0;
        fGraphMax = FMax(fGraphMax,fDataMax);
        //Add(fGraphMax,fDataMax);
    }
}

static final function Add( coerce string Desc, coerce string Value, optional bool bGraph )
{
    local WatchItem WI;

    if( default.bVisible )
    {
        WI.Desc     = Desc;
        WI.Value    = Value;
        WI.Data     = float(Value);

        if( bGraph && default.nGraph < 6 )
        {
            default.Items.Insert(default.nGraph,1);
            default.Items[default.nGraph] = WI;
            ++default.nGraph;
        }
        else
        {
            default.Items[default.Items.Length] = WI;
        }
    }
}


//event Tick( float DeltaTime )
//{
//    if( fDataMax ~= 0 || fGraphMax / fDataMax < GraphRescaleThresh )
//    {
//        if( GraphRescaleTime > default.GraphRescaleTime )
//        {
//            ConsoleCommand( GraphCmd @ "RESCALE" );
//            fGraphMax = 0;
//            GraphRescaleTime = 0;
//        }
//        GraphRescaleTime += DeltaTime;
//    }
//    else
//    {
//        GraphRescaleTime = 0;
//    }
//    fDataMax = 0;
//}


// ============================================================================

final function ToggleGraph()
{
    ConsoleCommand( GraphCmd @ "SHOW" );
}

final function ToggleKey()
{
    ConsoleCommand( GraphCmd @ "KEY" );
}


// ============================================================================

final function Rescale()
{
    Log( "RESCALE", class.name );
    ConsoleCommand( GraphCmd @ "RESCALE" );
}

final function LockScale()
{
    ConsoleCommand( GraphCmd @ "LOCKSCALE" );
}


// ============================================================================

final function AddStat( string S )
{
    ConsoleCommand( GraphCmd @ "ADDSTAT=" $ S );
}


// ============================================================================

final function SetFilter( string S )
{
    GraphFilter = S;
    ConsoleCommand( GraphCmd @ "FILTER=" $ GraphFilter );
}

final function SetAlpha( byte B )
{
    GraphAlpha = B;
    ConsoleCommand( GraphCmd @ "ALPHA=" $ GraphAlpha );
}

final function SetRange( byte B )
{
    GraphRange = B;
    ConsoleCommand( GraphCmd @ "XRANGE=" $ GraphRange );
}


// ============================================================================

final function SetW( int W )
{
    GraphW = W - GraphMargin*2;
    ConsoleCommand( GraphCmd @ "XSIZE=" $ GraphW );
}

final function SetH( int H )
{
    GraphH = H - GraphMargin*2;
    ConsoleCommand( GraphCmd @ "YSIZE=" $ GraphH );
}

final function SetX( int X )
{
    GraphX = X + GraphMargin;
    ConsoleCommand( GraphCmd @ "XPOS=" $ GraphX );
}

final function SetY( int Y )
{
    GraphY = Y + GraphH + GraphMargin;
    ConsoleCommand( GraphCmd @ "YPOS=" $ GraphY );
}


// ============================================================================

final function ResetGraph()
{
    ConsoleCommand( GraphCmd @ "RESCALE" );
    SetFilter(default.GraphFilter);
    SetAlpha(default.GraphAlpha);
    SetRange(default.GraphRange);
    SetW(default.GraphW);
    SetH(default.GraphH);
    SetX(default.GraphX);
    SetY(default.GraphY);
}

DefaultProperties
{
    GraphClass              = class'GDebug.gGraph'
    bCalcCoords             = True
    CBackground             = (R=255,G=255,B=255,A=96)
    CText                   = (R=255,G=255,B=255,A=192)
    TBackground             = Texture'Engine.MenuBlack'
    TextMargin              = 2
    ItemMargin              = 1

    GraphCmd                = "GRAPH"
    GraphMargin             = 12

    GraphH                  = 192
    GraphY                  = 0

    GraphFilter             = "None"
    GraphAlpha              = 80
    GraphRange              = 255

    CGraph(0)               = (R=255,G=127,B=127,A=255)
    CGraph(1)               = (R=255,G=255,B=127,A=255)
    CGraph(2)               = (R=127,G=255,B=127,A=255)
    CGraph(3)               = (R=127,G=255,B=224,A=255)
    CGraph(4)               = (R=127,G=160,B=255,A=255)
    CGraph(5)               = (R=127,G=127,B=255,A=255)

    GraphRescaleThresh      = 0.1
    GraphRescaleTime        = 5


    bActive                 = True
    bVisible                = True
    bRequiresTick           = True
    bNativeEvents           = False
}
