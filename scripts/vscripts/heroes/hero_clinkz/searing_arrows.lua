function CalculateDamage( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local distance = caster:GetRangeToUnit(target)
	local mid_point = caster:GetAttackRange()
	local damage_bonus = ability:GetLevelSpecialValueFor("damage_bonus", (ability:GetLevel() - 1))
	local distance_bonus_pct = ability:GetLevelSpecialValueFor("distance_bonus_pct", (ability:GetLevel() - 1))
	local max_distance_cap = ability:GetLevelSpecialValueFor("max_distance_cap", (ability:GetLevel() - 1))

	local damageTable = {}
	damageTable.attacker = caster
	damageTable.ability = ability
	damageTable.damage_type = ability:GetAbilityDamageType()
	damageTable.victim = target
	damageTable.damage = damage_bonus + distance_bonus_pct * damage_bonus * (mid_point - distance) / max_distance_cap
	ApplyDamage(damageTable)
end
