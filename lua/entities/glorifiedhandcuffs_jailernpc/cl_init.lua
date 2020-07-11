
include( "shared.lua" )

local theme = GlorifiedHandcuffs.Themes.GetCurrent()
local jailerNPCText = GlorifiedHandcuffs.i18n.GetPhrase( "jailerNpc" )

function ENT:Draw()
    self:DrawModel()

    local pos = self:GetPos()
    local angles = self:GetAngles()

    angles:RotateAroundAxis( angles:Forward(), 90 )
    angles:RotateAroundAxis( angles:Right(), 270 )

    surface.SetFont( "GlorifiedHandcuffs.JailerNPC.WordBox" )
    local jailerNPCTextW = surface.GetTextSize( jailerNPCText )

    cam.Start3D2D( pos + angles:Up() + angles:Forward() * -( jailerNPCTextW / 14.15 ) + angles:Right() * -79, angles, 0.12 )
        draw.WordBox( 8, 0, 0, jailerNPCText, "GlorifiedHandcuffs.JailerNPC.WordBox", theme.Data.Colors.jailerNPC3D2DBackground, theme.Data.Colors.jailerNPC3D2DText )
    cam.End3D2D()
end