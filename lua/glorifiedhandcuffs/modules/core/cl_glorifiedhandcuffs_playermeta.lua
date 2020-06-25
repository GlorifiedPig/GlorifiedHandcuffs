
function GlorifiedHandcuffs.IsPlayerSurrendering( ply )
    return ply:GetNW2Bool( "GlorifiedHandcuffs.Surrendering" )
end

function GlorifiedHandcuffs.IsPlayerHandcuffed( ply )
    return ply:GetNW2Bool( "GlorifiedHandcuffs.Handcuffed" )
end

function GlorifiedHandcuffs.GetPlayerHandcuffer( ply )
    local handcufferID = ply:GetNW2Int( "GlorifiedHandcuffs.Handcuffer" )
    return handcufferID == 0 and nil or Player( ply:GetNW2Int( "GlorifiedHandcuffs.Handcuffer" ) )
end