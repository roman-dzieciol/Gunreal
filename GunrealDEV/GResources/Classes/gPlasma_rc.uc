// ============================================================================
//  gPlasma_rc.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlasma_rc extends Resource;

#EXEC MESH IMPORT MESH=pmine ANIVFILE=..\Gunreal\GResources\Models\pmine_a.3d DATAFILE=..\Gunreal\GResources\Models\pmine_d.3d X=0 Y=0 Z=0
#EXEC MESH ORIGIN MESH=pmine X=0 Y=0 Z=0 ROLL=0 PITCH=0 YAW=0
#EXEC MESH SEQUENCE MESH=pmine SEQ=All STARTFRAME=0 NUMFRAMES=40
#EXEC MESH SEQUENCE MESH=pmine SEQ=Wobble STARTFRAME=0 NUMFRAMES=40 RATE=30
#EXEC MESHMAP NEW MESHMAP=pmine MESH=pmine_wtf
#EXEC MESHMAP SCALE MESHMAP=pmine X=1.0 Y=1.0 Z=1.0

DefaultProperties
{
}