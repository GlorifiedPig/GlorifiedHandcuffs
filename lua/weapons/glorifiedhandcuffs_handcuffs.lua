
SWEP.PrintName = "Handcuffs"
SWEP.Category = "GlorifiedHandcuffs"
SWEP.Author = "GlorifiedPig"
SWEP.Instructions = "Left click to handcuff player. Right click to unhandcuff player. Click E on handcuffed player to interact."

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 6
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false

SWEP.UseHands = true
SWEP.WorldModel = ""

function SWEP:Initialize()
    self:SetHoldType( "normal" )
end

function SWEP:Deploy()
    if CLIENT or not IsValid( self:GetOwner() ) then return true end
    self:GetOwner():DrawWorldModel( false )
    return true
end

function SWEP:SecondaryAttack() end

if CLIENT then return end

function SWEP:PrimaryAttack()
    local ply = self:GetOwner()

    local tr = ply:GetEyeTraceNoCursor()
    if not tr.Hit then return end

    local maxDist = GlorifiedHandcuffs.Config.HANDCUFF_DISTANCE
    if tr.HitPos:DistToSqr( ply:GetPos() ) > maxDist * maxDist then return end
    if not tr.Entity:IsPlayer() then return end

    if not GlorifiedHandcuffs.Config.PLAYER_ISPOLICE_CUSTOMFUNC( ply ) and not GlorifiedHandcuffs.Config.CAN_NORMAL_PLAYER_HANDCUFF_WITHOUT_SURRENDER and not GlorifiedHandcuffs.IsPlayerSurrendering( tr.Entity ) then return end

    timer.Remove( ply:UserID() .. ".GlorifiedHandcuffs.CuffTimer" )
    timer.Create( ply:UserID() .. ".GlorifiedHandcuffs.CuffTimer", GlorifiedHandcuffs.Config.TIME_TO_CUFF, 1, function()
        if ply:Alive() and tr.Entity:Alive() and ply:GetPos():DistToSqr( tr.Entity:GetPos() ) <= maxDist * maxDist then
            GlorifiedHandcuffs.PlayerHandcuffPlayer( ply, tr.Entity )
        end
    end )
end

function SWEP:SecondaryAttack()
    local ply = self:GetOwner()

    local tr = ply:GetEyeTraceNoCursor()
    if not tr.Hit then return end

    local maxDist = GlorifiedHandcuffs.Config.HANDCUFF_DISTANCE
    if tr.HitPos:DistToSqr( ply:GetPos() ) > maxDist * maxDist then return end
    if not tr.Entity:IsPlayer() then return end

    GlorifiedHandcuffs.PlayerUnHandcuffPlayer( ply, tr.Entity )
end