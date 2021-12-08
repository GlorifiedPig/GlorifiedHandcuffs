
if not GlorifiedHandcuffs.Config.SUPPORT_BLOGS or not GAS or not GAS.Logging then return end

--[[ Cuffing Module ]]--
local CUFFING_MODULE = GAS.Logging:MODULE()
CUFFING_MODULE.Category = "GlorifiedHandcuffs"
CUFFING_MODULE.Name = "Handcuffs"
CUFFING_MODULE.Colour = Color( 255, 130, 0 )

CUFFING_MODULE:Setup( function()
    CUFFING_MODULE:Hook( "GlorifiedHandcuffs.PlayerHandcuffPlayer", "GlorifiedHandcuffs.bLogs.PlayerHandcuffPlayer", function( cuffer, cuffed )
        CUFFING_MODULE:LogPhrase( "handcuffed", GAS.Logging:FormatPlayer( cuffer ), GAS.Logging:FormatPlayer( cuffed ) )
    end )
end )

GAS.Logging:AddModule( CUFFING_MODULE )
--[[ End Cuffing Module ]]--

--[[ Handcuff Escapes ]]--
local CUFFING_BREAKOUTS_MODULE = GAS.Logging:MODULE()
CUFFING_BREAKOUTS_MODULE.Category = "GlorifiedHandcuffs"
CUFFING_BREAKOUTS_MODULE.Name = "Breakouts"
CUFFING_BREAKOUTS_MODULE.Colour = Color( 255, 130, 0 )

CUFFING_BREAKOUTS_MODULE:Setup( function()
    CUFFING_BREAKOUTS_MODULE:Hook( "GlorifiedHandcuffs.PlayerBrokeFree", "GlorifiedHandcuffs.bLogs.PlayerBrokeFree", function( ply )
        CUFFING_BREAKOUTS_MODULE:LogPhrase( "handcuffs_broken", GAS.Logging:FormatPlayer( ply ) )
    end )
end )

GAS.Logging:AddModule( CUFFING_BREAKOUTS_MODULE )
--[[ End Cuffing Module ]]--