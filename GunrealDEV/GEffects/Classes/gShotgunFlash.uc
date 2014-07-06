// ============================================================================
//  gShotgunFlash.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gShotGunFlash extends gMuzzleFlash;

simulated event Trigger( Actor Other, Pawn EventInstigator )
{
    local int i;

    Super(gEmitter).Trigger( Other, EventInstigator );

    for( i=0; i!=Emitters.Length; ++i )
    {
        if( Emitters[i] != None && !Emitters[i].Backup_Disabled )
        {
            if( Other == None && i == 2 )
                continue;

            Emitters[i].AllParticlesDead = False;
            Emitters[i].Disabled = False;
            Emitters[i].Reset();
        }
    }
}

DefaultProperties
{
    TriggerSpawnClass       = class'gShotgunPuff';


    Begin Object Class=SpriteEmitter Name=SpriteEmitter7
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.720000
        FadeOutStartTime=0.032000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="Sg_Fire"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=1.000000,Max=2.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.500000)
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=17.000000,Max=28.000000),Y=(Min=17.000000,Max=28.000000),Z=(Min=17.000000,Max=28.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.180000,Max=0.180000)
        StartVelocityRange=(X=(Max=233.000000),Y=(Min=-12.000000,Max=12.000000),Z=(Min=-12.000000,Max=12.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter7'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter9
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.340000
        CoordinateSystem=PTCS_Relative
        MaxParticles=1
        Name="Sg_Sparks"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=27.000000,Max=37.000000),Y=(Min=27.000000,Max=37.000000),Z=(Min=27.000000,Max=37.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_sparks_1'
        LifetimeRange=(Min=0.140000,Max=0.140000)
        StartVelocityRange=(X=(Max=333.000000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(1)=SpriteEmitter'SpriteEmitter9'

    Begin Object Class=SpriteEmitter Name=SpriteEmitter10
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=255,G=255,R=255,A=255))
        Opacity=0.450000
        FadeOutStartTime=0.032000
        CoordinateSystem=PTCS_Relative
        MaxParticles=2
        Name="ShotgunDualFlare"
        StartLocationRange=(X=(Min=-12.000000,Max=12.000000),Y=(Min=-3.000000,Max=3.000000),Z=(Min=-3.000000,Max=3.000000))
        SpinsPerSecondRange=(X=(Min=-1.000000,Max=1.000000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(1)=(RelativeTime=0.560000,RelativeSize=1.000000)
        StartSizeRange=(X=(Min=30.000000,Max=60.000000),Y=(Min=30.000000,Max=60.000000),Z=(Min=30.000000,Max=60.000000))
        InitialParticlesPerSecond=100.000000
        Texture=Texture'G_FX.Mflashes.mini_flash_2smm'
        LifetimeRange=(Min=0.140000,Max=0.140000)
        StartVelocityRange=(X=(Max=233.000000),Y=(Min=-0.022000,Max=0.022000),Z=(Min=-0.022000,Max=0.022000))
    End Object
    Emitters(2)=SpriteEmitter'SpriteEmitter10'
}
