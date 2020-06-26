
GlorifiedHandcuffs.Config.PLAYER_ISPOLICE_CUSTOMFUNC = function( ply )
    if not ply or not ply:IsPlayer() then return end
    return ply:isCP()
end

GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED = true
GlorifiedHandcuffs.Config.BREAK_FREE_MIN_TIME = 0.04
GlorifiedHandcuffs.Config.BREAK_FREE_EXPIRY_TIME = 0.11
GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL = 25
GlorifiedHandcuffs.Config.BREAK_FREE_WANTED = true
GlorifiedHandcuffs.Config.BREAK_FREE_SOUND_ON_FAILURE = true
GlorifiedHandcuffs.Config.BREAK_FREE_SOUND_ON_FAILURE_PATH = "physics/metal/metal_box_impact_hard2.wav"