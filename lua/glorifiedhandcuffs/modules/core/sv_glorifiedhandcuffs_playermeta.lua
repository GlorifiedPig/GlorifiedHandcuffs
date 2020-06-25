
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
        ply:SelectWeapon( GlorifiedHandcuffs.Config.HANDS_SWEP_NAME )
        for k, v in pairs( boneManipPositions["surrender"] ) do
            ply:ManipulateBoneAngles( ply:LookupBone( k ), v )
        end
    end
    ply:Freeze( surrendering )
    ply:GlorifiedHandcuffs():SetSurrenderingInternal( surrendering )
    ply:SetNWBool( "GlorifiedHandcuffs.Surrendering", surrendering )
end

function GlorifiedHandcuffs.IsPlayerSurrendering( ply )
    return ply:GlorifiedHandcuffs():GetSurrenderingInternal()
end

function GlorifiedHandcuffs.TogglePlayerSurrendering( ply )
    GlorifiedHandcuffs.SetPlayerSurrenderStatus( ply, not GlorifiedHandcuffs.IsPlayerSurrendering( ply ) )
end

function GlorifiedHandcuffs.SetPlayerHandcuffedStatus( ply, handcuffed )
    if GlorifiedHandcuffs.IsPlayerSurrendering( ply ) then GlorifiedHandcuffs.SetPlayerSurrenderStatus( ply, false ) end
    resetBoneAngles( ply )

    if handcuffed then
        ply:SelectWeapon( GlorifiedHandcuffs.Config.HANDS_SWEP_NAME )
        for k, v in pairs( boneManipPositions["handcuffed"] ) do
            ply:ManipulateBoneAngles( ply:LookupBone( k ), v )
        end
    else
        ply:GlorifiedHandcuffs():SetHandcufferInternal( nil )
        ply:SetNWInt( "GlorifiedHandcuffs.Handcuffer", 0 )
    end
    ply:Freeze( handcuffed )
    ply:GlorifiedHandcuffs():SetHandcuffedInternal( handcuffed )
    ply:SetNWBool( "GlorifiedHandcuffs.Handcuffed", handcuffed )

    ply:EmitSound( GlorifiedHandcuffs.Config.HANDCUFF_SOUND_EFFECT, 100, 255 )
end

function GlorifiedHandcuffs.IsPlayerHandcuffed( ply )
    return ply:GlorifiedHandcuffs():GetHandcuffedInternal()
end

function GlorifiedHandcuffs.TogglePlayerHandcuffed( ply )
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( ply, not GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) )
end

function GlorifiedHandcuffs.PlayerHandcuffPlayer( ply, handcuffed )
    if GlorifiedHandcuffs.IsPlayerHandcuffed( handcuffed ) then return end
    handcuffed:SetNWInt( "GlorifiedHandcuffs.Handcuffer", ply:UserID() )
    handcuffed:GlorifiedHandcuffs():SetHandcufferInternal( ply )
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( handcuffed, true )
end

function GlorifiedHandcuffs.GetPlayerHandcuffer( ply )
    return ply:GlorifiedHandcuffs():GetHandcufferInternal()
end

function GlorifiedHandcuffs.PlayerUnHandcuffPlayer( ply, handcuffed )
    if not GlorifiedHandcuffs.IsPlayerHandcuffed( handcuffed ) or GlorifiedHandcuffs.GetPlayerHandcuffer( handcuffed ) != ply then return end
    GlorifiedHandcuffs.SetPlayerHandcuffedStatus( handcuffed, false )
end

hook.Add( "PlayerSwitchWeapon", "GlorifiedHandcuffs.PlayerMeta.PlayerSwitchWeapon", function( ply )
    if GlorifiedHandcuffs.IsPlayerSurrendering( ply ) or GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) then return true end
end )

hook.Add( "PlayerDisconnected", "GlorifiedHandcuffs.PlayerMeta.PlayerDisconnected", function( ply )
    for k, v in pairs( player.GetAll() ) do
        if GlorifiedHandcuffs.IsPlayerHandcuffed( v ) and GlorifiedHandcuffs.GetPlayerHandcuffer( v ) == ply then
            GlorifiedHandcuffs.SetPlayerHandcuffedStatus( v, false )
        end
    end
end )

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