
AddCSLuaFile()

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

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Weight = 6
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1

SWEP.ViewModel = Model( "models/sterling/glorified_c_handcuffs.mdl" )
SWEP.WorldModel = "models/sterling/glorified_w_handcuffs.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 85

SWEP.DrawCrosshair = false

function SWEP:Initialize()
    self:SetHoldType( "pistol" )
end

function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end

if CLIENT then return end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire( CurTime() + GlorifiedHandcuffs.Config.TIME_TO_CUFF )
    local ply = self:GetOwner()

    self:GetOwner():LagCompensation( true )
    local tr = ply:GetEyeTraceNoCursor()
    self:GetOwner():LagCompensation( false )
    if not tr.Hit then return end

    local maxDist = GlorifiedHandcuffs.Config.HANDCUFF_DISTANCE
    if tr.HitPos:DistToSqr( ply:GetPos() ) > maxDist * maxDist then return end
    if not tr.Entity:IsPlayer() then return end

    if GlorifiedHandcuffs.IsPlayerHandcuffed( tr.Entity ) then return end
    if not GlorifiedHandcuffs.IsPlayerPolice( ply ) and not GlorifiedHandcuffs.Config.CAN_NORMAL_PLAYER_HANDCUFF_WITHOUT_SURRENDER and not GlorifiedHandcuffs.IsPlayerSurrendering( tr.Entity ) and not GlorifiedHandcuffs.Config.JAIL_ONLY_MODE or ( GlorifiedHandcuffs.Config.JAIL_ONLY_MODE and not GlorifiedHandcuffs.IsPlayerPolice( ply ) ) then return end

    self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

    timer.Simple( 1, function()
        if not self or not self:IsValid() then return end
        self:SendWeaponAnim( ACT_VM_IDLE )
    end )

    timer.Remove( ply:UserID() .. ".GlorifiedHandcuffs.CuffTimer" )
    timer.Create( ply:UserID() .. ".GlorifiedHandcuffs.CuffTimer", GlorifiedHandcuffs.Config.TIME_TO_CUFF, 1, function()
        if ply and tr.Entity and ply:Alive() and tr.Entity:Alive() and ply:GetPos():DistToSqr( tr.Entity:GetPos() ) <= maxDist * maxDist then
            if GlorifiedHandcuffs.Config.JAIL_ONLY_MODE then
                GlorifiedHandcuffs.ArrestPlayer( tr.Entity, GlorifiedHandcuffs.Config.JAILER_ARREST_TIME, ply )
            else
                GlorifiedHandcuffs.PlayerHandcuffPlayer( ply, tr.Entity )
            end
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

    if GlorifiedHandcuffs.Config.JAIL_ONLY_MODE then
        if not GlorifiedHandcuffs.IsPlayerPolice( ply ) then return end
        GlorifiedHandcuffs.UnArrestPlayer( tr.Entity )
    else
        GlorifiedHandcuffs.PlayerUnHandcuffPlayer( ply, tr.Entity )
    end
end