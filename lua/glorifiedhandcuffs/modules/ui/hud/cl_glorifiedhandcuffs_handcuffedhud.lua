
local ply

local ghi18n = GlorifiedHandcuffs.i18n

local themeData = GlorifiedHandcuffs.Themes.GetCurrent().Data

local cuffedMaterial = themeData.Materials.cuffs

local breakFreeProgress = 0

local function percentageColor( percentage )
    local red = 255
    local green = 255
    if percentage >= 0 && percentage <= 0.5 then
      green = 510 * percentage
    elseif percentage > 0.5 && percentage <= 1 then
      red = -510 * percentage + 510
    end
    return Color( red, green, 0 )
end

hook.Add( "HUDPaint", "GlorifiedLeveling.HandcuffedHUD.Handcuffed", function()
    -- debug break free thing
    breakFreeProgress = math.Approach( breakFreeProgress, 250, 0.2 )
    if breakFreeProgress >= 250 then breakFreeProgress = 0 end
    -- end

    if not ply then ply = LocalPlayer() end
    surface.SetMaterial( cuffedMaterial )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() / 2 - 48, 5, 96, 96 )

    surface.SetFont( "GlorifiedHandcuffs.HUD.Handcuffed" )
    local handcuffedFontW = surface.GetTextSize( ghi18n.GetPhrase( "cuffed" ) )
    draw.RoundedBox( 5, ScrW() / 2 - ( handcuffedFontW + 15 ) / 2, 5 + 96 + 5, handcuffedFontW + 15, 30, Color( 210, 80, 80 ) )
    draw.SimpleText( ghi18n.GetPhrase( "cuffed" ), "GlorifiedHandcuffs.HUD.Handcuffed", ScrW() / 2, 5 + 96 + 5 + 15, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    local hitToFreeText = string.Split( ghi18n.GetPhrase( "hitToFree" ), "%s" )
    surface.SetFont( "GlorifiedHandcuffs.HUD.BreakFree" )
    local spamFontW = surface.GetTextSize( hitToFreeText[1] )
    local keyFontW = surface.GetTextSize( "E" )
    local hitToFreeFontW = surface.GetTextSize( ghi18n.GetPhrase( "hitToFree" ) )
    draw.RoundedBox( 5, ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2, 5 + 96 + 5 + 30 + 5, hitToFreeFontW + 15, 35, Color( 31, 31, 31, 230 ) )
    draw.SimpleText( hitToFreeText[1], "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15, 5 + 96 + 5 + 15 + 32 + 5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.RoundedBox( 6, ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 10 + spamFontW, 5 + 96 + 5 + 33 + 5 + 3, 20, 22, Color( 102, 176, 64 ) )
    draw.SimpleText( "E", "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW, 5 + 96 + 5 + 15 + 32 + 5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.SimpleText( hitToFreeText[2], "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW + keyFontW, 5 + 96 + 5 + 15 + 32 + 5, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    draw.RoundedBox( 7, ScrW() / 2 - 250 / 2, 5 + 96 + 5 + 30 + 5 + 35 + 5, 250, 15, Color( 31, 31, 31, 230 ) )
    draw.RoundedBox( 7, ScrW() / 2 - 250 / 2, 5 + 96 + 5 + 30 + 5 + 35 + 5, breakFreeProgress, 15, percentageColor( breakFreeProgress / 250 ) )
end )