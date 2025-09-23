RegisterNetEvent("ta-inv:SetPlayerStats", function(key, value)
    if key then
        PlayerStats[key] = value
    else
        PlayerStats = value
    end
end)

RegisterNUICallback("GetStats", function(data, cb)
    PlayerStats.money = GetMoney()
    local dataTable = {}
    for k,v in pairs(Config.StatTypes) do
        if v.listOnProfile then
            dataTable[v.key] = {
                value = PlayerStats[v.key],
                label = v.label
            }
        end
    end
    dataTable.money = PlayerStats.money
    cb(dataTable)
end)

AddEventHandler('gameEventTriggered', function(name, eventData)
    if name == "CEventNetworkEntityDamage" then
        local ped, victim, killer, isFatal = PlayerPedId(), eventData[1], eventData[2], eventData[6] == 1
        local killerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(killer))
        local victimId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(victim)) or tostring(victim==-1 and " " or victim)
        if ped == victim and isFatal then
            TriggerServerEvent("ta-inv:playerKilled", killerId, victimId)
        end
    end
end)