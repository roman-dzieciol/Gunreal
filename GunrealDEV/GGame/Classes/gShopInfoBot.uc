// ============================================================================
//  gShopInfoBot.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShopInfoBot extends gShopInfo
    within gBot;

// ============================================================================
//  Pawn
// ============================================================================
function PawnSpawned()
{
    local gPawn P;
    //local gPRI GPRI;

    //gLog( "PawnSpawned" );

    P = GetPawn();
    if( P != None )
    {
        CreateShoppingList();
        P.BonusMode = BonusMode;
        P.PendingBonusMode = PendingBonusMode;
        BuyPending();
    }
}


// ============================================================================
//  Shop
// ============================================================================

// Version 3.0, let's see if this comes out like what we want :)
function CreateShoppingList() {
    local gPlayer.sShopLoadout Loadout;
    local array<class<gWeapon> > WeaponListA, WeaponListB;
    local gPRI GPRI;
    local int i, j, k, MyMoney, TotalCost;
    local bool bBreak;
    local class<gShopManifest> MC;
    local array< class<gWeapon> > WL;
    local array< class<Weapon> > GL;


    // TODO: verify ammo code

    GPRI = GetGPRI();
    if( GPRI == None )
        return;

    MC = GetManifestClass(Level.Game);
    GL = MC.static.GetGloveClasses();
    WL = MC.static.GetWeaponClasses();
    Loadout.Manifest = MC;

    WeaponListA = WL;
    for(i = 0; i < WeaponListA.Length; i++) {
        for(j = 0; j < WeaponListA[i].default.BotPurchaseProbMod; j++) {
            WeaponListB[WeaponListB.Length] = WeaponListA[i];
        }
    }
    MyMoney = GPRI.GetMoney();
    while(!bBreak) {
        i = Rand(WeaponListB.Length);
        Loadout.Weapons[k] = WeaponListB[i];
        Loadout.Ammo[k] = GetMaxAmmo(WeaponListB[i]) * 0.5;
        TotalCost += GetAmmoCost(WeaponListB[i], Loadout.Ammo[k]);
        TotalCost += WeaponListB[i].default.CostWeapon;

        //log(self@"wants to buy a"@Loadout.Weapons[k]);

        for(j = 0; j < WeaponListB.Length; j++) {
            if(WeaponListB[j] == Loadout.Weapons[k]) {
                WeaponListB.Remove(j, 1);
                if( j == WeaponListB.Length )
                    break;
                j--;
            }
        }
        if(Loadout.Weapons[k].default.CostWeapon >= 800 && MyMoney - TotalCost < 500) bBreak = True;
        k++;
        if(MyMoney < 2000) bBreak = True;
        if(k > 2) bBreak = True;
        if(k > 1 && MyMoney - TotalCost < 1000) bBreak = True;
        if(MyMoney - TotalCost < 0) {
            bBreak = True;
            Loadout.PendingBonusMode = BM_Money;
        } else {
            j = Rand(3);
            switch(j) {
                case 0: Loadout.PendingBonusMode = BM_Regen; break;
                case 1: Loadout.PendingBonusMode = BM_Armor; break;
                case 2: Loadout.PendingBonusMode = BM_Shield; break;
            }
        }
    }

    Loadout.BonusMode = BonusMode;


    // get random glove, except for telepod
    j = Rand(3);
    if( GL[j].name =='gTeleporterGun' )
    {
        ++j;
        if( j >= GL.Length )
            j = 0;
    }
    
    // mark glove
    Loadout.Glove = GL[j];
    switch(j) {
        case 1: Loadout.GloveAmmo = 3+Rand(10); break;
        case 2: Loadout.GloveAmmo = 3+Rand(2); break;
    }
        
    Begin(outer);
    BuyLoadout(Loadout);
    End(outer);
}


// ============================================================================
//  Shop - Owner accessors/mutators
// ============================================================================

function gPawn GetPawn()
{
    return gPawn(Pawn);
}

function gPRI GetGPRI()
{
    return Outer.GetGPRI();
}

function PlayerReplicationInfo GetPRI()
{
    return PlayerReplicationInfo;
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    bInstantBonusChange=True
}
