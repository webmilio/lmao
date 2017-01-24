--[[
	Author: Noya
	Date: 14.01.2015.
	Applies a Lifesteal modifier if the attacked target is not a building and not a mechanical unit
]]

function VampiricAuraShare( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local ability_level = ability:GetLevel() - 1
	
	local playerID = target:GetPlayerOwnerID()
	local duration = 5
	local modifier = event.modifier
	
	if playerID then
		ability:ApplyDataDrivenModifier(caster, target, modifier, { Duration = duration } )
	end
end

function VampiricAuraApply( event )
	-- Variables
	local attacker = event.attacker
	local target = event.target
	local ability = event.ability

	if target.GetInvulnCount == nil and not target:IsMechanical() then
		ability:ApplyDataDrivenModifier(attacker, attacker, "modifier_vampiric_aura_lifesteal", {duration = 0.03})
	end
end