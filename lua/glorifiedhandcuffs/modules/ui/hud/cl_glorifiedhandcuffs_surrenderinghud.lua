
local ply
local ghi18n = GlorifiedHandcuffs.i18n
local themeData = GlorifiedHandcuffs.Themes.GetCurrent().Data
local surrenderMaterial = themeData.Materials.surrender

local surrenderingFontW = surface.GetTextSize( ghi18n.GetPhrase( "surrendering" ) )
local hitToFreeText = string.Split( ghi18n.GetPhrase( "putHandsDown" ), "%s" )
surface.SetFont( "GlorifiedHandcuffs.HUD.StopSurrendering" )
local spamFontW = surface.GetTextSize( hitToFreeText[1] )
local keyFontW = surface.GetTextSize( GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY_NAME )
local hitToFreeFontW = surface.GetTextSize( ghi18n.GetPhrase( "putHandsDown" ) )
local scrW = ScrW()

hook.Add( "HUDPaint", "GlorifiedLeveling.HUD.Surrendering", function()
    if not GlorifiedHandcuffs.IsPlayerSurrendering( LocalPlayer() ) then return end
    if not ply then ply = LocalPlayer() end
    surface.SetMaterial( surrenderMaterial )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( scrW / 2 - 48, 5, 96, 96 )

    surface.SetFont( "GlorifiedHandcuffs.HUD.Surrendering" )
    draw.RoundedBox( 5, scrW / 2 - ( surrenderingFontW + 15 ) / 2, 106, surrenderingFontW + 15, 30, themeData.Colors.hudSurrenderingBackgroundColor )
    draw.SimpleText( ghi18n.GetPhrase( "surrendering" ), "GlorifiedHandcuffs.HUD.Surrendering", scrW / 2, 121, themeData.Colors.hudSurrenderingBackgroundTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    draw.RoundedBox( 5, scrW / 2 - ( hitToFreeFontW + 15 ) / 2, 5 + 96 + 5 + 30 + 5, hitToFreeFontW + 15, 35, themeData.Colors.hudStopSurrenderingBackgroundColor )
    draw.SimpleText( hitToFreeText[1], "GlorifiedHandcuffs.HUD.StopSurrendering", scrW / 2 - ( hitToFreeFontW + 15 ) / 2 + 15, 158, themeData.Colors.hudStopSurrenderingBackgroundTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.RoundedBox( 6, scrW / 2 - ( hitToFreeFontW + 15 ) / 2 + 10 + spamFontW, 5 + 96 + 5 + 33 + 5 + 3, 20, 22, themeData.Colors.hudStopSurrenderingKeypressBackgroundColor )
    draw.SimpleText( GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY_NAME, "GlorifiedHandcuffs.HUD.StopSurrendering", scrW / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW, 158, themeData.Colors.hudStopSurrenderingKeypressTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    draw.SimpleText( hitToFreeText[2], "GlorifiedHandcuffs.HUD.StopSurrendering", scrW / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW + keyFontW, 158, themeData.Colors.hudStopSurrenderingBackgroundTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
end )