// ============================================================================
//  gCheatManager.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCheatManager extends CheatManager within gPlayer;

event Created()
{
    //Log("Created", name);
    GunrealCheats = Self;
}

exec function FlashOverlayClass( class<gOverlayTemplate> Template )
{
    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;
        
    outer.FlashOverlay.ShowOverlay(Template);
}

exec function AmbientOverlayClass( class<gOverlayTemplate> Template )
{
    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;
        
    outer.AmbientOverlay.ShowOverlay(Template);
}

exec function FadeOverlays()
{
    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;
                
    outer.FlashOverlay.FadeOverlay();
    outer.AmbientOverlay.FadeOverlay();
}

exec function ClearOverlays()
{
    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;
        
    outer.FlashOverlay.ClearOverlay();
    outer.AmbientOverlay.ClearOverlay();
}

exec function GShake( class<gShakeView> Template, float Amount )
{
    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;
        
    Log( "ShakeView" @Template @Amount );
    GunrealShake( Template, Amount );
}

exec function AllWeapons()
{
    local int i;

    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone || Pawn == None || Vehicle(Pawn) != None )
        return;

    for( i = 0; i != class'gWeaponsUT'.default.ClassNames.Length; ++i )
        Pawn.GiveWeapon(class'gWeaponsUT'.default.ClassNames[i]);

    for( i = 0; i != class'gWeaponsSuperUT'.default.ClassNames.Length; ++i )
        Pawn.GiveWeapon(class'gWeaponsSuperUT'.default.ClassNames[i]);

    for( i = 0; i != class'gWeaponsGunreal'.default.ClassNames.Length; ++i )
        Pawn.GiveWeapon(class'gWeaponsGunreal'.default.ClassNames[i]);

    ReportCheat("AllWeapons");
}

exec function AllMoney()
{
    local gPRI GPRI;

    GPRI = GetGPRI();

    if( GPRI == None )
        return;

    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;

    if( GPRI != None )
        GPRI.UpdateMoney(9999999, class'gMessageMoneyCheat',,,, True);

    ReportCheat("AllMoney");
}

exec function SuperMoney()
{
	local gPRI GPRI;
	local Controller C;

    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;

	for(C = Level.ControllerList; C != None; C = C.NextController)
	{
		if(C.Pawn != None)
			GPRI = gPlayer(C).GetGPRI();
		if(GPRI == None)
			GPRI = gBot(C).GetGPRI();
		if(GPRI != None && GPRI != GetGPRI())
			GPRI.UpdateMoney(9999999, class'gMessageMoneyCheat',,,, True);

	}

	ReportCheat("SuperMoney");
}

exec function GiveMoney(int Ammount)
{
    local gPRI GPRI;

    GPRI = GetGPRI();

    if( GPRI == None )
        return;

    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;

    if( GPRI != None )
        GPRI.UpdateMoney(Ammount, class'gMessageMoneyCheat',,,, True);

    ReportCheat("GiveMoney");
}

exec function NoMoney()
{
    local gPRI GPRI;

    GPRI = GetGPRI();

    if( GPRI == None )
        return;

    if( !AreCheatsEnabled() ||  Level.Netmode != NM_Standalone )
        return;

    if( GPRI != None )
        GPRI.UpdateMoney(-GPRI.GetMoney(), class'gMessageMoneyCheat',,,, True);

    ReportCheat("NoMoney");
}



exec function dumpnav()
{
    local NavigationPoint N;
    local string S;
    local FileLog F;
    local int i;

    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;

    F = Spawn(class'FileLog');
    F.OpenLog( "dumpnav", "txt", True );
    F.Logf("----");
    F.Logf(string(Level.TimeSeconds));
    F.Logf("----");

    for( N = Level.NavigationPointList; N != None; N = N.nextNavigationPoint )
    {
        CopyObjectToClipboard(N);
        S = PasteFromClipboard();
        F.Logf(S);

        for( i = 0; i != N.PathList.Length; ++i )
        {
            if( N.PathList[i] != None )
            {
                CopyObjectToClipboard(N.PathList[i]);
                S = PasteFromClipboard();
                F.Logf(S);
            }
        }

        F.Logf("");
    }

    F.CloseLog();
    F.Destroy();
}

exec function shownav()
{
    local NavigationPoint N, DN;
    local int i;
    local ReachSpec R;
    local vector DestOffset;
    local color C;

    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;

    hidenav();

    DestOffset = vect(0,0,8);
    DN = Level.NavigationPointList;

    for( N=Level.NavigationPointList; N!=None; N=N.nextNavigationPoint )
    {
        N.bHidden = False;

        for( i=0; i!=N.PathList.Length; ++i )
        {
            R = N.PathList[i];

            if( R != None )
            {
                if( R.Start != None && R.End != None )
                {
                    if( (R.reachFlags & 0x1F) != R.reachFlags )
                    {
                        // special flags, special color
                        C.R = 128;
                        C.G = 0;
                        C.B = 255;
                    }
                    else
                    {
                        C.R = 255;
                        C.G = 255;
                        C.B = 255;
                    }

                    DN.DrawStayingDebugLine(R.Start.Location + DestOffset, R.End.Location - DestOffset, C.R,C.G,C.B);
                }
                else
                {
                     //gLog("INVALID REACHSPEC" #GON(N)  #GON(R) #GON(R.Start) #GON(R.End));
                     Log("INVALID REACHSPEC" @N  @R @R.Start @R.End);
                     DN.DrawStayingDebugLine(N.Location, N.Location+vect(0,0,255), 255,0,0);
                }
            }
        }

    }
}

exec function hidenav()
{
    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;

    Level.NavigationPointList.ClearStayingDebugLines();
}

exec function debugproj()
{
    local Object O;

    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;
        
    foreach AllObjects(class'Object',O)
    {
        if( class<gProjectile>(O) != None )
        {
            class<gProjectile>(O).default.AttachmentClass = class'GEffects.gCoordsEmitter';
            class<gProjectile>(O).default.HitGroupClass = class'GEffects.gHitGroupDebug';
            class<gProjectile>(O).default.HitEffectClass = class'GEffects.gCoordsEmitter';
            class<gProjectile>(O).default.BounceEmitterClass = class'GEffects.gCoordsEmitter';
        }
    }
}



exec function HSuicide()
{
    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;

    Pawn.TakeDamage(99, Pawn, Pawn.Location, vect(0,0,50000), class'gDamTypeHeadshotSuicide');
}


exec function nuke()
{
    local Pawn p;
    
    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;   

    foreach DynamicActors(class'Pawn', p)
    {
        if( p.Controller != Level.GetLocalPlayerController() )
            p.TakeDamage(1000, Pawn, p.Location, p.Velocity, class'Gibbed');
    }
}

exec function nuke2()
{
    local Pawn p;

    if( !AreCheatsEnabled() || Level.Netmode != NM_Standalone )
        return;
        
    foreach DynamicActors(class'Pawn', p)
    {
        if( p.Controller != Level.GetLocalPlayerController() )
        {
            p.TakeDamage(1000, Pawn, p.GetBoneCoords('head').Origin, p.Velocity, class'DamageType');
        }
    }
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
}