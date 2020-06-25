
function GlorifiedHandcuffs.IsPlayerSurrendering( ply )
    return ply:GetNWBool( "GlorifiedHandcuffs.Surrendering" )
end

function GlorifiedHandcuffs.IsPlayerHandcuffed( ply )
    return ply:GetNWBool( "GlorifiedHandcuffs.Handcuffed" )
end

function GlorifiedHandcuffs.GetPlayerHandcuffer( ply )
    local handcufferID = ply:GetNW2Int( "GlorifiedHandcuffs.Handcuffer" )
    return handcufferID == 0 and nil or Player( ply:GetNWInt( "GlorifiedHandcuffs.Handcuffer" ) )
end