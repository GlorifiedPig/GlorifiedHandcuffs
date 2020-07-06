
local surrenderKey = GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY
hook.Add( "PlayerButtonDown", "GlorifiedHandcuffs.Keybinds.PlayerButtonDown", function( ply, button )
    if button == surrenderKey then
        GlorifiedHandcuffs.TogglePlayerSurrendering( ply )
    end
end )