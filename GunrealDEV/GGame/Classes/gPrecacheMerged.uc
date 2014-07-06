// ============================================================================
//  gPrecacheMerged.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================

#exec obj load file=G_Meshes.usx
#exec obj load file=G_Weapons.usx
#exec obj load file=G_FX.utx

class gPrecacheMerged extends Object;


// Gunreal Content
#EXEC OBJ LOAD FILE="2K4Menus.utx"
#EXEC OBJ LOAD FILE="2K4MenuSounds.uax"
#EXEC OBJ LOAD FILE="G_Anims.ukx"
#EXEC OBJ LOAD FILE="G_Anims3rd.ukx"
#EXEC OBJ LOAD FILE="G_FX.utx"
#EXEC OBJ LOAD FILE="G_Menu.utx"
#EXEC OBJ LOAD FILE="G_Meshes.usx"
#EXEC OBJ LOAD FILE="G_Skins.utx"
#EXEC OBJ LOAD FILE="G_Sounds.uax"
#EXEC OBJ LOAD FILE="G_Proc.uax"
#EXEC OBJ LOAD FILE="G_Weapons.usx"
#EXEC OBJ LOAD FILE="HUDContent.utx"
#EXEC OBJ LOAD FILE="MenuSounds.uax"

// Turret
#EXEC OBJ LOAD FILE="..\StaticMeshes\AS_Weapons_SM.usx"
#EXEC OBJ LOAD FILE="..\Textures\VMParticleTextures.utx"



// ============================================================================
//  Precache Merged
// ============================================================================

static function StaticPrecache(LevelInfo L)
{
	StaticPrecacheMaterials(L);
	StaticPrecacheStaticMeshes(L);
	StaticPrecacheSounds(L);
	StaticPrecacheSkelMeshes(L);
}

static function StaticPrecacheMaterials(LevelInfo L)
{
	Log(default.class.name, 'GunrealPrecacheMAT');
	stopwatch(False);
	L.AddPrecacheMaterial(Material'AS_FX_TX.Trails.Trail_red');
	L.AddPrecacheMaterial(Material'AW-2004Explosions.Fire.Part_explode2s');
	L.AddPrecacheMaterial(Material'AW-2004Particles.Energy.SparkHead');
	L.AddPrecacheMaterial(Material'AW-2004Particles.Fire.BlastMark');
	L.AddPrecacheMaterial(Material'AW-2004Particles.Fire.MuchSmoke2t');
	L.AddPrecacheMaterial(Material'AW-2004Particles.Weapons.PlasmaStar');
	L.AddPrecacheMaterial(Material'AW-2004Particles.Weapons.TracerShot');
	L.AddPrecacheMaterial(Material'Crosshairs.HUD.Crosshair_Circle1');
	L.AddPrecacheMaterial(Material'Crosshairs.HUD.Crosshair_Cross1');
	L.AddPrecacheMaterial(Material'EmitterTextures.MultiFrame.rockchunks02');
	L.AddPrecacheMaterial(Material'EpicParticles.Flares.BurnFlare1');
	L.AddPrecacheMaterial(Material'EpicParticles.Flares.SoftFlare');
	L.AddPrecacheMaterial(Material'EpicParticles.JumpPad.NewTransLaunBoltFB');
	L.AddPrecacheMaterial(Material'ExplosionTex.Framed.exp1_frames');
	L.AddPrecacheMaterial(Material'ExplosionTex.Framed.exp7_frames');
	L.AddPrecacheMaterial(Material'G_FX.Debris.debris_1a');
	L.AddPrecacheMaterial(Material'G_FX.Decals.Acidsplash2');
	L.AddPrecacheMaterial(Material'G_FX.Decals.Acid_drop1');
	L.AddPrecacheMaterial(Material'G_FX.Decals.bullet_1c');
	L.AddPrecacheMaterial(Material'G_FX.Decals.Burn_Decal_1');
	L.AddPrecacheMaterial(Material'G_FX.Decals.HRL_Decal_01b');
	L.AddPrecacheMaterial(Material'G_FX.Flares.flare1');
	L.AddPrecacheMaterial(Material'G_FX.Flares.flare2');
	L.AddPrecacheMaterial(Material'G_FX.Flares.flare3');
	L.AddPrecacheMaterial(Material'G_FX.Flares.flare4');
	L.AddPrecacheMaterial(Material'G_FX.Flares.flare5');
	L.AddPrecacheMaterial(Material'G_FX.fX.hrl_shield_a1');
	L.AddPrecacheMaterial(Material'G_FX.fX.hrl_shield_b1');
	L.AddPrecacheMaterial(Material'G_FX.fX.Mine_flash');
	L.AddPrecacheMaterial(Material'G_FX.fX.pickup_lite_1');
	L.AddPrecacheMaterial(Material'G_FX.fX.pickup_lite_2');
	L.AddPrecacheMaterial(Material'G_FX.fX.pickup_lite_3');
	L.AddPrecacheMaterial(Material'G_FX.fX.pickup_lite_4');
	L.AddPrecacheMaterial(Material'G_FX.fX.waterripple_2');
	L.AddPrecacheMaterial(Material'G_FX.Gibs.blood_dropsfly1');
	L.AddPrecacheMaterial(Material'G_FX.Gibs.blood_splash1b_sm');
	L.AddPrecacheMaterial(Material'G_FX.Gibs.blood_splat1');
	L.AddPrecacheMaterial(Material'G_FX.Gibs.blood_splat2b');
	L.AddPrecacheMaterial(Material'G_FX.Gibs.weapon_blood_splat1');
	L.AddPrecacheMaterial(Material'G_FX.Glass.glassgrid1');
	L.AddPrecacheMaterial(Material'G_FX.Interface.belt_square_a1');
	L.AddPrecacheMaterial(Material'G_FX.Interface.belt_square_a2');
	L.AddPrecacheMaterial(Material'G_FX.Interface.belt_stamina_a1');
	L.AddPrecacheMaterial(Material'G_FX.Interface.cg_belt_melee');
	L.AddPrecacheMaterial(Material'G_FX.Interface.cg_belt_mine');
	L.AddPrecacheMaterial(Material'G_FX.Interface.cg_belt_nade');
	L.AddPrecacheMaterial(Material'G_FX.Interface.cg_belt_tele');
	L.AddPrecacheMaterial(Material'G_FX.Interface.cg_belt_trans');
	L.AddPrecacheMaterial(Material'G_FX.Interface.crosshair_a5');
	L.AddPrecacheMaterial(Material'G_FX.Interface.crosshair_s1');
	L.AddPrecacheMaterial(Material'G_FX.Interface.crosshair_sniper_a1');
	L.AddPrecacheMaterial(Material'G_FX.Interface.dial_nokill');
	L.AddPrecacheMaterial(Material'G_FX.Interface.dial_survival');
	L.AddPrecacheMaterial(Material'G_FX.Interface.fb_iconsheet0_pulse');
	L.AddPrecacheMaterial(Material'G_FX.Interface.IconSheet0');
	L.AddPrecacheMaterial(Material'G_FX.Interface.scope_g601');
	L.AddPrecacheMaterial(Material'G_FX.Interface.Shop-A1');
	L.AddPrecacheMaterial(Material'G_FX.Interface.Shop-O1');
	L.AddPrecacheMaterial(Material'G_FX.Interface.Shop-R1');
	L.AddPrecacheMaterial(Material'G_FX.Interface.Shop-S1');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.AcidMG_flash_01');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mflash4');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mflash4b');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mini_blue1_quad');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mini_blue1_quad_smalpha');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mini_blue2_quad_sm');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mini_flash_2');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mini_flash_2quad');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mini_flash_2smm');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mini_flash_3quad_a');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.mini_sparks_1');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.plas_flash1');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.spark1Q');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.spark3');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.sparks_hit1cQ');
	L.AddPrecacheMaterial(Material'G_FX.Mflashes.spot1');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.elec_1');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.elec_1_quad');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Icon_Boost1');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.PlasmaballA');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Plasmaball_1');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Plasmaball_2');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Plasmaball_Alpha');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Plasmaball_E');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.plasmamine_red');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.plasmamine_test1');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Psplat_1');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Psplat_1red');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Psplat_2');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Psplat_2red');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Psplat_B');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.Psplat_Bred');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.P_dots1');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.P_dots2');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.P_Membrane1');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.P_Membrane1c');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.P_Membrane2Q');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.P_Membrane2Qb_sm');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.P_Membrane2Qd_sm');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.P_Membrane2Qe');
	L.AddPrecacheMaterial(Material'G_FX.Plasmafx.p_smoke1');
	L.AddPrecacheMaterial(Material'G_FX.Shield.shield_c1');
	L.AddPrecacheMaterial(Material'G_FX.Shield.shield_ring_1');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.boom1');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.boom2');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.fireburst2');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.Kafire3');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.Smikes2sm');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.Smoke2');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.smoke2_b');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.smoke52Q');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.smoke5fireQb');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.smoke5Q');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.smoke5Qb');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.smoke6');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.spark1');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.spark2');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.sparks_4Q');
	L.AddPrecacheMaterial(Material'G_FX.Smokes.spot1');
	L.AddPrecacheMaterial(Material'G_FX.Sniper.bullet_ripple_b');
	L.AddPrecacheMaterial(Material'G_FX.Sniper.bullet_ripple_bhi');
	L.AddPrecacheMaterial(Material'G_FX.Sniper.sniper_ripple');
	L.AddPrecacheMaterial(Material'G_FX.Sniper.sniper_scope_a1');
	L.AddPrecacheMaterial(Material'G_FX.Sniper.sniper_scope_a2');
	L.AddPrecacheMaterial(Material'G_FX.Sniper.sniper_screenwash_a');
	L.AddPrecacheMaterial(Material'HUDContent.Generic.GlowCirclePulse');
	L.AddPrecacheMaterial(Material'HUDContent.Generic.HUD');
	L.AddPrecacheMaterial(Material'ONSInterface-TX.tankBarrelAligned');
	L.AddPrecacheMaterial(Material'Turrets.Huds.LinkZoomTickBar');
	L.AddPrecacheMaterial(Material'Turrets.Huds.LinkZoomTickRot');
	L.AddPrecacheMaterial(Material'UT2004Weapons.Shaders.ShockHitShader');
	L.AddPrecacheMaterial(Material'UT2004Weapons.WeaponSpecMap2');
	L.AddPrecacheMaterial(Material'WeaponSkins.AmmoPickups.NewTransGlassFB');
	L.AddPrecacheMaterial(Material'WeaponSkins.AmmoPickups.NEWTranslocatorPUCK');
	L.AddPrecacheMaterial(Material'WeaponSkins.Skins.NEWTranslocatorTEX');
	L.AddPrecacheMaterial(Material'XEffectMat.Shock.shock_ring_b');
	L.AddPrecacheMaterial(Material'XEffects.BloodSplat1');
	L.AddPrecacheMaterial(Material'XEffects.RedMarker_t');
	L.AddPrecacheMaterial(Material'XEffects.rocketblastmark');
	L.AddPrecacheMaterial(Material'XEffects.ShellCasingTex');
	L.AddPrecacheMaterial(Material'XEffects.SmokeTex');
	L.AddPrecacheMaterial(Material'XEffects.WispSmoke_t');
	L.AddPrecacheMaterial(Material'XGame.Water.xSplashBase');
	L.AddPrecacheMaterial(Material'XGame.Water.xWaterDrops2');
	L.AddPrecacheMaterial(Material'XGameShaders.PlayerShaders.PlayerTrans');
	L.AddPrecacheMaterial(Material'XGameShaders.PlayerShaders.PlayerTransRed');
	L.AddPrecacheMaterial(Material'XGameShaders.WeaponShaders.MinigunFlashFinal');
	L.AddPrecacheMaterial(Material'XGameShaders.WeaponShaders.ShockMuzFlash1stFinal');
	L.AddPrecacheMaterial(Material'XWeapons_rc.Icons.SniperArrows');
	stopwatch(True);
}

static function StaticPrecacheStaticMeshes(LevelInfo L)
{
	Log(default.class.name, 'GunrealPrecacheSM');
	stopwatch(False);
	L.AddPrecacheStaticMesh(StaticMesh'AS_Weapons_SM.Turret.ASTurret_Base');
	L.AddPrecacheStaticMesh(StaticMesh'AS_Weapons_SM.Turret.FloorTurretSwivel');
	L.AddPrecacheStaticMesh(StaticMesh'Editor.TexPropCube');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.acid_ammo_mg');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.acid_ammo_p');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.firegun_ammo1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.g60_ammo');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.hrl_ammo0');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.minigun_ammo_a');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.minigun_ammo_b');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.minigun_ammo_c');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.plasma_ammo1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.rl_ammo1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.shotgun_ammo');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.sniper_ammo1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Ammo.spammer_ammo1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Gibs.headshot_k');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Pickups.adrenaline_1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Pickups.pickup_1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Pickups.pickup_2');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Pickups.spawner_1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Pickups.spawner_2');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Pickups.terminal_shield_1b');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.acid_bullet_mg');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.acid_bullet_p');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.combo_mine1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.combo_nade1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.combo_tele1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.combo_trans1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.hrl_beacon_a');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.hrl_eject_0');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.hrl_proj_a');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.minigun_shell_a');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.minigun_shell_b');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.minigun_shell_c');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.rl_proj_a');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.rl_proj_prox');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.shotgun_shell1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.spam_chargenew0');
	L.AddPrecacheStaticMesh(StaticMesh'G_Meshes.Projectiles.spam_chargenew1');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_acidmachgun');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_acidpistol');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_firegun');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_g60');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_hrl');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_minigun_a');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_minigun_b');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_minigun_c');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_plasmagun');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_rox');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_shotgun');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_snipercannon');
	L.AddPrecacheStaticMesh(StaticMesh'G_Weapons.Pickups.pkup_spammer');
	L.AddPrecacheStaticMesh(StaticMesh'WeaponStaticMesh.RocketLauncherPickup');
	stopwatch(True);
}

static function StaticPrecacheSounds(LevelInfo L)
{
	Log(default.class.name, 'GunrealPrecacheSD');
	stopwatch(False);
	DynamicLoadObject("AssaultSounds.Sentinel.Ceiling_Open_Close", class'Sound', True);
	DynamicLoadObject("G_Proc.acid.acd_g_glass_hit", class'Sound', True);
	DynamicLoadObject("G_Proc.acid.amg_p_fire", class'Sound', True);
	DynamicLoadObject("G_Proc.acid.ap_p_fire", class'Sound', True);
	DynamicLoadObject("G_Proc.cglove.cg_boom_b", class'Sound', True);
	DynamicLoadObject("G_Proc.cglove.cg_boom_c", class'Sound', True);
	DynamicLoadObject("G_Proc.cglove.cg_nade_hit", class'Sound', True);
	DynamicLoadObject("G_Proc.Clothing.clothing_gunreal", class'Sound', True);
	DynamicLoadObject("G_Proc.Clothing.clothing_gunreal_jump", class'Sound', True);
	DynamicLoadObject("G_Proc.Clothing.clothing_military", class'Sound', True);
	DynamicLoadObject("G_Proc.Clothing.clothing_military_jump", class'Sound', True);
	DynamicLoadObject("G_Proc.Destroyer.de_explode", class'Sound', True);
	DynamicLoadObject("G_Proc.G60.g60_g_fireseg", class'Sound', True);
	DynamicLoadObject("G_Proc.Gameplay.money_a", class'Sound', True);
	DynamicLoadObject("G_Proc.Gameplay.money_b", class'Sound', True);
	DynamicLoadObject("G_Proc.gore.gore_g_ragdoll_hits", class'Sound', True);
	DynamicLoadObject("G_Proc.HRL.hrl_p_boom", class'Sound', True);
	DynamicLoadObject("G_Proc.HRL.hrl_shieldhit_grp", class'Sound', True);
	DynamicLoadObject("G_Proc.impactfx.g_bullet_ric", class'Sound', True);
	DynamicLoadObject("G_Proc.impactfx.p_shell_terrain", class'Sound', True);
	DynamicLoadObject("G_Proc.Minigun.mini_p_fire_a", class'Sound', True);
	DynamicLoadObject("G_Proc.Minigun.mini_p_fire_b", class'Sound', True);
	DynamicLoadObject("G_Proc.Minigun.mini_p_fire_c", class'Sound', True);
	DynamicLoadObject("G_Proc.Minigun.mini_p_he_explosion", class'Sound', True);
	DynamicLoadObject("G_Proc.PlasmaGun.pl_p_altmine", class'Sound', True);
	DynamicLoadObject("G_Proc.PlasmaGun.pl_p_altslap", class'Sound', True);
	DynamicLoadObject("G_Proc.PlasmaGun.pl_p_alt_explode", class'Sound', True);
	DynamicLoadObject("G_Proc.PlasmaGun.pl_p_deny", class'Sound', True);
	DynamicLoadObject("G_Proc.PlasmaGun.pl_p_explode", class'Sound', True);
	DynamicLoadObject("G_Proc.PlasmaGun.pl_p_fire", class'Sound', True);
	DynamicLoadObject("G_Proc.rl.rl_boom1", class'Sound', True);
	DynamicLoadObject("G_Proc.Shotgun.sg_p_fire", class'Sound', True);
	DynamicLoadObject("G_Proc.Shotgun.sg_p_firedual", class'Sound', True);
	DynamicLoadObject("G_Proc.snipercannon.sc_p_firebig", class'Sound', True);
	DynamicLoadObject("G_Proc.Spammer.sp_p_fire", class'Sound', True);
	DynamicLoadObject("G_Proc.Spammer.sp_p_pop", class'Sound', True);
	DynamicLoadObject("G_Proc.Spammer.sp_p_stick", class'Sound', True);
	DynamicLoadObject("G_Sounds.acid_mgun.amg_clamp_dwn", class'Sound', True);
	DynamicLoadObject("G_Sounds.acid_mgun.amg_clamp_up", class'Sound', True);
	DynamicLoadObject("G_Sounds.acid_mgun.amg_spin_loop", class'Sound', True);
	DynamicLoadObject("G_Sounds.acid_pistol.ap_spindown", class'Sound', True);
	DynamicLoadObject("G_Sounds.acid_pistol.ap_spinup", class'Sound', True);
	DynamicLoadObject("G_Sounds.acid_pistol.ap_spin_loop", class'Sound', True);
	DynamicLoadObject("G_Sounds.acid_pistol.ap_switch", class'Sound', True);
	DynamicLoadObject("G_Sounds.Adrenaline.g_adren_pickup1", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_melee_fire", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_melee_player_impact", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_melee_wall_impact", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_mine_armed", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_mine_disc_impact", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_mine_fire", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_nade_altfire_beep", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_nade_fire", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_selectalt_a", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_telepod_fire", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_telepod_impact_bump", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_telepod_reclaim", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_trans_disc_reclaim", class'Sound', True);
	DynamicLoadObject("G_Sounds.cglove.cg_trans_fire", class'Sound', True);
	DynamicLoadObject("G_Sounds.Destroyer.de_altfire_begin", class'Sound', True);
	DynamicLoadObject("G_Sounds.Destroyer.de_altfire_end", class'Sound', True);
	DynamicLoadObject("G_Sounds.Destroyer.de_altfire_loop", class'Sound', True);
	DynamicLoadObject("G_Sounds.Destroyer.de_fire_proc", class'Sound', True);
	DynamicLoadObject("G_Sounds.G60.g60_fireseg_end", class'Sound', True);
	DynamicLoadObject("G_Sounds.G60.g60_zoom_begin", class'Sound', True);
	DynamicLoadObject("G_Sounds.G60.g60_zoom_end", class'Sound', True);
	DynamicLoadObject("G_Sounds.G60.g60_zoom_loop", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_armor_a", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_armor_b", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_health_a1", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_health_b1", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_invul_shield_a2", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_item_resp_a", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_minihealth_1", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_ram_a", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_respawn_b2", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_udamage_1", class'Sound', True);
	DynamicLoadObject("G_Sounds.Gameplay.g_udamage_ambloop_end1", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_altfire", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_alt_beep", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_fire", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_fire_noammo", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_homing_drone", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_homing_fire", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_homing_reclaim", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_homing_reload", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_homing_reload_empty", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_homing_stick", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_lock", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_plasma_deflect1", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_plasma_deflect2", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_reload", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_reload2", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_reload_empty", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_rocketfly_alt", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_rocketfly_homing", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_trigger_pull_a", class'Sound', True);
	DynamicLoadObject("G_Sounds.HRL.hrl_trigger_pull_b", class'Sound', True);
	DynamicLoadObject("G_Sounds.Interface.shopping_bubble_a1", class'Sound', True);
	DynamicLoadObject("G_Sounds.Interface.shopping_bubble_c1", class'Sound', True);
	DynamicLoadObject("G_Sounds.Interface.shopping_bubble_d1", class'Sound', True);
	DynamicLoadObject("G_Sounds.Minigun.mini_pickup", class'Sound', True);
	DynamicLoadObject("G_Sounds.Minigun.mini_w_spin", class'Sound', True);
	DynamicLoadObject("G_Sounds.Minigun.mini_w_winddown", class'Sound', True);
	DynamicLoadObject("G_Sounds.Minigun.mini_w_windup", class'Sound', True);
	DynamicLoadObject("G_Sounds.notif.notif_tone_1", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_boost", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_boostend", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_boostfire", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_boost_mech", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_charge", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_charge_hold", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_fire_alt", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_fire_alt_boosted", class'Sound', True);
	DynamicLoadObject("G_Sounds.PlasmaGun.pl_winddown", class'Sound', True);
	DynamicLoadObject("G_Sounds.rl.rl_fire1", class'Sound', True);
	DynamicLoadObject("G_Sounds.rl.rl_prox_stick1", class'Sound', True);
	DynamicLoadObject("G_Sounds.selection.grp_weapon_pickup_a", class'Sound', True);
	DynamicLoadObject("G_Sounds.Shotgun.sg_reload", class'Sound', True);
	DynamicLoadObject("G_Sounds.Shotgun.sg_unload", class'Sound', True);
	DynamicLoadObject("G_Sounds.snipercannon.sc_reload1", class'Sound', True);
	DynamicLoadObject("G_Sounds.snipercannon.sc_targeted1", class'Sound', True);
	DynamicLoadObject("G_Sounds.snipercannon.sc_zoom_begin1", class'Sound', True);
	DynamicLoadObject("G_Sounds.snipercannon.sc_zoom_end1", class'Sound', True);
	DynamicLoadObject("G_Sounds.snipercannon.sc_zoom_loop1", class'Sound', True);
	DynamicLoadObject("G_Sounds.Spammer.sp_beep", class'Sound', True);
	DynamicLoadObject("G_Sounds.Spammer.sp_bounce_alert", class'Sound', True);
	DynamicLoadObject("G_Sounds.Spammer.sp_fire_cant", class'Sound', True);
	DynamicLoadObject("G_Sounds.Spammer.sp_w_spin", class'Sound', True);
	DynamicLoadObject("G_Sounds.Spammer.sp_w_winddown", class'Sound', True);
	DynamicLoadObject("NewWeaponSounds.MiniGunTurretFire", class'Sound', True);
	DynamicLoadObject("NewWeaponSounds.NewGrenadeShoot", class'Sound', True);
	DynamicLoadObject("WeaponSounds.BaseGunTech.BSeekLost1", class'Sound', True);
	DynamicLoadObject("WeaponSounds.PGrenFloor1.P1GrenFloor1", class'Sound', True);
	DynamicLoadObject("WeaponSounds.PReload5.P1Reload5", class'Sound', True);
	DynamicLoadObject("WeaponSounds.Translocator.TranslocatorModuleRegeneration", class'Sound', True);
	stopwatch(True);
}

static function StaticPrecacheSkelMeshes(LevelInfo L)
{
	Log(default.class.name, 'GunrealPrecacheSK');
	stopwatch(False);
	DynamicLoadObject("AS_Vehicles_M.FloorTurretBase", class'Mesh', True);
	DynamicLoadObject("AS_Vehicles_M.FloorTurretGun", class'Mesh', True);
	DynamicLoadObject("GResources.pmine", class'Mesh', True);
	DynamicLoadObject("G_Anims.amgun", class'Mesh', True);
	DynamicLoadObject("G_Anims.apistol", class'Mesh', True);
	DynamicLoadObject("G_Anims.cglove", class'Mesh', True);
	DynamicLoadObject("G_Anims.FireGun", class'Mesh', True);
	DynamicLoadObject("G_Anims.G60", class'Mesh', True);
	DynamicLoadObject("G_Anims.HRL", class'Mesh', True);
	DynamicLoadObject("G_Anims.minigun_a", class'Mesh', True);
	DynamicLoadObject("G_Anims.minigun_b", class'Mesh', True);
	DynamicLoadObject("G_Anims.minigun_c", class'Mesh', True);
	DynamicLoadObject("G_Anims.Plasma", class'Mesh', True);
	DynamicLoadObject("G_Anims.Rox", class'Mesh', True);
	DynamicLoadObject("G_Anims.Shotgun", class'Mesh', True);
	DynamicLoadObject("G_Anims.Sniper", class'Mesh', True);
	DynamicLoadObject("G_Anims.Spammer", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.FireGun", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.G60", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.HRL", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.mGun", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.minigun_a", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.minigun_b", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.minigun_c", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.Pistol", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.Plasma", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.Rox", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.Shotgun", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.Sniper", class'Mesh', True);
	DynamicLoadObject("G_Anims3rd.Spammer", class'Mesh', True);
	stopwatch(True);
}



DefaultProperties
{

}