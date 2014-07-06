// ============================================================================
//  gUDamagePickupDroppedEmitter.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gUDamagePickupDroppedEmitter extends gEmitter;

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
    Begin Object Class=SpriteEmitter Name=SpriteEmitter0
        UseDirectionAs=PTDU_Up
        FadeOut=True
        RespawnDeadParticles=False
        SpinParticles=True
        UseSizeScale=True
        UseRegularSizeScale=False
        UniformSize=True
        AutomaticInitialSpawning=False
        BlendBetweenSubdivisions=True
        ColorScale(0)=(Color=(B=245,G=180,R=154,A=255))
        ColorScale(1)=(RelativeTime=1.000000,Color=(B=225,G=219,R=208,A=255))
        FadeOutStartTime=0.040000
        CoordinateSystem=PTCS_Relative
        MaxParticles=25
        Name="ddamage_dropped"
        SpinsPerSecondRange=(X=(Min=-0.010000,Max=0.010000))
        StartSpinRange=(X=(Min=-1.000000,Max=1.000000))
        SizeScale(0)=(RelativeSize=1.000000)
        SizeScale(1)=(RelativeTime=1.000000,RelativeSize=2.000000)
        StartSizeRange=(X=(Min=55.000000,Max=85.000000),Y=(Min=55.000000,Max=85.000000),Z=(Min=55.000000,Max=85.000000))
        ParticlesPerSecond=12.000000
        InitialParticlesPerSecond=12.000000
        Texture=Texture'G_FX.Plasmafx.elec_1_quad'
        TextureUSubdivisions=2
        TextureVSubdivisions=2
        LifetimeRange=(Min=0.200000,Max=0.200000)
        StartVelocityRange=(X=(Min=-44.000000,Max=44.000000),Y=(Min=-44.000000,Max=44.000000),Z=(Min=-44.000000,Max=44.000000))
    End Object
    Emitters(0)=SpriteEmitter'SpriteEmitter0'
}