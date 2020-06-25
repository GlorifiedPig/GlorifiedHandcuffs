
local keyPressTotal = 0
local timeSinceLastKeyPress = 0
GlorifiedHandcuffs.BreakFreeTotal = 0

-- 80 key presses to pass

hook.Add( "PlayerButtonDown", "GlorifiedHandcuffs.BreakFree.PlayerButtonDown", function( ply, key )
    -- if ply is handcuffed, dont forget to set nw2 vars!
    if key == KEY_E and SysTime() >= timeSinceLastKeyPress + GlorifiedHandcuffs.Config.BREAK_FREE_MIN_TIME then
        timeSinceLastKeyPress = SysTime()
        keyPressedRecently = true
        keyPressTotal = keyPressTotal + 1
        GlorifiedHandcuffs.BreakFreeTotal = keyPressTotal
        if timer.Exists( "GlorifiedHandcuffs.BreakFreeTimer" ) then
            timer.Start( "GlorifiedHandcuffs.BreakFreeTimer" )
        else
            timer.Create( "GlorifiedHandcuffs.BreakFreeTimer", GlorifiedHandcuffs.Config.BREAK_FREE_EXPIRY_TIME, 1, function()
                keyPressTotal = 0
                GlorifiedHandcuffs.BreakFreeTotal = keyPressTotal
            end )
        end
    end
end )