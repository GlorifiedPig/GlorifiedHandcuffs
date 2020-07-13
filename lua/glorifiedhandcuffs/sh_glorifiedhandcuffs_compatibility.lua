
GlorifiedHandcuffs.HookRunName = "DarkRPFinishedLoading" -- Which hook should we start loading GlorifiedHandcuffs files in?
GlorifiedHandcuffs.ClearHandcuffVarsHooks = {
    "PlayerSpawn",
    "PlayerDeath",
    "playerArrested",
    "playerUnArrested"
}

function GlorifiedHandcuffs.IsPlayerPolice( ply )
    if not ply or isnumber( ply ) or not ply:IsValid() or not ply:IsPlayer() then return false end
    return ply:isCP()
end

function GlorifiedHandcuffs.FormatMoney( money )
    return DarkRP.formatMoney( money )
end

function GlorifiedHandcuffs.GetMoney( ply )
    if not ply or not ply:IsValid() or not ply:IsPlayer() then return false end
    return ply:getDarkRPVar( "money" )
end

function GlorifiedHandcuffs.CanPlayerAfford( ply, money )
    if not ply or not ply:IsValid() or not ply:IsPlayer() then return false end
    return ply:canAfford( money )
end

function GlorifiedHandcuffs.AddPlayerMoney( ply, money )
    if not ply or not ply:IsValid() or not ply:IsPlayer() then return false end
    return ply:addMoney( money )
end

function GlorifiedHandcuffs.IsPlayerArrested( ply )
    if not ply or not ply:IsValid() or not ply:IsPlayer() then return false end
    return ply:isArrested()
end

function GlorifiedHandcuffs.HasGunLicense( ply )
    if not ply or not ply:IsValid() or not ply:IsPlayer() then return false end
    return ply:getDarkRPVar( "HasGunlicense" )
end

if SERVER then
    function GlorifiedHandcuffs.ArrestPlayer( ply, time, arrester )
        GlorifiedHandcuffs.ResetAllHandcuffVars( ply )
        ply:arrest( time, arrester )
    end

    function GlorifiedHandcuffs.UnArrestPlayer( ply )
        if not ply or not ply:IsValid() or not ply:IsPlayer() then return false end
        GlorifiedHandcuffs.ResetAllHandcuffVars( ply )
        ply:unArrest()
    end

    function GlorifiedHandcuffs.Notify( ply, msgType, time, message )
        DarkRP.notify( ply, msgType, time, message )
    end
else
    function GlorifiedHandcuffs.Notify( msgType, time, message )
        notification.AddLegacy( message, msgType, time )
    end
end