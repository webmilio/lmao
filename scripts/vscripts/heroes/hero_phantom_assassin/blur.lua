function Blur( keys )
	local caster = keys.caster
	local ability = keys.ability
	local modifier = keys.modifier
	local casterLocation = caster:GetAbsOrigin()
	local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1)
	local enemyHeroes = FindUnitsInRadius(caster:GetTeam(), casterLocation, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, 0, 0, false)

	if #enemyHeroes == 0 then
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	elseif caster:HasModifier(modifier) then
		caster:RemoveModifierByName(modifier)
	end
end

function EvasionStack( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local modifier = keys.modifier
	local current_stacks = caster:GetModifierStackCount(modifier, caster)
	local max_stack_count = ability:GetLevelSpecialValueFor("max_stack_count", ability:GetLevel() - 1)

	if target:IsHero() and target:GetTeamNumber() ~= caster:GetTeamNumber() then
		if not caster:HasModifier(modifier) then
			ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
			caster:SetModifierStackCount(modifier, caster, 1)
		elseif caster:GetModifierStackCount(modifier, caster) >= max_stack_count then
			caster:RemoveModifierByName(modifier)
			ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
			caster:SetModifierStackCount(modifier, caster, max_stack_count)
		else
			caster:RemoveModifierByName(modifier)
			ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
			caster:SetModifierStackCount(modifier, caster, current_stacks + 1)
		end
	end
end