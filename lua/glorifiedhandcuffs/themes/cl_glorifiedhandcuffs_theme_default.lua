
GlorifiedHandcuffs.Themes.Register( "Default", "Default", {
    Colors = {
        xpBarBackgroundDrawColor = Color( 31, 31, 31, 230 ),

        scrollBarCol = Color( 105, 105, 105 ),
        scrollBarHoverCol = Color( 85, 85, 85 ),

        bailMenuBackgroundColor = Color( 51, 51, 51 ),
        bailMenuTitleBarBackgroundColor = Color( 34, 34, 34 ),
        bailMenuCloseButtonBackgroundColor = Color( 201, 60, 63 ),
        bailMenuCloseButtonHoverColor = Color( 134, 35, 37 ),
        bailMenuPlayerBackgroundColor = Color( 73, 73, 73 ),
        bailMenuPlayerNameTextColor = Color( 255, 255, 255 ),
        bailMenuPlayerSteamIDCol = Color( 160, 160, 160 ),
        bailMenuBailButtonTextColor = Color( 255, 255, 255 ),
        bailMenuBailButtonColorCanAfford = Color( 89, 175, 63 ),
        bailMenuBailButtonColorCanAffordHover = Color( 69, 155, 45 ),
        bailMenuBailButtonColorCantAfford = Color( 201, 60, 63 ),
        bailMenuBailButtonColorCantAffordHover = Color( 156, 40, 42 ),
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
        },
        ["BailMenu.PlayerInfo"] = {
            font = "Roboto",
            size = function() return ScrH() * 0.02 end,
            weight = 1000,
            antialias = true
        },
        ["BailMenu.BailPlayer"] = {
            font = "Roboto",
            size = function() return ScrH() * 0.02 end,
            weight = 500,
            antialias = true
        },
    },
    Materials = {
        cuffs = Material( "glorifiedhandcuffs/cuffs.png", "noclamp smooth" ),
        close = Material( "glorifiedhandcuffs/close.png", "noclamp smooth" ),
    }
} )
GlorifiedHandcuffs.Themes.GenerateFonts()