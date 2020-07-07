
AddCSLuaFile()

SWEP.PrintName = "Restrained"
SWEP.Category = "GlorifiedHandcuffs"
SWEP.Author = "GlorifiedPig"
SWEP.Instructions = "You are restrained and unable to move."

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
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1

SWEP.ViewModel = Model( "models/sterling/glorified_c_handcuffs.mdl" )
SWEP.WorldModel = ""
SWEP.UseHands = true
SWEP.ViewModelFOV = 85

SWEP.DrawCrosshair = false

function SWEP:Initialize()
    self:SetHoldType( "normal" )
end

function SWEP:Deploy()
    local ply = self:GetOwner()
    if CLIENT or not IsValid( ply ) then return true end
    ply:DrawWorldModel( false )
    if GlorifiedHandcuffs.IsPlayerHandcuffed( ply ) then
        self:SendWeaponAnim( ACT_VM_HOLSTER )
    else
        self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
    end
    return false
end

function SWEP:PrimaryAttack() end
function SWEP:SecondaryAttack() end