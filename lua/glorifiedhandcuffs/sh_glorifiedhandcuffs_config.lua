
GlorifiedHandcuffs.Config.PLAYER_ISPOLICE_CUSTOMFUNC = function( ply )
    if not ply or isnumber( ply ) or not ply:IsValid() or not ply:IsPlayer() then return false end
    return ply:isCP()
end

GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED = true
GlorifiedHandcuffs.Config.BREAK_FREE_MIN_TIME = 0.04
GlorifiedHandcuffs.Config.BREAK_FREE_EXPIRY_TIME = 0.11
GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL = 25
GlorifiedHandcuffs.Config.BREAK_FREE_WANTED = true
GlorifiedHandcuffs.Config.BREAK_FREE_SOUND_ON_FAILURE = true
GlorifiedHandcuffs.Config.BREAK_FREE_SOUND_ON_FAILURE_PATH = "physics/metal/metal_box_impact_hard2.wav"

GlorifiedHandcuffs.Config.HANDCUFF_DISTANCE = 125
GlorifiedHandcuffs.Config.TIME_TO_CUFF = 1 -- How many seconds must the player remain within distance to handcuff?

GlorifiedHandcuffs.Config.BAIL_AMOUNT = 2500

GlorifiedHandcuffs.Config.CAN_NORMAL_PLAYER_HANDCUFF_WITHOUT_SURRENDER = true -- Can a normal player handcuff without the person being handcuffed surrendering?

GlorifiedHandcuffs.Config.BREAK_FREE_KEY = KEY_E
GlorifiedHandcuffs.Config.BREAK_FREE_KEY_NAME = "E"
GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY = KEY_J
GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY_NAME = "J"