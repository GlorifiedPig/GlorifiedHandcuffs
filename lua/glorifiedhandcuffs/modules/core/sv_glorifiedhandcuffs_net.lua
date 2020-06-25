
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptStarted" )
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptFailed" )
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptSuccess" )

net.Receive( "GlorifiedHandcuffs.BreakFree.AttemptStarted", function( len, ply )
    ply:GlorifiedHandcuffs().BreakFreeAttemptStart = CurTime()
end )

net.Receive( "GlorifiedHandcuffs.BreakFree.AttemptFailed", function( len, ply )
    ply:GlorifiedHandcuffs().BreakFreeAttemptStart = nil
end )

net.Receive( "GlorifiedHandcuffs.BreakFree.AttemptSuccess", function( len, ply )
    if ply:GlorifiedHandcuffs().BreakFreeAttemptStart == nil or CurTime() <= ply:GlorifiedHandcuffs().BreakFreeAttemptStart + ( GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL / 15 ) or not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) then return end
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( ply, false )
    if GlorifiedHandcuffs.Config.BREAK_FREE_WANTED then
        ply:wanted( GlorifiedHandcuffs.GetPlayerHandcuffer( ply ), GlorifiedHandcuffs.i18n.GetPhrase( "brokenFreeWanted" ), 180 )
    end
end )