// ============================================================================
//  gAmmoPickup.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gAmmoPickup extends UTAmmoPickup
    abstract;


function AnnouncePickup( Pawn Receiver )
{
    Receiver.HandlePickup(self);
    PlaySound(PickupSound, SLOT_None, 1.0);
}


function float DetourWeight(Pawn Other, float PathWeight)
{
    local Inventory Inv;
    local float Desire;

    for( Inv=Other.Inventory; Inv!=None; Inv=Inv.Inventory )
    {
        if( Weapon(Inv) != None )
        {
            Desire = Weapon(Inv).DesireAmmo(InventoryType, True);
            if( Desire != 0 )
                return Desire * MaxDesireability/PathWeight;
        }
    }
    return 0;
}

function float BotDesireability(Pawn Bot)
{
    local Inventory Inv;
    local float Desire;

    if( Bot.Controller.bHuntPlayer )
        return 0;

    for( Inv=Bot.Inventory; Inv!=None; Inv=Inv.Inventory )
    {
        if( Weapon(Inv) != None )
        {
            Desire = Weapon(Inv).DesireAmmo(InventoryType, False);
            if( Desire != 0 )
                return Desire * MaxDesireability;
        }
    }

    // Gunreal: we don't use nor check ammo instances

    return 0.25 * MaxDesireability;
}


// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    bAmbientGlow            = False
    AmbientGlow             = 0

    InventoryType           = None

    PickupMessage           = "You picked up ammo."
    PickupSound             = Sound'G_Sounds.selection.grp_weapon_pickup_a'
    PickupForce             = "SniperAmmoPickup"

    AmmoAmount              = 1
    MaxDesireability        = 0.3

    CollisionHeight         = 12.0
    CollisionRadius         = 12.0

    DrawType                = DT_StaticMesh
    DrawScale               = 0.1
    PrePivot                = (X=0,Y=0,Z=0)
    StaticMesh              = StaticMesh'Editor.TexPropCube'
}