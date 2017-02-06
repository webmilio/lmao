function DistanceCheck( keys )
	local caster = keys.caster
	local ability = keys.ability
	local modifier = keys.modifier
	local crit_modifier = keys.crit_modifier
	local charge_distance = ability:GetLevelSpecialValueFor("charge_distance", ability:GetLevel() - 1)
	local current_stacks = caster:GetModifierStackCount(modifier, caster)
	if current_stacks == nil then
		current_stacks = 0
	end

	if current_stacks < 100 then
		if caster.position == nil then
			caster.position = caster:GetAbsOrigin()
		end

		local vector_distance = caster.position - caster:GetAbsOrigin()
		local distance = vector_distance:Length2D()
		local total_stacks = current_stacks + math.floor(distance / charge_distance)
		if total_stacks > 100 then
			total_stacks = 100
		end
		caster:SetModifierStackCount(modifier, caster, total_stacks)
		caster.position = caster:GetAbsOrigin()
	elseif not caster:HasModifier(crit_modifier) then
		ability:ApplyDataDrivenModifier(caster, caster, crit_modifier, nil)
	end
end

function ResetStacks( keys )
	local caster = keys.caster
	local ability = keys.ability
	local modifier = keys.modifier
	local crit_modifier = keys.crit_modifier
	caster.position = caster:GetAbsOrigin()
	caster:SetModifierStackCount(modifier, caster, 0)
	caster:RemoveModifierByName(crit_modifier)
end