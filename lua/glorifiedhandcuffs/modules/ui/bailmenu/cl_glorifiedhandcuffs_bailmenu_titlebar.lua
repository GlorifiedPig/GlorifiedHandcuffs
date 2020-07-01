
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    local titleLabel = vgui.Create( "DLabel", self )
    titleLabel:SetFont( "GlorifiedHandcuffs.BailMenu.TitleBar" )
    titleLabel:SetText( "Bail Menu" )
    titleLabel:SizeToContents()
    titleLabel:DockMargin( 10, 0, 0, 0 )
    titleLabel:Dock( LEFT )

    local closeButton = vgui.Create( "DButton", self )
    closeButton:SetText( "" )
    closeButton:Dock( RIGHT )
    closeButton.DoClick = function()
        self:GetParent():AlphaTo( 0, 0.3, 0, function()
            self:GetParent():Remove()
        end )
    end
    self.CloseButton = closeButton
end

function PANEL:PerformLayout( w, h )
    self.CloseButton:SetSize( w * 0.09, h )
    self.CloseButton.Paint = function( closeButton, closeButtonW, closeButtonH )
        local iconSize = closeButtonH * 0.6
        if not closeButton.Color then closeButton.Color = self.Theme.Data.Colors.bailMenuCloseButtonBackgroundColor end
        closeButton.Color = GlorifiedHandcuffs.UI.LerpColor( FrameTime() * 5, closeButton.Color, closeButton:IsHovered() and self.Theme.Data.Colors.bailMenuCloseButtonHoverColor or self.Theme.Data.Colors.bailMenuCloseButtonBackgroundColor )
        surface.SetDrawColor( closeButton.Color )
        surface.SetMaterial( self.Theme.Data.Materials.close )
        surface.DrawTexturedRect( closeButtonW / 2 - iconSize / 2, closeButtonH / 2 - iconSize / 2, iconSize, iconSize )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBoxEx( 6, 0, 0, w, h, self.Theme.Data.Colors.bailMenuTitleBarBackgroundColor, true, true, false, false )
end

vgui.Register( "GlorifiedHandcuffs.BailMenu.TitleBar", PANEL, "Panel" )