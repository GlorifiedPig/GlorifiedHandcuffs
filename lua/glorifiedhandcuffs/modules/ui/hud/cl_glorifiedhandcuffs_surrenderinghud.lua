
local ply
local ghi18n = GlorifiedHandcuffs.i18n
local themeData = GlorifiedHandcuffs.Themes.GetCurrent().Data
local surrenderMaterial = themeData.Materials.surrender

hook.Add( "HUDPaint", "GlorifiedLeveling.HandcuffedHUD.Surrendering", function()
    if not GlorifiedHandcuffs.IsPlayerSurrendering( LocalPlayer() ) then return end
    if not ply then ply = LocalPlayer() end
    surface.SetMaterial( surrenderMaterial )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() / 2 - 48, 5, 96, 96 )

    surface.SetFont( "GlorifiedHandcuffs.HUD.Handcuffed" )
    local surrenderingFontW = surface.GetTextSize( ghi18n.GetPhrase( "surrendering" ) )
    draw.RoundedBox( 5, ScrW() / 2 - ( surrenderingFontW + 15 ) / 2, 5 + 96 + 5, surrenderingFontW + 15, 30, Color( 210, 80, 80 ) )
    draw.SimpleText( ghi18n.GetPhrase( "surrendering" ), "GlorifiedHandcuffs.HUD.Handcuffed", ScrW() / 2, 5 + 96 + 5 + 15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    local hitToFreeText = string.Split( ghi18n.GetPhrase( "putHandsDown" ), "%s" )
    surface.SetFont( "GlorifiedHandcuffs.HUD.BreakFree" )
    local spamFontW = surface.GetTextSize( hitToFreeText[1] )
    local keyFontW = surface.GetTextSize( GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY_NAME )
    local hitToFreeFontW = surface.GetTextSize( ghi18n.GetPhrase( "putHandsDown" ) )
    draw.RoundedBox( 5, ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2, 5 + 96 + 5 + 30 + 5, hitToFreeFontW + 15, 35, Color( 31, 31, 31, 230 ) )
    draw.SimpleText( hitToFreeText[1], "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15, 5 + 96 + 5 + 15 + 32 + 5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.RoundedBox( 6, ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 10 + spamFontW, 5 + 96 + 5 + 33 + 5 + 3, 20, 22, Color( 102, 176, 64 ) )
    draw.SimpleText( GlorifiedHandcuffs.Config.TOGGLE_SURRENDER_KEY_NAME, "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW, 5 + 96 + 5 + 15 + 32 + 5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    draw.SimpleText( hitToFreeText[2], "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW + keyFontW, 5 + 96 + 5 + 15 + 32 + 5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
end )