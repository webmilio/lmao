function PhantomStrike( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local modifier = keys.modifier
	local duration = ability:GetLevelSpecialValueFor("duration", ability:GetLevel() - 1)
	ability.phantom_strike_attacks = ability:GetLevelSpecialValueFor("bonus_max_attack_count", ability:GetLevel() - 1) - 1

	-- If the target is an enemy then do enemy team logic
	if target:GetTeamNumber() ~= caster:GetTeamNumber() then

		-- Apply the attack speed modifier and keep track of the target for attack checks later
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {duration = duration})
		ability.phantom_strike_target = target

		-- Order the caster to attack the target
		order = 
		{
			UnitIndex = caster:GetEntityIndex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = target:GetEntityIndex(),
			Queue = true
		}

		ExecuteOrderFromTable(order)
	end
end

--[[Triggers on every attack made while under the effect of the attack speed modifier
	It checks if the caster is still attacking the original target and if it exceeded the maximum number of attacks]]
function PhantomStrikeAttack( keys )
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local modifier = keys.modifier

	-- Check if the attacked target is still the original target or if it still has any attack charges left
	if target ~= ability.phantom_strike_target or ability.phantom_strike_attacks <= 0 then
		-- If not then remove the attack speed modifier
		caster:RemoveModifierByName(modifier) 
	else
		-- Otherwise reduce the number of attack charges
		ability.phantom_strike_attacks = ability.phantom_strike_attacks - 1
	end
end