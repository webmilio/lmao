function SpellImmune( keys )
    local caster = keys.caster

    caster:Purge(false, true, false, true, false)
end