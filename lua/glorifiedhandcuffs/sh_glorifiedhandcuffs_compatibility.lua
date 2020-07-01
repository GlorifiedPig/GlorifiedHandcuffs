
GlorifiedHandcuffs.HookRunName = "DarkRPFinishedLoading" -- Which hook should we start loading GlorifiedHandcuffs files in?

function GlorifiedHandcuffs.FormatMoney( money )
    return DarkRP.formatMoney( money )
end

function GlorifiedHandcuffs.CanPlayerAfford( ply, money )
    return ply:canAfford( money )
end

function GlorifiedHandcuffs.IsPlayerArrested( ply )
    return ply:isArrested()
end

if SERVER then
    function GlorifiedHandcuffs.Notify( ply, msgType, time, message )
        DarkRP.notify( ply, msgType, time, message )
    end
else
    function GlorifiedHandcuffs.Notify( msgType, time, message )
        notification.AddLegacy( message, msgType, time )
    end
end