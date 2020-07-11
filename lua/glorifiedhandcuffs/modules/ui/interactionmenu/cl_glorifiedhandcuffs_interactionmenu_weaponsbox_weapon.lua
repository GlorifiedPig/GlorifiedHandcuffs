
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.ConfiscateButton = vgui.Create( "DButton", self )
    self.ConfiscateButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.WeaponBoxInfo" )
    self.ConfiscateButton:SetTextColor( Color( 255, 255, 255 ) )
    self.ConfiscateButton:Dock( BOTTOM )

    self.ModelPanel = vgui.Create( "SpawnIcon", self )
    self.ModelPanel:Dock( LEFT )
    self.ModelPanel:DockMargin( self.ModelPanel:GetWide() / 2, 0, 0, 0 )
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.interactionMenuWeaponBackgroundColor )
end

function PANEL:SetWeaponInfo( weapon )
    local weaponClass = weapon:GetClass()
    self.WeaponLegal = GlorifiedHandcuffs.Config.LEGAL_WEAPONS[weaponClass] and GlorifiedHandcuffs.HasGunLicense( ply )
    self.ModelPanel:SetModel( weapon:GetWeaponWorldModel() )

    self.ConfiscateButton:SetText( weapon:GetPrintName() )
    local confiscateColor = self.WeaponLegal and self.Theme.Data.Colors.interactionMenuConfiscateWeaponColorLegal or self.Theme.Data.Colors.interactionMenuConfiscateWeaponColor
    local confiscateHoverColor = self.WeaponLegal and self.Theme.Data.Colors.interactionMenuConfiscateWeaponColorLegalHover or self.Theme.Data.Colors.interactionMenuConfiscateWeaponColorHover
    local curConfiscateColor = confiscateColor
    local curConfiscateColorLerped = curConfiscateColor
    self.ConfiscateButton.Paint = function( confiscateButton, confiscateButtonW, confiscateButtonH )
        curConfiscateColor = confiscateButton:IsHovered() and confiscateHoverColor or confiscateColor
        curConfiscateColorLerped = GlorifiedHandcuffs.UI.LerpColor( FrameTime() * 4, curConfiscateColorLerped, curConfiscateColor )
        draw.RoundedBoxEx( 6, 0, 0, confiscateButtonW, confiscateButtonH, curConfiscateColorLerped, false, false, true, true )
    end
    self.ConfiscateButton.OnCursorEntered = function()
        self.ConfiscateButton:SetText( "Confiscate" )
    end
    self.ConfiscateButton.OnCursorExited = function()
        self.ConfiscateButton:SetText( weapon:GetPrintName() )
    end
end

vgui.Register( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", PANEL, "Panel" )