RegisterNetEvent('ssa-base:damage_message:server:hit', function(attackerid, victim, hit, victimDied, bonehash)
    TriggerClientEvent('ssa-base:damage_message:client:hit', attackerid, victim, hit, victimDied, bonehash)
end)