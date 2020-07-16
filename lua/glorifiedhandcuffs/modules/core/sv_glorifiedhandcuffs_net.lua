
util.AddNetworkString( "GlorifiedHandcuffs.InteractionMenu.OpenInteractionMenu" )
util.AddNetworkString( "GlorifiedHandcuffs.InteractionMenu.StartDraggingPlayer" )
util.AddNetworkString( "GlorifiedHandcuffs.InteractionMenu.TogglePlayerBlindfold" )
util.AddNetworkString( "GlorifiedHandcuffs.InteractionMenu.TogglePlayerGagged" )
util.AddNetworkString( "GlorifiedHandcuffs.InteractionMenu.StripAllWeapons" )
util.AddNetworkString( "GlorifiedHandcuffs.InteractionMenu.StripIllegalWeapons" )
util.AddNetworkString( "GlorifiedHandcuffs.InteractionMenu.StripWeapon" )
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptStarted" )
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptFailed" )
util.AddNetworkString( "GlorifiedHandcuffs.BreakFree.AttemptSuccess" )
util.AddNetworkString( "GlorifiedHandcuffs.Bail.OpenBailMenu" )
util.AddNetworkString( "GlorifiedHandcuffs.Bail.RequestBailout" )

hook.Add( "PlayerUse", "GlorifiedHandcuffs.InteractionMenu.PlayerUse", function( ply, ent )
    if ent:IsPlayer() and GlorifiedHandcuffs.GetPlayerHandcuffer( ent ) == ply and ( not ply:GlorifiedHandcuffs().NextInteractionMenuUse or CurTime() >= ply:GlorifiedHandcuffs().NextInteractionMenuUse ) then
        if ent:GlorifiedHandcuffs().BeingDragged then
            GlorifiedHandcuffs.PlayerDragStopped( ent )
        else
            net.Start( "GlorifiedHandcuffs.InteractionMenu.OpenInteractionMenu" )
            net.WriteEntity( ent )
            net.Send( ply )
        end
        ply:GlorifiedHandcuffs().NextInteractionMenuUse = CurTime() + 0.75
    end
end )

net.Receive( "GlorifiedHandcuffs.InteractionMenu.StartDraggingPlayer", function( len, ply )
    local plyToDrag = net.ReadEntity()
    if GlorifiedHandcuffs.GetPlayerHandcuffer( plyToDrag ) == ply and not plyToDrag:GlorifiedHandcuffs().BeingDragged then
        GlorifiedHandcuffs.PlayerDragPlayer( plyToDrag, ply )
    end
end )

net.Receive( "GlorifiedHandcuffs.InteractionMenu.TogglePlayerBlindfold", function( len, ply )
    local plyToBlindfold = net.ReadEntity()
    if GlorifiedHandcuffs.GetPlayerHandcuffer( plyToBlindfold ) == ply then
        GlorifiedHandcuffs.TogglePlayerBlindfolded( plyToBlindfold )
    end
end )

net.Receive( "GlorifiedHandcuffs.InteractionMenu.TogglePlayerGagged", function( len, ply )
    local plyToGag = net.ReadEntity()
    if GlorifiedHandcuffs.GetPlayerHandcuffer( plyToGag ) == ply then
        GlorifiedHandcuffs.TogglePlayerGagged( plyToGag )
    end
end )

net.Receive( "GlorifiedHandcuffs.InteractionMenu.StripAllWeapons", function( len, ply )
    local plyToStrip = net.ReadEntity()
    if GlorifiedHandcuffs.GetPlayerHandcuffer( plyToStrip ) == ply then
        GlorifiedHandcuffs.StripAllWeapons( plyToStrip, not GlorifiedHandcuffs.IsPlayerPolice( ply ), ply )
    end
end )

net.Receive( "GlorifiedHandcuffs.InteractionMenu.StripIllegalWeapons", function( len, ply )
    local plyToStrip = net.ReadEntity()
    if GlorifiedHandcuffs.GetPlayerHandcuffer( plyToStrip ) == ply then
        GlorifiedHandcuffs.StripAllIllegalWeapons( plyToStrip, not GlorifiedHandcuffs.IsPlayerPolice( ply ), ply )
    end
end )

net.Receive( "GlorifiedHandcuffs.InteractionMenu.StripWeapon", function( len, ply )
    local plyToStrip = net.ReadEntity()
    local weaponToStrip = net.ReadString()
    if GlorifiedHandcuffs.GetPlayerHandcuffer( plyToStrip ) == ply then
        plyToStrip:StripWeapon( weaponToStrip )
        if not GlorifiedHandcuffs.IsPlayerPolice( ply ) then
            ply:Give( weaponToStrip )
        end
    end
end )

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
    if ply:GlorifiedHandcuffs().BreakFreeAttemptStart == nil or CurTime() <= ply:GlorifiedHandcuffs().BreakFreeAttemptStart + ( GlorifiedHandcuffs.Config.BREAK_FREE_TOTAL / 20 ) or not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) or not GlorifiedHandcuffs.Config.BREAK_FREE_ENABLED then return end
    if GlorifiedHandcuffs.Config.BREAK_FREE_WANTED and GlorifiedHandcuffs.IsPlayerPolice( GlorifiedHandcuffs.GetPlayerHandcuffer( ply ) ) then
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