
GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED = true -- Should the break free system be enabled?
GlorifiedHandcuffs.Config.BREAK_FREE_MIN_TIME = 0.05 -- What's the minimum time between clicks when breaking out?
GlorifiedHandcuffs.Config.BREAK_FREE_EXPIRY_TIME = 0.11 -- What's the maximum time between clicks when breaking out?
GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL = 100 -- How many clicks are required to break out?
GlorifiedHandcuffs.Config.BREAK_FREE_WANTED = true -- Should we make the player wanted for breaking out?
GlorifiedHandcuffs.Config.BREAK_FREE_SOUND_ON_FAILURE = true -- Should we play a 3D sound when the player fails breaking out?
GlorifiedHandcuffs.Config.BREAK_FREE_SOUND_ON_FAILURE_PATH = "physics/metal/metal_box_impact_hard2.wav" -- See above.

GlorifiedHandcuffs.Config.JAILER_ARREST_TIME = 120 -- How long will a player be arrested at the jailer for?
GlorifiedHandcuffs.Config.JAILER_ARREST_REWARD = 100 -- How much will a cop get rewarded for an arrest? Only works if jail only mode is off.
GlorifiedHandcuffs.Config.TEAM_CHANGE_UPON_JAIL = false -- Should we change the player's job upon jailing?
GlorifiedHandcuffs.Config.TEAM_CHANGE_UPON_JAIL_TEAM = TEAM_CITIZEN -- Which job would you like to change to?
GlorifiedHandcuffs.Config.JAIL_ONLY_MODE = false -- Set to true if you would like the handcuffs to behave like an arrest baton, arresting upon handcuffing.

GlorifiedHandcuffs.Config.CAN_NORMAL_PLAYER_HANDCUFF_WITHOUT_SURRENDER = true -- Can a normal player handcuff without the person being handcuffed surrendering?
GlorifiedHandcuffs.Config.ONLY_ALLOW_HANDCUFF_IF_PLAYER_WANTED = false -- Should we only allow an officer to handcuff a player if they're wanted?
GlorifiedHandcuffs.Config.CAN_ANY_COP_RELEASE_HANDCUFFS = false -- Set this to true if you want any cop to release someone from handcuffs.
GlorifiedHandcuffs.Config.HANDCUFF_DISTANCE = 125 -- How far can a player handcuff from?
GlorifiedHandcuffs.Config.TIME_TO_CUFF = 0.4 -- How many seconds must the player remain within distance to handcuff?

GlorifiedHandcuffs.Config.DRAG_SPEED_LIMIT = true -- Is there a speed limit on dragging?
GlorifiedHandcuffs.Config.DRAG_SPEED_LIMIT = 500 -- What's the speed limit on dragging?

GlorifiedHandcuffs.Config.BAIL_AMOUNT = 2500 -- How much does it cost to bail someone out?

GlorifiedHandcuffs.Config.BREAK_FREE_KEY = KEY_E -- The key to break free.
GlorifiedHandcuffs.Config.BREAK_FREE_KEY_NAME = "E" -- The string for the key that appears in the HUD.
GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY = KEY_J -- The key to surrender.
GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY_NAME = "J" -- The string for the key that appears in the HUD.

GlorifiedHandcuffs.Config.NIGHTSTICK_STUN_TIME = 5 -- How many seconds should the Nightstick freeze a player for?
GlorifiedHandcuffs.Config.NIGHTSTICK_STUN_PUSH_DISTANCE = 100 -- How far should the Nightstick push a stunned player?

GlorifiedHandcuffs.Config.PLAYERMODEL_WHITELIST = { -- Which player models cannot be handcuffed?
    ["example_model_here.mdl"] = true
}
GlorifiedHandcuffs.Config.TEAM_WHITELIST = { -- Which teams cannot be handcuffed?
    [TEAM_CITIZEN] = false,
}

GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST = false -- Is the below blacklist a whitelist?
GlorifiedHandcuffs.Config.WEAPON_BLACKLIST = { -- Which weapons will not appear in the confiscate menu.
    ["keys"] = true,
    ["arrest_stick"] = true,
    ["door_ram"] = true,
    ["lockpick"] = true,
    ["med_kit"] = true,
    ["pocket"] = true,
    ["stunstick"] = true,
    ["unarrest_stick"] = true,
    ["weaponchecker"] = true,
    ["weapon_keypadchecker"] = true,
    ["weapon_bugbait"] = true,
    ["weapon_fists"] = true,
    ["gmod_camera"] = true,
    ["manhack_welder"] = true,
    ["weapon_medkit"] = true,
    ["gmod_tool"] = true,
    ["weapon_physgun"] = true,
    ["weapon_physcannon"] = true,
    ["glorifiedhandcuffs_restrained"] = true,
    ["glorifiedhandcuffs_handcuffs"] = true,
    ["glorifiedhandcuffs_nightstick"] = true,
    ["glorifiedbanking_card"] = true,
}
GlorifiedHandcuffs.Config.LEGAL_WEAPONS = { -- Weapons that are legal with a gun license.
    ["weapon_glock2"] = true,
    ["weapon_fiveseven2"] = true,
}