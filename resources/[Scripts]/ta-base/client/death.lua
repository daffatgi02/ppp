matchmakingolusu = false 
AddEventHandler('gameEventTriggered', function(event, data)
    if event == "CEventNetworkEntityDamage" then
        local victim, attacker, victimDied, weapon = data[1], data[2], data[4], data[7]
        if not IsEntityAPed(victim) then return end
        if victimDied and NetworkGetPlayerIndexFromPed(victim) == PlayerId() and IsEntityDead(PlayerPedId()) then
            -- if attacker == -1 then return end
            local killerClientId = NetworkGetPlayerIndexFromPed(attacker)
            local killerServerId = GetPlayerServerId(killerClientId)
            -- if killerClientId == -1 then return end
            if not priv_lobbys and not matchmaking then
                TriggerServerEvent("ta-base:server:addKill", killerServerId)
            end
            if advanced_gungame then
                TriggerServerEvent('ta-base:gamemodes:server:gungame:kill', killerServerId)
            end
            if IsPedAPlayer(attacker) then
                if advanced_gungame_2 then
                    TriggerEvent('ta-base:driveby:delcar')
                end
                if farm_and_fight then
                    TriggerEvent('ta-inv:client:free-lobby-car-delete:death')
                end
                if advanced_sumo then
                    TriggerEvent('ta-base:sumo:deletecar')
                end
                if not priv_lobbys and not matchmaking then
                    TriggerServerEvent("ta-base:server:playerDied")
                end
                if matchmaking then
                    matchmakingolusu = true
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if matchmaking == true then
            if matchmakingolusu == true then
                SetLocalPlayerAsGhost(true)
                SetEntityInvincible(PlayerPedId(), true)
                SetPlayerInvincible(PlayerPedId(), true)
            else
                SetLocalPlayerAsGhost(false)
                SetEntityInvincible(PlayerPedId(), false)
                SetPlayerInvincible(PlayerPedId(), false)
              end
        end
    end
end)