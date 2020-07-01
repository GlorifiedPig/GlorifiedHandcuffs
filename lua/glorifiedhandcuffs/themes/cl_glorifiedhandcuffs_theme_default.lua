
GlorifiedHandcuffs.Themes.Register( "Default", "Default", {
    Colors = {
        xpBarBackgroundDrawColor = Color( 31, 31, 31, 230 ),

        bailMenuBackgroundColor = Color( 51, 51, 51 ),
        bailMenuTitleBarBackgroundColor = Color( 34, 34, 34 ),
        bailMenuCloseButtonBackgroundColor = Color( 201, 60, 63 ),
        bailMenuCloseButtonHoverColor = Color( 134, 35, 37 ),
    },
    Fonts = {
        ["HUD.Handcuffed"] = {
            font = "Roboto",
            size = 20,
            weight = 1000,
            antialias = true
        },
        ["HUD.BreakFree"] = {
            font = "Roboto",
            size = 22,
            weight = 1000,
            antialias = true
        },
        ["BailMenu.TitleBar"] = {
            font = "Roboto",
            size = function() return ScrW() * 0.015 end,
            weight = 500,
            antialias = true
        }
    },
    Materials = {
        cuffs = Material( "glorifiedhandcuffs/cuffs.png", "noclamp smooth" ),
        close = Material( "glorifiedhandcuffs/close.png", "noclamp smooth" ),
    }
} )
GlorifiedHandcuffs.Themes.GenerateFonts()