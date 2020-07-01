
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.TopBar = vgui.Create( "Panel", self )
    self.TopBar.Theme = self:GetParent().Theme
    self.TopBar.Paint = function( s, w, h )
        draw.SimpleText( GlorifiedHandcuffs.i18n.GetPhrase( "arrestedPlayers", #self.Players ), "GlorifiedHandcuffs.BailMenu.ArrestedPlayers", w * 0.024, h * 0.46, self.Theme.Data.Colors.arrestedPlayersTextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end

    self.ScrollPanel = vgui.Create( "GlorifiedHandcuffs.ScrollPanel", self )

    self.Players = {}
end

function PANEL:AddPlayer( ply )
    local playerid = #self.Players + 1

    self.Players[playerid] = vgui.Create( "GlorifiedHandcuffs.BailMenu.ArrestedPlayer", self.ScrollPanel )
    self.Players[playerid].Theme = self.Theme
    self.Players[playerid]:AddPlayer( ply )
end

function PANEL:ResetPlayers()
    self.ScrollPanel:Clear()
    table.Empty( self.Players )
end

function PANEL:PerformLayout( w, h )
    self.TopBar:SetSize( w, h * 0.05 )
    self.TopBar:DockMargin( 0, 5, 0, 0 )
    self.TopBar:Dock( TOP )

    self.ScrollPanel:Dock( FILL )
    self.ScrollPanel:DockMargin( 0, 0, 0, h * 0.02 )
    self.ScrollPanel:DockPadding( 0, 0, w * 0.013, 0 )

    local plyh = h * 0.12
    local plymarginx, plymarginy = w * 0.026, h * 0.008
    for k,v in ipairs( self.Players ) do
        v:SetHeight( plyh )
        v:Dock( TOP )
        v:DockMargin( plymarginx, plymarginy, plymarginx, plymarginy )
    end
end

vgui.Register( "GlorifiedHandcuffs.BailMenu.ArrestedPlayers", PANEL, "Panel" )