function MortalStrike( keys )
	if crit_proc == 1 then
		local ability = keys.ability
		local level = ability:GetLevel() - 1
		local cooldown = ability:GetCooldown(level)
		local caster = keys.caster	
		local modifier = keys.modifier

		ability:StartCooldown(cooldown)

		caster:RemoveModifierByName(modifier) 

		Timers:CreateTimer(cooldown, function()
			ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
		end)
		crit_proc = 0
	end
end

function CheckAttackStart( keys )
	local caster = keys.caster
	local modifier = keys.modifier
	if caster:HasModifier(modifier) then
		crit_proc = 1
	end
end

function CheckUpgrade( keys )
	local caster = keys.caster
	local ability = keys.ability
	local level = ability:GetLevel()
	local modifier = keys.modifier
	if level == 1 then
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	end
end
