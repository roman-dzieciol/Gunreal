// ============================================================================
//  gProximityFuze.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gProximityFuze extends gBasedActor;

var   bool              bWarned;
var   Actor             WarnActor;
var() Sound             WarnSound;
var() float             WarnSoundVolume;
var() float             WarnSoundRadius;

event PostBeginPlay()
{
    local gPickupBase PB;
    local gTerminal T;

    //gLog( "PostBeginPlay" );

    Super.PostBeginPlay();

    // go boom on pickup bases
    foreach DynamicActors(class'gPickupBase',PB)
    {
        if( VSize(Location-PB.Location) < CollisionRadius + PB.CollisionRadius )
        {
            SetOff(PB);
            return;
        }
    }

    // go boom on terminals
    foreach DynamicActors(class'gTerminal',T)
    {
        if( VSize(Location-T.Location) < CollisionRadius + T.CollisionRadius )
        {
            SetOff(T);
            return;
        }
    }
}


function SetOff(Actor Other)
{
    SetTimer(1.0, False);
    WarnActor = Other;
}

event Timer()
{
    if( !bWarned )
    {
        // Play warn sound
        if( WarnActor != None && WarnSound != None )
            WarnActor.PlaySound(WarnSound, SLOT_Misc, WarnSoundVolume, true, WarnSoundRadius, 1.0, true);
        
        bWarned = True;
        SetTimer(1.0, False);
    }
    else
    {
        if( Owner != None )
            gProjectile(Owner).Hit(Owner.Base, Owner.Location, vector(Owner.Rotation));
    }
}

event Touch( Actor Other )
{
    // Touch projectile
    if( Pawn(Other) != None && Owner != None )
    {
        gProjectile(Owner).ProximityTouch(Other);
    }
}



// ============================================================================
//  DefaultProperties
// ============================================================================
DefaultProperties
{
    WarnSound                       = Sound'G_Sounds.notif_waz_2'
    WarnSoundVolume                 = 2.0
    WarnSoundRadius                 = 230

    CollisionRadius                 = 48
    CollisionHeight                 = 32
    bCollideActors                  = True
    bUseCylinderCollision           = True
    bOnlyAffectPawns                = True
    RemoteRole                      = ROLE_None
}
