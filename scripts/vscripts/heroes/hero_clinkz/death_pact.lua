function DeathPact( keys )
	local caster = keys.caster
	local unit = keys.unit
	local ability = keys.ability
	local modifier = keys.modifier
	local modifier_spell = keys.modifier_spell
	local unit_health = unit:GetMaxHealth()
	local health_gain_pct = ability:GetLevelSpecialValueFor( "health_gain_pct" , ability:GetLevel() - 1 ) / 100
	local damage_gain_pct = ability:GetLevelSpecialValueFor( "damage_gain_pct" , ability:GetLevel() - 1 ) / 100

	--Remove Death Pact Active Modifier on Clinkz
	caster:RemoveModifierByName(modifier_spell)

	-- Heal
	local health_gain = math.floor(unit_health * health_gain_pct)
	caster:Heal( health_gain, caster)

	-- Damage Gain
	damage_gain = math.floor(unit_health * damage_gain_pct)
	if caster:HasModifier(modifier) then
		caster:RemoveModifierByName(modifier)
	end
	ability:ApplyDataDrivenModifier(caster, caster, modifier, nil)
	caster:SetModifierStackCount(modifier, caster, damage_gain)
	print("Gained "..damage_gain.." damage")
end