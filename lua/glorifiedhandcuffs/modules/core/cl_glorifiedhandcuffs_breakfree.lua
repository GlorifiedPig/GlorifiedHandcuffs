
local timeSinceLastKeyPress = 0
GlorifiedHandcuffs.BreakFreeTotal = 0

hook.Add( "PlayerButtonDown", "GlorifiedHandcuffs.BreakFree.PlayerButtonDown", function( ply, key )
    if GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED and GlorifiedHandcuffs.IsPlayerHandcuffed( LocalPlayer() ) and key == GlorifiedHandcuffs.Config.BREAK_FREE_KEY and CurTime() >= timeSinceLastKeyPress + GlorifiedHandcuffs.Config.BREAK_FREE_MIN_TIME then
        timeSinceLastKeyPress = CurTime()
        GlorifiedHandcuffs.BreakFreeTotal = GlorifiedHandcuffs.BreakFreeTotal + 1
        if GlorifiedHandcuffs.BreakFreeTotal >= GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL then
            net.Start( "GlorifiedHandcuffs.BreakFree.AttemptSuccess" )
            net.SendToServer()
            timer.Simple( LocalPlayer():Ping() / 1000, function()
                GlorifiedHandcuffs.BreakFreeTotal = 0 -- We need to do this synced with the player's ping, otherwise the lagg will make it difficult to suceed.
            end )
            return
        end

        if timer.Exists( "GlorifiedHandcuffs.BreakFreeTimer" ) then
            timer.Start( "GlorifiedHandcuffs.BreakFreeTimer" )
        else
            net.Start( "GlorifiedHandcuffs.BreakFree.AttemptStarted" )
            net.SendToServer()
            timer.Create( "GlorifiedHandcuffs.BreakFreeTimer", GlorifiedHandcuffs.Config.BREAK_FREE_EXPIRY_TIME - ( LocalPlayer():Ping() / 1000 ), 1, function()
                if GlorifiedHandcuffs.BreakFreeTotal >= GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL then return end
                net.Start( "GlorifiedHandcuffs.BreakFree.AttemptFailed" )
                net.SendToServer()
                GlorifiedHandcuffs.BreakFreeTotal = 0
            end )
        end
    end
end )