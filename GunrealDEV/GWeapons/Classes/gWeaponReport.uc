// ============================================================================
//  gWeaponReport.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gWeaponReport extends gActor;


struct WeaponProperty
{
    var string Property;
    var string Value;
};

struct WeaponProperties
{
    var array<WeaponProperty>   Properties;
};

var array<WeaponProperties>  Report;

var array<string>   WeaponNames;
var FileLog         FL;


event PostBeginPlay()
{
    local int i,j;
    local class<gWeapon> W;

    WeaponNames = class'gWeaponsGunreal'.default.ClassNames;

    FL = Spawn(class'FileLog');
    FL.OpenLog("WeaponReport",,True);
    Logf( "" );

    for( i=0; i!=WeaponNames.Length; ++i )
    {
        W = class<gWeapon>(DynamicLoadObject(WeaponNames[i],class'Class',True));
        if(W != None )
            Report[Report.Length] = ReportProperties(W);
    }

    if(Report.Length > 0 )
    {
        Logf( "<table border=\"1\" rules=\"all\" frame=\"void\" cellpadding=\"3\""@
              CSS( IS("white-space","nowrap") @IS("border-color","#ddd") ) $">" );

        for( j=0; j!=Report[0].Properties.Length; ++j )
        {
            // property names
            //S = "||" @ Report[0].Properties[j].Property;
            Logf( "<tr>" );
            Logf( Report[0].Properties[j].Property );

            // property values
            for( i=0; i!=Report.Length; ++i )
            {
                Logf( Report[i].Properties[j].Value );
            }
            Logf( Report[0].Properties[j].Property );

            //S @= "||";
            Logf( "</tr>" );
        }

        Logf( "</table>" );

    }

    Destroy();
}

event Destroyed()
{
    FL.CloseLog();
}


function WeaponProperties ReportProperties( class<gWeapon> W )
{
    local array<WeaponProperty> P;
    local WeaponProperties WP;
    local class<gWeaponPickup> GP;
    local class<gWeaponAttachment> GA;
    local class<gWeaponFire> GPR;
    local class<gWeaponFire> GAL;
    local class<gAmmo> GAM1;
    local class<gAmmo> GAM2;
    local class<gAmmoPickup> GAMP1;
    local class<gAmmoPickup> GAMP2;

    GP = class<gWeaponPickup>( W.default.PickupClass );
    GA = class<gWeaponAttachment>( W.default.AttachmentClass );
    GPR = class<gWeaponFire>( W.default.FireModeClass[0] );
    GAL = class<gWeaponFire>( W.default.FireModeClass[1] );

    GAM1 = class<gAmmo>( GPR.default.AmmoClass );
    GAM2 = class<gAmmo>( GAL.default.AmmoClass );

    GAMP1 = class<gAmmoPickup>( GAM1.default.PickupClass );
    GAMP2 = class<gAmmoPickup>( GAM2.default.PickupClass );

    P[P.Length] = CreateProperty( "Weapon", *W.name );
    P[P.Length] = CreateProperty( "ItemName", *W.default.ItemName );
    P[P.Length] = CreateProperty( "Description", *W.default.Description );
    P[P.Length] = CreateProperty( "PickupMessage", *GP.default.PickupMessage );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "HudColor", *W.default.HudColor );
    P[P.Length] = CreateProperty( "ChargingBar", *W.default.bShowChargingBar );
    P[P.Length] = CreateProperty( "IconMaterial", *W.default.IconMaterial );
    P[P.Length] = CreateProperty( "IconCoords", *W.default.IconCoords );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "IdleAnim", *W.default.IdleAnim );
    P[P.Length] = CreateProperty( "SelectAnim", *W.default.SelectAnim );
    P[P.Length] = CreateProperty( "PutDownAnim", *W.default.PutDownAnim );
    P[P.Length] = CreateProperty( "3rd bHeavy", *GA.default.bHeavy );
    P[P.Length] = CreateProperty( "3rd bRapidFire", *GA.default.bRapidFire );
    P[P.Length] = CreateProperty( "3rd bAltRapidFire", *GA.default.bAltRapidFire );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "SelectSound", *W.default.SelectSound );
    P[P.Length] = CreateProperty( "PickupSound", *GP.default.PickupSound );
    P[P.Length] = CreateProperty( "FireSound 1", *GPR.default.FireSound );
    P[P.Length] = CreateProperty( "FireSound 2", *GAL.default.FireSound );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "SelectForce", *W.default.SelectForce );
    P[P.Length] = CreateProperty( "PickupForce", *GP.default.PickupForce );
    P[P.Length] = CreateProperty( "FireForce 1", *GPR.default.FireForce );
    P[P.Length] = CreateProperty( "FireForce 2", *GAL.default.FireForce );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "AIRating", *W.default.AIRating );
    P[P.Length] = CreateProperty( "MaxDesireability", *GP.default.MaxDesireability );
    P[P.Length] = CreateProperty( "BotRefireRate 1", *GPR.default.BotRefireRate );
    P[P.Length] = CreateProperty( "BotRefireRate 2", *GAL.default.BotRefireRate );
    P[P.Length] = CreateProperty( "WarnTargetPct 1", *GPR.default.WarnTargetPct );
    P[P.Length] = CreateProperty( "WarnTargetPct 2", *GAL.default.WarnTargetPct );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "DisplayFOV", *W.default.DisplayFOV );
    P[P.Length] = CreateProperty( "DrawScale", *W.default.DrawScale );
    P[P.Length] = CreateProperty( "DrawScale 3rd", *GA.default.DrawScale );
    P[P.Length] = CreateProperty( "HighDetailOverlay", *W.default.HighDetailOverlay );
    P[P.Length] = CreateProperty( "BobDamping", *W.default.BobDamping );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "Priority", *W.default.Priority );
    P[P.Length] = CreateProperty( "InventoryGroup", *W.default.InventoryGroup );
    P[P.Length] = CreateProperty( "GroupOffset", *W.default.GroupOffset );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "LightType", *GetEnum(enum'ELightType',W.default.LightType) );
    P[P.Length] = CreateProperty( "LightEffect", *GetEnum(enum'ELightEffect',W.default.LightEffect) );
    P[P.Length] = CreateProperty( "LightPeriod", *W.default.LightPeriod );
    P[P.Length] = CreateProperty( "LightBrightness", *W.default.LightBrightness );
    P[P.Length] = CreateProperty( "LightHue", *W.default.LightHue );
    P[P.Length] = CreateProperty( "LightSaturation", *W.default.LightSaturation );
    P[P.Length] = CreateProperty( "LightRadius", *W.default.LightRadius );
    P[P.Length] = CreateProperty( "AmbientGlow", *W.default.AmbientGlow );
    P[P.Length] = CreateProperty( "ScaleGlow", *W.default.ScaleGlow );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "3rd LightType", *GetEnum(enum'ELightType',GA.default.LightType) );
    P[P.Length] = CreateProperty( "3rd LightEffect", *GetEnum(enum'ELightEffect',GA.default.LightEffect) );
    P[P.Length] = CreateProperty( "3rd LightPeriod", *GA.default.LightPeriod );
    P[P.Length] = CreateProperty( "3rd LightBrightness", *GA.default.LightBrightness );
    P[P.Length] = CreateProperty( "3rd LightHue", *GA.default.LightHue );
    P[P.Length] = CreateProperty( "3rd LightSaturation", *GA.default.LightSaturation );
    P[P.Length] = CreateProperty( "3rd LightRadius", *GA.default.LightRadius );
    P[P.Length] = CreateProperty( "3rd AmbientGlow", *GA.default.AmbientGlow );
    P[P.Length] = CreateProperty( "3rd ScaleGlow", *GA.default.ScaleGlow );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "AmbientSound", *W.default.AmbientSound );
    P[P.Length] = CreateProperty( "SoundVolume", *W.default.SoundVolume );
    P[P.Length] = CreateProperty( "SoundRadius", *W.default.SoundRadius );
    P[P.Length] = CreateProperty( "SoundPitch", *W.default.SoundPitch );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "FireRate 1", *GPR.default.FireRate );
    P[P.Length] = CreateProperty( "FireRate 2", *GAL.default.FireRate );
    P[P.Length] = CreateProperty( "Exclusive 1", *GPR.default.bModeExclusive );
    P[P.Length] = CreateProperty( "Exclusive 2", *GAL.default.bModeExclusive );
    P[P.Length] = CreateProperty( "Projectile 1", *GPR.default.ProjectileClass );
    P[P.Length] = CreateProperty( "Projectile 2", *GAL.default.ProjectileClass );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "Ammo 1", *GAM1.default.ItemName );
    P[P.Length] = CreateProperty( "Ammo 1 IconMaterial", *GAM1.default.IconMaterial );
    P[P.Length] = CreateProperty( "Ammo 1 IconCoords", *GAM1.default.IconCoords );
    P[P.Length] = CreateProperty( "Ammo 1 MaxAmmo", *GAM1.default.MaxAmmo );
    P[P.Length] = CreateProperty( "Ammo 1 InitialAmount", *GAM1.default.InitialAmount );
    P[P.Length] = CreateProperty( "Ammo 1 PickupMessage", *GAMP1.default.PickupMessage );
    P[P.Length] = CreateProperty( "Ammo 1 PickupSound", *GAMP1.default.PickupSound );
    P[P.Length] = CreateProperty( "Ammo 1 PickupForce", *GAMP1.default.PickupForce );
    P[P.Length] = CreateProperty( "Ammo 1 DrawScale", *GAMP1.default.DrawScale );
    P[P.Length] = CreatePropertySeparator( W.Name );

    P[P.Length] = CreateProperty( "Ammo 2", *GAM2.default.ItemName );
    P[P.Length] = CreateProperty( "Ammo 2 IconMaterial", *GAM2.default.IconMaterial );
    P[P.Length] = CreateProperty( "Ammo 2 IconCoords", *GAM2.default.IconCoords );
    P[P.Length] = CreateProperty( "Ammo 2 MaxAmmo", *GAM2.default.MaxAmmo );
    P[P.Length] = CreateProperty( "Ammo 2 InitialAmount", *GAM2.default.InitialAmount );
    P[P.Length] = CreateProperty( "Ammo 2 PickupMessage", *GAMP2.default.PickupMessage );
    P[P.Length] = CreateProperty( "Ammo 2 PickupSound", *GAMP2.default.PickupSound );
    P[P.Length] = CreateProperty( "Ammo 2 PickupForce", *GAMP2.default.PickupForce );
    P[P.Length] = CreateProperty( "Ammo 2 DrawScale", *GAMP2.default.DrawScale );
    P[P.Length] = CreatePropertySeparator( W.Name );
/*
*/

    WP.Properties = P;
    return WP;
}


final function WeaponProperty CreateProperty( coerce string Property, coerce string Value )
{
    local WeaponProperty P;
    P.Property = TableCellCSS(IS("background-color","#eee"),Property);
    P.Value = Value;
    return P;
}


final function WeaponProperty CreatePropertySeparator( coerce string S )
{
    local WeaponProperty P;
    P.Property = TableCellCSS(IS("background-color","#eee"),"");
    P.Value = TableCellCSS(IS("background-color","#ddd")
                        $IS("font-size","9px")
                        $IS("color","#999")
                        $IS("font-family","verdana")
                        ,Caps(S));
    return P;
}

final function Logf( coerce string S )
{
    FL.Logf( S );
}


static final preoperator string *( color O )
{
    return TableCellCSS( IS("background-color",RGB(O.R,O.G,O.B)), O.R$","$O.G$","$O.B$","$O.A );
}

static final preoperator string *( IntBox O )
{
    return TableCell( O.X1 $"," $O.Y1 @O.X2 $"," $O.Y2 );
}

static final preoperator string *( byte O )
{
    return TableCell( O );
}

static final preoperator string *( int O )
{
    return TableCell( O );
}

static final preoperator string *( float O )
{
    return TableCell( O );
}

static final preoperator string *( bool O )
{
    if(O )
        return TableCell( O );
    else
        return TableCell( "" );
}

static final preoperator string *( Object O )
{
    if(O == None )
        return TableCell( "" );
    else
        return TableCell( ABBR( O, O.Name ) );
}

static final preoperator string *( coerce string O )
{
    if(Len(O) > 24 )
        return TableCell( ABBR( O, Left(O,22) $".." ) );
    else
        return TableCell( O );
}



static final function string TableCell( coerce string S )
{
    return "<td>" $S$  "</td>";
}

static final function string TableCellCSS( coerce string style, coerce string S )
{
    return "<td"@ CSS(style) $">" $S$  "</td>";
}

static final function string CSS( coerce string S )
{
    return "style=\"" $S $"\"";
}

static final function string IS( coerce string P, coerce string V )
{
    return P $":" @V $";" ;
}

static final function string RGB( byte R, byte G, byte B )
{
    return "rgb(" $R$ "," $G$ "," $B$ ")";
}

static final function string ABBR( coerce string full, coerce string abbr )
{
    return "<abbr title=\"" $Left(full,1024) $"\">" $abbr$ "</abbr>";
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{

}
