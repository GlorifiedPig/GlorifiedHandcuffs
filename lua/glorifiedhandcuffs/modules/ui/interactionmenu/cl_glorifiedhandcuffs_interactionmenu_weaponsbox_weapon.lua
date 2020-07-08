
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.ConfiscateButton = vgui.Create( "DButton", self )
    self.ConfiscateButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.WeaponBoxInfo" )
    self.ConfiscateButton:SetTextColor( Color( 255, 255, 255 ) )
    self.ConfiscateButton:SetText( "MP5" )
    self.ConfiscateButton:Dock( BOTTOM )

    self.ModelPanel = vgui.Create( "SpawnIcon", self )
    self.ModelPanel:SetModel( "models/weapons/w_smg_mp5.mdl" )
    self.ModelPanel:Dock( LEFT )
    self.ModelPanel:DockMargin( self.ModelPanel:GetWide() / 2, 0, 0, 0 )
end

function PANEL:PerformLayout()
    self.ConfiscateButton.Paint = function( confiscateButton, confiscateButtonW, confiscateButtonH )
        draw.RoundedBoxEx( 6, 0, 0, confiscateButtonW, confiscateButtonH, Color( 165, 0, 0 ), false, false, true, true )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.interactionMenuWeaponBackgroundColor )
end

vgui.Register( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", PANEL, "Panel" )