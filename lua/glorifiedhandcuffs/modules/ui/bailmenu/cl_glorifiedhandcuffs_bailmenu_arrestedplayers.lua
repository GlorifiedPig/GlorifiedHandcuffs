
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.ScrollPanel = vgui.Create( "GlorifiedHandcuffs.ScrollPanel", self )

    self.EmptyListLabel = vgui.Create( "DLabel", self )
    self.EmptyListLabel:SetText( GlorifiedHandcuffs.i18n.GetPhrase( "noPlayers" ) )
    self.EmptyListLabel:SetTextColor( Color( 255, 255, 255, 90 ) )
    self.EmptyListLabel:SetPos( 10, 7 )
    self.EmptyListLabel:SizeToContents()

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
    self.EmptyListLabel:SetVisible( false )

    self.ScrollPanel:Dock( FILL )
    self.ScrollPanel:DockMargin( 0, h * 0.02, 0, 0 )
    self.ScrollPanel:DockPadding( 0, 0, w * 0.013, 0 )

    local plyH = h * 0.14
    local plyMarginX, plyMarginY = w * 0.026, h * 0.008
    for k, v in ipairs( self.Players ) do
        v:SetHeight( plyH )
        v:Dock( TOP )
        v:DockMargin( plyMarginX, plyMarginY, plyMarginX, plyMarginY )
    end

    if #self.Players <= 0 then
        self.EmptyListLabel:SetVisible( true )
    end
end

vgui.Register( "GlorifiedHandcuffs.BailMenu.ArrestedPlayers", PANEL, "Panel" )