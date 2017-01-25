function assassinate_register_target( keys )
	keys.caster.assassinate_target = keys.target
end

function assassinate_remove_target( keys )
	if keys.caster.assassinate_target then
		keys.caster.assassinate_target:RemoveModifierByName( "modifier_assassinate_target_datadriven" )
		keys.caster.assassinate_target = nil
	end
end

function CalculateDamage( keys )

	local ability = keys.ability
	local caster = keys.caster
	local target = keys.target
	local ability_damage = ability:GetLevelSpecialValueFor("ability_damage", (ability:GetLevel() - 1))
	
	local damage_table = {}

	damage_table.attacker = caster
	damage_table.damage_type = ability:GetAbilityDamageType()
	damage_table.ability = ability
	damage_table.victim = target
	damage_table.damage = ability_damage * (3 - 2 * target:GetHealthPercent() / 100 )

	ApplyDamage(damage_table)

end