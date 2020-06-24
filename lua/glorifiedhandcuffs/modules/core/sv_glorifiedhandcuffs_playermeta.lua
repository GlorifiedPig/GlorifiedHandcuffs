
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

function GlorifiedHandcuffs.SetPlayerSurrenderStatus( ply, shouldSurrender )
    ply.GHSurrendering = shouldSurrender
    resetBoneAngles( ply )

    if shouldSurrender then
        ply.GHWasFrozen = ply:IsFrozen()
        ply:SelectWeapon( GlorifiedHandcuffs.Config.HANDS_SWEP_NAME )
        ply:Freeze( true )
        for k, v in pairs( boneManipPositions["surrender"] ) do
            ply:ManipulateBoneAngles( ply:LookupBone( k ), v )
        end
    else
        ply.GHSurrendering = false
        resetBoneAngles( ply )
        ply:Freeze( ply.GHWasFrozen or false )
    end
end

function GlorifiedHandcuffs.IsPlayerSurrendering( ply )
    return ply.GHSurrendering
end

function GlorifiedHandcuffs.ToggleSurrenderPlayer( ply )
    GlorifiedHandcuffs.SetPlayerSurrenderStatus( ply, not GlorifiedHandcuffs.IsPlayerSurrendering( ply ) )
end

concommand.Add( "glorifiedhandcuffs_debug", function( ply )
    GlorifiedHandcuffs.ToggleSurrenderPlayer( ply )
end)