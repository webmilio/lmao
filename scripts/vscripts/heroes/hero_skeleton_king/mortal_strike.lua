function MortalStrike( keys )
	local ability = keys.ability
	local level = ability:GetLevel() - 1
	local cooldown = ability:GetCooldown(level)
	local caster = keys.caster	
	local modifierName = "modifier_mortal_strike_datadriven"

	ability:StartCooldown(cooldown)

	caster:RemoveModifierByName(modifierName) 

	Timers:CreateTimer(cooldown, function()
		ability:ApplyDataDrivenModifier(caster, caster, modifierName, {})
		end)	
end