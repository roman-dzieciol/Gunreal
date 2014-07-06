// ============================================================================
//  gPlayerHUD.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlayerHUD extends gObject
    within gPlayer
	config;


var() Color                             MoneyColor;
var() Color                             MoneyColorShopping;
var() Color                             MoneyColorPoor;

var() float              				SurvivalTime;
var() float                             SurvivalFadeTime;
var() localized string                  SurvivalCaption;

var() HudBase.SpriteWidget              NoKillIcon;
var() float                             NoKillFadeTime;
var() localized string                  NoKillCaption;

var() float                             ShopHintY;
var() Color                             ShopHintColor;
var() localized string                  ShopHint;

var() localized string                  VehicleHint;
var() localized string                  WeaponPickupHint;

var() config string						LastBackground;
var() float								LoadingFadeTime;

static function PrecacheScan( gPrecacheScan S )
{
    S.PrecacheObject(default.NoKillIcon.WidgetTexture);
}

simulated function Free()
{
    //gLog( "Free" );

    ClearOuter();
}

simulated function ClientSetHUD(class<HUD> newHUDClass, class<Scoreboard> newScoringClass)
{
    local HudCDeathMatch H;

    // non-team games have any hud color you want, as long as it's black.
    H = HudCDeathMatch(MyHUD);
    if( H != None && HudCTeamDeathMatch(H) == None )
    {
        H.HudColorRed = H.HudColorNormal;
        H.HudColorBlue = H.HudColorNormal;
        H.default.HudColorRed = H.HudColorNormal;
        H.default.HudColorBlue = H.HudColorNormal;
        H.HudColorTeam[0] = H.HudColorNormal;
        H.HudColorTeam[1] = H.HudColorNormal;
        H.default.HudColorTeam[0] = H.HudColorNormal;
        H.default.HudColorTeam[1] = H.HudColorNormal;
    }
}

function SetupGunrealCrosshair()
{
    local int i;
    local array<CacheManager.CrosshairRecord> CustomCrosshairs;

    class'CacheManager'.static.GetCrosshairList(CustomCrosshairs);
    for( i=0; i<CustomCrosshairs.Length; ++i )
    {
        if( CustomCrosshairs[i].FriendlyName ~= "Gunreal Default" )
        {
            class'HudBase'.default.bUseCustomWeaponCrosshairs = False;
            class'HudBase'.static.StaticSaveConfig();

            class'HUD'.default.CrosshairStyle = i;
            class'HUD'.default.CrosshairScale = 0.8;
            class'HUD'.default.CrosshairOpacity = 1.0;
            class'HUD'.default.CrossHairColor = class'HUD'.default.WhiteColor;
            class'HUD'.static.StaticSaveConfig();

            bGunrealCrosshair = True;
            SaveConfig();
            break;
        }
    }
}

simulated function RenderOverlaysDead(Canvas C)
{
    local float XL, YL;

    RenderOverlays(C);

    if( bUseShopping )
    {
        C.DrawColor = ShopHintColor;
        C.Font = MyHUD.GetConsoleFont(C);
        C.TextSize(ShopHint, XL, YL);
        C.SetPos((C.ClipX - XL)*0.5, C.ClipY * ShopHintY);
        C.DrawText(ShopHint);
    }
}

simulated function RenderOverlaysWaiting(Canvas C)
{
    local float XL, YL;

    RenderOverlays(C);

    if( bUseShopping )
    {
        C.DrawColor = ShopHintColor;
        C.Font = MyHUD.GetConsoleFont(C);
        C.TextSize(ShopHint, XL, YL);
        C.SetPos((C.ClipX - XL)*0.5, C.ClipY * ShopHintY);
        C.DrawText(ShopHint);
    }
}

simulated function RenderOverlays(Canvas C)
{
    local HudCDeathMatch HUD;
    local gTerminal T;
    local gWeaponPickup WP;
    local vehicle V;

    local gPRI GPRI;
    local gBot gb;
    local float Width;
    local float Height;
    local float XL, YL;
    local float MultiplierTime, Multiplier;
    local bool bTouchingTerminal, bTouchingWeaponPickup, bTouchingVehicle;
    local int MyCurrentRanking, i;

    HUD = HudCDeathMatch(MyHUD);

    GPRI = GetGPRI();

    if( bRestoreWeaponBar )
    {
        bRestoreWeaponBar = False;

        if( MyHUD != None )
            MyHUD.bShowWeaponBar = True;
    }

    // Draw only if HUD.DrawHUD() will be called
    if(HUD.bShowDebugInfo
        || HUD.bHideHud
        || HUD.bShowLocalStats
        || HUD.bShowScoreBoard
        || HUD.PlayerOwner == None
        || HUD.PawnOwnerPRI == None
        || (HUD.PlayerOwner.IsSpectating() && HUD.PlayerOwner.bBehindView)
        || (Pawn != None && Pawn.bHideRegularHUD))
        return;

    if( gPawn(ViewTarget) != None )
    {
        gb = gBot(gPawn(ViewTarget).Controller);

        if( gb != None )
            GPRI = gb.GetGPRI();

        if( GPRI != None )
        {
            C.DrawColor = MoneyColor;

            if( Pawn != None )
            {
            	foreach Pawn.VisibleCollidingActors(class'gTerminal',T,2048)
            	{
            		T.RenderHealthBar(C);
            	}
            
                foreach Pawn.TouchingActors(class'gWeaponPickup', WP) {
                    if(WP != None) {
                        bTouchingWeaponPickup = True;
                        break;
                    }
                }
                if(!bTouchingWeaponPickup) {
                    foreach Pawn.TouchingActors(class'gTerminal', T) {
                        if(T != None) {
                            bTouchingTerminal = True;
                            break;
                        }
                    }
                    if(!bTouchingTerminal) {
                        foreach Pawn.TouchingActors(class'Vehicle', V) {
                            if(V != None) {
                                bTouchingVehicle = True;
                                break;
                            }
                        }
                    }
                }
            }
            if(bTouchingWeaponPickup) {
                C.DrawColor = ShopHintColor;
                C.Font = MyHUD.GetConsoleFont(C);
                C.TextSize(WeaponPickupHint, XL, YL);
                C.SetPos((C.ClipX - XL) * 0.5, C.ClipY * ShopHintY);
                C.DrawText(WeaponPickupHint);
            } else if(bTouchingTerminal) {
                C.DrawColor = ShopHintColor;
                C.Font = MyHUD.GetConsoleFont(C);
                C.TextSize(ShopHint, XL, YL);
                C.SetPos((C.ClipX - XL) * 0.5, C.ClipY * ShopHintY);
                C.DrawText(ShopHint);
            } else if(bTouchingVehicle) {
                C.DrawColor = ShopHintColor;
                C.Font = MyHUD.GetConsoleFont(C);
                C.TextSize(VehicleHint, XL, YL);
                C.SetPos((C.ClipX - XL) * 0.5, C.ClipY * ShopHintY);
                C.DrawText(VehicleHint);
            }


            C.Style = ERenderStyle.STY_Normal;
            C.Font = MyHUD.GetMediumFontFor(C);
            C.ColorModulate = C.default.ColorModulate;
            C.SetPos(8, C.ClipY * 0.5);
            C.DrawText("$" $GPRI.GetMoney());


            // Draw survival bonus widget
            if( GPRI.bSurvivalBonus )
            {
                C.DrawColor = HUD.WhiteColor;
                C.Style = ERenderStyle.STY_Alpha;

                // Fade in
                if( SurvivalTime > 0 )           
                	C.DrawColor.A = (255.0 * FClamp((Level.TimeSeconds - SurvivalTime) / SurvivalFadeTime, 0, 1));
                else
                	SurvivalTime = Level.TimeSeconds;  

                // Caption
                C.Font = HUD.GetFontSizeIndex(C, -2);
                C.StrLen(SurvivalCaption, Width, Height);
                C.SetPos((C.ClipX * 0.06) - (Width * 0.5), (C.ClipY * 0.4) + Height);
                C.DrawText(SurvivalCaption);
            }
            else
            {
            	SurvivalTime = 0;
            }


            // Draw no-kill widget
            MultiplierTime = GPRI.GetNoKillMultiplierTime() - GPRI.NoKillTimeBase;
            if( MultiplierTime >= 0 )
            {
                C.DrawColor = HUD.WhiteColor;
                C.Style = ERenderStyle.STY_Alpha;

                // Fade in
                if( MultiplierTime <= NoKillFadeTime )
                    C.DrawColor.A = (255.0 * (MultiplierTime / NoKillFadeTime));

                // Dial
                Multiplier = GPRI.GetNoKillMultiplier();
                if( Multiplier < GPRI.NoKillLevelMax )
                {
                    // FIXME: remove as soon as #749 is fixed
                    TexRotator(NoKillIcon.WidgetTexture).TexRotationType = TR_FixedRotation;
                    TexRotator(NoKillIcon.WidgetTexture).Rotation.Yaw = 0;

                    TexRotator(NoKillIcon.WidgetTexture).Rotation.Yaw = -((MultiplierTime * 65536.0) / GPRI.NoKillTimeLevel);
                    NoKillIcon.Tints[0] = C.DrawColor;
                    NoKillIcon.Tints[1] = C.DrawColor;
                    HUD.DrawSpriteWidget(C, NoKillIcon);
                }

                // Amount
                C.Font = HUD.GetFontSizeIndex(C, -1);
                C.StrLen(int(Multiplier), Width, Height);
                C.SetPos((C.ClipX * 0.06) - (Width * 0.5), (C.ClipY * 0.3) - (Height * 0.5));
                C.DrawText(int(Multiplier));

                // Caption
                C.Font = HUD.GetFontSizeIndex(C, -2);
                C.StrLen(NoKillCaption, Width, Height);
                C.SetPos((C.ClipX * 0.06) - (Width * 0.5), (C.ClipY * 0.3) + Height);
                C.DrawText(NoKillCaption);
            }
        }
    }

    if( Level.GRI != None )
    {
        for( i = 0; i < Level.GRI.PRIArray.Length; i++ )
        {
            if( PlayerReplicationInfo == Level.GRI.PRIArray[i] )
            {
                MyCurrentRanking = (i+1);
                break;
            }
        }
        if(MyCurrentRanking != MyPreviousRanking) {
            //log(self@"Ranking Changed, previous="@mypreviousranking@"new="@mycurrentranking);
            if(MyCurrentRanking < 4 && MyPreviousRanking > 3) {
                ClientPlaySound(sound'G_Sounds.rank_power_a', True, 2);
            } else if(MyCurrentRanking == 1) {
                ClientPlaySound(sound'G_Sounds.rank_1st', True, 2);
                ReceiveLocalizedMessage(class'gMessageRank1st');
            } else if(MyCurrentRanking == 2) {
                ClientPlaySound(sound'G_Sounds.rank_2nd', True, 2);
                ReceiveLocalizedMessage(class'gMessageRank2nd');
            } else if(MyCurrentRanking == 3) {
                ClientPlaySound(sound'G_Sounds.rank_3rd', True, 2);
                ReceiveLocalizedMessage(class'gMessageRank3rd');
            }

            MyPreviousRanking = MyCurrentRanking;
        }
    }
}

simulated function RenderLoadingScreen(Canvas C)
{
	local Material LoadingMat;
	local float Alpha;
	
	if( Level.TimeSeconds > LoadingFadeTime )
		return;
	
	LoadingMat = Material(DynamicLoadObject(default.LastBackground, class'Material', true));
	if( LoadingMat == None )
		return;
	
	Alpha = FClamp( Level.TimeSeconds / LoadingFadeTime, 0, 1.0);
	Alpha = Alpha ** 4.0;
	Alpha = (1.0 - Alpha) * 255.0;
	if( byte(Alpha) == 0 )
		return;
	
	C.Reset();
	C.SetPos(0,0);
	C.Style = 5;	
	C.SetDrawColor(255,255,255,Alpha);
	C.DrawTile(LoadingMat, C.ClipX, C.ClipY, 0, 0, 1024, 768);
}


DefaultProperties
{
	LoadingFadeTime				= 4.0

    SurvivalFadeTime            = 1.0
    SurvivalCaption             = "[Survival]"

    NoKillFadeTime              = 1.0
    NoKillCaption               = "[No-Kill]"

    ShopHint                    = "[Press USE to shop]"
    ShopHintColor               = (R=255,G=255,B=255,A=255)
    ShopHintY                   = 0.8

    MoneyColor                  = (R=255,G=255,B=255,A=192)
    MoneyColorShopping          = (R=0,G=128,B=45,A=192)
    MoneyColorPoor              = (R=255,G=0,B=0,A=192)

    NoKillIcon                  = (WidgetTexture=TexRotator'G_FX.Interface.dial_nokill',TextureCoords=(X1=0,Y1=0,X2=64,Y2=64),RenderStyle=STY_Alpha,TextureScale=0.5,ScaleMode=SM_None,Scale=1.0,DrawPivot=DP_MiddleMiddle,PosX=0.06,PosY=0.3,OffsetX=-2,OffsetY=-2,Tints[0]=(R=255,G=255,B=255,A=255),Tints[1]=(R=255,G=255,B=255,A=255))

    WeaponPickupHint            = "[Press USE to Pick Up / Middle-Mouse to Swap]"
    VehicleHint                 = "[Press USE to Enter]"

}
