function CheckDayTime( keys )
	local caster = keys.caster
	local ability = keys.ability
	local modifier = keys.modifier

	if not GameRules:IsDaytime() then
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	else
		if caster:HasModifier(modifier) then caster:RemoveModifierByName(modifier) end
	end
end

function ActiveCheckDayTime( keys )
	local caster = keys.caster
	local ability = keys.ability
	local modifier_day = keys.modifier_day
	local modifier_night = keys.modifier_night

	if GameRules:IsDaytime() then
		ability:ApplyDataDrivenModifier(caster, caster, modifier_day, {})
	else
		ability:ApplyDataDrivenModifier(caster, caster, modifier_night, {})
	end
end