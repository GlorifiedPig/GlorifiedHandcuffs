
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.TitleBar = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.TitleBar", self )

    self.Weapons = {}
end

function PANEL:AddWeapon( weapon )
    if table.Count( self.Weapons ) >= 8 then return end
    local newWeapon = table.insert( self.Weapons, vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", self ) )
    self.Weapons[newWeapon]:SetWeaponInfo( weapon )
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