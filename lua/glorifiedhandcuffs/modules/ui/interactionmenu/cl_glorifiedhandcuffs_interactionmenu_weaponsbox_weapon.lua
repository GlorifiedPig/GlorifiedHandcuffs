
local PANEL = {}

function PANEL:Init()
    self.Theme = self:GetParent().Theme

    self.ConfiscateButton = vgui.Create( "DButton", self )
    self.ConfiscateButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.WeaponBoxInfo" )
    self.ConfiscateButton:SetTextColor( self.Theme.Data.Colors.interactionMenuConfiscateWeaponTextColor )
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
    self.WeaponLegal = GlorifiedHandcuffs.Config.LEGAL_WEAPONS[weaponClass] and GlorifiedHandcuffs.HasGunLicense( weapon:GetOwner() )
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
        self.ConfiscateButton:SetText( GlorifiedHandcuffs.i18n.GetPhrase( "confiscate" ) )
    end
    self.ConfiscateButton.OnCursorExited = function()
        if not weapon or not weapon:IsValid() then return end
        self.ConfiscateButton:SetText( weapon:GetPrintName() )
    end
    self.ConfiscateButton.DoClick = function()
        net.Start( "GlorifiedHandcuffs.InteractionMenu.StripWeapon" )
        net.WriteEntity( weapon:GetOwner() )
        net.WriteString( weapon:GetClass() )
        net.SendToServer()
        GlorifiedHandcuffs.UI.CloseInteractionMenu()
    end
end

vgui.Register( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox.Weapon", PANEL, "Panel" )