
local PANEL = {}

function PANEL:Init()
    self:SetSize( ScrH() * 0.6, ScrH() * 0.6 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedHandcuffs.Themes.GetCurrent()

    self.TitleBar = vgui.Create( "GlorifiedHandcuffs.BailMenu.TitleBar", self )
    self.ArrestedPlayers = vgui.Create( "GlorifiedHandcuffs.BailMenu.ArrestedPlayers", self )
    for k, v in pairs( player.GetAll() ) do
        if GlorifiedHandcuffs.IsPlayerArrested( v ) then
            self.ArrestedPlayers:AddPlayer( v )
        end
    end

    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.3 )
end

function PANEL:PerformLayout( w, h )
    self.TitleBar:Dock( TOP )
    self.TitleBar:SetSize( w, h * 0.1 )

    self.ArrestedPlayers:Dock( FILL )

    if IsValid( self.Page ) then
        self.Page:Dock( FILL )
    end
end

function PANEL:Think()
    if input.IsKeyDown( KEY_ESCAPE ) then
        GlorifiedHandcuffs.UI.CloseBailMenu()
        RunConsoleCommand( "cancelselect" )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.bailMenuBackgroundColor )
end

vgui.Register( "GlorifiedHandcuffs.BailMenu.Menu", PANEL, "EditablePanel" )

function GlorifiedHandcuffs.UI.OpenBailMenu()
    if not IsValid( LocalPlayer() ) then return end

    if IsValid( GlorifiedHandcuffs.UI.BailMenu ) then
        GlorifiedHandcuffs.UI.BailMenu:Remove()
        GlorifiedHandcuffs.UI.BailMenu = nil
    end

    GlorifiedHandcuffs.UI.BailMenu = vgui.Create( "GlorifiedHandcuffs.BailMenu.Menu" )
end

function GlorifiedHandcuffs.UI.CloseBailMenu()
    if not GlorifiedHandcuffs.UI.BailMenu then return end

    GlorifiedHandcuffs.UI.BailMenu:AlphaTo( 0, 0.3, 0, function()
        GlorifiedHandcuffs.UI.BailMenu:Remove()
        GlorifiedHandcuffs.UI.BailMenu = nil
    end )
end

net.Receive( "GlorifiedHandcuffs.Bail.OpenBailMenu", GlorifiedHandcuffs.UI.OpenBailMenu )