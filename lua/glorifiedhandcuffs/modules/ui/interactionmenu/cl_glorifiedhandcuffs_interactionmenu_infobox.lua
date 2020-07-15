
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.LeftIconPanel = vgui.Create( "EditablePanel", self )
    self.LeftIconPanel:Dock( LEFT )
    self.LeftIconPanel:SetSize( 48, 0 )

    self.LeftIcon = vgui.Create( "DImage", self.LeftIconPanel )
    self.LeftIcon:SetSize( 36, 36 )
    self.LeftIcon:SetPos( 10, self:GetTall() / 2 )

    self.LeftLabel = vgui.Create( "DLabel", self )
    self.LeftLabel:SetFont( "GlorifiedHandcuffs.InteractionMenu.InfoBox" )
    self.LeftLabel:SetColor( self.Theme.Data.Colors.interactionMenuInfoBoxTextColor )
    self.LeftLabel:DockMargin( 10, 0, 0, 0 )
    self.LeftLabel:Dock( LEFT )

    self.RightLabel = vgui.Create( "DButton", self )
    self.RightLabel:SetFont( "GlorifiedHandcuffs.InteractionMenu.InfoBoxInfo" )
    self.RightLabel:DockMargin( 0, 0, 10, 0 )
    self.RightLabel:Dock( RIGHT )
end

function PANEL:PerformLayout( w, h )
    self.LeftIcon:SetPos( 10, h / 2 - self.LeftIcon:GetTall() / 2 - 2 )
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.interactionMenuInfoBoxBackgroundColor )
end

function PANEL:SetLabelInfo( leftLabelName, rightLabelName, rightLabelColor, rightLabelTextColor, iconMaterial )
    self.LeftIcon:SetMaterial( iconMaterial )

    self.LeftLabel:SetText( leftLabelName )
    self.LeftLabel:SizeToContents()

    self.RightLabel:SetText( rightLabelName )
    self.RightLabel:SetTextColor( rightLabelTextColor )
    self.RightLabel:SizeToContents()
    self.RightLabel:SetWidth( self.RightLabel:GetWide() * 1.2 )
    self.RightLabel.Paint = function( rightLabel, rightLabelW, rightLabelH )
        draw.RoundedBox( 8, 0, 9, rightLabelW, rightLabelH - 18, rightLabelColor )
    end
end

vgui.Register( "GlorifiedHandcuffs.InteractionMenu.InfoBox", PANEL, "Panel" )