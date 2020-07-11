
local PANEL = {}

function PANEL:Init()
end

function PANEL:PerformLayout( w, h )
    self.TitleBar:Dock( TOP )
    self.TitleBar:SetSize( w, h * 0.1 )

    self.NameInfoBox:SetSize( w, h * 0.1 )
    self.NameInfoBox:DockMargin( 15, 15, 15, 0 )
    self.NameInfoBox:Dock( TOP )

    self.JobInfoBox:SetSize( w, h * 0.1 )
    self.JobInfoBox:DockMargin( 15, 10, 15, 0 )
    self.JobInfoBox:Dock( TOP )

    self.WalletInfoBox:SetSize( w, h * 0.1 )
    self.WalletInfoBox:DockMargin( 15, 10, 15, 0 )
    self.WalletInfoBox:Dock( TOP )

    self.WeaponsBox:SetSize( w, h * 0.38 )
    self.WeaponsBox:Dock( TOP )
    self.WeaponsBox:DockMargin( 15, 10, 15, 0 )

    self.DragButton:SetSize( w / 2, 0 )
    self.DragButton:DockMargin( 0, 20, 0, 20 )
    self.DragButton:Dock( LEFT )

    self.ConfiscateButton:SetSize( w / 2, 0 )
    self.ConfiscateButton:DockMargin( 0, 20, 0, 20 )
    self.ConfiscateButton:Dock( LEFT )
end

function PANEL:SetPlayer( ply )
    self:SetSize( ScrH() * 0.55, ScrH() * 0.55 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedHandcuffs.Themes.GetCurrent()

    self.TitleBar = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.TitleBar", self )

    self.NameInfoBox = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.InfoBox", self )
    self.NameInfoBox:SetLabelInfo( "Name", ply:Nick(), Color( 45, 45, 45 ), Color( 255, 255, 255 ) )

    self.JobInfoBox = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.InfoBox", self )
    self.JobInfoBox:SetLabelInfo( "Job", team.GetName( ply:Team() ), team.GetColor( ply:Team() ), Color( 255, 255, 255 ) )

    self.WalletInfoBox = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.InfoBox", self )
    self.WalletInfoBox:SetLabelInfo( "Wallet", GlorifiedHandcuffs.FormatMoney( GlorifiedHandcuffs.GetMoney( ply ) ), Color( 0, 165, 0 ), Color( 255, 255, 255 ) )

    self.WeaponsBox = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox", self )
    for k, v in pairs( ply:GetWeapons() ) do
        if not GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST and GlorifiedHandcuffs.Config.WEAPON_BLACKLIST[v:GetClass()] then continue end
        if GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST and not GlorifiedHandcuffs.Config.WEAPON_BLACKLIST[v:GetClass()] then continue end
        self.WeaponsBox:AddWeapon( v )
    end

    self.DragButton = vgui.Create( "DButton", self )
    self.DragButton:SetTextColor( Color( 255, 255, 255 ) )
    self.DragButton:SetText( "Drag Player" )
    self.DragButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.BottomButtons" )
    local dragColor = self.Theme.Data.Colors.interactionMenuDragPlayerButton
    local dragHoverColor = self.Theme.Data.Colors.interactionMenuDragPlayerButtonHover
    local curDragColor = dragColor
    local curDragColorLerped = curDragColor
    self.DragButton.Paint = function( dragButton, dragButtonW, dragButtonH )
        curDragColor = dragButton:IsHovered() and dragHoverColor or dragColor
        curDragColorLerped = GlorifiedHandcuffs.UI.LerpColor( FrameTime() * 4, curDragColorLerped, curDragColor )
        draw.RoundedBox( 6, 15, 0, dragButtonW - 20, dragButtonH, curDragColorLerped )
    end

    self.ConfiscateButton = vgui.Create( "DButton", self )
    self.ConfiscateButton:SetTextColor( Color( 255, 255, 255 ) )
    self.ConfiscateButton:SetText( "Confiscate Illegal Weapons" )
    self.ConfiscateButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.BottomButtons" )
    local confiscateColor = self.Theme.Data.Colors.interactionMenuConfiscateIllegalWeaponsColor
    local confiscateHoverColor = self.Theme.Data.Colors.interactionMenuConfiscateIllegalWeaponsColorHover
    local curConfiscateColor = confiscateColor
    local curConfiscateColorLerped = curConfiscateColor
    self.ConfiscateButton.Paint = function( confiscateButton, confiscateButtonW, confiscateButtonH )
        curConfiscateColor = confiscateButton:IsHovered() and confiscateHoverColor or confiscateColor
        curConfiscateColorLerped = GlorifiedHandcuffs.UI.LerpColor( FrameTime() * 4, curConfiscateColorLerped, curConfiscateColor )
        draw.RoundedBox( 6, 6, 0, confiscateButtonW - 20, confiscateButtonH, curConfiscateColorLerped )
    end

    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.3 )
end

function PANEL:Think()
    if input.IsKeyDown( KEY_ESCAPE ) then
        GlorifiedHandcuffs.UI.CloseInteractionMenu()
        RunConsoleCommand( "cancelselect" )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.interactionMenuBackgroundColor )
end

vgui.Register( "GlorifiedHandcuffs.InteractionMenu.Menu", PANEL, "EditablePanel" )

function GlorifiedHandcuffs.UI.OpenInteractionMenu( interactedPly )
    if not IsValid( LocalPlayer() ) then return end
    if not interactedPly then interactedPly = LocalPlayer() end -- Remove this line, only for debugging!

    if IsValid( GlorifiedHandcuffs.UI.InteractionMenu ) then
        GlorifiedHandcuffs.UI.InteractionMenu:Remove()
        GlorifiedHandcuffs.UI.InteractionMenu = nil
    end

    GlorifiedHandcuffs.UI.InteractionMenu = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.Menu" )
    GlorifiedHandcuffs.UI.InteractionMenu:SetPlayer( interactedPly )
end

function GlorifiedHandcuffs.UI.CloseInteractionMenu()
    if not GlorifiedHandcuffs.UI.InteractionMenu then return end

    GlorifiedHandcuffs.UI.InteractionMenu:AlphaTo( 0, 0.3, 0, function()
        if not GlorifiedHandcuffs.UI.InteractionMenu then return end
        GlorifiedHandcuffs.UI.InteractionMenu:Remove()
        GlorifiedHandcuffs.UI.InteractionMenu = nil
    end )
end

concommand.Add( "glorifiedhandcuffs_uidebug", GlorifiedHandcuffs.UI.OpenInteractionMenu )