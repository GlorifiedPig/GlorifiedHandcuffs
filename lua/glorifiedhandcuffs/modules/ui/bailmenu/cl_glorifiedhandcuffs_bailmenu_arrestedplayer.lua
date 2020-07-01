
local PANEL = {}

function PANEL:AddPlayer( ply )
    self.Player = ply

    self.Avatar = vgui.Create( "GlorifiedHandcuffs.CircleAvatar", self )

    local function drawPlayerInfo( playerno, x, containerh, align )
        local centerh = containerh / 2
        local spacing = containerh * 0.13

        draw.SimpleText( self.Player:Name(), "GlorifiedHandcuffs.BailMenu.PlayerInfo", x, centerh - spacing, self.Theme.Data.Colors.playerNameTextCol, align, TEXT_ALIGN_CENTER )
        draw.SimpleText( self.Player:SteamID(), "GlorifiedHandcuffs.BailMenu.PlayerInfo", x, centerh + spacing, self.Theme.Data.Colors.playerSteamIDCol, align, TEXT_ALIGN_CENTER )
    end

    function self:Paint( w, h )
        draw.RoundedBox( h * 0.1, 0, 0, w, h, self.Theme.Data.Colors.playerBackgroundCol )
        drawPlayerInfo( 1, h * 0.93, h, TEXT_ALIGN_LEFT )
    end
end

function PANEL:PerformLayout( w, h )
    local avatarsize = h * 0.65

    self.Avatar:SetSize( avatarsize, avatarsize )
    self.Avatar:SetMaskSize( avatarsize * 0.5 )
    self.Avatar:SetPos( h * 0.2, h * 0.18 )
    self.Avatar:SetSteamID( self.Player:SteamID64(), avatarsize )
end

vgui.Register( "GlorifiedHandcuffs.BailMenu.ArrestedPlayer", PANEL, "Panel" )