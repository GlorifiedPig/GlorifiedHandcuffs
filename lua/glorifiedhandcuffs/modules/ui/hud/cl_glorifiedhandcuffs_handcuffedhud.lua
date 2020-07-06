
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
    elseif percentage > 1 then
        green = 255
        red = 0
    end
    return Color( red, green, 0 )
end

local hitToFreeLocalization = ghi18n.GetPhrase( "hitToFree" )
local cuffedLocalization = ghi18n.GetPhrase( "cuffed" )

local hitToFreeText = string.Split( hitToFreeLocalization, "%s" )
surface.SetFont( "GlorifiedHandcuffs.HUD.BreakFree" )
local spamFontW = surface.GetTextSize( hitToFreeText[1] )
local keyFontW = surface.GetTextSize( GlorifiedHandcuffs.Config.BREAK_FREE_KEY_NAME )
local hitToFreeFontW = surface.GetTextSize( hitToFreeLocalization )
local handcuffedFontW = surface.GetTextSize( cuffedLocalization )

hook.Add( "HUDPaint", "GlorifiedLeveling.HUD.Handcuffed", function()
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( LocalPlayer() ) then return end
    if not ply then ply = LocalPlayer() end
    surface.SetMaterial( cuffedMaterial )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( ScrW() / 2 - 48, 5, 96, 96 )

    surface.SetFont( "GlorifiedHandcuffs.HUD.Handcuffed" )
    draw.RoundedBox( 5, ScrW() / 2 - ( handcuffedFontW + 15 ) / 2, 106, handcuffedFontW + 15, 30, themeData.Colors.hudCuffedBackgroundColor )
    draw.SimpleText( cuffedLocalization, "GlorifiedHandcuffs.HUD.Handcuffed", ScrW() / 2, 121, themeData.Colors.hudCuffedBackgroundTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    if not GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED then return end

    draw.RoundedBox( 5, ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2, 141, hitToFreeFontW + 15, 35, themeData.Colors.hudBreakFreeBackgroundColor )
    draw.SimpleText( hitToFreeText[1], "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15, 158, themeData.Colors.hudBreakFreeBackgroundTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.RoundedBox( 6, ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 10 + spamFontW, 147, 20, 22, themeData.Colors.hudBreakFreeKeypressBackgroundColor )
    draw.SimpleText( GlorifiedHandcuffs.Config.BREAK_FREE_KEY_NAME, "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW, 158, themeData.Colors.hudBreakFreeKeypressTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.SimpleText( hitToFreeText[2], "GlorifiedHandcuffs.HUD.BreakFree", ScrW() / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW + keyFontW, 158, themeData.Colors.hudBreakFreeBackgroundTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    local breakFreePercent = ( GlorifiedHandcuffs.BreakFreeTotal / GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL )
    breakFreeProgress = Lerp( FrameTime() * 12, breakFreeProgress, breakFreePercent * 300 )
    draw.RoundedBox( 7, ScrW() / 2 - 300 / 2, 181, 300, 15, themeData.Colors.hudBreakFreeBackgroundColor )
    render.SetScissorRect( ScrW() / 2 - 300 / 2, 0, ScrW() / 2 - 300 / 2 + breakFreeProgress, ScrH(), true )
    draw.RoundedBox( 7, ScrW() / 2 - 300 / 2, 181, 300, 15, percentageColor( breakFreeProgress / 300 ) )
    render.SetScissorRect( 0, 0, ScrW(), ScrH(), false )
end )