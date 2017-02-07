function DistanceCheck( keys )
	local caster = keys.caster
	local ability = keys.ability
	local modifier = keys.modifier
	local crit_modifier = keys.crit_modifier
	local blur_modifier = keys.blur_modifier
	local multiplier = 1
	local charge_distance = ability:GetLevelSpecialValueFor("charge_distance", ability:GetLevel() - 1)
	local current_stacks = caster:GetModifierStackCount(modifier, caster)
	if current_stacks == nil then
		current_stacks = 0
	end
	if caster:HasModifier(blur_modifier) then
		multiplier = 2
	end

	if current_stacks < 100 then
		if caster.position == nil then
			caster.position = caster:GetAbsOrigin()
		end

		local vector_distance = caster.position - caster:GetAbsOrigin()
		local distance = vector_distance:Length2D()
		local total_stacks = current_stacks + math.floor(distance / charge_distance) * multiplier
		if total_stacks > 100 then
			total_stacks = 100
		end
		caster:SetModifierStackCount(modifier, caster, total_stacks)
		caster.position = caster:GetAbsOrigin()
	elseif not caster:HasModifier(crit_modifier) then
		ability:ApplyDataDrivenModifier(caster, caster, crit_modifier, nil)
	end
end

function StackOnHit( keys )
	local caster = keys.caster
	local ability = keys.ability
	local modifier = keys.modifier
	local attack_charge = ability:GetLevelSpecialValueFor("attack_charge", ability:GetLevel() - 1)
	local current_stacks = caster:GetModifierStackCount(modifier, caster)
	if current_stacks == nil then
		current_stacks = 0
	end

	if current_stacks < 100 then
		local current_stacks = current_stacks + attack_charge
		if current_stacks > 100 then
			current_stacks = 100
		end
		caster:SetModifierStackCount(modifier, caster, current_stacks)
	end
end

function ResetStacks( keys )
	local caster = keys.caster
	local modifier = keys.modifier
	local crit_modifier = keys.crit_modifier
	caster.position = caster:GetAbsOrigin()
	caster:SetModifierStackCount(modifier, caster, 0)
	caster:RemoveModifierByName(crit_modifier)
end