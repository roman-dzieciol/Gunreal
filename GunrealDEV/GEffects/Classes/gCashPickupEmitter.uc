// ============================================================================
//  gCashPickupEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gCashPickupEmitter extends gEmitter;

var   Pawn          Target;
var() float         AccelRate;
var() Sound         PickupSound;

simulated event PostBeginPlay()
{
    Super.PostBeginPlay();

    if( Owner != None )
    {
        SetBase(Owner);
    }
}

simulated event Tick(float DeltaTime)
{
    if( Target == None )
    {
        if( Owner != None )
        {
            if( Owner.Instigator != None )
            {
                SetBase(None);
                Target = Owner.Instigator;
                SetPhysics(PHYS_Projectile);
                SetCollisionSize(10, 10);
                SetCollision(True);

                //gLog( "CHASE" @Target );
            }
        }
        else
        {
            //gLog( "NO TARGET" );
            Die();
        }
    }
    else
    {
        //gLog( "Chasing" @Target @CollisionRadius );
        Acceleration = AccelRate * Normal(Target.Location - Location);
        Velocity = VSize(Velocity) * Normal(Target.Location - Location);

        if( VSize(Target.Location - Location) < 15 )
            Touch(Target);
    }
}

simulated event Touch(Actor Other)
{
    if( Pawn(Other) != None && Target != None && Other == Target )
    {
        //gLog( "TOUCH" @Other );
        PlaySound(PickupSound, SLOT_None, 1.0,, 600);
        Die();
    }
}

final simulated function Die()
{
    //gLog( "Die" @Target );
    Disable('Tick');
    SetCollision(False);
    SetPhysics(PHYS_None);

    Kill();
}


// ============================================================================
//  Precache
// ============================================================================

static function PrecacheScan( gPrecacheScan S )
{
    Super.PrecacheScan(S);
    S.PrecacheObject(default.PickupSound);
}

DefaultProperties
{
    //Physics                     = PHYS_None
    //bTrailerSameRotation        = False
    bBounce                     = False
    AccelRate                   = 2000
    bOnlyAffectPawns            = True
    AutoDestroy                 = False
    PickupSound                 = Sound'G_Proc.money_a'
    bUseCylinderCollision       = True

    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        FadeOut=True
        FadeIn=True
        UseActorForces=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        Acceleration=(Z=33.000000)
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.700000
        FadeOutStartTime=0.750000
        FadeInEndTime=0.270000
        MaxParticles=70
        Name="smoke"
        DetailMode=DM_SuperHigh
        SpinsPerSecondRange=(X=(Max=0.100000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.300000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=3.000000)
        StartSizeRange=(X=(Min=12.000000,Max=16.000000),Y=(Min=12.000000,Max=16.000000),Z=(Min=12.000000,Max=16.000000))
        ParticlesPerSecond=8.000000
        InitialParticlesPerSecond=8.000000
        Texture=Texture'G_FX.Plasmafx.P_Membrane2Qd_sm'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=2.000000,Max=3.000000)
        StartVelocityRange=(X=(Min=-5.000000,Max=5.000000),Y=(Min=-5.000000,Max=5.000000),Z=(Min=-5.000000,Max=5.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter1
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.600000,Max=0.600000),Z=(Min=0.600000,Max=0.600000))
        Opacity=0.530000
        FadeOutStartTime=0.099000
        FadeInEndTime=0.099000
        CoordinateSystem=PTCS_Relative
        MaxParticles=33
        Name="ripple_floor"
        DetailMode=DM_SuperHigh
        StartLocationRange=(Z=(Min=2.000000,Max=2.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=15.000000,Max=29.000000),Y=(Min=15.000000,Max=29.000000),Z=(Min=15.000000,Max=29.000000))
        ParticlesPerSecond=5.000000
        InitialParticlesPerSecond=5.000000
        DrawStyle=PTDS_AlphaBlend
        Texture=Texture'G_FX.Sniper.bullet_ripple_b'
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter1'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter2
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        FadeOutStartTime=0.184000
        FadeInEndTime=0.184000
        CoordinateSystem=PTCS_Relative
        MaxParticles=33
        Name="green"
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=15.000000,Max=29.000000),Y=(Min=15.000000,Max=29.000000),Z=(Min=15.000000,Max=29.000000))
        ParticlesPerSecond=5.000000
        InitialParticlesPerSecond=5.000000
        Texture=Texture'G_FX.Flares.flare4'
        LifetimeRange=(Min=0.400000,Max=0.400000)
        StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter2'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter3
        UseDirectionAs=PTDU_Normal
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        ColorMultiplierRange=(X=(Min=0.000000,Max=0.000000),Z=(Min=0.000000,Max=0.000000))
        FadeOutStartTime=0.270000
        FadeInEndTime=0.150000
        CoordinateSystem=PTCS_Relative
        MaxParticles=22
        Name="green_floor"
        StartLocationRange=(Z=(Min=2.000000,Max=2.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=22.000000,Max=29.000000),Y=(Min=22.000000,Max=29.000000),Z=(Min=22.000000,Max=29.000000))
        ParticlesPerSecond=5.000000
        InitialParticlesPerSecond=5.000000
        Texture=Texture'G_FX.Flares.flare4'
        LifetimeRange=(Min=0.500000,Max=0.500000)
    End Object
    Emitters(3)=SpriteEmitter'SpriteEmitter3'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter4
        FadeOut=True
        FadeIn=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=60,G=233,R=242,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        ColorScale(2)=(RelativeTime=1.000000,Color=(B=144,G=144,R=144,A=255))
        FadeOutStartTime=0.180000
        FadeInEndTime=0.168000
        CoordinateSystem=PTCS_Relative
        MaxParticles=33
        Name="white_stuff"
        DetailMode=DM_High
        StartLocationRange=(X=(Min=-9.000000,Max=9.000000),Y=(Min=-9.000000,Max=9.000000),Z=(Max=9.000000))
        StartSpinRange=(X=(Max=1.000000),Y=(Max=1.000000),Z=(Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=3.000000,Max=5.000000),Y=(Min=3.000000,Max=5.000000),Z=(Min=3.000000,Max=5.000000))
        ParticlesPerSecond=15.000000
        InitialParticlesPerSecond=15.000000
        Texture=Texture'G_FX.Flares.flare5'
        LifetimeRange=(Min=0.400000,Max=0.400000)
        StartVelocityRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(4)=SpriteEmitter'SpriteEmitter4'
}