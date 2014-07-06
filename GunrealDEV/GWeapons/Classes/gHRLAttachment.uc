// ============================================================================
//  gHRLAttachment.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gHRLAttachment extends gWeaponAttachment;


var() class<Emitter> BlowbackClass;
var() name BlowbackBone;


static function PrecacheScan(gPrecacheScan S)
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.BlowbackClass);
}

simulated function ShowMuzzleFlash()
{
    local Emitter E;

    Super.ShowMuzzleFlash();

    if( Level.DetailMode >= ShellDetailMode )
    {
        if( BlowbackClass != None )
        {
            E = Spawn(BlowbackClass);
            if( E != None && BlowbackBone != '' )
            {
                AttachToBone(E, BlowbackBone);
            }
        }
    }
}

// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    BlowbackBone            = "blowback"
    BlowbackClass           = class'GEffects.gHRLBlowback'

    IgnoredMode             = 1
    bWeaponLight            = False

    bHeavy                  = True
    bRapidFire              = False
    bAltRapidFire           = False

    Mesh                    = Mesh'G_Anims3rd.hrl'

    DrawScale               = 0.3
    RelativeLocation        = (X=0,Y=-10,Z=-20) //X -Forward/+Backward, Y -Left/+Right, Z -Up/+Down
}