// ============================================================================
//  gSpammerFireAlt.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gSpammerFireAlt extends gNoFire;


event PostBeginPlay()
{
    Super.PostBeginPlay();
}

simulated function bool AllowFire()
{
    return Super.AllowFire() || gSpammer(Weapon).CurrentMines > 0;
}

function DoFireEffect()
{
    //gLog( "DoFireEffect:" #Weapon.BotMode );

    gSpammer(Weapon).TriggerMines(Weapon);
    Weapon.BotMode = 0;

    if( Bot(Instigator.Controller) != None )
    {
        Bot(Instigator.Controller).StopFiring();
    }
}



DefaultProperties
{
    bIsAltFire          = True

    FireAnim            = alt
    FireAnimRate        = 1.0
    TweenTime           = 0.0

    FireRate            = 0.5
    BotRefireRate       = 0
}
