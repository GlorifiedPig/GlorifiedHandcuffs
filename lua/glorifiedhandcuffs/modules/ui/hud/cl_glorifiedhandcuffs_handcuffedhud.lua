
local ply

local ghi18n = GlorifiedHandcuffs.i18n

local themeData = GlorifiedHandcuffs.Themes.GetCurrent().Data

local cuffedMaterial = themeData.Materials.cuffs
local cuffedMaterialBlindfolded = themeData.Materials.cuffs_blindfolded

local breakFreeProgress = 0

local function percentageColor( percentage )
    local red = 255
    local green = 255
    if percentage >= 0 and percentage <= 0.5 then
      green = 510 * percentage
    elseif percentage > 0.5 and percentage <= 1 then
      red = -510 * percentage + 510
    elseif percentage > 1 then
        green = 255
        red = 0
    end
    return Color( red, green, 0 )
end

local hitToFreeLocalization = ghi18n.GetPhrase( "hitToFree" )
local cuffedLocalization = ghi18n.GetPhrase( "cuffed" )
local blindfoldedLocalization = ghi18n.GetPhrase( "blindfolded" )
local gaggedLocalization = ghi18n.GetPhrase( "gagged" )

local hitToFreeText = string.Split( hitToFreeLocalization, "%s" )
surface.SetFont( "GlorifiedHandcuffs.HUD.BreakFree" )
local spamFontW = surface.GetTextSize( hitToFreeText[1] )
local keyFontW = surface.GetTextSize( GlorifiedHandcuffs.Config.BREAK_FREE_KEY_NAME )
local hitToFreeFontW = surface.GetTextSize( hitToFreeLocalization )
local handcuffedFontW = surface.GetTextSize( cuffedLocalization )
local blindfoldedFontW = surface.GetTextSize( blindfoldedLocalization )
local gaggedFontW = surface.GetTextSize( gaggedLocalization )
local scrW = ScrW()
local scrH = ScrH()
local colorBlack = Color( 0, 0, 0 )
local playerBlindfolded

hook.Add( "HUDPaint", "GlorifiedLeveling.HUD.Handcuffed", function()
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( LocalPlayer() ) then return end
    if not ply then ply = LocalPlayer() end
    playerBlindfolded = GlorifiedHandcuffs.IsPlayerBlindfolded( LocalPlayer() )
    if playerBlindfolded then
        draw.RoundedBox( 0, 0, 0, scrW, scrH, colorBlack )
    end

    surface.SetMaterial( playerBlindfolded and cuffedMaterialBlindfolded or cuffedMaterial )
    surface.SetDrawColor( 255, 255, 255 )
    surface.DrawTexturedRect( scrW / 2 - 48, 5, 96, 96 )

    surface.SetFont( "GlorifiedHandcuffs.HUD.Handcuffed" )
    draw.RoundedBox( 5, scrW / 2 - ( handcuffedFontW + 15 ) / 2, 106, handcuffedFontW + 15, 30, themeData.Colors.hudCuffedBackgroundColor )
    draw.SimpleText( cuffedLocalization, "GlorifiedHandcuffs.HUD.Handcuffed", scrW / 2, 121, themeData.Colors.hudCuffedBackgroundTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

    local extraHeight = 0

    if playerBlindfolded then
        draw.RoundedBox( 5, scrW / 2 - ( blindfoldedFontW + 15 ) / 2, 141, blindfoldedFontW + 15, 30, themeData.Colors.hudCuffedBackgroundColor )
        draw.SimpleText( blindfoldedLocalization, "GlorifiedHandcuffs.HUD.Handcuffed", scrW / 2, 156, themeData.Colors.hudCuffedBackgroundTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        extraHeight = extraHeight + 35
    end

    if GlorifiedHandcuffs.IsPlayerGagged( LocalPlayer() ) then
        draw.RoundedBox( 5, scrW / 2 - ( gaggedFontW + 15 ) / 2, 141 + extraHeight, gaggedFontW + 15, 30, themeData.Colors.hudCuffedBackgroundColor )
        draw.SimpleText( gaggedLocalization, "GlorifiedHandcuffs.HUD.Handcuffed", scrW / 2, 156 + extraHeight, themeData.Colors.hudCuffedBackgroundTextColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        extraHeight = extraHeight + 35
    end

    if not GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED then return end

    draw.RoundedBox( 5, scrW / 2 - ( hitToFreeFontW + 15 ) / 2, 141 + extraHeight, hitToFreeFontW + 15, 35, themeData.Colors.hudBreakFreeBackgroundColor )
    draw.SimpleText( hitToFreeText[1], "GlorifiedHandcuffs.HUD.BreakFree", scrW / 2 - ( hitToFreeFontW + 15 ) / 2 + 15, 158 + extraHeight, themeData.Colors.hudBreakFreeBackgroundTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.RoundedBox( 6, scrW / 2 - ( hitToFreeFontW + 15 ) / 2 + 10 + spamFontW, 147 + extraHeight, 20, 22, themeData.Colors.hudBreakFreeKeypressBackgroundColor )
    draw.SimpleText( GlorifiedHandcuffs.Config.BREAK_FREE_KEY_NAME, "GlorifiedHandcuffs.HUD.BreakFree", scrW / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW, 158 + extraHeight, themeData.Colors.hudBreakFreeKeypressTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    draw.SimpleText( hitToFreeText[2], "GlorifiedHandcuffs.HUD.BreakFree", scrW / 2 - ( hitToFreeFontW + 15 ) / 2 + 15 + spamFontW + keyFontW, 158 + extraHeight, themeData.Colors.hudBreakFreeBackgroundTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

    local breakFreePercent = ( GlorifiedHandcuffs.BreakFreeTotal / GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL )
    breakFreeProgress = Lerp( FrameTime() * 12, breakFreeProgress, breakFreePercent * 300 )
    draw.RoundedBox( 7, scrW / 2 - 300 / 2, 181 + extraHeight, 300, 15, themeData.Colors.hudBreakFreeBackgroundColor )
    render.SetScissorRect( scrW / 2 - 300 / 2, 0, scrW / 2 - 300 / 2 + breakFreeProgress, scrH, true )
    draw.RoundedBox( 7, scrW / 2 - 300 / 2, 181 + extraHeight, 300, 15, percentageColor( breakFreeProgress / 300 ) )
    render.SetScissorRect( 0, 0, scrW, scrH, false )
end )