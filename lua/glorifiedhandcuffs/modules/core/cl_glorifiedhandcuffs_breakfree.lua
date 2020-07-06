
local timeSinceLastKeyPress = 0
GlorifiedHandcuffs.BreakFreeTotal = 0

hook.Add( "PlayerButtonDown", "GlorifiedHandcuffs.BreakFree.PlayerButtonDown", function( ply, key )
    if GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED and GlorifiedHandcuffs.IsPlayerHandcuffed( LocalPlayer() ) and key == GlorifiedHandcuffs.Config.BREAK_FREE_KEY and SysTime() >= timeSinceLastKeyPress + GlorifiedHandcuffs.Config.BREAK_FREE_MIN_TIME then
        timeSinceLastKeyPress = SysTime()
        keyPressedRecently = true
        GlorifiedHandcuffs.BreakFreeTotal = GlorifiedHandcuffs.BreakFreeTotal + 1
        if GlorifiedHandcuffs.BreakFreeTotal >= GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL then
            net.Start( "GlorifiedHandcuffs.BreakFree.AttemptSuccess" )
            net.SendToServer()
            GlorifiedHandcuffs.BreakFreeTotal = 0
            return
        end

        if timer.Exists( "GlorifiedHandcuffs.BreakFreeTimer" ) then
            timer.Start( "GlorifiedHandcuffs.BreakFreeTimer" )
        else
            net.Start( "GlorifiedHandcuffs.BreakFree.AttemptStarted" )
            net.SendToServer()
            timer.Create( "GlorifiedHandcuffs.BreakFreeTimer", GlorifiedHandcuffs.Config.BREAK_FREE_EXPIRY_TIME, 1, function()
                net.Start( "GlorifiedHandcuffs.BreakFree.AttemptFailed" )
                net.SendToServer()
                GlorifiedHandcuffs.BreakFreeTotal = 0
            end )
        end
    end
end )