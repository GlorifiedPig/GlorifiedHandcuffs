
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.TitleLabel = vgui.Create( "DLabel", self )
    self.TitleLabel:SetFont( "GlorifiedHandcuffs.InteractionMenu.TitleBar" )
    self.TitleLabel:SetText( "Weapons" )
    self.TitleLabel:SizeToContents()
    self.TitleLabel:DockMargin( 10, 0, 0, 0 )
    self.TitleLabel:Dock( LEFT )
end

function PANEL:Paint( w, h )
    draw.RoundedBoxEx( 6, 0, 0, w, h, self.Theme.Data.Colors.interactionMenuTitleBarBackgroundColor, true, true, false, false )
end

vgui.Register( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.TitleBar", PANEL, "Panel" )