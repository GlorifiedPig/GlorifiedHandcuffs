
GlorifiedHandcuffs.Themes.Register( "Dark", GlorifiedHandcuffs.i18n.GetPhrase( "glDarkTheme" ), {
    Colors = {
        xpBarBackgroundDrawColor = Color( 31, 31, 31, 230 ),
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
    },
    Materials = {
        cuffs = Material( "glorifiedhandcuffs/cuffs.png", "noclamp smooth" ),
    }
} )
GlorifiedHandcuffs.Themes.GenerateFonts()