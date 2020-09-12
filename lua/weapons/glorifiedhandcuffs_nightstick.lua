
AddCSLuaFile()

SWEP.PrintName = "Nightstick"
SWEP.Category = "GlorifiedHandcuffs"
SWEP.Author = "GlorifiedPig"
SWEP.Instructions = "Left click to stun player."

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

SWEP.ViewModel = Model( "models/weapons/v_stunbaton.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_stunbaton.mdl" )
SWEP.UseHands = true
SWEP.ViewModelFOV = 85

SWEP.DrawCrosshair = false

function SWEP:Initialize()
    self:SetHoldType( "Melee" )
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire( CurTime() + 0.45 )
    local traceResult = {
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * GlorifiedHandcuffs.Config.NIGHTSTICK_STUN_PUSH_DISTANCE,
        mins = Vector( -5, -5, -5 ),
        maxs = Vector( 5, 5, 5 ),
        filter = self.Owner
    }
    self:GetOwner():LagCompensation( true )
    traceResult = util.TraceHull( traceResult )
    self:GetOwner():LagCompensation( false )

    if traceResult.Hit then
        local trEntity = traceResult.Entity
        self:SendWeaponAnim( ACT_VM_HITCENTER )
        local soundToEmit = "physics/concrete/concrete_impact_hard" .. math.random( 1, 3 ) .. ".wav"

        if trEntity:IsPlayer() then
            soundToEmit = "physics/body/body_medium_impact_hard" .. math.random( 1, 4 ) .. ".wav"
            if not trEntity:IsFrozen() then
                trEntity:Freeze( true )
                timer.Simple( GlorifiedHandcuffs.Config.NIGHTSTICK_STUN_TIME, function()
                    if trEntity and trEntity:IsValid() and trEntity:IsPlayer() and not GlorifiedHandcuffs.IsPlayerHandcuffed( trEntity ) then
                        trEntity:Freeze( false )
                    end
                end )
            end
        end

        timer.Simple( 0.12, function()
            if not self or not trEntity or not trEntity:IsValid() then return end
            if trEntity:IsPlayer() then
                trEntity:SetVelocity( ( trEntity:GetPos() - self:GetOwner():GetPos() ) * 5 )
            end
            self:EmitSound( soundToEmit )
            hook.Run( "GlorifiedHandcuffs.BatonUsed", self:GetOwner(), trEntity )
        end )
    else
        self:EmitSound( "Weapon_Stunstick.Melee_Miss" )
        self:SendWeaponAnim( ACT_VM_MISSCENTER )
    end
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

function SWEP:SecondaryAttack() end