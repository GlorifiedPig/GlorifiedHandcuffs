
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

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
    self.ScrollPanel:Dock( FILL )
    self.ScrollPanel:DockMargin( 0, h * 0.02, 0, 0 )
    self.ScrollPanel:DockPadding( 0, 0, w * 0.013, 0 )

    local plyh = h * 0.14
    local plymarginx, plymarginy = w * 0.026, h * 0.008
    for k,v in ipairs( self.Players ) do
        v:SetHeight( plyh )
        v:Dock( TOP )
        v:DockMargin( plymarginx, plymarginy, plymarginx, plymarginy )
    end
end

vgui.Register( "GlorifiedHandcuffs.BailMenu.ArrestedPlayers", PANEL, "Panel" )