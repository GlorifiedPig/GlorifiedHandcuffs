
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.TitleBar = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.TitleBar", self )

    self.Weapons = {}
    self.Weapons[1] = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self )
    self.Weapons[2] = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self )
    self.Weapons[3] = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self )
    self.Weapons[4] = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self )
    self.Weapons[5] = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self )
    self.Weapons[6] = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self )
    self.Weapons[7] = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self )
    self.Weapons[8] = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self )
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.interactionMenuInfoBoxBackgroundColor )

    self.TitleBar:Dock( TOP )
    self.TitleBar:SetSize( w, h * 0.23 )

    for k, v in pairs( self.Weapons ) do
        local line = math.ceil( k / 4 )
        local linePos = k - ( ( line - 1 ) * 4 )
        v:SetPos( ( 7 * linePos ) + ( linePos - 1 ) * v:GetWide(), self.TitleBar:GetTall() + ( 5 * line ) + ( ( line - 1 ) * v:GetTall() ) )
        v:SetSize( w / 4.25, h * 0.35 )
    end
end

vgui.Register( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox", PANEL, "Panel" )