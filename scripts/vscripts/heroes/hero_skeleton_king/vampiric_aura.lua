function VampiricAura( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1

	local duration = ability:GetLevelSpecialValueFor("think_interval", ability_level)
	local modifier = keys.modifier

	ability:ApplyDataDrivenModifier(caster, target, modifier, {Duration = duration}) 
end