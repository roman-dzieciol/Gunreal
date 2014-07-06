// ============================================================================
//  g2K4Tab_DetailSettings.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class g2K4Tab_DetailSettings extends UT2K4Tab_DetailSettings;


var automated moCheckBox    ch_ParticleForces;


function SetupPositions()
{
    Super.SetupPositions();
    sb_Section2.ManageComponent(ch_ParticleForces);
}

function InternalOnLoadINI(GUIComponent Sender, string s)
{
    local PlayerController PC;

    PC = PlayerOwner();
    switch( Sender )
    {
        case ch_ParticleForces:
            ch_ParticleForces.SetComponentValue(class'gEmitter'.default.bUseActorForces,true);
            break;

        default:
            Super.InternalOnLoadINI(Sender, s);
    }
}

function InternalOnChange(GUIComponent Sender)
{
    if( bIgnoreChange )
        return;

    switch( Sender )
    {
        case ch_ParticleForces:
            class'gEmitter'.default.bUseActorForces = ch_ParticleForces.IsChecked();
            class'gEmitter'.static.StaticSaveConfig();
            if( class'gEmitter'.default.bUseActorForces )
                ShowPerformanceWarning();
            break;

    }

    Super.InternalOnChange(Sender);
}

function bool RenderDeviceClick( byte Btn )
{
    switch( Btn )
    {
    case QBTN_Yes:
        SaveSettings();
        Console(Controller.Master.Console).DelayedConsoleCommand("relaunch -mod=Gunreal");
        break;

    case QBTN_Cancel:
        sRenDev = sRenDevD;
        co_RenderDevice.Find(sRenDev);
        co_RenderDevice.SetComponentValue(sRenDev,True);
        break;
    }

    return True;
}

DefaultProperties
{
    Begin Object Class=moCheckBox Name=ParticleForces
        WinWidth=0.300000
        WinHeight=0.040000
        WinLeft=0.599727
        WinTop=0.864910
        Caption="Particle Forces (SLOW!)"
        Hint="Enable particles being blown around by some moving things (SLOW!)."
        OnLoadINI=InternalOnLoadIni
        IniOption="@Internal"
        IniDefault="False"
        CaptionWidth=0.94
        bSquare=True
        ComponentJustification=TXTA_Left
        TabOrder=23
        OnChange=InternalOnChange
    End Object
    ch_ParticleForces=ParticleForces
}