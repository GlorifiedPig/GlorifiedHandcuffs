
GlorifiedHandcuffs.HookRunName = "DarkRPFinishedLoading" -- Which hook should we start loading GlorifiedHandcuffs files in?

if SERVER then
    function GlorifiedHandcuffs.Notify( ply, msgType, time, message )
        DarkRP.notify( ply, msgType, time, message )
    end
else
    function GlorifiedHandcuffs.Notify( msgType, time, message )
        notification.AddLegacy( message, msgType, time )
    end
end