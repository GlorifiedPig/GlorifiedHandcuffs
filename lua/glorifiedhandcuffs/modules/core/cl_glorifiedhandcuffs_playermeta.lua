
function GlorifiedHandcuffs.IsPlayerSurrendering( ply )
    return ply:GetNWBool( "GlorifiedHandcuffs.Surrendering" )
end

function GlorifiedHandcuffs.IsPlayerHandcuffed( ply )
    return ply:GetNWBool( "GlorifiedHandcuffs.Handcuffed" )
end

function GlorifiedHandcuffs.IsPlayerBlindfolded( ply )
    return ply:GetNWBool( "GlorifiedHandcuffs.Blindfolded" )
end

function GlorifiedHandcuffs.IsPlayerGagged( ply )
    return ply:GetNWBool( "GlorifiedHandcuffs.Gagged" )
end

function GlorifiedHandcuffs.GetPlayerHandcuffer( ply )
    local handcufferID = ply:GetNW2Int( "GlorifiedHandcuffs.Handcuffer" )
    return handcufferID == 0 and nil or Player( ply:GetNWInt( "GlorifiedHandcuffs.Handcuffer" ) )
end

hook.Add( "SetupMove", "GlorifiedHandcuffs.PlayerMeta.SetupMove", function( ply, mv )
    if GlorifiedHandcuffs.IsPlayerSurrendering( ply ) then
        mv:SetMaxClientSpeed( 100 )
    end
end )