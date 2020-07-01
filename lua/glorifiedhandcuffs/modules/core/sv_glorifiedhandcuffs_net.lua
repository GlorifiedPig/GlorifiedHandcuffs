
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptStarted" )
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptFailed" )
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptSuccess" )
util.AddNetworkString( "GlorifiedHandcuffs.Bail.OpenBailMenu" )
util.AddNetworkString( "GlorifiedHandcuffs.Bail.RequestBailout" )

net.Receive( "GlorifiedHandcuffs.BreakFree.AttemptStarted", function( len, ply )
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) or not GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED then return end
    ply:GlorifiedHandcuffs().BreakFreeAttemptStart = CurTime()
end )

net.Receive( "GlorifiedHandcuffs.BreakFree.AttemptFailed", function( len, ply )
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) or not GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED then return end
    ply:GlorifiedHandcuffs().BreakFreeAttemptStart = nil
    if not GlorifiedHandcuffs.Config.BREAK_FREE_SOUND_ON_FAILURE then return end
    if ply:GlorifiedHandcuffs().BreakFreeLastAttemptFailed == nil or CurTime() >= ply:GlorifiedHandcuffs().BreakFreeLastAttemptFailed + 5 then
        ply:EmitSound( GlorifiedHandcuffs.Config.BREAK_FREE_SOUND_ON_FAILURE_PATH )
        ply:GlorifiedHandcuffs().BreakFreeLastAttemptFailed = CurTime()
    end
end )

net.Receive( "GlorifiedHandcuffs.BreakFree.AttemptSuccess", function( len, ply )
    if ply:GlorifiedHandcuffs().BreakFreeAttemptStart == nil or CurTime() <= ply:GlorifiedHandcuffs().BreakFreeAttemptStart + ( GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL / 15 ) or not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) or not GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED then return end
    if GlorifiedHandcuffs.Config.BREAK_FREE_WANTED and GlorifiedHandcuffs.Config.PLAYER_ISPOLICE_CUSTOMFUNC( GlorifiedHandcuffs.GetPlayerHandcuffer( ply ) ) then
        ply:wanted( GlorifiedHandcuffs.GetPlayerHandcuffer( ply ), GlorifiedHandcuffs.i18n.GetPhrase( "brokenFreeWanted" ), 180 )
    end
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( ply, false )
end )

function GlorifiedHandcuffs.OpenBailMenu( ply )
    net.Start( "GlorifiedHandcuffs.Bail.OpenBailMenu" )
    net.Send( ply )
end

net.Receive( "GlorifiedHandcuffs.Bail.RequestBailout", function( len, ply )
    local bailoutPlayer = net.ReadEntity()
    if GlorifiedHandcuffs.CanPlayerAfford( ply, GlorifiedHandcuffs.Config.BAIL_AMOUNT ) and GlorifiedHandcuffs.IsPlayerArrested( bailoutPlayer ) then
        GlorifiedHandcuffs.UnArrestPlayer( bailoutPlayer )
        GlorifiedHandcuffs.AddPlayerMoney( ply, -GlorifiedHandcuffs.Config.BAIL_AMOUNT )
    end
end )