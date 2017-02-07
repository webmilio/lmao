function CalculateDamage( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local targetLocation = target:GetAbsOrigin()
	local radius = ability:GetSpecialValueFor("radius")
	local modifier = keys.modifier
	local crit_modifier = keys.crit_modifier
	local crit_ability = caster:GetAbilityByIndex(3) --Obtain Ability 4 handle for Critical Damage Value
	local base_damage = ability:GetLevelSpecialValueFor("damage", ability:GetLevel() - 1)
	local damageTable = {}
	damageTable.attacker = caster
	damageTable.ability = ability
	damageTable.damage_type = ability:GetAbilityDamageType()
	damageTable.damage = base_damage

	if caster:HasModifier(crit_modifier) then
		damageTable.damage = damageTable.damage * crit_ability:GetLevelSpecialValueFor("crit_damage", crit_ability:GetLevel() - 1) / 100
		caster.position = caster:GetAbsOrigin()
		caster:SetModifierStackCount(modifier, caster, 0)
		caster:RemoveModifierByName(crit_modifier)
	end

	local unitsToDamage = FindUnitsInRadius(caster:GetTeam(), targetLocation, nil, radius, ability:GetAbilityTargetTeam(), ability:GetAbilityTargetType(), DOTA_UNIT_TARGET_FLAG_NONE, 0, false)

	for _,v in ipairs(unitsToDamage) do
		damageTable.victim = v
		ApplyDamage(damageTable)
	end
end