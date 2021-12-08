
local rightUpperArm = "ValveBiped.Bip01_R_UpperArm"
local leftUpperArm = "ValveBiped.Bip01_L_UpperArm"
local rightForeArm = "ValveBiped.Bip01_R_ForeArm"
local leftForeArm = "ValveBiped.Bip01_L_ForeArm"
local rightHand = "ValveBiped.Bip01_R_Hand"
local leftHand = "ValveBiped.Bip01_L_Hand"

local function resetBoneAngles( ply )
    if not ply:GetBoneCount() then return end
    for i = 0, ply:GetBoneCount() do
        ply:ManipulateBonePosition( i, Vector( 0, 0, 0 ) )
        ply:ManipulateBoneAngles( i, Angle( 0, 0, 0 ) )
    end
end

local boneManipPositions = {}
boneManipPositions["surrender"] = {
    [rightUpperArm] = Angle( 45, 0, 90 ),
    [leftUpperArm] = Angle( -45, 0, -90 ),
    [rightForeArm] = Angle( 0, -110, 0 ),
    [leftForeArm] = Angle( 0, -110, 20 )
}

boneManipPositions["handcuffed"] = {
    [rightUpperArm] = Angle( -15, 30, 0 ),
    [leftUpperArm] = Angle( 15, 20, 0 ),
    [rightForeArm] = Angle( -30, -30, 40 ),
    [leftForeArm] = Angle( 30, -30, -40 ),
    [rightHand] = Angle( 0, 0, -120 ),
    [leftHand] = Angle( 0, 0, 90 )
}

function GlorifiedHandcuffs.SetPlayerSurrenderStatus( ply, surrendering )
    if GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) then return end
    resetBoneAngles( ply )

    if surrendering then
        for k, v in pairs( boneManipPositions["surrender"] ) do
            local bone = ply:LookupBone( k )
            if not bone then return end
            ply:ManipulateBoneAngles( ply:LookupBone( k ), v )
        end
    end

    ply:GlorifiedHandcuffs().Surrendering = surrendering
    ply:SetNWBool( "GlorifiedHandcuffs.Surrendering", surrendering )
    hook.Run( "GlorifiedHandcuffs.PlayerSurrenderStatusUpdated", ply, surrendering )

    GlorifiedHandcuffs.SetPlayerHasRestrainedWeapon( ply, surrendering )
end

function GlorifiedHandcuffs.IsPlayerSurrendering( ply )
    return ply:GlorifiedHandcuffs().Surrendering
end

function GlorifiedHandcuffs.TogglePlayerSurrendering( ply )
    GlorifiedHandcuffs.SetPlayerSurrenderStatus( ply, not GlorifiedHandcuffs.IsPlayerSurrendering( ply ) )
end

function GlorifiedHandcuffs.SetPlayerHandcuffedStatus( ply, handcuffed )
    if GlorifiedHandcuffs.IsPlayerSurrendering( ply ) then GlorifiedHandcuffs.SetPlayerSurrenderStatus( ply, false ) end
    GlorifiedHandcuffs.PlayerDragStopped( ply )
    resetBoneAngles( ply )

    if handcuffed then
        for k, v in pairs( boneManipPositions["handcuffed"] ) do
            ply:ManipulateBoneAngles( ply:LookupBone( k ), v )
        end
        ply:EmitSound( GlorifiedHandcuffs.Config.HANDCUFF_SOUND_EFFECT, 100, 255 )
    else
        GlorifiedHandcuffs.SetPlayerBlindfoldedStatus( ply, false )
        GlorifiedHandcuffs.SetPlayerGaggedStatus( ply, false )
        ply:GlorifiedHandcuffs().Handcuffer = 0
        ply:SetNWInt( "GlorifiedHandcuffs.Handcuffer", 0 )
    end

    ply:Freeze( handcuffed )
    ply:GlorifiedHandcuffs().Handcuffed = handcuffed
    ply:SetNWBool( "GlorifiedHandcuffs.Handcuffed", handcuffed )
    hook.Run( "GlorifiedHandcuffs.PlayerHandcuffStatusUpdated", ply, handcuffed )

    GlorifiedHandcuffs.SetPlayerHasRestrainedWeapon( ply, handcuffed )
end

function GlorifiedHandcuffs.IsPlayerHandcuffed( ply )
    return ply:GlorifiedHandcuffs().Handcuffed
end

function GlorifiedHandcuffs.TogglePlayerHandcuffed( ply )
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( ply, not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) )
end

function GlorifiedHandcuffs.SetPlayerBlindfoldedStatus( ply, blindfolded )
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) then return end
    ply:SetNWBool( "GlorifiedHandcuffs.Blindfolded", blindfolded )
    ply:GlorifiedHandcuffs().Blindfolded = blindfolded
end

function GlorifiedHandcuffs.IsPlayerBlindfolded( ply )
    return ply:GlorifiedHandcuffs().Blindfolded
end

function GlorifiedHandcuffs.TogglePlayerBlindfolded( ply )
    GlorifiedHandcuffs.SetPlayerBlindfoldedStatus( ply, not GlorifiedHandcuffs.IsPlayerBlindfolded( ply ) )
end

function GlorifiedHandcuffs.SetPlayerGaggedStatus( ply, gagged )
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) then return end
    ply:SetNWBool( "GlorifiedHandcuffs.Gagged", gagged )
    ply:GlorifiedHandcuffs().Gagged = gagged
end

function GlorifiedHandcuffs.IsPlayerGagged( ply )
    return ply:GlorifiedHandcuffs().Gagged
end

function GlorifiedHandcuffs.TogglePlayerGagged( ply )
    GlorifiedHandcuffs.SetPlayerGaggedStatus( ply, not GlorifiedHandcuffs.IsPlayerGagged( ply ) )
end

function GlorifiedHandcuffs.PlayerHandcuffPlayer( ply, handcuffed )
    if GlorifiedHandcuffs.IsPlayerHandcuffed( handcuffed ) or GlorifiedHandcuffs.Config.PLAYERMODEL_WHITELIST[ply:GetModel()] or GlorifiedHandcuffs.Config.TEAM_WHITELIST[handcuffed:Team()] or ( GlorifiedHandcuffs.Config.ONLY_ALLOW_HANDCUFF_IF_PLAYER_WANTED and not GlorifiedHandcuffs.IsPlayerWanted( ply ) ) then return end

    handcuffed:GlorifiedHandcuffs().Handcuffer = ply:UserID()
    handcuffed:SetNWInt( "GlorifiedHandcuffs.Handcuffer", ply:UserID() )
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( handcuffed, true )
    hook.Run( "GlorifiedHandcuffs.PlayerHandcuffPlayer", ply, handcuffed )
end

function GlorifiedHandcuffs.PlayerUnHandcuffPlayer( ply, handcuffed )
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( handcuffed ) or ( GlorifiedHandcuffs.GetPlayerHandcuffer( handcuffed ) != ply and not ( GlorifiedHandcuffs.Config.CAN_ANY_COP_RELEASE_HANDCUFFS and GlorifiedHandcuffs.IsPlayerPolice( ply ) ) ) then return end
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( handcuffed, false )
    hook.Run( "GlorifiedHandcuffs.PlayerUnHandcuffPlayer", ply, handcuffed )
end

function GlorifiedHandcuffs.GetPlayerHandcuffer( ply )
    local handcufferID = ply:GlorifiedHandcuffs().Handcuffer
    return handcufferID != nil and Player( handcufferID ) or 0
end

function GlorifiedHandcuffs.JailNearbyPlayers( jailer, jailerNPC )
    local playersJailed = 0
    for _, v in ipairs( ents.FindInSphere( jailerNPC:GetPos(), 1000 ) ) do
        if v:IsPlayer() and GlorifiedHandcuffs.IsPlayerHandcuffed( v ) and GlorifiedHandcuffs.GetPlayerHandcuffer( v ) == jailer and GlorifiedHandcuffs.IsPlayerPolice( jailer ) then
            playersJailed = playersJailed + 1
            GlorifiedHandcuffs.ArrestPlayer( v, GlorifiedHandcuffs.Config.JAILER_ARREST_TIME, jailer )
        end
    end

    if playersJailed > 0 then
        local arrestReward = playersJailed * GlorifiedHandcuffs.Config.JAILER_ARREST_REWARD
        GlorifiedHandcuffs.Notify( jailer, NOTIFY_GENERIC, 5, GlorifiedHandcuffs.i18n.GetPhrase( "playersJailed", playersJailed, GlorifiedHandcuffs.FormatMoney( arrestReward ) ) )
        GlorifiedHandcuffs.AddPlayerMoney( jailer, arrestReward )
    end
end

function GlorifiedHandcuffs.StripAllWeapons( ply, giveToPly, plyToGiveTo )
    for _, v in ipairs( ply:GetWeapons() ) do
        local weaponClass = v:GetClass()
        if not GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST and GlorifiedHandcuffs.Config.WEAPON_BLACKLIST[weaponClass] then continue end
        if GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST and not GlorifiedHandcuffs.Config.WEAPON_BLACKLIST[weaponClass] then continue end
        if ply.getJobTable and table.HasValue( ply:getJobTable().weapons or {}, weaponClass ) then continue end -- I need to table.HasValue here because of the retarded way DarkRP sets up the loadout.
        ply:StripWeapon( weaponClass )
        if giveToPly and plyToGiveTo then
            plyToGiveTo:Give( weaponClass )
        end
    end
end

function GlorifiedHandcuffs.StripAllIllegalWeapons( ply, giveToPly, plyToGiveTo )
    for _, v in ipairs( ply:GetWeapons() ) do
        local weaponClass = v:GetClass()
        if not GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST and GlorifiedHandcuffs.Config.WEAPON_BLACKLIST[weaponClass] then continue end
        if GlorifiedHandcuffs.Config.WEAPON_BLACKLIST_IS_WHITELIST and not GlorifiedHandcuffs.Config.WEAPON_BLACKLIST[weaponClass] then continue end
        if GlorifiedHandcuffs.Config.LEGAL_WEAPONS[weaponClass] and GlorifiedHandcuffs.HasGunLicense( ply ) then continue end
        if ply.getJobTable and table.HasValue( ply:getJobTable().weapons or {}, weaponClass ) then continue end -- I need to table.HasValue here because of the retarded way DarkRP sets up the loadout.
        ply:StripWeapon( weaponClass )
        if giveToPly and plyToGiveTo then
            plyToGiveTo:Give( weaponClass )
        end
    end
end

function GlorifiedHandcuffs.PlayerDragPlayer( ply, dragger )
    if not ply or not ply:IsValid() or ply:GlorifiedHandcuffs().BeingDragged then return end
    GlorifiedHandcuffs.PlayerDragStopped( ply )
    ply:GlorifiedHandcuffs().BeingDragged = true
    timer.Create( ply:UserID() .. ".GlorifiedHandcuffs.DragTimer", 0.1, 0, function()
        GlorifiedHandcuffs.PlayerDragMove( ply, dragger )
    end )
end

function GlorifiedHandcuffs.PlayerDragStopped( ply )
    if not ply or not ply:IsValid() then return end
    ply:GlorifiedHandcuffs().BeingDragged = false
    timer.Remove( ply:UserID() .. ".GlorifiedHandcuffs.DragTimer" )
end

function GlorifiedHandcuffs.InsertPlayerIntoVehicle( ply, vehicle, cuffer )
    if cuffer:GlorifiedHandcuffs().RecentlyInsertedPlayer then return end
    cuffer:GlorifiedHandcuffs().RecentlyInsertedPlayer = true
    timer.Simple( 5, function()
        if cuffer then cuffer:GlorifiedHandcuffs().RecentlyInsertedPlayer = false end
    end )
    local availableSeats = vehicle.VC_getSeatsAvailable and vehicle:VC_getSeatsAvailable() or 0
    if #availableSeats <= 1 then return end
    for k, v in pairs( availableSeats ) do
        if not v:GetDriver():IsValid() and k != 1 then
            ply:EnterVehicle( v )
            ply:Freeze( true )
            return
        end
    end
end

function GlorifiedHandcuffs.RemovePlayerFromVehicle( ply )
    local cuffer = GlorifiedHandcuffs.GetPlayerHandcuffer( ply )
    cuffer:GlorifiedHandcuffs().RecentlyInsertedPlayer = false
    ply:ExitVehicle()
    ply:Freeze( false )
end

local function clampVector( vector, min, max )
    return Vector( math.Clamp( vector.x, min, max ), math.Clamp( vector.y, min, max ), math.Clamp( vector.z, min, max ) )
end

function GlorifiedHandcuffs.PlayerDragMove( ply, dragger )
    local draggerPos = dragger:GetPos()
    local plyPos = ply:GetPos()

    local distanceAmount = plyPos:DistToSqr( draggerPos )
    if distanceAmount >= ( 100 * 100 ) then
        local dragSpeedLimit = GlorifiedHandcuffs.Config.DRAG_DISTANCE_LIMIT and GlorifiedHandcuffs.Config.DRAG_DISTANCE_LIMIT_COUNT or 0
        if distanceAmount >= ( dragSpeedLimit * dragSpeedLimit ) then
            GlorifiedHandcuffs.PlayerDragStopped( ply )
            return
        end

        ply:SetVelocity( clampVector( draggerPos - plyPos, -GlorifiedHandcuffs.Config.DRAG_SPEED_COUNT or -100, GlorifiedHandcuffs.Config.DRAG_SPEED_COUNT or 100 ) )
    end
end

function GlorifiedHandcuffs.SetPlayerHasRestrainedWeapon( ply, hasWeapon )
    if hasWeapon then
        ply:Give( GlorifiedHandcuffs.Config.HANDS_SWEP_NAME )
        ply:SelectWeapon( GlorifiedHandcuffs.Config.HANDS_SWEP_NAME )
    else
        ply:StripWeapon( GlorifiedHandcuffs.Config.HANDS_SWEP_NAME )
    end
end

function GlorifiedHandcuffs.ResetAllHandcuffVars( ply )
    resetBoneAngles( ply )
    GlorifiedHandcuffs.SetPlayerSurrenderStatus( ply, false )
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( ply, false )
    GlorifiedHandcuffs.PlayerDragStopped( ply )
    GlorifiedHandcuffs.SetPlayerHasRestrainedWeapon( ply, false )
    GlorifiedHandcuffs.SetPlayerBlindfoldedStatus( ply, false )
    GlorifiedHandcuffs.SetPlayerGaggedStatus( ply, false )
end

hook.Add( "PlayerSwitchWeapon", "GlorifiedHandcuffs.PlayerMeta.PlayerSwitchWeapon", function( ply, oldWeapon, newWeapon )
    if newWeapon:GetClass() != GlorifiedHandcuffs.Config.HANDS_SWEP_NAME and ( GlorifiedHandcuffs.IsPlayerSurrendering( ply ) or GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) ) then return true end
end )

hook.Add( "PlayerCanHearPlayersVoice", "GlorifiedHandcuffs.PlayerMeta.PlayerCanHearPlayersVoice", function( listener, ply )
    if GlorifiedHandcuffs.IsPlayerGagged( ply ) then return false end
end )

hook.Add( "CanPlayerSuicide", "GlorifiedHandcuffs.PlayerMeta.CanPlayerSuicide", function( ply )
    if GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) or GlorifiedHandcuffs.IsPlayerSurrendering( ply ) then return false end
end )

hook.Add( "SetupMove", "GlorifiedHandcuffs.PlayerMeta.SetupMove", function( ply, mv )
    if GlorifiedHandcuffs.IsPlayerSurrendering( ply ) then
        mv:SetMaxClientSpeed( 100 )
    end
end )

hook.Add( GlorifiedHandcuffs.PlayerArrestedHook, "GlorifiedHandcuffs.PlayerMeta.PlayerArrested", function( ply )
    if GlorifiedHandcuffs.Config.TEAM_CHANGE_UPON_JAIL and not ply:GlorifiedHandcuffs().OldArrestTeam then
        ply:GlorifiedHandcuffs().OldArrestTeam = ply:Team()
        GlorifiedHandcuffs.SetPlayerTeam( ply, GlorifiedHandcuffs.Config.TEAM_CHANGE_UPON_JAIL_TEAM )
    end
end )

hook.Add( GlorifiedHandcuffs.PlayerUnArrestedHook, "GlorifiedHandcuffs.PlayerMeta.PlayerUnArrested", function( ply )
    if GlorifiedHandcuffs.Config.TEAM_CHANGE_UPON_JAIL and ply:GlorifiedHandcuffs().OldArrestTeam then
        GlorifiedHandcuffs.SetPlayerTeam( ply, ply:GlorifiedHandcuffs().OldArrestTeam )
        ply:GlorifiedHandcuffs().OldArrestTeam = nil
    end
end )

hook.Add( "PlayerDisconnected", "GlorifiedHandcuffs.PlayerMeta.PlayerDisconnected", function( ply )
    for _, v in ipairs( player.GetAll() ) do
        if GlorifiedHandcuffs.IsPlayerHandcuffed( v ) and GlorifiedHandcuffs.GetPlayerHandcuffer( v ) == ply then
            GlorifiedHandcuffs.ResetAllHandcuffVars( v )
        end
    end
end )

hook.Add( "CanPlayerEnterVehicle", "GlorifiedHandcuffs.PlayerMeta.CanPlayerEnterVehicle", function( ply, vehicle )
    local vehiclePassengers = vehicle.VC_getPlayers and vehicle:VC_getPlayers() or {}
    local playersRemoved = false
    for _, v in ipairs( vehiclePassengers ) do
        if GlorifiedHandcuffs.IsPlayerHandcuffed( v ) and GlorifiedHandcuffs.GetPlayerHandcuffer( v ) == ply then playersRemoved = true GlorifiedHandcuffs.RemovePlayerFromVehicle( v ) end
    end

    if playersRemoved then return false end

    local handcuffed
    for _, v in ipairs( player.GetAll() ) do
        if GlorifiedHandcuffs.IsPlayerHandcuffed( v ) and GlorifiedHandcuffs.GetPlayerHandcuffer( v ) == ply then handcuffed = v break end
    end
    if not handcuffed then return end
    GlorifiedHandcuffs.InsertPlayerIntoVehicle( handcuffed, vehicle, ply )
    return false
end )

hook.Add( "PlayerSpawnProp", "GlorifiedHandcuffs.PlayerMeta.PlayerSpawnProp", function( ply, mdl )
    if IsValid( ply ) and GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) then
        return false
    end
end )

for _, v in ipairs( GlorifiedHandcuffs.ClearHandcuffVarsHooks ) do
    hook.Add( v, "GlorifiedHandcuffs.PlayerMeta." .. v, GlorifiedHandcuffs.ResetAllHandcuffVars )
end

local plyMeta = FindMetaTable( "Player" )

local CLASS = {}
CLASS.__index = CLASS

AccessorFunc( CLASS, "m_player", "Player" )

function plyMeta:GlorifiedHandcuffs()
    if not self.GlorifiedHandcuffs_Internal then
        self.GlorifiedHandcuffs_Internal = table.Copy( CLASS )
        self.GlorifiedHandcuffs_Internal:SetPlayer( self )
    end

    return self.GlorifiedHandcuffs_Internal
end

function CLASS:SetSurrenderStatus( surrendering )
    GlorifiedHandcuffs.SetPlayerSurrenderStatus( self, surrendering )
end

function CLASS:IsSurrendering()
    return GlorifiedHandcuffs.IsPlayerSurrendering( self )
end

function CLASS:ToggleSurrendering()
    GlorifiedHandcuffs.TogglePlayerSurrendering( self )
end

function CLASS:SetHandcuffedStatus( handcuffed )
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( self, handcuffed )
end

function CLASS:IsHandcuffed()
    return GlorifiedHandcuffs.IsPlayerHandcuffed( self )
end

function CLASS:ToggleHandcuffed()
    GlorifiedHandcuffs.TogglePlayerHandcuffed( self )
end

function CLASS:GetHandcuffer()
    return GlorifiedHandcuffs.GetPlayerHandcuffer( self )
end

function CLASS:StripAllIllegalWeapons()
    GlorifiedHandcuffs.StripAllIllegalWeapons( self )
end