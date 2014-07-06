// ============================================================================
//  gPawnHUD.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPawnHUD extends gObject
    within gPawn;


var font AmmoCaptionFont;
var float AmmoCaptionMargin;
var float AmmoCaptionPadding;
var color AmmoCaptionColor;
var color AmmoCaptionBGColor;



var() Material WarrantyMaterial;
var() intbox WarrantyCoords;
var() intbox WarrantyCoordsPickup;


var   Material              SlotMaterial;
var   Material              SlotMaterialSelected;
var   array<Material>       BonusMaterials;
var   Material              PendingBonusMaterial;
var   Color                 SlotColor;
var   Color                 SlotColorSelected;
var   Material              StaminaBackMaterial;
var   Color                 NoAmmoColor;
var   Texture               AmmoIndicatorTexture;
var() Texture               StaminaTexture;     // HUD bar texture

var   float                 InaccuracyXHairAlphaLimit;
var   float                 InaccuracyXHairAlphaCurve;
var   float                 InaccuracyXHairMagnify;
var   float                 InaccuracyXHairAlphaMin;

var() Material              XHairMaterial;
var() IntBox                XHairCoordsN;
var() IntBox                XHairCoordsE;
var() IntBox                XHairCoordsW;
var() IntBox                XHairCoordsS;
var() float                 XHairMinOffset;

var   float                 PoisonTargetTime;
var   float                 PoisonTarget;

var() float                 TurretHintY;
var() Color                 TurretHintColor;
var() localized string      TurretHint;

var() Color                 StaminaColor;
var() Color                 StaminaWaitColor;
var() Color                 InvShieldColor;
var() Color					HealingWardColor;

var() localized string		HealingWardCaption;


static function PrecacheScan( gPrecacheScan S )
{
    local int i;

    S.PrecacheObject(default.WarrantyMaterial);
    S.PrecacheObject(default.StaminaTexture);
    S.PrecacheObject(default.AmmoIndicatorTexture);
    S.PrecacheObject(default.SlotMaterial);
    S.PrecacheObject(default.SlotMaterialSelected);
    S.PrecacheObject(default.PendingBonusMaterial);
    S.PrecacheObject(default.StaminaBackMaterial);

    for( i=0; i<default.BonusMaterials.Length; ++i )
        S.PrecacheObject(default.BonusMaterials[i]);
}

simulated function Free()
{
    //gLog( "Free" );

    ClearOuter();
}


final simulated function DrawHUD(Canvas C)
{
    local gPlayer PC;
    local HudCDeathMatch HUD;
    local float Progress, OffsetY;
    local gAcidTimer T;

    PC = gPlayer(Level.GetLocalPlayerController());

    if( PC != None && HudCDeathMatch(PC.myHUD) != None )
        HUD = HudCDeathMatch(PC.myHUD);
    else
        return;

    // Draw only if HUD.DrawHUD() will be called
    // TODO: Could potentially examine which of these occurences is most likely, and optimize the order of them
    if(HUD.bShowDebugInfo
        || HUD.bHideHud
        || HUD.bShowLocalStats
        || HUD.bShowScoreBoard
        || HUD.PlayerOwner == None
        //|| HUD.PawnOwner == None
        || HUD.PawnOwnerPRI == None
        || (HUD.PlayerOwner.IsSpectating() && HUD.PlayerOwner.bBehindView)
        || bHideRegularHUD)
        return;

    // Draw stamina bar
    if( PC != None && PC.bWaitForStamina )
        DrawProgressBar(C, OffsetY, StaminaPoints * 0.01, StaminaWaitColor);
    else
        DrawProgressBar(C, OffsetY, StaminaPoints * 0.01, StaminaColor);


    if( bUseShopping )
    {
        // Draw inv shield bar
        if( BonusMode == BM_Shield )
        {
            if( Level.TimeSeconds < (ShieldTime + ShieldDuration + ShieldRecharge) && Level.TimeSeconds > (ShieldTime + ShieldDuration) )
                Progress = (Level.TimeSeconds - (ShieldTime + ShieldDuration)) / ShieldRecharge;
            else if( Level.TimeSeconds < (ShieldTime + ShieldDuration) && Level.TimeSeconds > ShieldTime )
                Progress = (ShieldDuration - (Level.TimeSeconds - ShieldTime)) / ShieldDuration;
            else
                Progress = 1.0;

            DrawProgressBar(C, OffsetY, Progress, InvShieldColor);
        }

        // Draw acid bar
        T = class'gAcidTimer'.static.GetAcidTimer(Outer);
        if( T != None && T.DamageTotal > 0 )
        {
            DrawPoisonBar(C, T, OffsetY);
        }
        
        Progress = FClamp(GetHealingWardTime() / HealingWardTimeBase, 0, 1);
        if( Progress > 0.0 && VSize(Velocity) < 10 )
        {
        	C.Font = HUD.GetConsoleFont(C);;
    		OffsetY = -0.20;
            DrawProgressBar(C, OffsetY, Progress, HealingWardColor,, HealingWardCaption, true);
        }

        // Weapons Bar
        if( HUD.bShowWeaponBar )
        {
            PC.bRestoreWeaponBar = True;
            HUD.bShowWeaponBar = False;
            DrawWeaponBar(C, HUD);
        }
    }
}

final simulated function DrawWeaponBar(Canvas C, HudCDeathMatch H)
{
    local Inventory Inv;
    local gWeapon GW;
    local Weapon W;
    local Weapon NewWeapon;
    local gWeapon Slots[8];
    local int i, Count, Pos;
    local float X, Y, IW, IH, TX, TY, TW, TH;
    local float BW, BH, SW, SH, RX, RY;
    local Material M;
    local bool bSlotsFull;
    local Weapon SpecialSlot;
    local Weapon DefaultSlot;
    local string DefaultWeaponName;

    // get default weapon name
    DefaultWeaponName = Caps(RequiredEquipment[0]);

    // Screen scale
    RX = C.ClipX / 1024;
    RY = C.ClipY / 768;

    // which weapon is selected?
    if( SelectedWeapon != None )
        NewWeapon = SelectedWeapon;
    else if( PendingWeapon != None )
        NewWeapon = PendingWeapon;
    else if( Weapon != None )
        NewWeapon = Weapon;

    // Enumerate weapons
    for( Inv = Inventory; Inv != None; Inv = Inv.Inventory )
    {
        // on clients the inventory chain can become looped temporarily because of replication delays
        if( ++Count > 100 )
            break;

        W = Weapon(Inv);
        if( W == None )
            continue;

        if( DefaultSlot == None && Caps(W.class) == DefaultWeaponName )
        {
            DefaultSlot = W;
            continue;
        }

        if( !bSlotsFull )
        {
            GW = gWeapon(W);
            if( GW != None && GW.ItemSize > 0 )
            {
                if( Pos + GW.ItemSize <= ArrayCount(Slots) )
                {
                    for( i = 0; i < GW.ItemSize; ++i )
                        Slots[Pos++] = GW;
                    continue;
                }
                else
                {
                    bSlotsFull = True;
                }
            }
        }

        if( SpecialSlot == None )
            SpecialSlot = W;
    }

    // which special weapon is selected?
    if( SelectedWeapon != None && Caps(SelectedWeapon.class) != DefaultWeaponName && UsesGloveSlot(SelectedWeapon) )
        SpecialSlot = SelectedWeapon;
    else if( PendingWeapon != None && Caps(PendingWeapon.class) != DefaultWeaponName && UsesGloveSlot(PendingWeapon) )
        SpecialSlot = PendingWeapon;
    else if( Weapon != None && Caps(Weapon.class) != DefaultWeaponName && UsesGloveSlot(Weapon) )
        SpecialSlot = Weapon;

    SW = 60 * RX; // 0.05859375 60/1024
    SH = 60 * RY;// 0.078125 60/768

    // - Draw default slot ----------------------------------------------------
    X = 0.195 * C.ClipX;
    Y = C.ClipY - SH;
    TX = 0;
    TY = 0;
    TW = SlotMaterial.MaterialUSize();
    TH = SlotMaterial.MaterialVSize();

    C.SetPos(X, Y);
    C.DrawColor = SlotColor;
    C.Style = ERenderStyle.STY_Alpha;
    if( DefaultSlot != None && DefaultSlot == NewWeapon )
        C.DrawTile(SlotMaterialSelected, SW, SH, TX, TY, TW, TH);
    else
        C.DrawTile(SlotMaterial, SW, SH, TX, TY, TW, TH);

    // - Draw glove slot ------------------------------------------------------
    X += SW;
    Y = C.ClipY - SH;

    C.SetPos(X, Y);
    if( SpecialSlot != None && SpecialSlot == NewWeapon )
        C.DrawTile(SlotMaterialSelected, SW, SH, TX, TY, TW, TH);
    else
        C.DrawTile(SlotMaterial, SW, SH, TX, TY, TW, TH);


    // - Draw bonus slot ------------------------------------------------------
    X += SW;
    BW = 25 * RX; // 0.0244140625 25/1024
    BH = 50 * RY; // 0.065104167 50/768
    Y += (SH - BH) * 0.5;

    M = BonusMaterials[Min(BonusMode, BonusMaterials.Length - 1)];

    TX = 0;
    TY = 0;
    TW = M.MaterialUSize();
    TH = M.MaterialVSize();

    C.SetPos(X, Y);
    C.DrawTile(M, BW, BH, TX, TY, TW, TH);

    // - Draw pending bonus slot ----------------------------------------------
    if( BonusMode != PendingBonusMode )
    {
        M = PendingBonusMaterial;
        TX = 0;
        TY = 0;
        TW = M.MaterialUSize();
        TH = M.MaterialVSize();

        C.SetPos(X, Y);
        C.DrawTile(M, BW, BH, TX, TY, TW, TH);
    }

    // - Draw weapon slots ----------------------------------------------------
    X += BW;
    Y = C.ClipY - SH;

    TX = 0;
    TY = 0;
    TW = SlotMaterial.MaterialUSize();
    TH = SlotMaterial.MaterialVSize();

    for( i = 0; i < ArrayCount(Slots); ++i )
    {
        C.SetPos(X + i * SW, Y);

        GW = Slots[i];
        if( GW != None && GW == NewWeapon )
            C.DrawTile(SlotMaterialSelected, SW, SH, TX, TY, TW, TH);
        else
            C.DrawTile(SlotMaterial, SW, SH, TX, TY, TW, TH);
    }

    // - Draw weapons ---------------------------------------------------------
    C.DrawColor = H.HudColorNormal;

    for( i = 0; i < ArrayCount(Slots); ++i )
    {
        GW = Slots[i];

        if( GW != None )
        {
            if( i != 0 && Slots[i-1] == GW )
                continue;

            C.SetPos(X + i*SW, Y);

            if( GW.AmmoAmount(0) <= 0 )
                C.DrawColor = NoAmmoColor;

            M = GW.IconMaterial;
            if( M != None )
            {
                TX = GW.IconCoords.X1;
                TY = GW.IconCoords.Y1;
                TW = GW.IconCoords.X2 - TX;
                TH = GW.IconCoords.Y2 - TY;
            }
            else
            {
                M = Material'Engine.DefaultTexture';
                TX = 0;
                TY = 0;
                TW = M.MaterialUSize();
                TH = M.MaterialVSize();
            }

            IW = SW;
            IH = SH;

            if( GW.ItemSize > 1 )
                IW = SW * GW.ItemSize;

            C.DrawTile(M, IW, IH, TX, TY, TW, TH);
            C.DrawColor = H.HudColorNormal;

            // Draw warranty
            if( GW.WarrantyMode != 0 )
            {
                IH = IH * 0.5;
                IW = IH;
                C.SetPos(X+SW*(i+Max(1,GW.ItemSize))-IW-4*RX, Y+SH-IH-4*RY);
                if( GW.WarrantyMode == 2 )
                    C.DrawTile(WarrantyMaterial, IW, IH, WarrantyCoordsPickup.X1, WarrantyCoordsPickup.Y1, WarrantyCoordsPickup.X2, WarrantyCoordsPickup.Y2 );
                else
                    C.DrawTile(WarrantyMaterial, IW, IH, WarrantyCoords.X1, WarrantyCoords.Y1, WarrantyCoords.X2, WarrantyCoords.Y2 );
            }

            // Draw Ammo
            if( GW.default.CostAmmo > 0 && GW.AmmoAmount(0) > 0 )
                DrawWeaponBarAmmo(C,H,GW.AmmoAmount(0),X + i*SW, Y);
        }
    }
    C.DrawColor = H.HudColorNormal;

    // - Draw default weapon --------------------------------------------------
    if( DefaultSlot != None )
    {
        X = 0.195 * C.ClipX;
        C.SetPos(X, Y);

        M = DefaultSlot.IconMaterial;

        if( M != None )
        {
            TX = DefaultSlot.IconCoords.X1;
            TY = DefaultSlot.IconCoords.Y1;
            TW = DefaultSlot.IconCoords.X2 - TX;
            TH = DefaultSlot.IconCoords.Y2 - TY;
        }
        else
        {
            M = Material'Engine.DefaultTexture';
            TX = 0;
            TY = 0;
            TW = M.MaterialUSize();
            TH = M.MaterialVSize();
        }

        IW = SW;
        IH = SH;

        C.DrawTile(M, IW, IH, TX, TY, TW, TH);
    }

    // - Draw special weapon --------------------------------------------------
    if( SpecialSlot != None )
    {
        X = 0.195 * C.ClipX + SW;
        C.SetPos(X, Y);

        M = SpecialSlot.IconMaterial;

        GW = gWeapon(SpecialSlot);
        if( GW != None && GW.default.CostAmmo > 0 )
        {
            if( GW.AmmoAmount(0) <= 0 )
                C.DrawColor = NoAmmoColor;
        }

        if( M != None )
        {
            TX = SpecialSlot.IconCoords.X1;
            TY = SpecialSlot.IconCoords.Y1;
            TW = SpecialSlot.IconCoords.X2 - TX;
            TH = SpecialSlot.IconCoords.Y2 - TY;
        }
        else
        {
            M = Material'Engine.DefaultTexture';
            TX = 0;
            TY = 0;
            TW = M.MaterialUSize();
            TH = M.MaterialVSize();
        }

        IW = SW;
        IH = SH;

        C.DrawTile(M, IW, IH, TX, TY, TW, TH);

        // Draw Ammo
        if( GW != None && GW.default.CostAmmo > 0 && GW.AmmoAmount(0) > 0 )
            DrawWeaponBarAmmo(C,H,GW.AmmoAmount(0),X, Y);
    }
}

final simulated function DrawWeaponBarAmmo( Canvas C, HudCDeathMatch myHUD, int Ammo, int ActualLeft, int ActualTop )
{
    local float X,Y,W,H,XL,YL;
    local string S;

    if( Ammo > 0 )
    {
        S = string(Ammo);
        C.Font = myHUD.GetConsoleFont(C);
        if( C.Font == None )
            C.Font = C.default.Font;

        C.StrLen( S, XL,YL );
        W = XL + AmmoCaptionPadding*2;
        H = YL + AmmoCaptionPadding*2;
        X = ActualLeft + AmmoCaptionMargin;
        Y = ActualTop + AmmoCaptionMargin;

        C.Style = 5;

        C.DrawColor = AmmoCaptionBGColor;
        C.SetPos(X,Y);
        C.DrawTile(texture'Engine.WhiteTexture', W, H, 0,0,1,1 );

        C.DrawColor = AmmoCaptionColor;
        C.SetPos(X + AmmoCaptionPadding,Y +  AmmoCaptionPadding);
        C.DrawTextClipped( S );
    }
}

simulated function DrawProgressBar(Canvas C, out float OffsetY, float Progress, Color BarColor, optional bool bExpanding, optional string Caption, optional bool bCenter )
{
    local float X1, Y1, W1, H1, XL, YL;
    local float X2, Y2, W2, H2;
    
    if( Caption != "" )
    {
		C.StrLen(Caption, XL, YL);
    	OffsetY -= YL / 768;
    }

    // Stamina Bar Background
    W1 = (445 / 1024) * C.ClipX;
    H1 = (16 / 768) * C.ClipY;

    X1 = (332 / 1024) * C.ClipX;
    Y1 = ((692 / 768) + OffsetY)* C.ClipY;
    
    if( bCenter )
    {
    	X1 = (C.ClipX - W1)* 0.5;
    }

    if( bExpanding )
    {
        W1 *= Progress;
        X1 = ((332+445*0.5)/1024) * C.ClipX - W1*0.5;
    }

    C.Style = ERenderStyle.STY_Alpha;
    C.ColorModulate = C.default.ColorModulate;
    C.SetDrawColor(255, 255, 255, 255);

    // Draw BG with side borders outside of the region
    C.SetPos(X1-8, Y1);
    C.DrawTile(StaminaBackMaterial, 8, H1, 0, 0, 8, StaminaBackMaterial.MaterialVSize());
    C.SetPos(X1, Y1);
    C.DrawTile(StaminaBackMaterial, W1, H1, 8, 0, StaminaBackMaterial.MaterialUSize()-16, StaminaBackMaterial.MaterialVSize());
    C.SetPos(X1+W1, Y1);
    C.DrawTile(StaminaBackMaterial, 8, H1, StaminaBackMaterial.MaterialUSize()-8, 0, 8, StaminaBackMaterial.MaterialVSize());

    // Stamina Bar
    W2 = W1;
    H2 = (8 / 768) * C.ClipY;

    X2 = X1;
    Y2 = ((697 / 768) + OffsetY) * C.ClipY;

    if( !bExpanding )
    {
        W2 *= Progress;
    }
    
    if( bCenter )
    {
    	//X2 = (C.ClipX - W2) * 0.5;
    }

    C.Style = ERenderStyle.STY_Alpha;
    C.SetPos(X2, Y2);
    C.DrawColor = BarColor;
    C.DrawRect(StaminaTexture, W2, H2);
    OffsetY -= 0.020834;
    
    if( Caption != "" )
    {
    	C.SetPos((C.ClipX-XL) * 0.5f, Y1+H1);
    	C.DrawText(Caption);
    }
}

function DrawPoisonBar( Canvas C, gAcidTimer T, float OffsetY )
{
    local float PulseColor, SmoothDamage;
    local color BarColor;

    if( T.DamageTotal > 0 )
    {
        // Smooth the acid bar using prediction
        if( T.DamageTotal != PoisonTarget )
        {
            PoisonTarget = T.DamageTotal;
            PoisonTargetTime = Level.TimeSeconds;
            SmoothDamage = PoisonTarget;
        }
        else
        {
            SmoothDamage = PoisonTarget - (Level.TimeSeconds - PoisonTargetTime) * T.DamagePerSecond;
        }

        if( T.bWillKill )
            PulseColor = (sin(Level.TimeSeconds*8.0)*0.5+0.5) * 255.0;

        BarColor.R = PulseColor;
        BarColor.G = 255-PulseColor;
        BarColor.B = 0;
        BarColor.A = 255;
        DrawProgressBar(C, OffsetY, FClamp(SmoothDamage / float(default.Health), 0,1), BarColor, True);
    }
}


final simulated function SpecialDrawCrosshair(Canvas C)
{
    local float XHairScale, X,Y,W,H,XL,YL, XHairOffset, XHairScaleX, XHairScaleY, ResScaleX, ResScaleY;
    local vector HitLocation, Hitnormal, EndTrace, StartTrace, ScreenPos;
    local PlayerController PC;
    local HudCDeathMatch HDM;
    local Plane OldModulate;
    local Actor TracedActor;
    //local float SpeedAlpha;
    //local color XHairColor;

    // Get local player
    PC = Level.GetLocalPlayerController();
    if( PC == None || PC.Pawn != Outer )
        return;

    // Get HUD
    HDM = HudCDeathMatch(PC.MyHUD);
    if( HDM == None || !HDM.bCrosshairShow )
        return;

    // Scale crosshair using aim error
    XHairScale = 1 + InaccuracyXhairScale * InaccuracyXHairMagnify;

    // Fade crosshair using aim error
    /*if( InaccuracyXHairScaleSmooth > 0 )
    {
        SpeedAlpha = 1.0 - (FClamp(InaccuracyXHairScaleSmooth/InaccuracyXHairAlphaLimit, 0, 1) ** InaccuracyXHairAlphaCurve);
        XHairColor.A = XHairColor.A * FMax(SpeedAlpha, InaccuracyXHairAlphaMin);
    }*/

    //Log( "XHairScale" #XHairScale #InaccuracyXHairScaleSmooth );

    // Bump xhair scale on pickup
    if( HDM.LastPickupTime > Level.TimeSeconds - 0.4 )
    {
        if( HDM.LastPickupTime > Level.TimeSeconds - 0.2 )
            XHairScale *= (1 + 5 * (Level.TimeSeconds - HDM.LastPickupTime));
        else
            XHairScale *= (1 + 5 * (HDM.LastPickupTime + 0.4 - Level.TimeSeconds));
    }

    // Trace
    StartTrace = Location + EyePosition();
    EndTrace = StartTrace + (vector(PC.Rotation) * 16384);
    TracedActor = Trace(HitLocation, HitNormal, EndTrace, StartTrace, True, vect(8,8,8));
    if( TracedActor == None )
        HitLocation = EndTrace;

    // Turret upgrades
    if( gTurret(TracedActor) != None
    &&  gTurret(TracedActor).CanUpgrade(outer) )
    {
        C.DrawColor = TurretHintColor;
        C.Font = HDM.GetConsoleFont(C);
        C.TextSize(TurretHint, XL, YL);
        C.SetPos((C.ClipX - XL) * 0.5, C.ClipY * TurretHintY);
        C.DrawText(TurretHint);
    }

    // 3rd person crosshair placed at traced position
    if( PC.bBehindView )
    {
        // Traced crosshair
        ScreenPos = C.WorldToScreen(HitLocation);
        X = FClamp(ScreenPos.X, 0, C.ClipX);
        Y = FClamp(ScreenPos.Y, 0, C.ClipY);
    }
    else
    {
        // 1st person crosshair centered
        X = C.ClipX * 0.5;
        Y = C.ClipY * 0.5;
    }


    // Setup canvas
    OldModulate = C.ColorModulate;
    C.ColorModulate.W = 1;
    C.SetDrawColor(255,255,255,255);

    XHairScaleX = XHairScale;
    XHairScaleY = XHairScale;
    ResScaleX = C.ClipX / 1024.0;
    ResScaleY = C.ClipY / 768.0;

    // Draw XHair N tile
    W = XHairCoordsN.X2 * ResScaleX;
    H = XHairCoordsN.Y2 * ResScaleY;
    XHairOffset = XHairMinOffset * XHairScaleY * ResScaleY;
    C.SetPos(X - W * 0.5, Y - H - XHairOffset);
    C.DrawTile(XHairmaterial, W, H, XHairCoordsN.X1, XHairCoordsN.Y1, XHairCoordsN.X2, XHairCoordsN.Y2);

    // Draw XHair E tile
    W = XHairCoordsE.X2 * ResScaleX;
    H = XHairCoordsE.Y2 * ResScaleY;
    XHairOffset = XHairMinOffset * XHairScaleX * ResScaleX;
    C.SetPos(X + XHairOffset, Y - H * 0.5);
    C.DrawTile(XHairmaterial, W, H, XHairCoordsE.X1, XHairCoordsE.Y1, XHairCoordsE.X2, XHairCoordsE.Y2);

    // Draw XHair W tile
    W = XHairCoordsW.X2 * ResScaleX;
    H = XHairCoordsW.Y2 * ResScaleY;
    XHairOffset = XHairMinOffset * XHairScaleX * ResScaleX;
    C.SetPos(X - W - XHairOffset, Y - H * 0.5);
    C.DrawTile(XHairmaterial, W, H, XHairCoordsW.X1, XHairCoordsW.Y1, XHairCoordsW.X2, XHairCoordsW.Y2);

    // Draw XHair S tile
    W = XHairCoordsS.X2 * ResScaleX;
    H = XHairCoordsS.Y2 * ResScaleY;
    XHairOffset = XHairMinOffset * XHairScaleY * ResScaleY;
    C.SetPos(X - W * 0.5, Y + XHairOffset);
    C.DrawTile(XHairMaterial, W, H, XHairCoordsS.X1, XHairCoordsS.Y1, XHairCoordsS.X2, XHairCoordsS.Y2);

    // Restore canvas
    C.ColorModulate = OldModulate;


    // Draw enemy name
    HDM.DrawEnemyName(C);
}


final simulated function bool UsesGloveSlot(Inventory Inv)
{
    return gWeapon(Inv) == None || gWeapon(Inv).ItemSize <= 0;
}


static final function DrawGenericHealthBar(
	Canvas C, 
	Actor A, 
	float HealthAlpha, 
	float BarWidth, 
	vector WorldLoc, 
	Material BorderMat, 
	Material BarMat
)
{
	local PlayerController PC;
	local color HealthColor;
	local float W, H;
	local vector ScreenLoc, ScreenExtent, CamLoc, X,Y,Z;
	local rotator CamRot;
	
	PC = A.Level.GetLocalPlayerController();
	if( PC == None )
		return;
	
	// Only with LOS
	if( !PC.LineOfSightTo(A) )
		return;

	// Get screen-space bar location
    ScreenLoc = C.WorldToScreen(WorldLoc);
    
    // Skip if behind
	if( ScreenLoc.Z > 1 )
		return;
    
    // Calc screen-space bar dimensions
	C.GetCameraLocation(CamLoc, CamRot);
	GetAxes(CamRot,X,Y,Z);
    ScreenExtent = C.WorldToScreen(WorldLoc + Y*BarWidth);    
    W = VSize(ScreenLoc*vect(1,1,0) - ScreenExtent*vect(1,1,0));
    H = W * 0.175;
    
    // Skip if too small
	if( H < 2 )
		return;

	// Draw health bar border
	C.Style = 5;
	C.DrawColor = class'HUD'.default.WhiteColor;
	C.SetPos( ScreenLoc.X-W*0.5, ScreenLoc.Y );
	C.DrawTile( BorderMat, 
				W, 
				H, 
				0, 0, BorderMat.MaterialUSize(), BorderMat.MaterialVSize() );

	// Calc health bar
	HealthColor = class'gColorSpace'.static.HSLToRGB( 80.0*HealthAlpha**3.0, 255, 127 );
	HealthColor.A = 255;
	
	// Draw health bar
	C.Style = 5;
	C.DrawColor = HealthColor;
	C.SetPos( ScreenLoc.X-W*0.5, ScreenLoc.Y );
	C.DrawTile( BarMat, 
				W*HealthAlpha, 
				H, 
				0, 0, BarMat.MaterialUSize(), BarMat.MaterialVSize() );
}

DefaultProperties
{
	HealingWardCaption				= "Healing Ward" 

    TurretHint                    = "[Press USE to add an Upgrade Shield (-40% damage)]"
    TurretHintColor               = (R=255,G=255,B=255,A=255)
    TurretHintY                   = 0.75

    XHairMinOffset = 4.0
    InaccuracyXHairAlphaCurve       = 0.5
    InaccuracyXHairAlphaLimit       = 0.12
    InaccuracyXHairAlphaMin         = 0.1
    InaccuracyXHairMagnify          = 66

    AmmoCaptionMargin               = 4
    AmmoCaptionPadding              = 2
    AmmoCaptionColor                = (R=255,G=255,B=255,A=224)
    AmmoCaptionBGColor              = (R=0,G=0,B=0,A=96)

    StaminaColor                    = (R=255,G=255,B=255,A=255)
    StaminaWaitColor                = (R=192,G=192,B=192,A=255)

    InvShieldColor                  = (R=125,G=160,B=215,A=255)
    HealingWardColor           		= (R=128,G=192,B=255,A=255)


    WarrantyMaterial                = Material'G_FX.Interface.IconSheet0'
    WarrantyCoords                  = (X1=800,Y1=108,X2=24,Y2=24);
    WarrantyCoordsPickup            = (X1=823,Y1=108,X2=24,Y2=24);

    StaminaTexture                  = Texture'Engine.WhiteTexture'

    StaminaBackMaterial             = Material'G_FX.belt_stamina_a1'
    SlotMaterial                    = Material'G_FX.belt_square_a1'
    SlotMaterialSelected            = Material'G_FX.belt_square_a2'
    SlotColor                       = (R=255,G=255,B=255,A=255)
    SlotColorSelected               = (R=255,G=255,B=255,A=255)

    BonusMaterials(0)               = Material'G_FX.Shop-S1'
    BonusMaterials(1)               = Material'G_FX.Shop-A1'
    BonusMaterials(2)               = Material'G_FX.Shop-R1'
    BonusMaterials(3)               = Material'G_FX.Shop-O1'
    BonusMaterials(4)               = Material'Engine.DefaultTexture' // Last = Unknown
    PendingBonusMaterial            = Material'G_FX.belt_square_a2'

    NoAmmoColor                     = (R=80,G=80,B=80,A=255)

    AmmoIndicatorTexture            = Texture'HudContent.Generic.HUD'


    XHairMaterial=Material'G_FX.crosshair_a5'
    XHairCoordsN=(X1=26,Y1=0,X2=12,Y2=26)
    XHairCoordsE=(X1=38,Y1=26,X2=26,Y2=12)
    XHairCoordsW=(X1=0,Y1=26,X2=26,Y2=12)
    XHairCoordsS=(X1=26,Y1=38,X2=12,Y2=26)


}
