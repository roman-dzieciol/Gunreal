// ============================================================================
//  gVersionCheck.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gVersionCheck extends gActor;


var HttpSock socket, socket2;

var HttpSock InstallerSocket;
var int CurrentVersion;
var int InstallerVersion;


event PostBeginPlay()
{
    //gLog("PostBeginPlay" );
    CheckForUpdates();
}

event Destroyed()
{
    //gLog("Destroyed" );
}


event Timer()
{
    local PlayerController PC;

    //gLog("Timer");
    PC = Level.GetLocalPlayerController();
    if( PC != None && Viewport(PC.Player) != None )
    {
        CheckForUpdates();
    }
}


function CheckForUpdates()
{
    //gLog("CheckForUpdates" );

    CurrentVersion = class'gBuildInfo'.static.GetVersion();
    //l_CurrentVersion.Caption = "Version v" $CurrentVersion;

    InstallerSocket = Spawn(class'HttpSock');

    Reconnect(InstallerSocket);
    SetTimer(0,false);
}

function OnConnectionTimeout(HttpSock Sender)
{
    //gLog("OnConnectionTimeout");
    Reconnect(Sender);
}

function Reconnect(HttpSock Sender)
{
    if( Sender == InstallerSocket )
    {
        InstallerSocket.OnComplete = OnComplete_InstallerSocket;
        //InstallerSocket.OnConnectionTimeout = OnConnectionTimeout;
        InstallerSocket.ClearRequestData();
        InstallerSocket.get("http://www.gunreal.com/updater/Latest.txt");
    }
}

function int GetVersion(HttpSock Sender)
{
    local int i;
    local string s;

    for( i=0; i<Sender.ReturnData.length; ++i )
    {
        s = Sender.ReturnData[i];
        Log( s );
        return int(s);
    }
    return -1;
}

function OnComplete_InstallerSocket(HttpSock Sender)
{
    //gLog("OnComplete_InstallerSocket" );

    InstallerVersion = GetVersion(Sender);
    if( InstallerVersion > CurrentVersion )
        OnNewVersion( InstallerVersion );
}

delegate OnNewVersion( int Version );

DefaultProperties
{
    InstallerVersion=-1
}