function HealKiller( keys )
	local caster = keys.caster
	local target = keys.unit
	local attacker = keys.attacker
	local ability = keys.ability
	local modifier = keys.modifier
	local health_bonus_pct = ability:GetLevelSpecialValueFor("health_bonus_pct", (ability:GetLevel() -1))/100
	
	if caster:IsAlive() then
		local target_health = target:GetMaxHealth()
		local heal = target_health * health_bonus_pct
		caster:Heal(heal, caster)
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	else
		local caster_health = caster:GetMaxHealth()
		local heal = caster_health * health_bonus_pct
		attacker:Heal(heal, caster)
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	end
end