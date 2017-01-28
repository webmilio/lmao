--Does not currently work on other players
function HealKiller(keys)
	local caster = keys.caster
	local target = keys.unit
	local attacker = keys.attacker
	local ability = keys.ability
	local modifier = keys.modifier
	local health_bonus_pct = ability:GetLevelSpecialValueFor("health_bonus_pct", (ability:GetLevel() -1))/100
	
	if caster:IsAlive() then
		local target_health = target:GetMaxHealth()
		local heal = target_health * health_bonus_pct
		local refresh_buff_time = caster:FindModifierByName(modifier):GetRemainingTime() + 3
		caster:Heal(heal, caster)
		if target:IsHero() then
			caster:RemoveModifierByName(modifier)
			ability:ApplyDataDrivenModifier(caster, caster, modifier, {Duration = refresh_buff_time})
		end
	else
		local caster_health = caster:GetMaxHealth()
		local heal = caster_health * health_bonus_pct
		attacker:Heal(heal, caster)
	end
end