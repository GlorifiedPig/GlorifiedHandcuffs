
local PANEL = {}

function PANEL:AddPlayer( ply )
    self.Player = ply

    self.Avatar = vgui.Create( "GlorifiedHandcuffs.CircleAvatar", self )

    local function drawPlayerInfo( playerno, x, containerh, align )
        local centerh = containerh / 2
        local spacing = containerh * 0.12

        draw.SimpleText( self.Player:Name(), "GlorifiedHandcuffs.BailMenu.PlayerInfo", x, centerh - spacing, self.Theme.Data.Colors.bailMenuPlayerNameTextColor, align, TEXT_ALIGN_CENTER )
        draw.SimpleText( self.Player:SteamID(), "GlorifiedHandcuffs.BailMenu.PlayerInfo", x, centerh + spacing, self.Theme.Data.Colors.bailMenuPlayerSteamIDCol, align, TEXT_ALIGN_CENTER )
    end

    function self:Paint( w, h )
        draw.RoundedBox( h * 0.1, 0, 0, w, h, self.Theme.Data.Colors.bailMenuPlayerBackgroundColor )
        drawPlayerInfo( 1, h * 0.95, h, TEXT_ALIGN_LEFT )
    end

    self.BailButton = vgui.Create( "DButton", self )
    self.BailButton:SetTextColor( self.Theme.Data.Colors.bailMenuBailButtonTextColor )
    self.BailButton:SetFont( "GlorifiedHandcuffs.BailMenu.BailPlayer" )
    self.BailButton:SetText( GlorifiedHandcuffs.i18n.GetPhrase( "bailPlayer" ) )
    self.BailButton:Dock( RIGHT )
    self.BailButton.DoClick = function()
        if GlorifiedHandcuffs.CanPlayerAfford( LocalPlayer(), GlorifiedHandcuffs.Config.BAIL_AMOUNT ) then
            net.Start( "GlorifiedHandcuffs.Bail.RequestBailout" )
            net.WriteEntity( self.Player )
            net.SendToServer()
            GlorifiedHandcuffs.UI.CloseBailMenu()
        end
    end
end

function PANEL:PerformLayout( w, h )
    local avatarsize = h * 0.65

    self.Avatar:SetSize( avatarsize, avatarsize )
    self.Avatar:SetMaskSize( avatarsize * 0.5 )
    self.Avatar:SetPos( h * 0.2, h * 0.18 )
    self.Avatar:SetSteamID( self.Player:SteamID64(), avatarsize )

    local canAffordBail = GlorifiedHandcuffs.CanPlayerAfford( LocalPlayer(), GlorifiedHandcuffs.Config.BAIL_AMOUNT )
    local bailButtonColor = canAffordBail and self.Theme.Data.Colors.bailMenuBailButtonColorCanAfford or self.Theme.Data.Colors.bailMenuBailButtonColorCantAfford
    local bailButtonColorLerped = bailButtonColor

    self.BailButton:SetSize( w * 0.3, h )
    self.BailButton.Paint = function( bailButton, bailButtonW, bailButtonH )
        if not bailButton:IsHovered() then
            bailButtonColor = canAffordBail and self.Theme.Data.Colors.bailMenuBailButtonColorCanAfford or self.Theme.Data.Colors.bailMenuBailButtonColorCantAfford
        else
            bailButtonColor = canAffordBail and self.Theme.Data.Colors.bailMenuBailButtonColorCanAffordHover or self.Theme.Data.Colors.bailMenuBailButtonColorCantAffordHover
        end
        bailButtonColorLerped = GlorifiedHandcuffs.UI.LerpColor( FrameTime() * 4, bailButtonColorLerped, bailButtonColor )

        local displaySizeW = bailButtonW * 0.7
        local displaySizeH = bailButtonH * 0.55
        draw.RoundedBox( 4, bailButtonW / 2 - displaySizeW / 2, bailButtonH / 2 - displaySizeH / 2, displaySizeW, displaySizeH, bailButtonColorLerped )
    end
    self.BailButton.OnCursorEntered = function()
        self.BailButton:SetText( GlorifiedHandcuffs.FormatMoney( GlorifiedHandcuffs.Config.BAIL_AMOUNT ) )
    end
    self.BailButton.OnCursorExited = function()
        self.BailButton:SetText( GlorifiedHandcuffs.i18n.GetPhrase( "bailPlayer" ) )
    end
end

vgui.Register( "GlorifiedHandcuffs.BailMenu.ArrestedPlayer", PANEL, "Panel" )