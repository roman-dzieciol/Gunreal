// ============================================================================
//  gPlayerInput.uc ::
// ============================================================================
//  Copyright 2005-2008 The Gunreal Team :: http://www.gunreal.com
// ============================================================================
class gPlayerInput extends PlayerInput within gPlayer
    config(User)
    transient;

event Created()
{
    //Log("Created", Name);
    GunrealInput = Self;
}

// ============================================================================
// DefaultProperties
// ============================================================================
DefaultProperties
{
}