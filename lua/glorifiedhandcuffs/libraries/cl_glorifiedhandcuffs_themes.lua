
GlorifiedHandcuffs.Themes = {}

local registeredThemes = {}
local defaultTheme = "Default"
local selectedTheme

function GlorifiedHandcuffs.Themes.Register( id, name, data )
    if not registeredThemes[id] then
        registeredThemes[id] = {}
    end

    registeredThemes[id].DisplayName = name
    registeredThemes[id].Data = id == defaultTheme and data or table.Merge( GlorifiedHandcuffs.Themes.Get( defaultTheme ).Data, data )
end

function GlorifiedHandcuffs.Themes.Get( id )
    return registeredThemes[id] or registeredThemes[defaultTheme] or false
end

function GlorifiedHandcuffs.Themes.GetCurrent()
    return GlorifiedHandcuffs.Themes.Get( selectedTheme )
end

function GlorifiedHandcuffs.Themes.GetAll()
    return registeredThemes
end

function GlorifiedHandcuffs.Themes.GetByName( name )
    local returnedTheme = registeredThemes[defaultTheme]
    for k, v in pairs( registeredThemes ) do
        if v.DisplayName == name then returnedTheme = v break end
    end
    return returnedTheme
end

function GlorifiedHandcuffs.Themes.GenerateFonts()
    local fontsTable = GlorifiedHandcuffs.Themes.GetCurrent().Data.Fonts
    if fontsTable then
        for k, v in pairs( fontsTable ) do
            if isfunction( v.size ) then
                v.size = v.size()
            end

            surface.CreateFont( "GlorifiedHandcuffs." .. k, v )
        end
    end
end

function GlorifiedHandcuffs.Themes.Select( id )
    if registeredThemes[id] then
        GlorifiedHandcuffs.Themes.GenerateFonts()

        cookie.Set( "GlorifiedHandcuffs.Theme", tostring( id ) )
        selectedTheme = tostring( id )

        hook.Run( "GlorifiedHandcuffs.ThemeUpdated", GlorifiedHandcuffs.Themes.GetCurrent() )
    end
end

hook.Add( "OnScreenSizeChanged", "GlorifiedHandcuffs.Themes.OnScreenSizeChanged", function()
    GlorifiedHandcuffs.Themes.GenerateFonts()
end )

hook.Add( "InitPostEntity", "GlorifiedHandcuffs.Themes.InitPostEntity", function()
    GlorifiedHandcuffs.Themes.Select( cookie.GetString( "GlorifiedHandcuffs.Theme", defaultTheme ) )
end )

concommand.Add( "glorifiedhandcuffs_theme", function( ply, args )
    if ply != LocalPlayer() then return end
    local theme = string.lower( args[1] )
    GlorifiedHandcuffs.Themes.Select( theme )
end )