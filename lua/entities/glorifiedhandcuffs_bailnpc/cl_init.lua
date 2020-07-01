
include( "shared.lua" )

local theme = GlorifiedHandcuffs.Themes.GetCurrent()
local bailNPCText = GlorifiedHandcuffs.i18n.GetPhrase( "bailNpc" )

function ENT:Draw()
    self:DrawModel()

    local pos = self:GetPos()
    local angles = self:GetAngles()

    angles:RotateAroundAxis( angles:Forward(), 90 )
    angles:RotateAroundAxis( angles:Right(), 270 )

    surface.SetFont( "GlorifiedHandcuffs.BailNPC.WordBox" )
    local bailNpcTextW = surface.GetTextSize( bailNPCText )

    cam.Start3D2D( pos + angles:Up() + angles:Forward() * -( bailNpcTextW / 14.15 ) + angles:Right() * -79, angles, 0.12 )
        draw.WordBox( 8, 0, 0, bailNPCText, "GlorifiedHandcuffs.BailNPC.WordBox", theme.Data.Colors.bailNPC3D2DBackground, theme.Data.Colors.bailNPC3D2DText )
    cam.End3D2D()
end