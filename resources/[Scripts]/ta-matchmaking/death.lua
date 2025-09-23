AddEventHandler('gameEventTriggered', function(event, data)
    if Bools.ingame then
        if event == "CEventNetworkEntityDamage" then
            local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
            if not IsEntityAPed(victim) then return end
            if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
                local data = {
                    -- victimCoords = {x = ESX.Math.Round(victimCoords.x, 1), y = ESX.Math.Round(victimCoords.y, 1), z = ESX.Math.Round(victimCoords.z, 1)},
                    -- killerCoords = {x = ESX.Math.Round(killerCoords.x, 1), y = ESX.Math.Round(killerCoords.y, 1), z = ESX.Math.Round(killerCoords.z, 1)},
                    killedByPlayer = true,
                    killerWeapon = weapon,
                    killerServerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)),
                }

                TriggerServerEvent('ta-matchmaking:onDeath', data)
            end
        end
    end
end)