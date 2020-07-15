
local PANEL = {}

function PANEL:PerformLayout( w, h )
    self.TitleBar:Dock( TOP )
    self.TitleBar:SetSize( w, h * 0.1 )

    self.NameInfoBox:SetSize( w, h * 0.085 )
    self.NameInfoBox:DockMargin( 15, 15, 15, 0 )
    self.NameInfoBox:Dock( TOP )

    self.JobInfoBox:SetSize( w, h * 0.085 )
    self.JobInfoBox:DockMargin( 15, 10, 15, 0 )
    self.JobInfoBox:Dock( TOP )

    self.WalletInfoBox:SetSize( w, h * 0.085 )
    self.WalletInfoBox:DockMargin( 15, 10, 15, 0 )
    self.WalletInfoBox:Dock( TOP )

    self.WeaponsBox:SetSize( w, h * 0.38 )
    self.WeaponsBox:Dock( TOP )
    self.WeaponsBox:DockMargin( 15, 10, 15, 0 )
end

function PANEL:SetPlayer( ply )
    self:SetSize( ScrH() * 0.55, ScrH() * 0.6 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedHandcuffs.Themes.GetCurrent()

    self.TitleBar = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.TitleBar", self )

    self.NameInfoBox = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.InfoBox", self )
    self.NameInfoBox:SetLabelInfo( GlorifiedHandcuffs.i18n.GetPhrase( "name" ), ply:Nick(), self.Theme.Data.Colors.interactionMenuInfoBoxNameColor, self.Theme.Data.Colors.interactionMenuInfoBoxNameTextColor, self.Theme.Data.Materials.name )

    self.JobInfoBox = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.InfoBox", self )
    self.JobInfoBox:SetLabelInfo( GlorifiedHandcuffs.i18n.GetPhrase( "job" ), team.GetName( ply:Team() ), team.GetColor( ply:Team() ), self.Theme.Data.Colors.interactionMenuInfoBoxJobTextColor, self.Theme.Data.Materials.briefcase )

    self.WalletInfoBox = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.InfoBox", self )
    self.WalletInfoBox:SetLabelInfo( GlorifiedHandcuffs.i18n.GetPhrase( "wallet" ), GlorifiedHandcuffs.FormatMoney( GlorifiedHandcuffs.GetMoney( ply ) ), self.Theme.Data.Colors.interactionMenuInfoBoxWalletColor, self.Theme.Data.Colors.interactionMenuInfoBoxWalletTextColor, self.Theme.Data.Materials.money )

    self.WeaponsBox = vgui.Create( "GlorifiedHandcuffs.InteractionMenu.WeaponsBox", self )
    for k, v in pairs( ply:GetWeapons() ) do
        if not GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST and GlorifiedHandcuffs.Config.WEAPON_BLACKLIST[v:GetClass()] then continue end
        if GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST and not GlorifiedHandcuffs.Config.WEAPON_BLACKLIST[v:GetClass()] then continue end
        self.WeaponsBox:AddWeapon( v )
    end

    self.TopRowButtons = vgui.Create( "EditablePanel", self )
    self.TopRowButtons:Dock( TOP )
    self.TopRowButtons:SetTall( self:GetTall() / 12.5 )
    self.TopRowButtons:DockMargin( 15, 10, 15, 0 )
    self.TopRowButtons.PerformLayout = function( topRowButtons, w, h )
        self.ConfiscateAllButton:SetWide( w / 2 )
        self.ConfiscateIllegalButton:SetWide( w / 2 )
    end

    self.ConfiscateAllButton = vgui.Create( "DButton", self.TopRowButtons )
    self.ConfiscateAllButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.BottomButtons" )
    self.ConfiscateAllButton:Dock( LEFT )
    self.ConfiscateAllButton:SetTextColor( Color( 255, 255, 255 ) )
    self.ConfiscateAllButton:SetText( "Confiscate All" )
    self.ConfiscateAllButton.Paint = function( confiscateAllButton, w, h )
        draw.RoundedBox( 0, 0, 0, w - 2, h, Color( 230, 56, 56 ) )
    end

    self.ConfiscateIllegalButton = vgui.Create( "DButton", self.TopRowButtons )
    self.ConfiscateIllegalButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.BottomButtons" )
    self.ConfiscateIllegalButton:Dock( LEFT )
    self.ConfiscateIllegalButton:SetTextColor( Color( 255, 255, 255 ) )
    self.ConfiscateIllegalButton:SetText( "Confiscate Illegal" )
    self.ConfiscateIllegalButton.Paint = function( confiscateIllegalButton, w, h )
        draw.RoundedBox( 0, 2, 0, w - 2, h, Color( 230, 56, 56 ) )
    end

    self.BottomRowButtons = vgui.Create( "EditablePanel", self )
    self.BottomRowButtons:Dock( TOP )
    self.BottomRowButtons:SetTall( self:GetTall() / 12.5 )
    self.BottomRowButtons:DockMargin( 15, 5, 15, 15 )
    self.BottomRowButtons.PerformLayout = function( bottomRowButtons, w, h )
        self.DragButton:SetWide( w / 3 )
        self.BlindfoldButton:SetWide( w / 3 )
        self.GagButton:SetWide( w / 3 )
    end

    self.DragButton = vgui.Create( "DButton", self.BottomRowButtons )
    self.DragButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.BottomButtons" )
    self.DragButton:Dock( LEFT )
    self.DragButton:SetTextColor( Color( 255, 255, 255 ) )
    self.DragButton:SetText( "Drag Player" )
    self.DragButton.Paint = function( dragButton, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 126, 126, 126 ) )
    end

    self.BlindfoldButton = vgui.Create( "DButton", self.BottomRowButtons )
    self.BlindfoldButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.BottomButtons" )
    self.BlindfoldButton:Dock( LEFT )
    self.BlindfoldButton:SetTextColor( Color( 255, 255, 255 ) )
    self.BlindfoldButton:SetText( "Blindfold Player" )
    self.BlindfoldButton.Paint = function( blindfoldButton, w, h )
        draw.RoundedBox( 0, 4, 0, w - 2, h, Color( 126, 126, 126 ) )
    end

    self.GagButton = vgui.Create( "DButton", self.BottomRowButtons )
    self.GagButton:SetFont( "GlorifiedHandcuffs.InteractionMenu.BottomButtons" )
    self.GagButton:Dock( LEFT )
    self.GagButton:SetTextColor( Color( 255, 255, 255 ) )
    self.GagButton:SetText( "Gag Player" )
    self.GagButton.Paint = function( gagButton, w, h )
        draw.RoundedBox( 0, 4, 0, w - 2, h, Color( 126, 126, 126 ) )
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
    if not interactedPly then return end

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

net.Receive( "GlorifiedHandcuffs.InteractionMenu.OpenInteractionMenu", function()
    GlorifiedHandcuffs.UI.OpenInteractionMenu( net.ReadEntity() )
end )