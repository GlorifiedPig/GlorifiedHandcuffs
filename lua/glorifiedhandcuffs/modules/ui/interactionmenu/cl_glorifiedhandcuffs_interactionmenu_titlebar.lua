
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.TitleLabel = vgui.Create( "DLabel", self )
    self.TitleLabel:SetFont( "GlorifiedHandcuffs.InteractionMenu.TitleBar" )
    self.TitleLabel:SetText( "Interaction Menu" )
    self.TitleLabel:SizeToContents()
    self.TitleLabel:DockMargin( 10, 0, 0, 0 )
    self.TitleLabel:Dock( LEFT )

    self.CloseButton = vgui.Create( "DButton", self )
    self.CloseButton:SetText( "" )
    self.CloseButton:Dock( RIGHT )
    self.CloseButton.DoClick = GlorifiedHandcuffs.UI.CloseInteractionMenu
end

function PANEL:PerformLayout( w, h )
    self.CloseButton:SetSize( w * 0.085, h )
    self.CloseButton.Paint = function( closeButton, closeButtonW, closeButtonH )
        local iconSize = closeButtonH * 0.4
        if not closeButton.Color then closeButton.Color = self.Theme.Data.Colors.interactionMenuCloseButtonBackgroundColor end
        closeButton.Color = GlorifiedHandcuffs.UI.LerpColor( FrameTime() * 5, closeButton.Color, closeButton:IsHovered() and self.Theme.Data.Colors.interactionMenuCloseButtonHoverColor or self.Theme.Data.Colors.interactionMenuCloseButtonBackgroundColor )
        surface.SetDrawColor( closeButton.Color )
        surface.SetMaterial( self.Theme.Data.Materials.close )
        surface.DrawTexturedRect( closeButtonW / 2 - iconSize / 2, closeButtonH / 2 - iconSize / 2, iconSize, iconSize )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBoxEx( 6, 0, 0, w, h, self.Theme.Data.Colors.interactionMenuTitleBarBackgroundColor, true, true, false, false )
end

vgui.Register( "GlorifiedHandcuffs.InteractionMenu.TitleBar", PANEL, "Panel" )