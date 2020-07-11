
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
            ply:ManipulateBoneAngles( ply:LookupBone( k ), v )
        end
    end

    ply:Freeze( surrendering )
    ply:GlorifiedHandcuffs():SetSurrenderingInternal( surrendering )
    ply:SetNWBool( "GlorifiedHandcuffs.Surrendering", surrendering )

    GlorifiedHandcuffs.SetPlayerHasRestrainedWeapon( ply, surrendering )
end

function GlorifiedHandcuffs.IsPlayerSurrendering( ply )
    return ply:GlorifiedHandcuffs():GetSurrenderingInternal()
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
        ply:GlorifiedHandcuffs():SetHandcufferInternal( 0 )
        ply:SetNWInt( "GlorifiedHandcuffs.Handcuffer", 0 )
    end

    ply:Freeze( handcuffed )
    ply:GlorifiedHandcuffs():SetHandcuffedInternal( handcuffed )
    ply:SetNWBool( "GlorifiedHandcuffs.Handcuffed", handcuffed )

    GlorifiedHandcuffs.SetPlayerHasRestrainedWeapon( ply, handcuffed )
end

function GlorifiedHandcuffs.IsPlayerHandcuffed( ply )
    return ply:GlorifiedHandcuffs():GetHandcuffedInternal()
end

function GlorifiedHandcuffs.TogglePlayerHandcuffed( ply )
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( ply, not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) )
end

function GlorifiedHandcuffs.PlayerHandcuffPlayer( ply, handcuffed )
    if GlorifiedHandcuffs.IsPlayerHandcuffed( handcuffed ) then return end
    handcuffed:GlorifiedHandcuffs():SetHandcufferInternal( ply:UserID() )
    handcuffed:SetNWInt( "GlorifiedHandcuffs.Handcuffer", ply:UserID() )
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( handcuffed, true )
end

function GlorifiedHandcuffs.GetPlayerHandcuffer( ply )
    local handcufferID = ply:GlorifiedHandcuffs():GetHandcufferInternal()
    return handcufferID != nil and Player( handcufferID ) or 0
end

function GlorifiedHandcuffs.PlayerUnHandcuffPlayer( ply, handcuffed )
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( handcuffed ) or GlorifiedHandcuffs.GetPlayerHandcuffer( handcuffed ) != ply then return end
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( handcuffed, false )
end

function GlorifiedHandcuffs.JailNearbyPlayers( jailer, jailerNPC )
    local playersJailed = 0
    for k, v in pairs( ents.FindInSphere( jailerNPC:GetPos(), 1000 ) ) do
        if v:IsPlayer() and GlorifiedHandcuffs.IsPlayerHandcuffed( v ) and GlorifiedHandcuffs.GetPlayerHandcuffer( v ) == jailer and GlorifiedHandcuffs.Config.PLAYER_ISPOLICE_CUSTOMFUNC( jailer ) then
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

function GlorifiedHandcuffs.PlayerDragPlayer( ply, handcuffer )
    if not ply or not ply:IsValid() then return end
    GlorifiedHandcuffs.PlayerDragStopped( ply )
    timer.Create( ply:UserID() .. ".GlorifiedHandcuffs.DragTimer", 0.1, 0, function()
        GlorifiedHandcuffs.PlayerDragMove( ply, handcuffer )
    end )
end

function GlorifiedHandcuffs.PlayerDragStopped( ply )
    if not ply or not ply:IsValid() then return end
    timer.Remove( ply:UserID() .. ".GlorifiedHandcuffs.DragTimer" )
end

function GlorifiedHandcuffs.PlayerDragMove( ply, handcuffer )
    local handcufferPos = handcuffer:GetPos()
    local plyPos = ply:GetPos()
    local handcufferAngle = ( handcufferPos - ply:GetShootPos() ):Angle()
    local distanceAmount = plyPos:DistToSqr( handcufferPos )
    if distanceAmount >= ( 100 * 100 ) then
        if distanceAmount >= ( 500 * 500 ) then
            GlorifiedHandcuffs.PlayerDragStopped( ply )
            return
        end
        ply:SetEyeAngles( handcufferAngle + Angle( -35, 0, 0 ) )
        ply:SetVelocity( handcufferPos - plyPos )
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
end

hook.Add( "PlayerSwitchWeapon", "GlorifiedHandcuffs.PlayerMeta.PlayerSwitchWeapon", function( ply, oldWeapon, newWeapon )
    if newWeapon:GetClass() != GlorifiedHandcuffs.Config.HANDS_SWEP_NAME and ( GlorifiedHandcuffs.IsPlayerSurrendering( ply ) or GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) ) then return true end
end )

hook.Add( "PlayerDisconnected", "GlorifiedHandcuffs.PlayerMeta.PlayerDisconnected", function( ply )
    for k, v in pairs( player.GetAll() ) do
        if GlorifiedHandcuffs.IsPlayerHandcuffed( v ) and GlorifiedHandcuffs.GetPlayerHandcuffer( v ) == ply then
            GlorifiedHandcuffs.ResetAllHandcuffVars( v )
        end
    end
end )

hook.Add( "PlayerSpawn", "GlorifiedHandcuffs.PlayerMeta.PlayerSpawn", GlorifiedHandcuffs.ResetAllHandcuffVars )
hook.Add( "PlayerDeath", "GlorifiedHandcuffs.PlayerMeta.PlayerDeath", GlorifiedHandcuffs.ResetAllHandcuffVars )
hook.Add( "playerArrested", "GlorifiedHandcuffs.PlayerMeta.playerArrested", GlorifiedHandcuffs.ResetAllHandcuffVars )
hook.Add( "playerUnArrested", "GlorifiedHandcuffs.PlayerMeta.playerUnArrested", GlorifiedHandcuffs.ResetAllHandcuffVars )

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

function CLASS:SetSurrenderingInternal( surrendering ) self.Surrendering = surrendering return self end
function CLASS:GetSurrenderingInternal() return self.Surrendering end
function CLASS:SetHandcuffedInternal( handcuffed ) self.Handcuffed = handcuffed return self end
function CLASS:GetHandcuffedInternal() return self.Handcuffed end
function CLASS:SetHandcufferInternal( handcuffer ) self.Handcuffer = handcuffer return self end
function CLASS:GetHandcufferInternal() return self.Handcuffer end

concommand.Add( "glorifiedhandcuffs_debug", function( ply )
    GlorifiedHandcuffs.TogglePlayerHandcuffed( ply )
end )