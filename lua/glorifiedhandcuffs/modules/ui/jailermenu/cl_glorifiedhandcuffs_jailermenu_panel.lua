
local PANEL = {}

function PANEL:Init()
    self:SetSize( ScrH() * 0.4, ScrH() * 0.4 )
    self:Center()
    self:MakePopup()

    self.Theme = GlorifiedHandcuffs.Themes.GetCurrent()

    self.TitleBar = vgui.Create( "GlorifiedHandcuffs.JailerMenu.TitleBar", self )

    self:SetAlpha( 0 )
    self:AlphaTo( 255, 0.3 )

    self.ConfirmButton = vgui.Create( "DButton", self )
    self.ConfirmButton:SetText( "Confirm" )

    self.CancelButton = vgui.Create( "DButton", self )
    self.CancelButton:SetText( "Cancel" )
end

function PANEL:PerformLayout( w, h )
    self.TitleBar:Dock( TOP )
    self.TitleBar:SetSize( w, h * 0.1 )

    self.ConfirmButton:SetPos( 15, h - ( h / 7 ) )
    self.ConfirmButton:SetSize( w / 2.25, h / 7 )
    self.ConfirmButton.Paint = function( confirmButton, confirmButtonW, confirmButtonH )
        draw.RoundedBox( 6, 0, 0, confirmButtonW, confirmButtonH, Color( 0, 155, 0 ) )
    end

    self.CancelButton:SetPos( w - ( w / 2.25 ) - 15, h - ( h / 7 ) )
    self.CancelButton:SetSize( w / 2.25, h / 7 )
    self.CancelButton.Paint = function( cancelButton, cancelButtonW, cancelButtonH )
        draw.RoundedBox( 6, 0, 0, cancelButtonW, cancelButtonH, Color( 155, 0, 0 ) )
    end
end

function PANEL:Think()
    if input.IsKeyDown( KEY_ESCAPE ) then
        GlorifiedHandcuffs.UI.CloseJailerMenu()
        RunConsoleCommand( "cancelselect" )
    end
end

function PANEL:Paint( w, h )
    draw.RoundedBox( 6, 0, 0, w, h, self.Theme.Data.Colors.bailMenuBackgroundColor )
end

vgui.Register( "GlorifiedHandcuffs.JailerMenu.Menu", PANEL, "EditablePanel" )

function GlorifiedHandcuffs.UI.OpenJailerMenu()
    if not IsValid( LocalPlayer() ) then return end

    if IsValid( GlorifiedHandcuffs.UI.JailerMenu ) then
        GlorifiedHandcuffs.UI.JailerMenu:Remove()
        GlorifiedHandcuffs.UI.JailerMenu = nil
    end

    GlorifiedHandcuffs.UI.JailerMenu = vgui.Create( "GlorifiedHandcuffs.JailerMenu.Menu" )
end

function GlorifiedHandcuffs.UI.CloseJailerMenu()
    if not GlorifiedHandcuffs.UI.JailerMenu then return end

    GlorifiedHandcuffs.UI.JailerMenu:AlphaTo( 0, 0.3, 0, function()
        GlorifiedHandcuffs.UI.JailerMenu:Remove()
        GlorifiedHandcuffs.UI.JailerMenu = nil
    end )
end

concommand.Add( "glorifiedhandcuffs_uidebug", GlorifiedHandcuffs.UI.OpenJailerMenu )