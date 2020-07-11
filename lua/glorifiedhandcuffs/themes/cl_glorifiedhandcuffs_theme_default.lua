
GlorifiedHandcuffs.Themes.Register( "Default", "Default", {
    Colors = {
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

        interactionMenuBackgroundColor = Color( 51, 51, 51 ),
        interactionMenuTitleBarBackgroundColor = Color( 34, 34, 34 ),
        interactionMenuCloseButtonBackgroundColor = Color( 201, 60, 63 ),
        interactionMenuCloseButtonHoverColor = Color( 134, 35, 37 ),
        interactionMenuInfoBoxBackgroundColor = Color( 85, 85, 85 ),
        interactionMenuInfoBoxTextColor = Color( 255, 255, 255 ),
        interactionMenuInfoBoxNameColor = Color( 45, 45, 45 ),
        interactionMenuInfoBoxNameTextColor = Color( 255, 255, 255 ),
        interactionMenuInfoBoxJobTextColor = Color( 255, 255, 255 ),
        interactionMenuInfoBoxWalletColor = Color( 0, 200, 0 ),
        interactionMenuInfoBoxWalletTextColor = Color( 255, 255, 255 ),
        interactionMenuWeaponBackgroundColor = Color( 125, 125, 125 ),
        interactionMenuDragPlayerTextColor = Color( 255, 255, 255 ),
        interactionMenuDragPlayerButton = Color( 200, 145, 45 ),
        interactionMenuDragPlayerButtonHover = Color( 170, 125, 37 ),
        interactionMenuConfiscateIllegalWeaponsTextColor = Color( 255, 255, 255 ),
        interactionMenuConfiscateIllegalWeaponsColor = Color( 255, 60, 60 ),
        interactionMenuConfiscateIllegalWeaponsColorHover = Color( 225, 35, 35 ),
        interactionMenuConfiscateWeaponTextColor = Color( 255, 255, 255 ),
        interactionMenuConfiscateWeaponColor = Color( 200, 60, 60 ),
        interactionMenuConfiscateWeaponColorHover = Color( 185, 25, 25 ),
        interactionMenuConfiscateWeaponColorLegal = Color( 0, 200, 0 ),
        interactionMenuConfiscateWeaponColorLegalHover = Color( 0, 180, 0 ),

        hudCuffedBackgroundColor = Color( 210, 80, 80 ),
        hudCuffedBackgroundTextColor = Color( 255, 255, 255 ),
        hudBreakFreeBackgroundColor = Color( 31, 31, 31, 230 ),
        hudBreakFreeBackgroundTextColor = Color( 255, 255, 255 ),
        hudBreakFreeKeypressBackgroundColor = Color( 102, 176, 64 ),
        hudBreakFreeKeypressTextColor = Color( 255, 255, 255 ),

        hudSurrenderingBackgroundColor = Color( 210, 80, 80 ),
        hudSurrenderingBackgroundTextColor = Color( 255, 255, 255 ),
        hudStopSurrenderingBackgroundColor = Color( 31, 31, 31, 230 ),
        hudStopSurrenderingBackgroundTextColor = Color( 255, 255, 255 ),
        hudStopSurrenderingKeypressBackgroundColor = Color( 102, 176, 64 ),
        hudStopSurrenderingKeypressTextColor = Color( 255, 255, 255 ),

        bailNPC3D2DBackground = Color( 55, 55, 55, 155 ),
        bailNPC3D2DText = Color( 255, 255, 255 ),

        jailerNPC3D2DBackground = Color( 55, 55, 55, 155 ),
        jailerNPC3D2DText = Color( 255, 255, 255 ),
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
        ["HUD.Surrendering"] = {
            font = "Roboto",
            size = 20,
            weight = 1000,
            antialias = true
        },
        ["HUD.StopSurrendering"] = {
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
        ["BailNPC.WordBox"] = {
            font = "Roboto",
            size = 50,
            weight = 1000,
            antialias = true
        },
        ["JailerNPC.WordBox"] = {
            font = "Roboto",
            size = 50,
            weight = 1000,
            antialias = true
        },
        ["InteractionMenu.TitleBar"] = {
            font = "Roboto",
            size = function() return ScrW() * 0.015 end,
            weight = 500,
            antialias = true
        },
        ["InteractionMenu.InfoBox"] = {
            font = "Roboto",
            size = function() return ScrW() * 0.013 end,
            weight = 500,
            antialias = true
        },
        ["InteractionMenu.InfoBoxInfo"] = {
            font = "Roboto",
            size = function() return ScrW() * 0.012 end,
            weight = 500,
            antialias = true
        },
        ["InteractionMenu.WeaponBoxInfo"] = {
            font = "Roboto",
            size = function() return ScrW() * 0.01 end,
            weight = 500,
            antialias = true
        },
        ["InteractionMenu.BottomButtons"] = {
            font = "Roboto",
            size = function() return ScrW() * 0.012 end,
            weight = 500,
            antialias = true
        },
    },
    Materials = {
        cuffs = Material( "glorifiedhandcuffs/cuffs.png", "noclamp smooth" ),
        surrender = Material( "glorifiedhandcuffs/surrender.png", "noclamp smooth" ),
        close = Material( "glorifiedhandcuffs/close.png", "noclamp smooth" ),
        name = Material( "glorifiedhandcuffs/name.png", "noclamp smooth" ),
        money = Material( "glorifiedhandcuffs/money.png", "noclamp smooth" ),
        briefcase = Material( "glorifiedhandcuffs/briefcase.png", "noclamp smooth" ),
    }
} )
GlorifiedHandcuffs.Themes.GenerateFonts()